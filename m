Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 12:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiFOMjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbiFOMjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 08:39:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEB3DA40
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:39:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu17so8027601qtb.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=j1KOp1xOvv9gEHZS1/45v5fQ2LkPkSyENTfQkuadTMU=;
        b=T+gM8ftQsm2j7bR13VDSrsmjhgzyuCmjXdJA0/diETKuh0/Btzewyt4fs3ymPMUL5c
         A3Uv3Cq8F/sZu4VVM2W75kG273YW14BWRpgn7TjP42wa/2PRYmEUIsZDhiKbVr/Jnv5d
         VoMkIMONPv3o80Zr0Fcb5jeIui4xKzDXLgO0AHUb4Mm/1ZlqjBvM/oNysJg+vpTNtgO+
         opQ9h4asDPiEfT6PhTXXxju8POjQmJ+rkA2r5iiHNcdMi3SmjJWfclOedlgAejgZ6P3u
         EiZn03Jvm/+pYkGTr9KU+4HPEgqQ9nj0whJlbq2OoEiRfzHRINqTChC7mZ24EkZqa31p
         j9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j1KOp1xOvv9gEHZS1/45v5fQ2LkPkSyENTfQkuadTMU=;
        b=3gVzjTYDNX4IuKXrdteTQxe8iV4v5nlWtKlDt+2uM7u8YCYtDP/KFQyCNbZmYEfUmp
         o3xymmT9O8R+62MVoGo9MIS4AgOS7GMFoKGlq2CaB57gSGUcb0V5n6KEVZWYLtvI8MPC
         nuYBz5+o3zgeIiMwiIUyRh2TqkQJ5gCwB0mz17iqLMyTh73a7GbenlyQZ4PZdWrW6wCw
         j1eoghUx+Sjql86TeASShkdnn5yyCcVjwBzDj3D8P300ZfgtWTAMOdoUwBWEi9kUnPta
         xgD6aUxsW08+MZuKpQkmwev5OkbFzmjne/4s9/QlhAt2S3Uip00+kycPk/ULvu5v80nG
         qv4Q==
X-Gm-Message-State: AOAM5320Xk9GBCM7Kc/O4ZTZ0m6AdUbJVBpcnmq0pyzdMoPQV1QyFRBQ
        VCedFfIZy9Y7x5U13feRyTlVw/SWAdFw
X-Google-Smtp-Source: ABdhPJznxKkjJU7qF9o1aw5cqF10k6Zx6mWxTUKFIJ9Ao2EuqQZQStHcei8KdFr2DXvnnGQXtQMERQ==
X-Received: by 2002:a05:622a:178a:b0:305:1638:dc96 with SMTP id s10-20020a05622a178a00b003051638dc96mr8402018qtk.505.1655296743682;
        Wed, 15 Jun 2022 05:39:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a0bd600b006a73ad95d40sm12407557qki.55.2022.06.15.05.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:39:03 -0700 (PDT)
Message-ID: <ffa6d63c-0efb-d805-dc73-a781e5a92f22@github.com>
Date:   Wed, 15 Jun 2022 08:39:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 2/5] fetch+push tests: add missing coverage for
 6dcbdc0d661
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
 <RFC-patch-2.5-38af32c5b96-20220615T104503Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-patch-2.5-38af32c5b96-20220615T104503Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/22 6:53 AM, Ævar Arnfjörð Bjarmason wrote:
> Add tests that were missing from 6dcbdc0d661 (remote: create
> fetch.credentialsInUrl config, 2022-06-06), we want to test how we
> handle cases where the config comes from a file, and that we handle
> "pushURL" correctly.

The tests use your renamed transfer.credentialsInUrl, but you haven't
renamed at this point.

> Currently the "pushURL" case isn't handled at all, i.e. URLs aren't
> warned about in "remote.*pushurl" , only for "remote.*.url".

Good find. I suppose that the second test_expect_success will _fail_
at the point of this patch?

Thanks,
-Stolee
