Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2EC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 13:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFB92064C
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 13:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiKvms9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDXNRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXNRU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 09:17:20 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD6C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 06:17:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so12202296otq.13
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AP4FkA9R+d+OHfPeog/NJTN0QBJuVQds+cdAcC12SUs=;
        b=GiKvms9ne1wMr/VNtTdL8lmUl28l3QFdQJsamsyBz/C1kd2zPVC8eQcgpWTbnXS/ub
         tK9cbbDBvNpPEryYGEn3ndcJeVZBcyFBLSVP7E7N+pvMQEni0m7Q32EuaDpyOgDoj2zQ
         FVyDkOsJAcKbBGaWU0kpd4/wF/sHVIzRZgzETA6uXX11c/hVijU7qAUnneKuSnnX7ILF
         p739K4kzHLcOp+pKTd6YwqK1Y8PNlXProcIRV4uDl15HCX0YxGetRmLXDVbP8TrJ+/4U
         VGkXrVpzIUj+5DHsqaH64e0wNfei/eqkLxFGCItzcE/NGiWG47i6mbTna6cAUWPVEqbf
         hfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AP4FkA9R+d+OHfPeog/NJTN0QBJuVQds+cdAcC12SUs=;
        b=IqE6OHfK14BWZ09vmkot7OsHD4jaDrqkQ6MCcChcGQDmGtA6jvGhXcSL3ayDSlLFGm
         AfK0V4pAFDxeJzW2FfxnVkLi/cywlzPF8TOGleFsxvU9S1M17G+rVDt3EJOJbYKGm/Ae
         Oq/AEnc5ehbHtSKUvAbamKIPquZM1YWQzl0fFZ759q2zFbB5j4JtET2rFEsfvgIB8NA5
         i3lqIhnLviwgiE7ri1V4IYbQoYcx1Msxq0G23SZeRh1r9QY2gdEuLCsScdXxgJwMI2AX
         nOpi7iFKFUve9fdCV60bZxKYBscL3TZEL4OtA6PeWWm2sIeA8kINFUDevkIihP4rqMbz
         bYXg==
X-Gm-Message-State: AGi0PuZ/178eKWzRSJ2LKO94Pi55E3TBcA9XkWUdaThqtOksojw7yPd0
        lT8KHPt1cinAtvm/Nwod6tJ1wIV9JDo=
X-Google-Smtp-Source: APiQypKjsDIzYlarxEqnl/rOXfdjejgumkzxhfJummLwNfoAEJkq9ESIjQcBHnigXqShs699dVbSiw==
X-Received: by 2002:a9d:550e:: with SMTP id l14mr7211539oth.121.1587734239634;
        Fri, 24 Apr 2020 06:17:19 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o18sm1477453otj.23.2020.04.24.06.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:17:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] commit-graph: close descriptors after mmap
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        dstolee@microsoft.com
References: <cover.1587677671.git.me@ttaylorr.com>
 <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
 <xmqq368tg8po.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2232c379-d0ec-0b52-96b4-379438642785@gmail.com>
Date:   Fri, 24 Apr 2020 09:17:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqq368tg8po.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/23/2020 6:04 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> From: Jeff King <peff@peff.net>
>>
>> We don't ever refer to the descriptor after mmap-ing it. And keeping it
>> open means we can run out of descriptors in degenerate cases (e.g.,
>> thousands of split chain files). Let's close it as soon as possible.
> 
> Yikes.  
> 
> Sorry, I should have looked at the use of mmap in this topioc more
> carefully when we queued the series.  It is an easy mistake to make
> by anybody new to the API to leave it open while the region is in
> use.

You are right. I was new when first contributing the commit-graph. It
was also easier to miss because we only had one commit-graph open at
the time. Adding in the incremental file format led to multiple file
descriptors being open.

However, this idea of closing a descriptor after an mmap is new to
me. So I thought about other situations where I made the same mistake.
Please see the patch below.

> With this fix, with or without the other topics still in flight, I
> do not think no code touches graph_fd.  Should we remove the
> graph_fd field from the structure as well?

I agree that this should be done.

Thanks,
-Stolee

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 24 Apr 2020 13:11:13 +0000
Subject: [PATCH] multi-pack-index: close file descriptor after mmap

We recently discovered that the commit-graph was not closing its
file descriptor after memory-mapping the file contents. After this
mmap() succeeds, there is no need to keep the file descriptor open.
In fact, there is signficant reason to close it so we do not run
out of descriptors.

This is entirely my fault for not knowing that we can have an open
mmap while also closing the descriptor. Some could blame this on
being a new contributor when the series was first submitted, but
even years later this is still new information to me.

That made me realize that I used the same pattern when opening a
multi-pack-index. Since this file is not (yet) incremental, there
will be at most one descriptor open for this reason. It is still
worth fixing, especially if we extend the format to be incremental
like the commit-graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 4 +---
 midx.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index 1527e464a7..60d30e873b 100644
--- a/midx.c
+++ b/midx.c
@@ -72,9 +72,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	FREE_AND_NULL(midx_name);
 
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
 
 	FLEX_ALLOC_STR(m, object_dir, object_dir);
-	m->fd = fd;
 	m->data = midx_map;
 	m->data_len = midx_size;
 	m->local = local;
@@ -190,8 +190,6 @@ void close_midx(struct multi_pack_index *m)
 		return;
 
 	munmap((unsigned char *)m->data, m->data_len);
-	close(m->fd);
-	m->fd = -1;
 
 	for (i = 0; i < m->num_packs; i++) {
 		if (m->packs[i])
diff --git a/midx.h b/midx.h
index e6fa356b5c..b18cf53bc4 100644
--- a/midx.h
+++ b/midx.h
@@ -12,8 +12,6 @@ struct repository;
 struct multi_pack_index {
 	struct multi_pack_index *next;
 
-	int fd;
-
 	const unsigned char *data;
 	size_t data_len;
 
-- 
2.26.2

