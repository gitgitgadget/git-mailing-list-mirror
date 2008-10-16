From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix mkpath abuse in dwim_ref/sha1_name.c
Date: Thu, 16 Oct 2008 08:21:12 +0200
Message-ID: <81b0412b0810152321u508f1e2eqa7790baf476baf34@mail.gmail.com>
References: <81b0412b0810140923x5cf58bb9x5acd1517a19e9847@mail.gmail.com>
	 <7viqru6a1r.fsf@gitster.siamese.dyndns.org>
	 <20081015062039.GA3775@blimp.localdomain>
	 <7vabd5r1ss.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 08:23:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqMGc-00007m-4c
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 08:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYJPGVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 02:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYJPGVP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 02:21:15 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:48127 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbYJPGVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 02:21:13 -0400
Received: by yx-out-2324.google.com with SMTP id 8so694590yxm.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FYKLo6OGYdeK4rSTcaxiFOBQXrbijIYbclCFLWO8WYE=;
        b=KSK+DeuZvOq+EzmRikHJWTVwguc63N5J5yK7ImO5PvLQmbRO6fgc+bB+s8MpOF6QHf
         Gv2AY6pBELpeTn7/DOPPjlj0MW10FfkJj1iLP1SouNTSQCDJWDnQE2oYwhM2e9wVwDyz
         nabBhrvbeVpRvy3gVmfM4TmQuE6hHWIW0DBig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l+L1ei9acYteFcYVANcceixTJMxFnW+wezBchGSgYEj9srHueJHn8rdUfdab7O/6J3
         mwrYMCnwq/vP229iMVzUj+DKxBGt1fupzQwZht8vs30radi4C+59xZLD8klwr0BuVAzA
         J4bsFRYvD5REaoEeWSVBBvJ8LAiCJcmabxaro=
Received: by 10.101.67.11 with SMTP id u11mr2657716ank.88.1224138072738;
        Wed, 15 Oct 2008 23:21:12 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Wed, 15 Oct 2008 23:21:12 -0700 (PDT)
In-Reply-To: <7vabd5r1ss.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98347>

2008/10/15 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Junio C Hamano, Wed, Oct 15, 2008 01:17:52 +0200:
>>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>>> >
>>> > Otherwise the function sometimes fail to resolve obviously correct refnames,
>>> > because the string data pointed to by "ref" argument were reused.
>>> >
>>> But your patch instead rewrites the computation of str2 by bypassing the
>>> call to "another_function_that_uses_get_pathname()" and duplicating its
>>> logic, which I do not think is a viable approach in the longer term.
>>
>> There is not enough logic to bypass there. It's just a dumb sprintf!
>
> But didn't you lose call to cleanup_path()?
>

In this case?
