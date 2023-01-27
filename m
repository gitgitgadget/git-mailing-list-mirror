Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC43C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 19:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjA0TVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjA0TVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 14:21:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F57D289
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:21:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s67so3851671pgs.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSXvdeVbPLIfT1l0lnlK+c+YAeAu443YnjthDc/+9ME=;
        b=KmbvArUVhGobEUMB0Cz6h+UqexUhT6zMJ84l0Amqe00i27L2hdJAsNT6CvtJcy8VkW
         7MM5ut9SksG3QLvUCjOySdkO5DvhfmcZdh11NJpZ9Fx8SZsU4Xa6izNMYnTthdfcXJay
         Hm8jDZhjLYUK1uTlWQa5/Vsuq39IbgwBrwFf/AVDyVJ3yBQ6suBp1Do3RMur93MIDfJE
         QPGxwhiwwrmwUEVTitt7SsenOhajQATHOct2T9SPqkfTzpUOG4KS0zFp83iVuxkDIt5X
         w9cezZdX/EZzmR1cl9rO/5iRXlZTbmlgKJGsWSQ0R04rDGNkbhLotV36SOq6D54bRSV7
         CIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSXvdeVbPLIfT1l0lnlK+c+YAeAu443YnjthDc/+9ME=;
        b=zkQjHjuo42zTmWbCNJ3JmAjwd3/HrUyYhRxeUhDwEoYeTvbVBWIP/QtT7KpSUgmkEh
         Gr2zOIr+9zZ7RUfHqK9pliG2Pj/tMN7cnjuiiKeW4jGyPDD8crRgWfpOVSyQ1SzED+eq
         pUqu/LN8ObLcQzzslyt9v40znkpFCwklLS0dE4/N4c6KDS8tVUBm0r8CD8UFEAkDIBCS
         vH+M8Hddx4wL5kfi4qS1cJGrk1Wl8vNrXYe+Fq7dGpX+IMpCVMm5xwbrmMdJnBAASK+W
         od5oyAkNaZIghb/6n6ZrByGREPnOpqWQmzb32HcgGSKylcAw1c2Ktqxe25QRtuQm0rzS
         2KHw==
X-Gm-Message-State: AO0yUKXHV/FoMgWMi3isg2cMcGift8xhOaIsk0wMPjaDh62WKhoFKtyl
        vWUZi5DVouqTGEDhhBqMJJ/e
X-Google-Smtp-Source: AK7set+W7feL2AqjYXGW2OX+0ozMaDQtpm/OMDNSwQbG8E8QIu5h+2XvX3dRk4FaGMJ0lg41qFAKDA==
X-Received: by 2002:a05:6a00:4505:b0:593:2e88:1680 with SMTP id cw5-20020a056a00450500b005932e881680mr1710052pfb.6.1674847306546;
        Fri, 27 Jan 2023 11:21:46 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id v64-20020a626143000000b00574ebfdc721sm3112415pfb.16.2023.01.27.11.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:21:46 -0800 (PST)
Message-ID: <b3f2992d-f614-5cc7-f606-d3607a154685@github.com>
Date:   Fri, 27 Jan 2023 11:21:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 10/10] bundle-uri: test missing bundles with heuristic
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <676522615ad0e8f24099ef35a0f39367e5f688ae.1674487310.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <676522615ad0e8f24099ef35a0f39367e5f688ae.1674487310.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The creationToken heuristic uses a different mechanism for downloading
> bundles from the "standard" approach. Specifically: it uses a concrete
> order based on the creationToken values and attempts to download as few
> bundles as possible. It also modifies local config to store a value for
> future fetches to avoid downloading bundles, if possible.
> 
> However, if any of the individual bundles has a failed download, then
> the logic for the ordering comes into question. It is important to avoid
> infinite loops, assigning invalid creation token values in config, but
> also to be opportunistic as possible when downloading as many bundles as
> seem appropriate.
> 
> These tests were used to inform the implementation of
> fetch_bundles_by_token() in bundle-uri.c, but are being added
> independently here to allow focusing on faulty downloads. There may be
> more cases that could be added that result in modifications to
> fetch_bundles_by_token() as interesting data shapes reveal themselves in
> real scenarios.
> 

The expanded testing is great, thanks for adding it!

