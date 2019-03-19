Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B5A20248
	for <e@80x24.org>; Tue, 19 Mar 2019 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCSUsc (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 16:48:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42229 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCSUsb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 16:48:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so207904pfn.9
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5aS8jWbLfhGgqCwrN6K2+MrJUyRHTwGiqZ6+Qmo2Ca8=;
        b=eoBctRkGXME849PvCwBCutygeAg6VGUJFyH0cWj1SS794gttlXFSb3sQJPlz2HmF4U
         ZtvTGOoRVY4kKKWvqzFoqdqrefSvdgm/2Th8YksixtQdHXUqHXub5uiHMiIbtrMUUK4R
         3723yc26zFdRZ9E9a0HjDLtPuZI5KEHUpiS7IWpxSly579rgn9SpB6p83Ml1++24CK2d
         zC5uVQBQpYaM9wNsc1QD9Vdk7yyDt7GEmNKWcmo4+fHvn8FQLS3T3hOy2eMLowwJ+5WZ
         0f7gXBis/1T22ZtUkiK+TvRPUweutW6Vx7bZRFE6yUTFDxr8f4F/dfiaR7pa7dIQljvS
         m63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5aS8jWbLfhGgqCwrN6K2+MrJUyRHTwGiqZ6+Qmo2Ca8=;
        b=ogmL0nn3g0WZmOCcuOkh97ThEQPXUEHXwVu+ZbGtR8Aj8wx/uWTKQzNu+Q67VnwDXM
         C/ptLpo+rW+U2Fvx1I9Q+HV+h9WmGBAnRr5xBVwBe0qxLrgopYqXxJgmsA/nfpfejuB7
         TkcgQGzvBplBT3yiqJnuAjwS925tuXANelbiVm80zvaHVLO3QO3G2heaIPlBYUiKL+c1
         IaSqbTvqWnL7FX1Duh1+LUUcxDVV3wQC1LrwmjNdosswGRqRaJ3UlC/s81gRZpDloiTj
         azFrjPRKyXCAc6NJc1nWOM2LFMY9mzKEMaM12qQkFhGyq3ccp7ON/3youxHQk7N3Fhka
         kUbA==
X-Gm-Message-State: APjAAAWoAHHr3wRfnVwE0T6+Pmvz/OHQHOvDsiqtQexulYUi2Ycr+TbS
        9OPDf5flSZzjBVCQx/d0N1uaHQ==
X-Google-Smtp-Source: APXvYqycMIVFk+J1EIM/FVW+yuy3RLYo9hxgUfVwjob6pJdURk3LLF9l95jeamwwd9qfdvI1BaWLpw==
X-Received: by 2002:aa7:81d7:: with SMTP id c23mr4268361pfn.146.1553028510717;
        Tue, 19 Mar 2019 13:48:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id g25sm10911152pfi.36.2019.03.19.13.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 13:48:29 -0700 (PDT)
Date:   Tue, 19 Mar 2019 13:48:22 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] CDN offloading of fetch response
Message-ID: <20190319204822.GG47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        git@vger.kernel.org
References: <cover.1550963965.git.jonathantanmy@google.com>
 <cover.1552073690.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.08 13:55, Jonathan Tan wrote:
> Here's my current progress - the only thing that is lacking is more
> tests, maybe, so I think it's ready for review.

This series looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
