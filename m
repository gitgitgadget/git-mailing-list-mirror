Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033331F453
	for <e@80x24.org>; Wed, 24 Oct 2018 13:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeJXVuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 17:50:54 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37196 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXVuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 17:50:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id y5so1846472uap.4
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xQpsT4ITYmnVaEkXYCkPp6uDrBjjgFQhytzaDhhqCTo=;
        b=LJS0i5fj6pKqR/arme0iA6eSvhWCnigyN+9vLCKSe9GvI0coLurW/9IkyVIv3Ak/7C
         YzwVQT2nyuppwJycIrmr7TvnkAy1sJm0VW4glP53q2Im27oq6GSdCE1GWr5QOJvQC3UK
         M7hmoqy2MAKkzOQqNRXO+sMYFBNbnRPqlyj7rpA+SE//wQLpNdbz4y5G0b+9mGqNGFVs
         ibq1Oe4DKTUORPtypmtKG2RdyGbXPuGLlPgxXeMxSPwd5JXPM5uN/IgnENGm8PlXH/Pq
         V+NoamMjvCaWIfSfQN+Di078g+FNE1up+czOHKTHtN6TJsDHQ0EnTwCshSlbP/8Uaffg
         yDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xQpsT4ITYmnVaEkXYCkPp6uDrBjjgFQhytzaDhhqCTo=;
        b=nPCB2Kpp6X1Eon+foTS0hI9hQLhVtIzgpUhwLKr//zLc6BuHtLrJNihDBiYyZGa5Qo
         vqTQnvK4m4s+E0glTWRhY7XOI0e7VEziwHIpci7qjYfxLEyjX8Mgc3BtsbXRcGuYhhIv
         Iy6eDW5phAU9isAc7S5Qeb9OiyZNKCHJc1qJr5Tw6MIvR5bzIMBC+RxIpFc4I9Wdi0Lg
         Q3CcgO18Gho2hmYUKBGlRdbN7CZyVDEegtGMe3mC9gUoX9FEoeT0sz7B9gQ/4a6NzLBa
         gzXrtjQUj/IYGn7m4p0+7/vfZvBbhvSpiTe8djl+XntHK90HnJCYa1vEF5na1/b3siRu
         3piA==
X-Gm-Message-State: AGRZ1gIOn1mjFTzCaXnj/SsEi06Wi9l+2FdKKVuSRoCRNjj9gzG7iiMl
        JFSXKoF4moSHxyVF7xrEE9uSG/Vu
X-Google-Smtp-Source: AJdET5cAdGzdOS8bbSu3HzEgHbfNoSXWrlgbTME3MUV+b7wQ2fdiw/Yx9OZa8RptckJGF+zZMvdP8g==
X-Received: by 2002:ab0:5ac5:: with SMTP id x5mr1172464uae.72.1540387367291;
        Wed, 24 Oct 2018 06:22:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3c92:d38f:3214:6b65? ([2001:4898:8010:0:25c8:d38f:3214:6b65])
        by smtp.gmail.com with ESMTPSA id s6sm1074555vkd.36.2018.10.24.06.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:22:46 -0700 (PDT)
Subject: Re: [PATCH v3 09/12] commit-graph: convert to using the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
 <20181022024342.489564-10-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a53e1c78-ef1d-220c-4592-99616798514a@gmail.com>
Date:   Wed, 24 Oct 2018 09:22:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <20181022024342.489564-10-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21/2018 10:43 PM, brian m. carlson wrote:
> Instead of using hard-coded constants for object sizes, use
> the_hash_algo to look them up.  In addition, use a function call to look
> up the object ID version and produce the correct value.  For now, we use
> version 1, which means to use the default algorithm used in the rest of
> the repository.

This patch looks good to me. Later, we will want to delete the 
commit-graph file during the "upgrade the repo to newhash" process, but 
that can wait.

Thanks,
-Stolee
