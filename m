From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] t3700-add: added test for --exclude option
Date: Sun, 15 Mar 2015 14:18:15 -0400
Message-ID: <CAPig+cRA9YqysB3Wakhu_a9hFnY189=4=Em2thY_rrFU552Nwg@mail.gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
	<1426427437-23370-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:18:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXD7F-0003g0-L2
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbCOSSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 14:18:17 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33927 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbCOSSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:18:16 -0400
Received: by yhch68 with SMTP id h68so10780195yhc.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vPq5nndAV1stHhvVwb0fB+p7XDXhMxdENvUEVOtTcWw=;
        b=HYp8AYg0Ppx81bUx9gtuubGFxfNJE5zRbOx4t+bc95MiyZRmnGMlP/6sRVgJbMpnGm
         IJUOjsD5UCY6hNiv6R5r2mZ/8gmIGV06hu8drvV7ceg+oEbC9Xj4QcqeEysYNB0PFgkN
         nFUEqeLUUP5fXMRuFP5ZfCWLIaHEc4+AYXq6iYNNEFiZSVD7G5hWiHc1dl2Ein031uX1
         YMbRBO44sTYD3FoeL+wPhdxQhBbgKomfroZXy1+Nnq2Vd9T6jNQeNadYEV2VeeNlUs39
         SXtpapVS1CzmXgZ68WHiNOZ0AAx7lH49IXYtEX2i6MKKIAyrrczI8bb79whloGi2sSt2
         6KuQ==
X-Received: by 10.236.202.238 with SMTP id d74mr57803698yho.166.1426443496010;
 Sun, 15 Mar 2015 11:18:16 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 11:18:15 -0700 (PDT)
In-Reply-To: <1426427437-23370-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: 7JwtNTGlfxcAFsOeaBkl-x_KYrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265511>

On Sun, Mar 15, 2015 at 9:50 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> t3700-add: added test for --exclude option

Write in imperative mood: s/added/add/

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index f7ff1f5..c52a5d0 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -81,6 +81,13 @@ test_expect_success '.gitignore is honored' '
>         ! (git ls-files | grep "\\.ig")
>  '
>
> +test_expect_success 'Test that "git add --exclude" works' '
> +       touch foo &&
> +       touch bar &&

Expanding slightly on what Torsten said: Use 'touch' when the
timestamp of the file is significant to the test; otherwise, just use
">foo".

> +       git add --exclude="bar" . &&
> +       ! (git ls-files | grep bar)

For completeness, don't you also want to test that "foo" _does_ appear
in the git-ls-files output?

> +'
> +
>  test_expect_success 'error out when attempting to add ignored ones without -f' '
>         test_must_fail git add a.?? &&
>         ! (git ls-files | grep "\\.ig")
> --
> 2.3.3.472.g20ceeac
