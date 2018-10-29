Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD221F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJ3CQC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:16:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35587 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeJ3CQC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:16:02 -0400
Received: by mail-io1-f66.google.com with SMTP id 79-v6so5487370iou.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZJw8E6UomJ7D0PEbSOCEKhEMjSzWVdPBCzbxxqqrjw=;
        b=jk1+f3pWbgDTSpBjfEQCvqRBQhFAU4hqnmYFeBkF0xKLOHt2eu1WSdPo5ol0KQnNe4
         PusxTSjQtvtnQaCUSjev6gh1wOlaJjYiX4Fh1/o810ArIqRI7HIVIfHx24x91bSMR53d
         gq0DpubgWL1Lu1aIWc/cKKD5Rp976qhWW5/rJitwH59dxNM8UtPo3Quago34Gi2AZotf
         WN1V83+VBnJPRr/FYOCAPy5zKQdGx5EWOTsXBEuoOBrb1gGH2LpuPyhaWgEcyQOrOeq3
         ZbLYUXxDg7MfN/rC9qNRkb5S5OwxqISvGnKR2aqJaUfXWMA2MxfXS18BT3ODXpXKGui3
         6G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZJw8E6UomJ7D0PEbSOCEKhEMjSzWVdPBCzbxxqqrjw=;
        b=iwOT96P7oHZBA6W5mE7zOF+VDEVjvVXA5gu+tMMPD+fxqBHq1JNndwYnjKcIJxEIfW
         GEOlKCRJcJtdXFzQxv6pDUsRg6uVXhbQvir+4tMcqXK60eyn+fvst6uAfoSZagOlPi9d
         o/1AMfCrEpT0whXKvL4zGJ1qXb+9iIpcxfx1ArAUgleyB5r9lLkagoVoOEAdReEF5xjb
         72OCBW2YOY/u1x45aAjEL11QhZ1s/cF/6xRb0K+SVc7xbwnF+dHb98RUvcX+qC/kpdNo
         gh8hLZ7u7ZdIH2ayAYIBWYy9YJ+brKIadc02efY/g7cofFr3uqcEAPjYZH9nqbQxjlzu
         vAOw==
X-Gm-Message-State: AGRZ1gI/kw0e1MQC8DH6dESL2U72J8ww9bXT3xCabvdqfHGKq4yH11e9
        6U5ETPdWqaTXmxCT0fkVOLSHRycHFmASNb3cA8E=
X-Google-Smtp-Source: AJdET5dtrFDWxsHFCyL8qqxZnFbPo0cIkBv2lr073aa9I76VFpK88syxTh7DZYiI5cKkK0VcwQWaPeMSOwFBk7TMhKY=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr9197751ioc.118.1540833989468;
 Mon, 29 Oct 2018 10:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181027071003.1347-1-pclouds@gmail.com> <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-7-pclouds@gmail.com> <0ee246db-d781-9a42-8b8c-3e98c132b0ae@gmail.com>
In-Reply-To: <0ee246db-d781-9a42-8b8c-3e98c132b0ae@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 18:26:03 +0100
Message-ID: <CACsJy8CYnngeA8JcFy83qYxKj3saB21Y32VV3R5o1PY_tkAq5Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] preload-index.c: remove #ifdef NO_PTHREADS
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 6:21 PM Ben Peart <peartben@gmail.com> wrote:
> @@ -114,6 +104,9 @@ static void preload_index(struct index_state *index,
>          threads = index->cache_nr / THREAD_COST;
>          if ((index->cache_nr > 1) && (threads < 2) &&
> git_env_bool("GIT_TEST_PRELOAD_INDEX", 0))
>                  threads = 2;
> +       cpus = online_cpus();
> +       if (threads > cpus)
> +               threads = cpus;
>          if (threads < 2)
>                  return;
>          trace_performance_enter();

Capping the number of threads to online_cpus() does not always make
sense. In this case (or at least the original use case where we stat()
over nfs) we want to issue as many requests to nfs server as possible
to reduce latency and it has nothing to do with how many cores we
have. Using more threads than cores might make sense since threads are
blocked by nfs client, but we still want to send more to the server.
-- 
Duy
