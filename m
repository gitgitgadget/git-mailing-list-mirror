From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/37] t6020: Modernize style a bit
Date: Mon, 20 Sep 2010 10:03:25 -0600
Message-ID: <AANLkTin3wXKUJoRtdk4e1KT5Gwo1H1+9H07LU313Ubo1@mail.gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
	<1284971350-30590-10-git-send-email-newren@gmail.com>
	<4C972839.9050303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 20 18:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxiq8-00028C-B0
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 18:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab0ITQD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 12:03:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61340 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0ITQD1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 12:03:27 -0400
Received: by fxm3 with SMTP id 3so745435fxm.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zLsh8cMfQgo0Nt4KoiDLAct0+puJMlgnusGU9AgeoaE=;
        b=K8W7V9qdqQrTSzMXgDfjBpwzLcWOekZLmY7tWjJ5t5rzlHG9YyA1g5zfAx3fJ8ZlxH
         1nJV+TYuZqvSMuA78X6sIXja/SwYQdtZr+/X2R+l5hwhmDZ76dufczJv5Z7xV+XbFdzf
         /oSvorku3AAdad6JuMggr7IfMFgh1EI2rUUZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lnlG2aBm7ub/8EBnJ+hykNpgdflgABavp35liWGs0OIiAB9pUwYGj4UkhPl0uAPPVB
         3/zjcUEK2+AutRsWE6eExxdNDOu2QDQuSQ+ADe+Kq47xEroYO1Nm+wE7a9cAR+wDle+p
         3k6CtidjlXlEbg+wrfDqgs5g878auZ63hyBeM=
Received: by 10.223.125.70 with SMTP id x6mr862740far.85.1284998605245; Mon,
 20 Sep 2010 09:03:25 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Mon, 20 Sep 2010 09:03:25 -0700 (PDT)
In-Reply-To: <4C972839.9050303@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156634>

On Mon, Sep 20, 2010 at 3:24 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 9/20/2010 10:28, schrieb Elijah Newren:
>> -test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg=
" B master'
>> +test_expect_success 'Merge with d/f conflicts' '
>> + =C2=A0 =C2=A0 test_must_fail git merge master
>> +'
>
> The old version requested a particular kind of failure. Are you sayin=
g
> that with modern 'git merge' all non-zero exit codes mean the same ki=
nd of
> failure?

No, I'm saying that I don't think the test meant to try to distinguish
between exit codes.  I think the test only used test_expect_code
because that's all that existed in 2005 (test_must_fail postdates this
test by over 2 years).  There's really only one exit code from git
merge[1], so there's really not much point in trying to distinguish
between kinds of failure.


[1] Okay, technically you can get code 128 if you hit a die(), but we
don't in general try to differentiate between failure due to hitting
die() and failure for other reasons when using test_must fail, so I
didn't think it was worth checking here either.
