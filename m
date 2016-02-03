From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/4] restore_env(): free the saved environment variable
 once we are done
Date: Tue, 2 Feb 2016 20:47:14 -0500
Message-ID: <CAPig+cT8PhJU=9aS8NvkN9wx6imtACOS9rkgDJeJpN=CGikd7Q@mail.gmail.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
	<xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqio26pt91.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 02:47:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQmXS-00083A-S5
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 02:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbcBCBrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 20:47:18 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35441 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcBCBrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 20:47:16 -0500
Received: by mail-vk0-f68.google.com with SMTP id e185so197523vkb.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 17:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EOx74OwxAkeXinDkWZQ/JSTh6rnDwBSgaeXIG06R/Qo=;
        b=OLCnoWiJvFkQbxuAolTJnX3dSC2My/2tXCpNfdM0Y63QzRQCuG7UPGK5tUhq8AfySm
         KT/X27q9QZbqt8cIKhE79haTZqL7pL6cMwmKSwfURZnuTExqnh6CANjRImzGhug/2Hdu
         idtCix5pv33owI1+wlcZNp5JcSjKwjSXCR+3O9uOn34gUHxhlX50eFAP4Ac/pmpCWrBg
         gYFC9jcITTSp4bffhTUoOtCibNY64he1B3xioS60thCpHx0o8OMRlVk5HaxejYbK/I/+
         pia2R0EPQhmcnGAyNHLblmfGhEFiHegxUJqoBKtU/BajnMHpKT7PcSL2+9k3zKv0LMND
         ClsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EOx74OwxAkeXinDkWZQ/JSTh6rnDwBSgaeXIG06R/Qo=;
        b=anC9KfT2hsH58E6BAV0ArO6o5IoMJHPCXdSNrfNOdKdhNi048hloAs23lwbxqRSPC8
         DPYT+b+1g7sF/Xeq/drWLInEXIqL3h3zoTOpIsSY3GD8GrmVp9Hme/zpY6vhtEhKPFxI
         OnRyyZCUM2HYmtPmSXFhnjMSM73Gn3XWLsw1DRQoeitNeA7PA01umXhJTVNyjwP6t96T
         4d4+grZVKXIB4WCQP9BbD3i7Mwxuq7z3m1fAXWmnLKekCsLsMT/VqfrxrM/yyJ46VFDW
         SKW5aDTsDc83mN76C19Yzge27NG2AG+0Gxrge39AzD7+NrqYqa22qB0tzxP7st7BXM1c
         GgGQ==
X-Gm-Message-State: AG10YOSj3M8h9MomJeZC2pj/nWzsyTvjf2jcM0E0E4mGS/1s3I5L6LYAQjN/Pg9nM8l8hM50b9N2yrIf90c7ig==
X-Received: by 10.31.164.78 with SMTP id n75mr23002919vke.14.1454464034937;
 Tue, 02 Feb 2016 17:47:14 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 2 Feb 2016 17:47:14 -0800 (PST)
In-Reply-To: <xmqqio26pt91.fsf_-_@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: qkIX19Gdg0ZQgQ9z17uHlsaGy40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285323>

On Tue, Feb 2, 2016 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Just like we free orig_cwd, which is the value of the original
> working directory saved in save_env_before_alias(), once we are
> done with it, the contents of orig_env[] array, saved in the
> save_env_before_alias() function should be freed; otherwise,
> the second and subsequent calls to save/restore pair will leak
> the memory allocated in save_env_before_alias().
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/git.c b/git.c
> @@ -54,10 +54,12 @@ static void restore_env(int external_alias)
>                 if (external_alias &&
>                     !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
>                         continue;
> -               if (orig_env[i])
> +               if (orig_env[i]) {
>                         setenv(env_names[i], orig_env[i], 1);
> -               else
> +                       free(orig_env[i]);

Now that this is "well-protected"[1] against incorrect nesting, you
don't worry about the dangling pointers in static orig_env[], right?
(The same for the dangling pointer in static 'orig_cwd' after being
freed a bit earlier in this function, correct?)

[1]: via assert()

> +               } else {
>                         unsetenv(env_names[i]);
> +               }
>         }
>  }
