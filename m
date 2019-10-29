Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88B81F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfJ2VTA (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 17:19:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfJ2VS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 17:18:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so10531024pfb.10
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1rlMCFeCe1gwVcwWHuOa7BkqVfDQ4LGR8aZ0I/6kN0=;
        b=HFAUGW+O+iULzDtjfhczI+GrhYwsfqqRlYqzLBkMPs4nFVruQZtUbQkrJnVxqdOfJ7
         A0+spUBsOAb0paUF+EEf6SAoRTZzmJKL6+txfae5XapQx7mOrIbtvCaexbXNjAkawZYd
         AYpYnXeHgyAwUMtXxTySzSAN1ky6bFHmJWJxMqNhsE+hw33SVwnQLjeT8GnWQMN57eGw
         sraACfqWnPnhtn18EfBqi36nFTRfEME68L4/Ejn5uK/pSCUBouACfrW4lcH5YMGJKVBo
         rzQZUeC4BOB5ChtZh+dEr2lpz8aDmLn+dn2XReFHB4u5IXYDwEbIjRtPDPXus4H455+W
         nLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=I1rlMCFeCe1gwVcwWHuOa7BkqVfDQ4LGR8aZ0I/6kN0=;
        b=MARI5qWsjDxk8LZZMFxqgoudiwDG82FLJuOzl1w9CJwCnMaXSBAdKryAFHRmsLuftW
         eiz/q07hL/EW1ykuse/shiG/0vAw2ygC+AOXvebRo2p4JhadLhBst+3SH+l3VxdGF0CW
         lq93tIyY432C9sXsHztedFZgsqXOzVmznKpwUbYeCP9QJ+83aoSh5Rjc6TGM8MRt6YaU
         4QQS6IKi6alRgssD53/Ujy1vw1dwAgn2OGW6oVDHQvE3ngcLaAbcl4TQGMlIjeJCSl/b
         mzvXuIt4hz7HPDtr65PKiCaOFNqKgUWwg99t5dX05JqB3ICS9nJx9mVALzn0UetNzMkr
         wXnw==
X-Gm-Message-State: APjAAAU0OnRFQF31fhfEPa9ImRvR628j4d6+xew+21nr6QljfPC06X2h
        wqKmVimfaN1wk4ahNF7o/7pn5g==
X-Google-Smtp-Source: APXvYqyM9POuKSumi+j80eGrJxfKWFzbKYghQNnmmCtwrdqV3Vv7dEwPZW+Cb+q7JWZ32sganWj1KA==
X-Received: by 2002:a63:1242:: with SMTP id 2mr20703367pgs.288.1572383938616;
        Tue, 29 Oct 2019 14:18:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id l24sm35300pff.151.2019.10.29.14.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:18:57 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:18:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/9] bugreport: count loose objects
Message-ID: <20191029211853.GD12243@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-7-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025025129.250049-7-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.24 19:51, Emily Shaffer wrote:
[snip]
> diff --git a/bugreport.h b/bugreport.h
> index 942a5436e3..09ad0c2599 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -18,3 +18,9 @@ void get_whitelisted_config(struct strbuf *sys_info);
>   * contents of hook_info will be discarded.
>   */
>  void get_populated_hooks(struct strbuf *hook_info);
> +
> +/**
> + * Adds the output of `git count-object -vH`. The previous contents of hook_info
> + * will be discarded.
> + */
> +void get_loose_object_summary(struct strbuf *obj_info);

Looks like a copy/paste typo here, shouldn't "hook_info" be "obj_info"
in the comment?
