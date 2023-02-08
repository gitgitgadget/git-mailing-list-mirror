Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B2C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 23:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjBHXAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBHXAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 18:00:10 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DB15CB5
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 15:00:09 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x8so228012ybt.13
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnzO3j+3Q6vHUJuoe6CMOzAGlW0xNMTSkSRVWCKOVq0=;
        b=grCv1Po65aTwtP6TxjjmH5WGSj0fU05R4hBW5PpDcFjnc3LAUvb290PgacGX65dnz3
         ayBRiRRdfMml7RTWotP//Oo5AzGIm7S4nFQgPi/pwt3uNKV+83N1bD5CkAtU53MHhifP
         rZsXWCSgIUvBYfmF/nYJg1kSrdoSCAuQAa/epNkH81DCcMv43GnsCsp6QR5P3Fh2AncM
         U8PbXvdWNfn6lotemkgjJ6pDHS+n1vTRBwIkRCvJ74HBYLUjY2G6J5L5oW3exM/09Ux7
         85JLbW8Xp5kmRj3W3vm/BIpmmAjY3tTWr8I4QSeB2PfiW8hmvjldlChMCZ0OGw9PWbG6
         FH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnzO3j+3Q6vHUJuoe6CMOzAGlW0xNMTSkSRVWCKOVq0=;
        b=hodCVDqx0Mmsg+ovYQiFoPqAA+vDQ8oWd2CxVwGDl+h4BzhRZWW+xvgrcPbSjLkgK9
         IT5yuwJ/mgfbHmOFYWzcScYKf60Ji+XRUIIGgzvyCFNaqyG9PDCymcOqpiol8m6Lpuvk
         oQXvs7+QRgLwQPkizdOgtRCXSRYupRiLkxF0vYnakYuV5Eaea7RsS27SqwQ6jVzMr7wl
         UcnavrxcdmccvoRKNjXR1kirMvBUVmDZw2F5xBl8Kjjp2ScpBdDfZxTDokVxW8SSs54i
         YWPWloWi8RL7CA+f/wQ6ceA/OpE2f7iaC/XVEkrlbZuGG6u2iXgAi4r3CzhpgPpZz1C4
         D58Q==
X-Gm-Message-State: AO0yUKXI6liYXyOsX9RBjiftOtE726baUvTwCV0e1oXxdISKGHb9+b6Y
        JffCaFzjI+MCx4qNAxzzfvPLhgY/5b10fiSCCZYlZxeSaYu6Dlp5
X-Google-Smtp-Source: AK7set/4S0gsc9hJDD1MA9QYbNSBXHffqHp8FMiLoMIohRicwQvq22fac4BdRNa6TygSWDcB/2yZv1kdy5A41YHiBxM=
X-Received: by 2002:a25:9f11:0:b0:898:5cc0:66c with SMTP id
 n17-20020a259f11000000b008985cc0066cmr1111695ybq.640.1675897208368; Wed, 08
 Feb 2023 15:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com> <20230207181706.363453-3-calvinwan@google.com>
 <230207.86ttzx13xc.gmgdl@evledraar.gmail.com>
In-Reply-To: <230207.86ttzx13xc.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Feb 2023 14:59:57 -0800
Message-ID: <CAFySSZD8OdTJjvdoT1nLaOq_Jjq=JF2rSSn_612JMXgD8+rycQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] submodule: strbuf variable rename
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'll only add that we could also do this on top:
>
>         diff --git a/submodule.c b/submodule.c
>         index c7c6bfb2e26..eeb940d96a0 100644
>         --- a/submodule.c
>         +++ b/submodule.c
>         @@ -1875,7 +1875,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>                 struct child_process cp = CHILD_PROCESS_INIT;
>                 struct strbuf buf = STRBUF_INIT;
>                 FILE *fp;
>         -       unsigned dirty_submodule = 0;
>         +       unsigned dirty_submodule0 = 0;
>                 const char *git_dir;
>                 int ignore_cp_exit_code = 0;
>
>         @@ -1908,10 +1908,11 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>                 while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
>                         char *str = buf.buf;
>                         const size_t len = buf.len;
>         +               unsigned *dirty_submodule = &dirty_submodule0;
>
>                         /* regular untracked files */
>                         if (str[0] == '?')
>         -                       dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>         +                       *dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>
>                         if (str[0] == 'u' ||
>                             str[0] == '1' ||
>         @@ -1923,17 +1924,17 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>
>                                 if (str[5] == 'S' && str[8] == 'U')
>                                         /* nested untracked file */
>         -                               dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>         +                               *dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>
>                                 if (str[0] == 'u' ||
>                                     str[0] == '2' ||
>                                     memcmp(str + 5, "S..U", 4))
>                                         /* other change */
>         -                               dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
>         +                               *dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
>                         }
>
>         -               if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
>         -                   ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
>         +               if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
>         +                   ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
>                              ignore_untracked)) {
>                                 /*
>                                  * We're not interested in any further information from
>         @@ -1949,7 +1950,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>                         die(_("'git status --porcelain=2' failed in submodule %s"), path);
>
>                 strbuf_release(&buf);
>         -       return dirty_submodule;
>         +       return dirty_submodule0;
>          }
>
>          int submodule_uses_gitfile(const char *path)
>
> Which, if we're massaging this for a subsequent smaller diff we can do
> to make only the comment adjustment part of this be a non-moved line.

Ah that's a neat little trick -- I'll save this one for the next time I do a
refactor like this :)
