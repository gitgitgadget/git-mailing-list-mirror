From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 1/4] tests: Infrastructure for Git smoke testing
Date: Sun, 8 Aug 2010 15:20:20 -0500
Message-ID: <AANLkTi=+i0a0Sj542=tzKqeGe0CBYA1F=-njc_yObwa8@mail.gmail.com>
References: <1281278967-31376-1-git-send-email-avarab@gmail.com> 
	<1281278967-31376-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 22:20:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCMS-0005tM-7d
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab0HHUUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 16:20:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57348 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab0HHUUm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 16:20:42 -0400
Received: by gyg10 with SMTP id 10so3240302gyg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7ScPuvoCy/mNATPQUV4Mt3VE7WQzXLbbIkth1g4sDVs=;
        b=xxXRkUOFF4NWBcnL0ExoEg67qtcIwZGoBBqsiHz2Pb8fZ7S4WpCljgi5MUQbbbuUGC
         o7hZLg5sofyNX6l1O6dAUGd2BlOjBBJaOZBy3FtRAkOX3ynrK6X/jDfUyOY5iwKLHsQu
         Bf5klmmLpfu1H59rVPGXJNZZADvjcwbs7TByM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VK/N/P99PJt25XM5Q8PbAF/q8DrOqOd/HW3Ut+HRCq3TNAbyBDQrN0RJqJyNg2F4hr
         FKAkmevA8iVoWAaQ8zOy/jDzfYXGvcL6pPAReu2/LcERK7RJx0ZFN+RJ9MN9RYS2YD7b
         6dbHPxWkqikiWJyyOKKlsTv5O9mOxnEH/Ggw4=
Received: by 10.150.72.38 with SMTP id u38mr16884009yba.156.1281298840228; 
	Sun, 08 Aug 2010 13:20:40 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Sun, 8 Aug 2010 13:20:20 -0700 (PDT)
In-Reply-To: <1281278967-31376-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152925>

Heya,

On Sun, Aug 8, 2010 at 09:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> +smoke_report: smoke
> + =C2=A0 =C2=A0 =C2=A0 curl \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -H "Expect: " \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -F project=3DGit \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -F architecture=3D=
"$(uname_M)" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -F platform=3D"$(u=
name_S)" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -F revision=3D"$(G=
IT_VERSION)" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -F report_file=3D@=
test-results/git-smoke.tar.gz \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(SMOKE_UPLOAD_FLA=
GS) \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 http://smoke.git.n=
ix.is/app/projects/process_add_report/1 \

I think at the very least this URL should be given it's own variable
so that it can be overridden easily.

--=20
Cheers,

Sverre Rabbelier
