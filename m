Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC50C6FD1D
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 04:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCWE2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 00:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCWE2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 00:28:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA233448
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 21:27:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c18so21196380ple.11
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 21:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679545642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG9oR7hNDhg+eEt+ODqTDpnls67/eei012Wosn9Sx90=;
        b=U8IL4/gvSXC6EFm6bGsKZsbPKFD9ONdoW2CgL/SAuXbUQzEkrGo81wR1iB9E2ifwYT
         rX4cV5ba7bhFeCilYaXot5jUqzvzO5aQJdBhsXKsydbr0CDhYX6BMjvnHQAPjcfg4ppU
         yoSy4iHBKOW+OLl5cuoLamEe9LY1OVCEW/PwbX1wLzKKk+ymxgEUH+W6iVmJIE2THnSY
         Jv4XUltKDwQRNEe2YV1D5FnZiC9F5Eug/o22Xct573IxXcXgS8HbsunqqceaUSDcY0HJ
         0zKw97yzqMqoybsnD0RHGPOcMyKlIXkY3oPqpq+2gFhFavZirpnhHQIb1ujV2RLYMC0c
         Yl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG9oR7hNDhg+eEt+ODqTDpnls67/eei012Wosn9Sx90=;
        b=6OiwCZ9EALs7cbWkxrJOKjrh+ARzmthTP+N5FhabKfnCkYzB+isYXf7GQowkDzMyFF
         6HkNq+pGZkB4Py9URGrf7a6Fz6XffL1I8sBh0Q7tGbUwo/gq/L+WpwdL8dyxMKeUFywM
         mV+8n4ttt0kq6i1xM4/6Fm93/TqHjGU3ll4MT5U7kM7AnApEBoIvBT1J6A/dQQYXA69u
         UU+l6lvmg8D7VIyxktEnj5FE9K5AAakqKwtsxH4A/udThkfKVYFZ+OSQnpqjNwOWTphU
         sevUSvCGEdZ4vJqz9szB0kKD+ezb4zI8HPzZOPWlDDBsWlVVB3/Ohw7oLVQUCOHF0bm/
         0j1w==
X-Gm-Message-State: AO0yUKVej2V/F/ATNF74QQaIseZ7zHQNZiybidgS3LZSG16SaOBL9DIK
        kDw+6PEYZisCHKCGMbPsYSCFn95hKttIoaZqWw==
X-Google-Smtp-Source: AK7set9UfkD+gBAWZHJaZirLC5i0SpPegXxX+GztXALkhBWoe+IOaI8M9OXoR8Z7jbDboBY/JXtJXg==
X-Received: by 2002:a05:6a20:c754:b0:d0:4361:9723 with SMTP id hj20-20020a056a20c75400b000d043619723mr1810160pzb.22.1679545642004;
        Wed, 22 Mar 2023 21:27:22 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm11205750pfo.141.2023.03.22.21.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 21:27:21 -0700 (PDT)
Message-ID: <48664dbe-b777-1019-8941-e2948dd55f53@github.com>
Date:   Wed, 22 Mar 2023 21:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: Git 2.41 release date
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <f337e514-8d3b-927a-5fe3-34f67f199435@github.com>
 <xmqq7cv8egvu.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7cv8egvu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> While perusing the Git Calendar [1], I noticed that the final 2.41 release
>> date is on a major US holiday (Memorial Day, May 29). In the past, release
>> dates have been shifted to avoid situations like this, and doing so has been
>> noticeably helpful to downstream maintainers/integrators. Would it make
>> sense to similarly shift 2.41?
> 
> Surely, I will be accomodating, of course.  Thanks for spotting.
> 
> How does Thu June 1st sound?

Thank you so much! June 1st sounds great.

