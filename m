Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84041F461
	for <e@80x24.org>; Wed,  4 Sep 2019 17:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfIDRzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 13:55:06 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:44203 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfIDRzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 13:55:05 -0400
Received: by mail-qk1-f180.google.com with SMTP id i78so18973037qke.11
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7LaEJmpF7LJ4q9EfRBwgyyhqbIdFjM1xylU8qxUpJVI=;
        b=A5rkZsOyxk2+MMhZ2ourvadVT4XIH3AiJpTLaoe7pRkcTmx8kGpkwIvqeNjpYXKNFi
         E1zzT/6hvVrSs9coTC57xn2WIe8mrGQnyQjAKNr3xcDx6M7YpjIPkJTPS+FQx46qiXcP
         cSGV6ap5VlQ8blORkEvmLDuYdjJ2bbL25F3TBbDXjzV6mNsrVkg6tgy+boClWOZVEvXr
         oiS4XKM1h8cvSgAhUOsIbzMpBFsgJW4xkKo6A3s4BwB3MXDV60Zmt5Y9mCegbm3DQ0AB
         y8BUqyE6nDnDZLI5PzBO10+khcc4JxCm0aRRHjdHqkWHLTUZvFcKZb+2J0bwVmK6QFQR
         Ppag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7LaEJmpF7LJ4q9EfRBwgyyhqbIdFjM1xylU8qxUpJVI=;
        b=N0MLnB+nwZczkPX3lDM7Gly45QGWsSqABzac710UMF5fyqHXdkEsSIjK5tFOdvidjF
         mtWfyxo+JvXIFF9Td0QG3k+N3Z8SyVG8yZAmCAX+Co6CqgL8gozSlL7ftBi8ZARmk6Iz
         gIg2d1Ikzw4gY09sEs7dwtVlJ62Mr0zjHqQpYv4W2ib0ERNpRjKY6B/imclZgXbdsWAz
         2+VDPDy4pM72hGWYDKoQ/+B/2pLiZlxayI2OSex/TRkMDrIFgOQm0szvrITE5JtpCE1/
         YQ7HFsoWD91+jXK38DsphtPcnqlpAkQbd+WKgNqqBrndzKR+XQ+mPuIq/QKdA12xU1du
         QKoA==
X-Gm-Message-State: APjAAAUqsQWfn+Rn2f3nYRx43kccg7txug6OvDurK/fmwnZ93WoZOdkY
        O/wGWjfFPRFkUPyLz+H2OrghQuOJV7U=
X-Google-Smtp-Source: APXvYqwjgyBiVa0H8NaLL6NOM2XOXj4yaLVJC+iwoGsaZGSxl6qobt7mv/E9QQmRyvAE2lJDjUg6NQ==
X-Received: by 2002:a37:6650:: with SMTP id a77mr28203016qkc.65.1567619704291;
        Wed, 04 Sep 2019 10:55:04 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:24fd:2e2b:8aac:d853])
        by smtp.gmail.com with ESMTPSA id t17sm991319qtt.57.2019.09.04.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 10:55:03 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:55:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/1] contrib/git-jump/git-jump: support alias expansion
Message-ID: <473a7c7b241ad2d449d3bcb6daeb77a179c7e45f.1567619579.git.me@ttaylorr.com>
References: <cover.1567619579.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567619579.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a caller of 'git-jump' has, say, the alias 'di' assigned to 'diff',
it can be cumbersome to remember to type 'git jump diff' instead of the
shorthand '... di' that they are used to.

Let's teach 'git-jump' to expand these aliases before calling the
mode-specific subroutine. Do so by fetching the configuration value of
'alias.$1', defaulting to "$1" in the case that no alias is set.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/README   | 4 ++++
 contrib/git-jump/git-jump | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 2f618a7f97..9e59990ba0 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -74,6 +74,10 @@ git jump grep -i foo_bar
 
 # use the silver searcher for git jump grep
 git config jump.grepCmd "ag --column"
+
+# jump to changes via an alias of 'git diff', assuming you have set
+# `git config alias.diff di`
+git jump di
 --------------------------------------------------
 
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 931b0fe3a9..15e129b350 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -15,6 +15,8 @@ grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
+
+Aliases of any of the above are expanded automatically.
 EOF
 }
 
@@ -68,7 +70,7 @@ if test $# -lt 1; then
 	usage >&2
 	exit 1
 fi
-mode=$1; shift
+mode="$(git config --default "$1" --get -- "alias.$1")"; shift
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-- 
2.22.0
