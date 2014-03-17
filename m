From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] log: add --nonlinear-barrier to help see non-linear history
Date: Mon, 17 Mar 2014 15:09:26 -0400
Message-ID: <CAPig+cRDbnecPbefYQitROC+-QXCJF228hggf5kMGG8W-s_Lxw@mail.gmail.com>
References: <1391867417-979-1-git-send-email-pclouds@gmail.com>
	<1395060676-23144-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:09:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcuh-0008Kj-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbaCQTJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 15:09:27 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:64579 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaCQTJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 15:09:26 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so16118446ykq.7
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=WJII/ufh8i9VeO9w6QIQozxJR6fjjSbTtbKIvmytJco=;
        b=EvgI7KI1/nrCdF+8S0GFN7Qf8I90h4iN12eNizbOVvf1RgNolL4xZUHxTCIbLQCh5B
         U6VjKEHR8H9ZOpS9JcVNxzmU51qAeamrT3FY1oEK1LyAQmxM+q+bfnRKAQW8FWj67rkP
         zbeHkA9qInIffP64sFNoeFKxZesmKGtpujpk2+WbNVJux7bbF5kjELKELO8hK7V3GU3g
         ELYRK7vdIZYHz2SH253JCuaprD0ylgKR8H+hVSmzio8QjBLnevCQNDK/FWO/vvJdIfVb
         WlhdnKZZhKMWVxot5dpInQ9hNps7VfLQSF63Lu0MHKylsfacumDU2KpN+A85VHghhPqh
         b27Q==
X-Received: by 10.236.177.100 with SMTP id c64mr28648694yhm.30.1395083366160;
 Mon, 17 Mar 2014 12:09:26 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 12:09:26 -0700 (PDT)
In-Reply-To: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: p-vQUytoxLRhdq9P97OF1bnXOq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244267>

On Mon, Mar 17, 2014 at 8:51 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  v2 renames the option name to --nonlinear-barrier and fixes using it
>  with --dense. Best used with --no-merges to see patch series.
>
>  Documentation/rev-list-options.txt |  7 ++++++
>  log-tree.c                         |  4 +++
>  revision.c                         | 51 ++++++++++++++++++++++++++++=
+++++++---
>  revision.h                         |  6 +++++
>  4 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index 03533af..435aa2d 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -750,6 +750,13 @@ This enables parent rewriting, see 'History Simp=
lification' below.
>  This implies the `--topo-order` option by default, but the
>  `--date-order` option may also be specified.
>
> +--nonlinear-barrier[=3D<barrier>]::
> +       When --graph is not used, all history branches are flatten an=
d

s/flatten/flattened/

> +       could be hard to see that the two consecutive commits do not

s/and could be/which can make it/

> +       belong to a linear branch. This option puts a barrier in
> +       between them in that case. If `<barrier>` is specified, it
> +       is the string that will be shown instead of the default one.
> +
>  ifdef::git-rev-list[]
>  --count::
>         Print a number stating how many commits would have been
