Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A3C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKHTIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKHTIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:08:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC91A832
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:08:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so22482065wrs.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/1szkQWFrp9ZzWmj4dDcjZ9DG3uBjDO0qjHthAlnbU=;
        b=WKgq+heb6t3ml0uwn4KdJXXLk3YzxWlnvk5s2I+oT19yBUOK6yNwyLtqGr8PgJHLxl
         /RcDCyd6xvYa1MRhDxEXA+yP+cRulLscrMjxcKeyaKicnhT5cfc0joSZWpcU+/aC5l6/
         gvM6hDC+cesJEvn+gyLzk6zyhNNKJ/6Lv3iqOOxT1g8GDAUi3KE24qieFtFKepvFuVla
         nwlu5g4b9WidBfodXq8wFCSmrVUaqtLTvh9/7KwzjzxuN6bVTC5xuo13pIW+vDtpmDm9
         tQqF/1IpWYfYUW58/Ov35d0nGQcr0oZMrJwwoXmOYCFZiW+bUwHQ2hj6Dg24YUUQsR6I
         NWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/1szkQWFrp9ZzWmj4dDcjZ9DG3uBjDO0qjHthAlnbU=;
        b=qEhBIKNkW9yciT0FVKjA8MDo+JihRetKgToxe67qwaeDkTZPpGhx+BQEjrzNKW4scc
         he9u4yX51rq1JW8zIYbcGpX43ZJdXPvMRlah7UAYrZmyfKISvOYDJe0r6r5rU0JjVJPA
         YnCvX5jlQZTFnmkL1sF7Z3ECI5h3PDYRxuA+2RLOANovdI/GFIvk0HJh6NCvXTyRnEXT
         ikZrm1xzD0+roM2Rkt84qgpdba1osMEVgUArCx71IJPGKjcB80XXinRxpuU+uz9iyDXL
         NPgFgKpRC9b9N5wVKH0U4QKiS8MrFbg9niL+uzM8KH7+AxoYAfj9ynVamtJcUKqUF91Q
         PaWg==
X-Gm-Message-State: ACrzQf3J/ad39sljwEXtLG/NsxFj0vuwkat/Y4TFHtLpJ7TfOaaBAVg9
        7MdkA+JZUkEelVEgDLAuQOQZ086FK7I=
X-Google-Smtp-Source: AMsMyM4dQe0KI9Ji5+AbG0XAsKdmUNLzf39hfYRczCiI+CeEqu+O33P6eZAgtuaDSUhK/g3G1Ey4RQ==
X-Received: by 2002:a05:6000:18c7:b0:22e:5503:9c46 with SMTP id w7-20020a05600018c700b0022e55039c46mr34712419wrq.668.1667934513123;
        Tue, 08 Nov 2022 11:08:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d684d000000b0023677693532sm10914101wrw.14.2022.11.08.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:08:32 -0800 (PST)
Message-Id: <31af383fd439c3c0a5003598961acfecfae4018c.1667934510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 19:08:28 +0000
Subject: [PATCH 2/4] chainlint: tighten accuracy when consuming input stream
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

To extract the next token in the input stream, Lexer::scan_token() finds
the start of the token by skipping whitespace, then consumes characters
belonging to the token until it encounters a non-token character, such
as an operator, punctuation, or whitespace. In the case of an operator
or punctuation which ends a token, before returning the just-scanned
token, it pushes that operator or punctuation character back onto the
input stream to ensure that it will be the first character consumed by
the next call to scan_token().

However, scan_token() is intentionally lax when whitespace ends a token;
it doesn't bother pushing the whitespace character back onto the token
stream since it knows that the next call to scan_token() will, as its
first step, skip over whitespace anyhow when looking for the start of
the token.

Although such laxity is harmless for the proper functioning of the
lexical analyzer, it does make it difficult to precisely identify the
token's end position in the input stream. Accurate token position
information may be desirable, for instance, to annotate problems or
highlight other interesting facets of the input found during the parsing
phase. To accommodate such possibilities, tighten scan_token() by making
it push the token-ending whitespace character back onto the input
stream, just as it does for other token-ending characters.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 9908de6c758..1f66c03c593 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -179,7 +179,7 @@ RESTART:
 		# handle special characters
 		last unless $$b =~ /\G(.)/sgc;
 		my $c = $1;
-		last if $c =~ /^[ \t]$/; # whitespace ends token
+		pos($$b)--, last if $c =~ /^[ \t]$/; # whitespace ends token
 		pos($$b)--, last if length($token) && $c =~ /^[;&|<>(){}\n]$/;
 		$token .= $self->scan_sqstring(), next if $c eq "'";
 		$token .= $self->scan_dqstring(), next if $c eq '"';
-- 
gitgitgadget