> +	# Case 2: middle bundle does not exist, only two bundles can unbundle
> +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = bundle-1.bundle
> +		creationToken = 1
> +
> +	[bundle "bundle-2"]
> +		uri = fake.bundle
> +		creationToken = 2
> +
> +	[bundle "bundle-3"]
> +		uri = bundle-3.bundle
> +		creationToken = 3
> +
> +	[bundle "bundle-4"]
> +		uri = bundle-4.bundle
> +		creationToken = 4
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-clone-2.txt" \
> +	git clone --single-branch --branch=base \
> +		--bundle-uri="$HTTPD_URL/bundle-list" \
> +		"$HTTPD_URL/smart/fetch.git" download-2 &&
> +
> +	# Bundle failure does not set these configs.
> +	test_must_fail git -C download-2 config fetch.bundleuri &&
> +	test_must_fail git -C download-2 config fetch.bundlecreationtoken &&
> +
> +	cat >expect <<-EOF &&
> +	$HTTPD_URL/bundle-list
> +	$HTTPD_URL/bundle-4.bundle
> +	$HTTPD_URL/bundle-3.bundle
> +	$HTTPD_URL/fake.bundle
> +	$HTTPD_URL/bundle-1.bundle
> +	EOF
> +	test_remote_https_urls <trace-clone-2.txt >actual &&
> +	test_cmp expect actual &&
> +
> +	# Only base bundle unbundled.
> +	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	cat >expect <<-EOF &&
> +	refs/bundles/base
> +	refs/bundles/right
> +	EOF
> +	test_cmp expect refs &&

Maybe I'm misreading, but I don't think the comment ("Only base bundle
unbundled") lines up with the expected bundle refs (both bundle-1
('refs/bundles/base') and bundle-3 ('refs/bundles/right') seem to be
unbundled). 

> +
> +	# Case 3: top bundle does not exist, rest unbundle fine.
> +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = bundle-1.bundle
> +		creationToken = 1
> +
> +	[bundle "bundle-2"]
> +		uri = bundle-2.bundle
> +		creationToken = 2
> +
> +	[bundle "bundle-3"]
> +		uri = bundle-3.bundle
> +		creationToken = 3
> +
> +	[bundle "bundle-4"]
> +		uri = fake.bundle
> +		creationToken = 4
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-clone-3.txt" \
> +	git clone --single-branch --branch=base \
> +		--bundle-uri="$HTTPD_URL/bundle-list" \
> +		"$HTTPD_URL/smart/fetch.git" download-3 &&
> +
> +	# As long as we have continguous successful downloads,
> +	# we _do_ set these configs.
> +	test_cmp_config -C download-3 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
> +	test_cmp_config -C download-3 3 fetch.bundlecreationtoken &&
> +
> +	cat >expect <<-EOF &&
> +	$HTTPD_URL/bundle-list
> +	$HTTPD_URL/fake.bundle
> +	$HTTPD_URL/bundle-3.bundle
> +	$HTTPD_URL/bundle-2.bundle
> +	$HTTPD_URL/bundle-1.bundle
> +	EOF
> +	test_remote_https_urls <trace-clone-3.txt >actual &&
> +	test_cmp expect actual &&
> +
> +	# All bundles failed to unbundle
> +	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	cat >expect <<-EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	refs/bundles/right
> +	EOF
> +	test_cmp expect refs

Similar issue with the comment here - it says that all bundles *failed* to
unbundle, but the test case description ("Case 3: top bundle does not exist,
rest unbundle fine.") and the result show bundle-1, bundle-2, and bundle-3
all unbundling successfully.

> +'
> +
> +# Expand the bundle list to include other interesting shapes, specifically
> +# interesting for use when fetching from a previous state.
> +#
> +# ---------------- bundle-7
> +#       7
> +#     _/|\_
> +# ---/--|--\------ bundle-6
> +#   5   |   6
> +# --|---|---|----- bundle-4
> +#   |   4   |
> +#   |  / \  /
> +# --|-|---|/------ bundle-3 (the client will be caught up to this point.)
> +#   \ |   3
> +# ---\|---|------- bundle-2
> +#     2   |
> +# ----|---|------- bundle-1
> +#      \ /
> +#       1
> +#       |
> +# (previous commits)

...

> +	# Case 1: all bundles exist: successful unbundling of all bundles

...

> +	# Case 2: middle bundle does not exist, only bundle-4 can unbundle

...

> +	# Case 3: top bundle does not exist, rest unbundle fine.

The rest of these cases look okay and, at a high-level, it's helpful to have
these additional tests covering a different topology.

