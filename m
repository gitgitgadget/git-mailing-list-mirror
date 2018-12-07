Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC0520A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 13:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLGNdj (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 08:33:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 08:33:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so4405706qtq.9
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=yX/bfzIZ90gtSpkzv5ad1sMnxakSH0A6tJ6BZyMy6Xc=;
        b=p+Ya10ac0ARjWYulGdEtcqneFIfS0Sbl2/1EHAiMUwfW9v8VwZhblpfAM6HSulk8Gr
         GK8PNw3x4TgJrfJutPWvFP9Lavh6ufEIKYxEpUueIrasXl4HwV9chRkh3McxC/IHTZRR
         5SC0jVUnEMXzf4QSdJfHgrLECgImx3lcQovo5bsJjBe4g4xx0oVjnIrvaB6R7SewjqPD
         Ak7r94ovZHqpUcMQvSnCNnmo3f9/zrUK+YhjYXR6wXy6RrTCr0+2eNweLk8AB+UdtbKO
         qnjuBVHB16K6MYBy4qfJ+Tab4StHFhOTR1Tb4ZjAdHGVrH2DCprLZz4dWNJ0EcapO3am
         62NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yX/bfzIZ90gtSpkzv5ad1sMnxakSH0A6tJ6BZyMy6Xc=;
        b=bL9BUTv22SgXuOljqPq5NYHfPWhO39KG4eZkkEhllYQjwBh8SbmuQTBBEN3g0dLeCi
         Lbg9o0LaZnA35IUtXbf1t+U9ITIrwvCEx2StwCcGIaYqLdWx+fY5XdHweGU5Ieh9g8SO
         mk8QdCsH5G5Cb0DVVy/ps6eFVCY1sq6nDTiOedmNd/42sCpPTMXJ5ip2BfjQjqWsE/Hc
         R0Rdo6NJ6hL+4GKkPYIPNVpw3x0BVvE0JOt+IcXVguF2FTFl7xYYWlmS7BN8YYn7fOfd
         Z+0jsbKQOxdFU/acF6pZqL7RsFuEpLQYGMAn+lx4scyUPsdeGFHaLPyV21SDQdFyDuAj
         SwAQ==
X-Gm-Message-State: AA+aEWY1qoEmB1A+PtFUTuu0SnIH3Bf0szP0PJLbAElLjFBUNsF0oUtg
        dPQ3RKmH/PtBTBhTr7+wvVQ=
X-Google-Smtp-Source: AFSGD/Xm9K2FCCVIEv66PITjp1FSK2ytWj6hG3Gz4wb0ctuFIO4gpQzleYVq+t1oqRXY7Ts/7OB2mg==
X-Received: by 2002:a0c:f053:: with SMTP id b19mr1988925qvl.29.1544189617707;
        Fri, 07 Dec 2018 05:33:37 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:84f0:5a6c:bde1:b2f7? ([2001:4898:8010:0:6e26:5a6c:bde1:b2f7])
        by smtp.gmail.com with ESMTPSA id y4sm2211079qtc.47.2018.12.07.05.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 05:33:36 -0800 (PST)
Subject: Re: [PATCH v2 2/3] commit-graph: fix buffer read-overflow
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544127439.git.steadmon@google.com>
 <af45c2337fbe2a59ac95aff3ce90a69d8c30416f.1544127439.git.steadmon@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7d3693c7-3926-b09d-fa17-faf5aa1dcde9@gmail.com>
Date:   Fri, 7 Dec 2018 08:33:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <af45c2337fbe2a59ac95aff3ce90a69d8c30416f.1544127439.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/6/2018 3:20 PM, Josh Steadmon wrote:
> +
> +# usage: corrupt_and_zero_graph_then_verify <corrupt_position> <data> <zero_position> <string>
> +# Manipulates the commit-graph file at <corrupt_position> by inserting the data,
> +# then zeros the file starting at <zero_position>. Finally, runs
> +# 'git commit-graph verify' and places the output in the file 'err'. Tests 'err'
> +# for the given string.
> +corrupt_and_zero_graph_then_verify() {

This method is very similar to to 'corrupt_graph_and_verify()', the only 
difference being the zero_pos, which zeroes the graph.

Could it instead be a modification of corrupt_graph_and_verify() where 
$4 is interpreted as zero_pos, and if it is blank we don't do the 
truncation?

> +test_expect_success 'detect truncated graph' '
> +	corrupt_and_zero_graph_then_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
> +		$GRAPH_CHUNK_LOOKUP_OFFSET "chunk lookup table entry missing"
> +'
> +

Thanks for this! I think it's valuable to keep explicit tests around 
that were discovered from your fuzz tests. Specifically, I can repeat 
the test when I get around to the next file format.

Thanks,
-Stolee
