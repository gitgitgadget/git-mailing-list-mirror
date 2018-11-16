Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471D41F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbeKQBbx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 20:31:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53043 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 20:31:52 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so35171372itb.2
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 07:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dCtx6RvauUlJJwg5bnL3RVghuun1wpJoDSYglP+abU=;
        b=tC2wuOKR2sXm+hOeBGnBBVnnfxVuyxJ5XlalShFG1mSXr9kkehjGalkh4vwTmRaImB
         hF4x91YfNXCF+C/SnZbzIjbBzSIWvQJGODCilkyHYzyzea6owCk49nLKdEm2rIFTUf7Z
         M723Y/FH8mkPjFcSjvqRaIQxCrGkgaTdlgiGia8dHj1za90NYv0fg0Li9L4mzR34TSka
         EmaBaS6pruy0HC+daf6eBGa6Vjc4yb2g6IGFSqTiLtRLcgCSl8QfmwtRhZBhIINxUcjn
         ZQRGy0xQZF5tWVesUweDRZrPSITFUyN3yk3Z/l53aVp6Z9xjqtNrcdq0Wng+jLsyHGrs
         q+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dCtx6RvauUlJJwg5bnL3RVghuun1wpJoDSYglP+abU=;
        b=iScJWKEI9WgqmTjftuSDpvXizRzeA0HtyZebMfWbe5uayBZVSaiaqU2Spx7Q4vdpln
         ZIwEVhKhKWuP6pHZDxL4QbX43+0ByXYm95oYEApb3u83H9Nb7n8itOCXzizP68eKHeLs
         zZNkafFD1LRLdtnne5e5VeykQ8BGvEthtQ4+La/5K3OsDt3uaU7phjOA2mitJ4GInrwv
         pXvI8CjmgTE7ZLgKYq9xrexOws2h0hPnGgpB3NalblTeXueR2e5Ymzu7EoUxSai27gCO
         6YaI+DH40XEN2vTbqSAO6aPyi88Wx6mIhj500W+1Vx64l0vUY3a8RZQTsgYxg24FznI+
         w3rQ==
X-Gm-Message-State: AGRZ1gIHBMXMbfjElTuQKoSrRuhH+w/hDjm9IkznazaCTjv2nY23N+8P
        EhumDa97KXMuS1amafV8iUvYWahr
X-Google-Smtp-Source: AJdET5d+8vE/kotOXOZYoYnms63VXnpuqlmAPbc27v2Ga4pu+i46dSxTWbgpDi3SrJl6lNhMJtnfrQ==
X-Received: by 2002:a02:5ac2:: with SMTP id v185-v6mr9430418jaa.15.1542381544355;
        Fri, 16 Nov 2018 07:19:04 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id n26sm3744889iob.73.2018.11.16.07.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:19:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:19:01 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 0/2] Fix scissors bug during merge conflict
Message-ID: <cover.1542380929.git.liu.denton@gmail.com>
References: <cover.1542172724.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542172724.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your feedback, Junio.

I tried to reroll the patch by adding another option into the MERGE_MODE
file but unfortunately, it didn't work completely because doing `merge
--squash` doesn't produce a MERGE_MODE. In addition to this, because of
the way merge and commit were structured, I needed to reorder a lot of
calls because some variables were only being set after I needed them.
Unless we want to produce a MERGE_MODE during --squash (which I don't
think is worth it) I don't think that this is the way to go.

Instead, I just refined my first approach and only checked the contents
of MERGE_MSG for a scissors line. The MERGE_MSG is going to be
machine-generated anyway so we should be safe from accidentally ignoring
a human-placed scissors line.

Changes since V1:
-----------------
* Only check MERGE_MSG for a scissors line instead of all prepended files
* Make a variable static in merge where appropriate
* Add passthrough options in pull
* Add documentation for the new option
* Add tests to ensure desired behaviour

Denton Liu (2):
  commit: don't add scissors line if one exists
  merge: add scissors line on merge conflict

 Documentation/merge-options.txt |  6 +++++
 builtin/commit.c                | 15 +++++++++--
 builtin/merge.c                 | 16 +++++++++++
 builtin/pull.c                  |  6 +++++
 t/t7600-merge.sh                | 48 +++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.19.1

