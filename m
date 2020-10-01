Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D1AC47420
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C331208B6
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQYidaSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbgJARMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 13:12:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59730 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbgJARMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 13:12:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 790DFD8345;
        Thu,  1 Oct 2020 13:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uaX74bK1S0Ucg6iPIPjPZn4fwk0=; b=WQYida
        SAkZYf6d8OSrmbmjaMepODPQTxPYYaf7Oj4+WTkUoi4nVqr4r4YBQZMm8XvbAwF/
        4gynFw48mcoQ+C6fL4hUnjm77HJF83euqBufU4/7SMdjOT6vw7bN5QxI+USb/uvX
        GiZv0vP3b9yjDI1K+MYIMvZSyzerUmZWJ7hdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=czmI0vCxOWTj7ubNipwbT6ZpouvkMf5I
        3LA4+vD3Gm6sEXcu9yaikJSEWw+lkdI7KM8IYf+3A+ET2TYDRzN8RyK29ZUeP3JJ
        VBCM5B7LAPH9uJwL3Xd5jkqBnlNYA0knMZI18+codfcvkxrD7GnmLq9/VNvh6UdT
        RQwgpwZy96M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71769D8344;
        Thu,  1 Oct 2020 13:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B82D8D8341;
        Thu,  1 Oct 2020 13:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <xmqqlfgqc5kq.fsf@gitster.c.googlers.com>
Date:   Thu, 01 Oct 2020 10:12:12 -0700
In-Reply-To: <xmqqlfgqc5kq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 01 Oct 2020 08:46:13 -0700")
Message-ID: <xmqq4knddg5v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FDEA272-0409-11EB-812B-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
>
>> Changes since v8:
>>   - Disable "commit-graph" when "in_merge_bases_many()" is called
>>     for this check, because it returns different results depending
>>     on whether "commit-graph" is enabled [1].
>
> Is that a wise move, though?  If the "different results" is
> expected, then it is a different story, but I would think it is a
> bug in commit-graph codepath if it produces a result different from
> what the callers expect, and disabling from the caller's end would
> mean that we lose one opportunity to help commit-graph folks to go
> and fix their bugs, no?
>
> Other than that, I think the topic is in quite a good shape.  Thanks
> for working on polishing it.

In other words, how about doing it like so.

In an ideal world, folks who know more about commit-graph than we do
will find what's broken in in_merge_bases_many() when commit-graph
is in use, before I finish lecturing against hiding a breakage under
the rug.  Let's see if another call for help helps ;-)

 remote.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git i/remote.c w/remote.c
index 98a578f5dc..361b8f1c0e 100644
--- i/remote.c
+++ w/remote.c
@@ -2408,7 +2408,20 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 /* Toggle the "commit-graph" feature; return the previously set state. */
 static int toggle_commit_graph(struct repository *repo, int disable) {
 	int prev = repo->commit_graph_disabled;
-	repo->commit_graph_disabled = disable;
+	static int should_toggle = -1;
+
+	if (should_toggle < 0) {
+		/*
+		 * The in_merge_bases_many() seems to misbehave when
+		 * the commit-graph feature is in use.  Disable it for
+		 * normal users, but keep it enabled when specifically
+		 * testing the feature.
+		 */
+		should_toggle = !git_env_bool("GIT_TEST_COMMIT_GRAPH", 0);
+	}
+
+	if (should_toggle)
+		repo->commit_graph_disabled = disable;
 	return prev;
 }
 
