Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC55C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFEA60FEA
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbhGSQ2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbhGSQ1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:27:06 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39999C078829
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:31:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y6so16582906ilj.13
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tk8n8AZBUuOwjNbyqJHckAQo8IA4ZnVbXwoJSh4LTcY=;
        b=HCeRKMs/P4+97F9Rj207xm0QtVmV+Z37kKC6CjI9oBu+O8JIj6LHgrfXBOlxMvl4mG
         QApLoFb71pMhVuzpmldGBnBjmC4i8dPrONsuQwK7UUiUo7G8cNIjyf05x8YLgUm6ZTwN
         duFCTcWQ4Hr39Lgkq4BZeqe2/sW04aBh4FExPOv0LYQ/s7VMjKmhXuajQ2PpmgJ4/HM8
         aPYfIk4D2qNYAApr4PWSjA9Y/5mmOap0+RBkooy8FmePQIwsNfr/Xt9bpJ1GB1DLul3W
         76NQLkFsko+hgOO47LWA5soqTp5bztGdYS26UPcDwgDKIES3MJGwYQML0+bdptr42XbY
         vW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tk8n8AZBUuOwjNbyqJHckAQo8IA4ZnVbXwoJSh4LTcY=;
        b=nb4kZoyxDOqH7t9mARcRrz2TSt/PqEWfASokEbR5tuBNZl14BPD3YkZv2+hywFLiiD
         lYvmKJLoK21X6dXo+C6VPnkiBsUR4CJO3RrOFc06ViJTLBZGHyn4usARGeS7m9xb+udo
         8sbLnz4p/hG/AppvDDrOzBHrJIC+QRnuYowVmvyI1JeJujpzPUl3UidpJr8iNphtekTB
         XrIQnvwrkEBsbAzLar/NJmHbtp9OQWgmhZi9GfKu6k0gXyK0soVb+KVypItyV3JS0tOE
         2oMJuC3jO39kXyjObpVNrjx1Om1egRvZqiXwRZZgRMRgyXEfk0OZ/m319Y6I7s3CiwqE
         rR3g==
X-Gm-Message-State: AOAM533pboRBKpDDuEWKROQBfc8WpbmbXf+WxO3G1MjdGdfEhAZrw9ES
        TPyOKS2DoS6EG1vgxb16hScdmw==
X-Google-Smtp-Source: ABdhPJzJBmSfwttZzGaECfTpOTJm6la7Z6CEibehF8kEXmH7fAhB2MCHM5kwWM0qOZOU7ptJINbk2Q==
X-Received: by 2002:a92:d07:: with SMTP id 7mr17047440iln.114.1626713596628;
        Mon, 19 Jul 2021 09:53:16 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id u10sm5991809iop.15.2021.07.19.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:53:16 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:53:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/5] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <YPWt++xs6lrqiExV@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-5.5-57ffd5812d6-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.5-57ffd5812d6-20210718T074936Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 09:58:09AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change the parse_options() invocation in the commit-graph code to make
> sense. We're calling it twice, once for common options parsing, and
> then for the sub-commands.
>
> But we never checked if we had something leftover in argc in "write"
> or "verify", as a result we'd silently accept garbage in these
> subcommands. Let's not do that.

All makes sense and looks good to me. One small note below:

>  test_expect_success 'usage' '
>  	test_expect_code 129 git commit-graph -h 2>err &&
> -	! grep error: err
> +	! grep error: err &&

Ah, now I see why you added this test back in the first patch. I still
think that we should get rid of the first two lines, but...

> +	test_expect_code 129 git commit-graph write blah &&
> +	test_expect_code 129 git commit-graph write verify

Keeping these makes sense.

Thanks,
Taylor
