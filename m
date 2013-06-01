From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] commit: reload cache properly
Date: Sat, 1 Jun 2013 16:09:39 +0700
Message-ID: <CACsJy8A6Hq_LEqAxUTLKP9-TA6aTq+91Wx2vYLhSuMSmRvpYiA@mail.gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
 <1369915136-4248-2-git-send-email-felipe.contreras@gmail.com>
 <87ehcok6gl.fsf@linux-k42r.v.cablecom.net> <CAMP44s1O=VTu8EZi+yOfGMccCpS+pozvZJuDW1mK95U8-YEquA@mail.gmail.com>
 <8761y0k4ja.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 01 11:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UihpJ-0007tX-4G
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3FAJKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:10:13 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:47350 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab3FAJKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:10:11 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so2095665lab.1
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WAHVrVXJ7Y111qjQkSPNS3wGppSt72XL2+gOkFv3KOQ=;
        b=uGI5M+PvbE6gm/wYdSEsmGqJHtE4v92VOZLMjr73HEN3apiDqfA2lH9JYZgpPuIsae
         Jy3i521h1a8BQrHlkkmQy+l0WniQc7/xSGdFFAvmo9EQzHz9uwKpFR6YbnxlmgVqRdtg
         RWQoEFAhOVS8KDbJd54vssg5po8AV0oGdDIxasrU1yfQ7BSusfXfFVeQrh8nVnxtIXBX
         +J3zq//WOt0T0vA8cL3oBByB2HF6ctFttFMYBSlXIDMEi4B/P/f369/dXEow0a9GpioA
         MDvSF/yqPXLERyWt9kwSfSIyPjWj1HVpBS+hK4IyaSzQ5GwwSUEP23OjyNAtpke8xHfx
         RBmw==
X-Received: by 10.112.6.6 with SMTP id w6mr7293691lbw.123.1370077809266; Sat,
 01 Jun 2013 02:10:09 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Sat, 1 Jun 2013 02:09:39 -0700 (PDT)
In-Reply-To: <8761y0k4ja.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226106>

On Thu, May 30, 2013 at 7:58 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 30, 2013 at 7:17 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> diff --git i/t/t7501-commit.sh w/t/t7501-commit.sh
> index 195e747..1608254 100755
> --- i/t/t7501-commit.sh
> +++ w/t/t7501-commit.sh
> @@ -524,4 +524,16 @@ test_expect_success 'commit a file whose name is a dash' '
>         test_i18ngrep " changed, 5 insertions" output
>  '
>
> +test_expect_success '--only works on to-be-born branch' '
> +       git checkout --orphan orphan &&
> +       echo foo >newfile &&
> +       git add newfile &&
> +       git commit --only newfile -m"--only on unborn branch" &&
> +       cat >expected <<EOF &&
> +100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99   newfile
> +EOF
> +       git ls-tree -r HEAD >actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done

Thomas, can you resubmit this as a patch to Junio? It's good that the
test suite covers all correct behaviors (and the incorrect ones).
--
Duy
