From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] t1501: avoid bashisms
Date: Sat, 25 Dec 2010 21:29:20 +0700
Message-ID: <AANLkTinhrBf14446rJBZSYWTSH6sxOchMcgBsrq8DoLO@mail.gmail.com>
References: <1293285457-11915-1-git-send-email-pclouds@gmail.com> <m2aajudjqt.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michel Briand <michelbriand@free.fr>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Dec 25 15:30:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWV8B-00020S-ED
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 15:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab0LYO3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 09:29:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42054 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0LYO3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Dec 2010 09:29:53 -0500
Received: by wwa36 with SMTP id 36so7997149wwa.1
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 06:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HLYvAQH49LMziWXV3AX7myR3T7dwZxsjp5/gbu/Pfmk=;
        b=lW+MUFcDl4rqebH6DaSy085uOpKGy9mfY08keATEGYSdeRK+zQclbJI0SQpJhLMUYE
         LK8cVtAxZGT5ZFy0jr7YxXQJfOHl78on5yzyaTzxpKgLLLryPanORVo4UbDCiCrVPrNA
         mBd3ztkxCR/A32LuGJIQBhHopRdIIrrpJ8pyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CTJfYasMqb1mb2qLWnd6CyBuBOae4DRad7tgsepIos9HqMrGgbM0KGP3gjkmoQVFsX
         DiWVTcaQJsjG2fr5if2PPXt5rDZ7T+v5v8AXZXUDzgUMk0m4lalqzf0lZkDS5QD9djGC
         YUu9VGSdqsX18UVn3qLycnNv51PyDr6k1gG+M=
Received: by 10.216.52.206 with SMTP id e56mr11609648wec.19.1293287390663;
 Sat, 25 Dec 2010 06:29:50 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sat, 25 Dec 2010 06:29:20 -0800 (PST)
In-Reply-To: <m2aajudjqt.fsf@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164180>

2010/12/25 Andreas Schwab <schwab@linux-m68k.org>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> @@ -322,7 +322,10 @@ test_expect_success 'git grep' '
>> =C2=A0test_expect_success 'git commit' '
>> =C2=A0 =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd repo.git &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_DIR=3D. GIT_WORK_TRE=
E=3Dwork git commit -a -m done
>
> In which way is that not portable?

I admit that I rarely leave bash, so I'll quote Johannes answer [1]

-- 8< --
Sure, it is (bashisms). This:

   GIT_DIR=3D"$TRASH_DIRECTORY/2/.git" test_repo 2/sub

does not work the same way in all shells when test_repo is a shell
function. You have to export GIT_DIR explicitly before the function cal=
l.
(But since in this case, test_repo invokes its own subshell anyway, you
better do it in the function.)
-- 8< --

[1] http://article.gmane.org/gmane.comp.version-control.git/162207
--=20
Duy
