From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: skip ill-formed references
Date: Fri, 30 Aug 2013 20:39:27 -0500
Message-ID: <CAMP44s2f7S4STbCOuh35sgdrgAdw-2Tw1LDkjhO37hXLxX3mRQ@mail.gmail.com>
References: <20130831011542.GA10486@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Aug 31 03:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFaAB-0001vW-Df
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 03:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab3HaBj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 21:39:29 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40972 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3HaBj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 21:39:28 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so2074936lab.38
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 18:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L1kdQLYUEuxTdB5UHDOviOW3nMh7fEKGd5V2oK3oCCY=;
        b=bI+kodvRLeuc5HRGbdZbf6fdfyw9Ww3/cH7YUiL09MXrBpMnfsTzjnNjldvN1frOe0
         HRy3Ky9wRlLO+BJQ2KV4cgl1dS42UG5LOCrFAw8sz5Lxk3HuZiVOSK40GJjpGjBv0y9s
         AIXp0fcxp2iB1KGHRDmKMGgZXVYt9rbq0CV/27hHRGlsMDPRLJof9dWWD3dUC3KWaHRE
         jQ/v+iyurVGom/HKt4QX/KLZ0YkgHFVJn6Z5W6EBWnOsu+8ER3K2hiFw44hcvQgmYstz
         VfANesXQioa3QbDJ/5mwoWyMcVBMFOyjUTYvOKjceanIamD3nYot4mIk+tjElReEztgZ
         Yyaw==
X-Received: by 10.152.88.74 with SMTP id be10mr10351106lab.4.1377913167087;
 Fri, 30 Aug 2013 18:39:27 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 18:39:27 -0700 (PDT)
In-Reply-To: <20130831011542.GA10486@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233491>

On Fri, Aug 30, 2013 at 8:15 PM, Max Kirillov <max@max630.net> wrote:
> References which fail check_refname_format() cause the whole
> import to fail. This might be undesirable if the references
> are not important.
>
> A better solution would be to provide some mapping, either
> by some reversible encoding, or by generating and storing
> the associations locally.
>
> But this is already going to allow working with many
> existing repositories.

Which repository triggered this?

Maybe we should do something similar as in git-remote-bzr:


def ref_is_valid(name):
    return not True in [c in name for c in '~^: \\']


        if not ref_is_valid(tag):
            continue
        print "? refs/tags/%s" % tag

-- 
Felipe Contreras
