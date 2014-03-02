From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Replace tmpname with pack_tmp_name in warning. The
 developer mistook tmpname for pack_tmp_name.
Date: Sat, 1 Mar 2014 22:59:56 -0500
Message-ID: <CAPig+cQS53vzZQrkeZDX7ci4708o9bVp5QMvNnesZU17u1Fz2w@mail.gmail.com>
References: <1393728219-3142-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, gister@pobox.com
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 05:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJxZv-0005bj-1H
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 05:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaCBD75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 22:59:57 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:54645 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaCBD74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 22:59:56 -0500
Received: by mail-yh0-f42.google.com with SMTP id a41so2484829yho.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 19:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XTJr3dSSx2f4pJpsRy5BqKzzYpaQ0JEKH9830SOqSys=;
        b=MZcTGDdZPx/muGxMCbuufNY1+qonIHeT+fDbzx4mX7+dEpqcfFzBCuYiSs/gcdh19c
         fvCzZgESqwohZ8GBmQEgFdpPcFBc6zt3sbvsxP036YdlZ6OcG19O+ZwZrH9Q/RXagSda
         G7g0YzCuIoaw0GDw7rh9nNL24pQ/Pr4/F4MdXAqw6ogK60qhbp7vntJh034RDT7B6qSf
         m4x0t14BaoRgW3zya403ZeWstxyb9YXlv/vJs7J0yxA9vly+z/qMevmteB3lDxjpVXuy
         hx+y2Fjg6hcKnlMtIVt0xENbRXB7yj18kHoIounUExGevprukYB/1LZD7AKmHB9skd71
         R0Rg==
X-Received: by 10.236.199.82 with SMTP id w58mr11981893yhn.57.1393732796304;
 Sat, 01 Mar 2014 19:59:56 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 19:59:56 -0800 (PST)
In-Reply-To: <1393728219-3142-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: skT0Mib9NA3uUxp0-jxdVy-PiFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243129>

On Sat, Mar 1, 2014 at 9:43 PM, Sun He <sunheehnus@gmail.com> wrote:
> Subject: Replace tmpname with pack_tmp_name in warning. The developer mistook tmpname for pack_tmp_name.

The subject should be a short summary of the change, and the rest of
the commit message before the "---" line provides extra detail
explaining the change.

> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>
>  As tmpname is used without initialization, it should be a mistake.

This is valid information for the commit message above the "---" line.
So, your full commit message might say something like this:

    Subject: write_pack_file: use correct variable in diagnostic

    'pack_tmp_name' is the subject of the utime() check, so report
    it in the warning, not the uninitialized 'tmpname'.

>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..4922ce5 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -823,7 +823,7 @@ static void write_pack_file(void)
>                                 utb.modtime = --last_mtime;
>                                 if (utime(pack_tmp_name, &utb) < 0)
>                                         warning("failed utime() on %s: %s",
> -                                               tmpname, strerror(errno));
> +                                               pack_tmp_name, strerror(errno));
>                         }
>
>                         /* Enough space for "-<sha-1>.pack"? */
> --
> 1.9.0.138.g2de3478.dirty
