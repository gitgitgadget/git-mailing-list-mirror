Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E862C1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934418AbeBMKBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:01:24 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:37453 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934235AbeBMKBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:01:22 -0500
Received: by mail-oi0-f42.google.com with SMTP id t78so13481693oih.4
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 02:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lNqCgM1J3GUnGVuTvMoHewKYZsbatmV006bdOwqfAEc=;
        b=arz3Zs4ztn9D0lpl0ZE0dP9XF7ccy5mK64/qxun5kkms844Z2UeUJlHKZNw9/3Aq21
         IP4CeFwq3ZVunYCIDpT5zoHrseH1F2SWOd5rpdlb6Dpe51Lfw3BTERRteFTwmphaHAYL
         d8yV12bwOYBk0LrWGnwkmTK8PpOccgUk/ZQav4mzzntEkGPLDfH/+9GGMKJJL4oj+8kM
         1Pl5glbgDGazPToISB8yatLyT7y4vrXgYcmt/C/iZsAQ3hP62LgB36FW4Zkl6ageKJeL
         VRy9n9SqaWjhz2FwPLDABKSZ0bthvWFcL63Tw/hnISop2UvUm0b3/boKdlRMBIS7BEqH
         jg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lNqCgM1J3GUnGVuTvMoHewKYZsbatmV006bdOwqfAEc=;
        b=qkoGdH/89mNxHOCNyur9EjUy8bm/aR0aDOPCZK3dcz+R/lJc4XVDcAoIYfNSkjrVau
         j3fGOlct/UI4rMoZLIH2orM1Th2AsX4ave1Vp3MDJN+FRODU+h6n2JoaiWg139igKp5m
         KpO3jjtWDRu5jwDA3/yk3VwEt3hD/IO9xF9G34zYhbGNSxstsWL1qqSD0a3ikVy61NKz
         CT1Oc5hJf0c5/BCXMfzeI1mvt+JmqQR+QTiuMUpfvMCRLIbDrDlgJmQont4K+cmBRozk
         STbGNCPAaC8Td4FyDWypENOMf9CNJXH5HWJco3jUeCT612B+Kt43zTAo578wGdIDbLx2
         h62w==
X-Gm-Message-State: APf1xPAu0Xm1qnhCUnE/0yvnjexIrLbFD6tZZ/W+nIQFh3plR/miZ15l
        tKtaKLNzuaTaKwQFKgil4KOUA67KQiohyAKRgWE=
X-Google-Smtp-Source: AH8x226OVy2f2Ts1zzjfOuhW1O55xBC9kT7IjCbebMeUkBH3leI9zazegNd2nlRxWUyMJP9LSpHZ4dZi7jddPw8zwmA=
X-Received: by 10.202.49.13 with SMTP id x13mr383574oix.351.1518516081314;
 Tue, 13 Feb 2018 02:01:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 02:00:50 -0800 (PST)
In-Reply-To: <c755e388-89a5-fc0f-f872-16fd5d5686b0@gmail.com>
References: <20180204093823.3671-1-pclouds@gmail.com> <20180207092141.4312-1-pclouds@gmail.com>
 <20180207092141.4312-2-pclouds@gmail.com> <c755e388-89a5-fc0f-f872-16fd5d5686b0@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Feb 2018 17:00:50 +0700
Message-ID: <CACsJy8AHa6QDmWu7TFjgW7m0pHysYkZq_WJ1QOVBVYaT4XdL4Q@mail.gmail.com>
Subject: Re: [PATCH v2] dir.c: ignore paths containing .git when invalidating
 untracked cache
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 11:59 PM, Ben Peart <peartben@gmail.com> wrote:
> diff --git a/dir.c b/dir.c
> index 7c4b45e30e..d431da46f5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1773,7 +1773,7 @@ static enum path_treatment treat_path(struct
> dir_struct *dir,
>         if (!de)
>                 return treat_path_fast(dir, untracked, cdir, istate, path,
>                                        baselen, pathspec);
> -       if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
> +       if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
>                 return path_none;
>         strbuf_setlen(path, baselen);
>         strbuf_addstr(path, de->d_name);
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 0af7c4edba..019576f306 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -118,8 +118,12 @@ static int query_fsmonitor(int version, uint64_t
> last_update, struct strbuf *que
>
>  static void fsmonitor_refresh_callback(struct index_state *istate, const
> char *name)
>  {
> -       int pos = index_name_pos(istate, name, strlen(name));
> +       int pos;
>
> +       if (!verify_path(name))
> +               return;
> +
> +       pos = index_name_pos(istate, name, strlen(name));
>         if (pos >= 0) {
>                 struct cache_entry *ce = istate->cache[pos];
>                 ce->ce_flags &= ~CE_FSMONITOR_VALID;
>

It's very tempting considering that the amount of changes is much
smaller. But I think we should go with my version. The hope is when a
_new_ call site appears, the author would think twice before passing
zero or one to the safe_path argument.

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index eb2d13bbcf..756beb0d8e 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -314,4 +314,43 @@ test_expect_success 'splitting the index results in the
> same state' '
>         test_cmp expect actual
>  '
>
> +test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating
> UNTR' '
> +       test_create_repo dot-git &&
> +       (
> +               cd dot-git &&
> +               mkdir -p .git/hooks &&
> +               : >tracked &&
> +               : >modified &&
> +               mkdir dir1 &&
> +               : >dir1/tracked &&
> +               : >dir1/modified &&
> +               mkdir dir2 &&
> +               : >dir2/tracked &&
> +               : >dir2/modified &&
> +               write_integration_script &&
> +               git config core.fsmonitor .git/hooks/fsmonitor-test &&
> +               git update-index --untracked-cache &&
> +               git update-index --fsmonitor &&
> +               GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-before" \
> +               git status &&
> +               test-dump-untracked-cache >../before
> +       ) &&
> +       cat >>dot-git/.git/hooks/fsmonitor-test <<-\EOF &&
> +       printf ".git\0"
> +       printf ".git/index\0"
> +       printf "dir1/.git\0"
> +       printf "dir1/.git/index\0"
> +       EOF
> +       (
> +               cd dot-git &&
> +               GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-after" \
> +               git status &&
> +               test-dump-untracked-cache >../after
> +       ) &&
> +       grep "directory invalidation" trace-before >>before &&
> +       grep "directory invalidation" trace-after >>after &&
> +       # UNTR extension unchanged, dir invalidation count unchanged
> +       test_cmp before after
> +'
> +
>  test_done
>
> base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
> --
> 2.15.0.windows.1
>



-- 
Duy
