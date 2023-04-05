Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96099C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjDER3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjDER27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:28:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D35FCC
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:28:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so21217298plg.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680715724;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vLoVq/8g3Q1EQw6lVo5vp6hZUSFemsZ59KHv6gIzdmU=;
        b=rxaxtkhSRObrDCsa3FbmCBJ1elfQbH2JRLJNSdyWKD+OdQQcdt4ZGAkHakplFnyhQZ
         8wl5EWGqChJzELNJPo7JvdOv6QH24VEjKDy97ayDayeTNAVNGlPXhTxhcMSJaozVWo9V
         SO20cgbbJ0B0woQ/yLy1eCEuzkmrUPDm1QGgioHquwYhKJEOCEhrQtqSMBomJr5nhNGo
         MGmq8R+ul/FUiAqYU9AZzIMHhW2yTc1i/OPn9LVTNAk+DtqDhfAA1wzEStAcSgySKOBD
         x4uiwXk+UV3xxQphDTg/d+74U74+PvpJGVVyM7R4ooKfteOv9HhjGC47aOi/7f8Z+pWO
         1mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715724;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLoVq/8g3Q1EQw6lVo5vp6hZUSFemsZ59KHv6gIzdmU=;
        b=oJRoEnrZ0nIhnS5QbH8PTk6azrTpvjrn/IsGsMoD6B1+6pUNg158XlLG3li6yZwB9R
         mCKfQgGAfme7FQK9/bRjVhEyiT99Yecn5f1iP9iDui0HKw21EsNdaNRRYgq3iN1dEv2U
         bzy5JRhSzYbR8Fa0TtvsdBWXjy2UxW7c5p9fufbiECD+GCWM/DbY+qFZ/hQ9vi6nS+7A
         sBYxJL/mIVn+nObMjBUmFWBERYq4VVxMdVTgI/zfWUA/uDGJKIxQrGn+VuGtIJnBA7Ia
         hlDCc+Wly2/+wZzDPovccJMRqVF3NpZKe9Jkpq+5wbGvlm9qFxjnQGm3BmGFERQ7ARBL
         jDZg==
X-Gm-Message-State: AAQBX9dlKges5hexiJPvsI6ceIkTj1Yj3oZYNyEFPUfbbdmeaHGKJ3W9
        FjMvmDRQgtNiugAxR+eut1cwOnLfMXreoVQ=
X-Google-Smtp-Source: AKy350YcLacc6y1hLkfP0Rq9PlbQFVj7c+q2k34D33J6vDbSdW6GB3ucs89Mb/K0KvECF18QYPOlY8/0jikhLjk=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:e892:b0:1a1:d366:b0bd with SMTP
 id w18-20020a170902e89200b001a1d366b0bdmr2787305plg.9.1680715724499; Wed, 05
 Apr 2023 10:28:44 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:28:40 +0000
In-Reply-To: <47afc6a6c8757032d9d69a2f9aaaeb427c5a003f.1680571352.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405172840.730076-1-calvinwan@google.com>
Subject: Re: [PATCH v2 21/24] strbuf: move forward declarations to beginning
 of file
From:   Calvin Wan <calvinwan@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Instead of moving these declarations, can we move
 strbuf_repo_add_unique_abbrev() and strbuf_add_unique_abbrev() to
 object-name.[ch]? These functions are related to both strbuf and
 object-name, but object-name should be a higher level API than strbuf
 so it seems more natural to belong in there.

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  strbuf.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/strbuf.h b/strbuf.h
> index 3dfeadb44c2..547696fb233 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -1,6 +1,8 @@
>  #ifndef STRBUF_H
>  #define STRBUF_H
>  
> +struct object_id;
> +struct repository;
>  struct string_list;
>  
>  /**
> @@ -72,12 +74,6 @@ struct strbuf {
>  extern char strbuf_slopbuf[];
>  #define STRBUF_INIT  { .buf = strbuf_slopbuf }
>  
> -/*
> - * Predeclare this here, since cache.h includes this file before it defines the
> - * struct.
> - */
> -struct object_id;
> -
>  /**
>   * Life Cycle Functions
>   * --------------------
> @@ -634,7 +630,6 @@ void strbuf_list_free(struct strbuf **list);
>   * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
>   * the strbuf `sb`.
>   */
> -struct repository;
>  void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
>  				   const struct object_id *oid, int abbrev_len);
>  void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
> -- 
> gitgitgadget
> 
> 
> 
