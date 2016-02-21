From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] merge-recursive: find-renames resets threshold
Date: Sun, 21 Feb 2016 12:18:47 -0500
Message-ID: <CAPig+cQa0t3DuXEP=zW1=2bSMro632c7DfMHcLo_iN9xhGqLqg@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-2-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:19:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXfH-0007i9-4I
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbcBURSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 12:18:51 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35928 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcBURSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 12:18:49 -0500
Received: by mail-vk0-f51.google.com with SMTP id c3so111799271vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SSCJdGaJjpP6pCJXmhv/vjvtkMfFvWXzmvJhERRO0xM=;
        b=sD+fKtofhfCBzpX9Djd+Iqj1iK4zaOAyulpK+MB9dZXKL23JxagvTqTbjh1wsyVoob
         xn4CsDgImVxV8cg/I6hOTRk9nEpSrf9Xznv1FcvELZffPWAOyFh9fWB7X5SMz9EHW2tR
         wB73pnNvO0sj0qfk4J1Z8vqpoJLXJnsW2MwWng35e7RS+HHBFo6OWC7ZfwuJ1QQAqonq
         PfCs9uC4RKj5/dF8e8DTaN8ipRFMKRKPoQG7/dxlhbzTLaJpjNiPCfhqs5A3qyhlCs66
         FqBfulxooSaACiKyDr58SHvgN+FPz4iUbs5JDQavVkUgZX7WD4uw5G+2dpVRVp/rqf7L
         /s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SSCJdGaJjpP6pCJXmhv/vjvtkMfFvWXzmvJhERRO0xM=;
        b=VsGPFgFxAe+d3MHS/9o/Z8b0olBbpaHSAYUV2Fx4XJO8eca1pPc/wu9TWmbGHNf+ww
         JDuAzSXZLen+gyf6r+BVjVYzsT2WMjq97wgCJGOOzhZMXd/LZtbmxDO3f5CgVYojZ3JJ
         4rgOWUkI+ZDH+Nc0606WFoipfch64xtV368BzLijuot91PRkXZRG+zQml4WCmuKe7+uu
         /Wdwav0Al/U0fi7o0LN95VN6/GJUrBIHmM/eaCai028z4AhucRfmgQHyvgXF39cZyAF3
         clT5uL22phf1S3A85cDaguLhbPPjoQ8E+AjYarCdIioda5a7ODGi2cfBhTfGokES3z9a
         2JBw==
X-Gm-Message-State: AG10YOTbMjiAK5YHjg+e4s17CLdIL0c+Fqpwxq7Mtv451IxRqqaHbTvkaDVPATGvU0NL7x5zFjVEqVyhioxwHA==
X-Received: by 10.31.150.76 with SMTP id y73mr19622596vkd.84.1456075127900;
 Sun, 21 Feb 2016 09:18:47 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 09:18:47 -0800 (PST)
In-Reply-To: <1456067358-19781-2-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: PaODWm2dbkHfMVyLJGZ4iK0_yF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286799>

On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> Make the find-renames option follow the behaviour in git-diff, where =
it
> resets the threshold when none is given. So, for instance,
> "--find-renames=3D25 --find-renames" should result in the default
> threshold (50%) instead of 25%.

Makes sense. I'd have expected to see the corresponding tests bundled
along with this patch rather than included in a separate patch (5/5)
whose title doesn't indicate any direct relation to this change
(although the corresponding test is mentioned briefly in the 5/5
commit message).

You might consider re-ordering the patches so that the patch (3/5)
which adds missing tests for existing features instead comes first.
Then, bundle the tests for this "fix" directly into this patch.

> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
>  merge-recursive.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 7bff5be..b880ae5 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2094,8 +2094,10 @@ int parse_merge_opt(struct merge_options *o, c=
onst char *s)
>                 o->renormalize =3D 0;
>         else if (!strcmp(s, "no-renames"))
>                 o->detect_rename =3D 0;
> -       else if (!strcmp(s, "find-renames"))
> +       else if (!strcmp(s, "find-renames")) {
>                 o->detect_rename =3D 1;
> +               o->rename_score =3D 0;
> +       }
>         else if (skip_prefix(s, "find-renames=3D", &arg) ||
>                  skip_prefix(s, "rename-threshold=3D", &arg)) {
>                 if ((o->rename_score =3D parse_rename_score(&arg)) =3D=
=3D -1 || *arg !=3D 0)
> --
> 2.7.1.492.gc9722f8
>
