From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] checkout: Better error message on invalid branch name
Date: Mon, 21 Jun 2010 21:09:11 +0000
Message-ID: <AANLkTino4Dz_nMSV_4HHKD3K185t7spE22d5chLdo960@mail.gmail.com>
References: <1277146419-19507-1-git-send-email-avarab@gmail.com>
	<7vd3vkgl0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 23:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQoF4-00072j-3u
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 23:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457Ab0FUVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 17:09:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63621 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758362Ab0FUVJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 17:09:12 -0400
Received: by gye5 with SMTP id 5so2516687gye.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=igOiR1oTyaofmhx5oaHSYDUw26oUJmHWGlrLcwZNSA0=;
        b=VR0qYxbdD5dOm3p/QuGk/TVvn5/EKlYFLq2UbZATCCjsAIXmk/aJY773+N+l9ZNUGP
         y5SEHrx4uC1f3T3ikrnyEPj57XUh0G/k2rxHBXbghn8RVpmWh4c/Qo5YcTv4acCHhWHS
         +F7037McCsfF6slfu2u9FHXjHODUDcsv7TikE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lBXa8azrgubbounpk72yCaGbzG4KPSZuWp0tGvcOZNVAG/nz2ZDgnZQrBydSO2TKWk
         ieq/PNnGPDhdtaUCBennvjYwHJwSPNapI8CDp6lWSJOfKh9YNAQn/YJpQqJpvNDqmXyY
         3okKn0ECxYvcOm3fdLdCzm7DEuqM+nk5paB8k=
Received: by 10.150.13.9 with SMTP id 9mr4928024ybm.375.1277154551510; Mon, 21 
	Jun 2010 14:09:11 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Mon, 21 Jun 2010 14:09:11 -0700 (PDT)
In-Reply-To: <7vd3vkgl0y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149439>

On Mon, Jun 21, 2010 at 20:58, Junio C Hamano <gitster@pobox.com> wrote:
> Cluttering the output without protecting it with "advice" does not look
> like a "fix" nor improvement.

The short version of the message would also need to be fixed then, to
do that properly would require bigger changes in the return code of
bad_ref_char and the functions that call it. Then we could have e.g.:

    $ git checkout -b "I LOVE YOU"
    fatal: git checkout: Branch name cannot contain ' ';  marked by
<-- HERE in 'I ' <-- HERE

Similar to what you get from:

    $ perl -e '/I LOVE [/'

That would also make the long version unnecessary, and maybe improve
some other error messages that deal with ref names.
