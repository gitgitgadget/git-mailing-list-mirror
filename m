From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] send-email: Use To: headers in patch files
Date: Tue, 28 Sep 2010 14:34:02 +0000
Message-ID: <AANLkTimTmfORavF6pNGjC6L46_f+GOaz86jEzBPYUxF2@mail.gmail.com>
References: <1285660964-26758-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Viresh Kumar <viresh.kumar@st.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bG8-00082t-Kg
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0I1OeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 10:34:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38819 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab0I1OeL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 10:34:11 -0400
Received: by gyd8 with SMTP id 8so31309gyd.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HX1zaeL2wLR8ywF1ZfIzvAwXIO4uTWz9TflMf0GlAec=;
        b=S+YZW7EUF4k7hysVxEX554D5hkFVvy8KpyD5rCDsVygbnnWBrW0Wd/XvPb0Wnmg0Jd
         rTKp3iK3ifxn6pAUIgOqXvEEWFj4D7ctp4586FdBr4fxboR190rn81sD261Og02LGOer
         GoR8uXtoa8yxKWIib+lMf7zDMhf8OS6SsHWio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fkeNSf5mPc5IOCaVOh3zw8MIMuxjT6CNjInoMHWTslq1O1v+tMdOTByjWIcD1Fbn1K
         K0MSQDE8lJqcnhPYjv63TVISr9oxslxpHaYmhWYIxHGehPGM6TLvFffMbBJLpYlrzfWT
         SosQnDE1IQAXj23UYjMl8WbNbWocPbsj1fPOk=
Received: by 10.231.11.13 with SMTP id r13mr7677748ibr.137.1285684442226; Tue,
 28 Sep 2010 07:34:02 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 07:34:02 -0700 (PDT)
In-Reply-To: <1285660964-26758-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157425>

On Tue, Sep 28, 2010 at 08:02, Stephen Boyd <bebarino@gmail.com> wrote:

> +test_expect_success $PREREQ 'patches To headers are used by default'=
 '
> + =C2=A0 =C2=A0 =C2=A0 patch=3D`git format-patch -1 --to=3D"bodies@ex=
ample.com"` &&
> + =C2=A0 =C2=A0 =C2=A0 git send-email \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --dry-run \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --from=3D"Example =
<nobody@example.com>" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --smtp-server rela=
y.example.com \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $patch >stdout &&
> + =C2=A0 =C2=A0 =C2=A0 grep "RCPT TO:<bodies@example.com>" stdout
> +'

Why not:

    git format-patch -1 --to=3D"bodies@example.com" &&
    test_when_finished "rm *.patch" &&
    git send-email [...] *.patch >out &&
    [...]
