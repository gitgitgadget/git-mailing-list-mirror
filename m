From: Caleb Jorden <cjorden@gmail.com>
Subject: Re: [PATCH] submodule helper list: Respect correct path prefix
Date: Wed, 24 Feb 2016 16:18:16 -0600
Message-ID: <CABD8wQkU5J7ZYDuNW9=M=2dzR2tJ5v1zcSUnUHPeo=2aed4V_g@mail.gmail.com>
References: <1456348502-4529-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:18:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYhlP-0007gE-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416AbcBXWSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:18:18 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:32931 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352AbcBXWSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:18:16 -0500
Received: by mail-io0-f171.google.com with SMTP id z135so69782451iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bYYGl75V2P+ZoVTJAUiPPlN4/DkdUPufmin5f+RyaD0=;
        b=rKKnu07C7IelWUYt7ntXZftJhrSsxUOPfjNlMbmx2S+/FNgkqaVkbuUrJddJK2gcBS
         cUJWK9jurdNfHh/yT/v7ekkKaM/sU4rI2YYejpdoKut0xIhOgfEaNLsGlht65qt3lBLo
         G9hpP4xw2JrCLeuq/uLfvQSIzYkCV8pbWinKDBR6ZHL+x48xf4Yqn7z5aiZH66+LAobs
         rPP+rUAte0eNz0lDWBwYJlpTKRLlqzhqZQmnXKbWg5cs0Sd4VOOrMylMhbRrOcZApF1a
         Q0uGTHrPMitogvxBRtk7a5ACaUKDlXBXXtzZ5w6Irqpmfgn/FDZGKVsj5/OdHo4J7WRj
         /Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bYYGl75V2P+ZoVTJAUiPPlN4/DkdUPufmin5f+RyaD0=;
        b=ZdLFt9/Rvth7z7Pzman3rpdApWl2gtspmrS9ShjvMj4oKoCrq8cd479SBxWd0XHjLk
         bMYlKibl8Uzg4Y/UJi0lUNKQq6VQ6qgOM/I+tqz6vXUOCsPBvP0Rz59i3Go50rZ2He6P
         Q6ysxH267QYkG46K3aftYe8AJPLMRI3qtfe40sq98nHa0DmMXdKSOZ1JWGOl0dMJnxz/
         v4Y0b65qttuntOgPwGHgEXg9GY5Yta4DhMeJr9qvr8Ba0N5miLRRjWVWRheAbkLlz64D
         VkTKcloc63yo9j49ZYajIayGif2uawA/I6r5v9jxo88rYLG7Cuog8ydetAjq4qhxI+dU
         +8cA==
X-Gm-Message-State: AG10YOQr3yla6dCokTioo59IZ8r9vPSFwT4bOJ71yJkoNRYXZND54Lwfu6verB78n3V3YpqEBlvCfX746qYi+A==
X-Received: by 10.107.134.35 with SMTP id i35mr42517055iod.95.1456352296127;
 Wed, 24 Feb 2016 14:18:16 -0800 (PST)
Received: by 10.79.111.136 with HTTP; Wed, 24 Feb 2016 14:18:16 -0800 (PST)
In-Reply-To: <1456348502-4529-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287237>

Stefan,

Thank you for the exceptionally quick response, and the patch!  As
your added test case verifies, this fixes my use case.  I will
continue to test this, and let you know if I see any other problems.

Thanks again.

Caleb Jorden
cjorden@gmail.com

On Wed, Feb 24, 2016 at 3:15 PM, Stefan Beller <sbeller@google.com> wrote:
> This is a regression introduced by 74703a1e4d (submodule: rewrite
> `module_list` shell function in C, 2015-09-02).
>
> Add a test to ensure we list the right submodule when giving a specific
> path spec.
>
> Reported-By: Caleb Jorden <cjorden@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  I developed this on top of current origin/master, though I can backport it
>  to 2.7 as well if desired.
>
>  I do not remember the cause why we started to ignore a common prefix.
>
>  Thanks,
>  Stefan
>
>  builtin/submodule--helper.c | 10 ++--------
>  t/t7400-submodule-basic.sh  | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff..ed764c9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -22,17 +22,12 @@ static int module_list_compute(int argc, const char **argv,
>                                struct module_list *list)
>  {
>         int i, result = 0;
> -       char *max_prefix, *ps_matched = NULL;
> -       int max_prefix_len;
> +       char *ps_matched = NULL;
>         parse_pathspec(pathspec, 0,
>                        PATHSPEC_PREFER_FULL |
>                        PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>                        prefix, argv);
>
> -       /* Find common prefix for all pathspec's */
> -       max_prefix = common_prefix(pathspec);
> -       max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> -
>         if (pathspec->nr)
>                 ps_matched = xcalloc(pathspec->nr, 1);
>
> @@ -44,7 +39,7 @@ static int module_list_compute(int argc, const char **argv,
>
>                 if (!S_ISGITLINK(ce->ce_mode) ||
>                     !match_pathspec(pathspec, ce->name, ce_namelen(ce),
> -                                   max_prefix_len, ps_matched, 1))
> +                                   0, ps_matched, 1))
>                         continue;
>
>                 ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> @@ -57,7 +52,6 @@ static int module_list_compute(int argc, const char **argv,
>                          */
>                         i++;
>         }
> -       free(max_prefix);
>
>         if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
>                 result = -1;
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 540771c..be82a75 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -999,5 +999,30 @@ test_expect_success 'submodule add clone shallow submodule' '
>         )
>  '
>
> +test_expect_success 'submodule helper list is not confused by common prefixes' '
> +       mkdir -p dir1/b &&
> +       (
> +               cd dir1/b &&
> +               git init &&
> +               echo hi >testfile2 &&
> +               git add . &&
> +               git commit -m "test1"
> +       ) &&
> +       mkdir -p dir2/b &&
> +       (
> +               cd dir2/b &&
> +               git init &&
> +               echo hello >testfile1 &&
> +               git add .  &&
> +               git commit -m "test2"
> +       ) &&
> +       git submodule add /dir1/b dir1/b &&
> +       git submodule add /dir2/b dir2/b &&
> +       git commit -m "first submodule commit" &&
> +       git submodule--helper list dir1/b |cut -c51- >actual &&
> +       echo "dir1/b" >expect &&
> +       test_cmp expect actual
> +'
> +
>
>  test_done
> --
> 2.7.2.334.g7c0da37.dirty
>
