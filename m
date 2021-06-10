Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2543C48BE0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 07:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6A461430
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 07:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFJH4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:56:32 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:39653 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhFJH41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 03:56:27 -0400
Received: by mail-pl1-f173.google.com with SMTP id v11so546904ply.6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gLUAX4mvxM1mN4EnsVhR7xcI9l/tg+gssVz+3Sh5zoY=;
        b=h+GwPemceD/svAjcsBIHlkmexlV+87MCrKuO0JfmpIHb4M8yLDtfumX18e4fyPBdmM
         TtYqnjM8BFt1I/vrMPsJeAZLIETrQm6uPMO4gGKUCQTnzMkwGDaYB3DpbVVuu29JW+vl
         Z79sNhctwSt9h7kYjSV9Qqf8sfICAqf6eaLHvFFAilST8BgKBURwaXvY5OaVePbmyY8/
         yPM/G3qyUDQsUhSxGfmYmB35w+CjPXyofdSHUZNQkXzmAMkwAlv3HnIYlbSRpfYngCMQ
         R1kfQQolhhAiewmOivU27Z+BOlGcMYM1GhduY0fQjEp921zXsRkEm6stjSrgeAmIZagG
         kF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gLUAX4mvxM1mN4EnsVhR7xcI9l/tg+gssVz+3Sh5zoY=;
        b=df/tzfcbmqaCLSCWjvkzx2ZLJ46dlexbuKVmYdkvrovmy8hsrL5nzcsyAOTEr3z85i
         NR9i2EIfFf/hVRg66HL+oz0XuXHNggsehuQ+mzysr3Fzmz3LuAPI4SpY6nG7SdGVfmpg
         5ezzMq+yQgFZlr+FPBA2dqtaExApYX4yi7O44P58IOA2s5bOOjgdfY4y8ItSGoNntwFH
         X9lT2JZXa7uDh5MMwDxcygbD0Mc/WT7ItFuxp0WGWG6qU5jFqKjxLdbivM7LxRVYsbEm
         S1fMgBR4kde3ySLPiKmwsRvsaYPqDxTnPROnK34Fsi3J0YXWOh5tE2aPN+LphXys7Sni
         kIIA==
X-Gm-Message-State: AOAM530twbcq8DEJ3Yt/Mf7GMjJayUClBxY3omiba8/e7YyPqf4gHmnX
        ZtzJWVNfbG2QR5bQ8wx09RXVaTQZdslsJ1rT
X-Google-Smtp-Source: ABdhPJz0aAdKF1Y5lY/XGk0sG3yXG2bx/D/NzVX9TnlTpJNiPV9z8SEjseyGeiT889XI5LhyHUaAew==
X-Received: by 2002:a17:90a:ad85:: with SMTP id s5mr2104374pjq.230.1623311611176;
        Thu, 10 Jun 2021 00:53:31 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id k136sm1653714pfd.87.2021.06.10.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:53:30 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:53:29 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Message-ID: <YMHE5xuxN90HJepT@danh.dev>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-10 08:41:21+0200, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.06.21 um 21:28 schrieb Felipe Contreras:
> > Virtually everyone is using it, and it's one of the first things we
> > teach newcomers in order to resolve conflicts efficiently.
> > 
> > Let's make it the default.
> 
> I tested diff3 style the VERY FIRST TIME the other day and was greated
> with the below. Needless to say that this change is a no-go from my POV.

I agree, despite using 3-way merging (with external tools) to resolve conflicts.

I prefer the current conflict style, aka no-diff3 conflict style.

-- Danh
> 
> Without diff3:
> 
> <<<<<<< HEAD
>     CClustering ComputeSSLClusters(double threshPercent, const CDataInfo* scale) const override;
>     void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist) const;
>     double EstimateNodeDist2() const override;
>     std::vector<double> EstimateNeighborMinDist() const override;
> =======
>     CClustering ComputeSSLClusters(double threshPercent,
>         const CDoubleArray& compWeights, const CDataInfo* scale) const override;
>     static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
>         double& minDist, double& maxDist);
> >>>>>>> no-compweights-in-cnet 
> 
> With diff3:
> 
> <<<<<<< HEAD
>     CClustering ComputeSSLClusters(double threshPercent, const CDataInfo* scale) const override;
>     void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist) const;
>     double EstimateNodeDist2() const override;
>     std::vector<double> EstimateNeighborMinDist() const override;
> ||||||| merged common ancestors
> <<<<<<<<< Temporary merge branch 1
>     CClustering ComputeSSLClusters(double threshPercent, const CDataInfo* scale) const override;
>     void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist) const;
>     virtual void ComputeKNearest(int K, const double*,
>         Neighborhood& result) const;
> ||||||||| d261d9944
>     CClustering ComputeClusters(const double* dist, double threshold,
>         const CDataInfo* scale) const override;
>     virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist);
>     virtual void ComputeUMatrix();
>     virtual void ComputeKNearest(int K, const double*,
>         Neighborhood& result) const;
> =========
>     CClustering ComputeClusters(const double* dist, double threshold,
>         const CDataInfo* scale) const override;
>     virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist);
>     virtual void ComputeUMatrix();
> =======
>     CClustering ComputeSSLClusters(double threshPercent,
>         const CDoubleArray& compWeights, const CDataInfo* scale) const override;
>     static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
>         double& minDist, double& maxDist);
> >>>>>>> no-compweights-in-cnet 
> 
> -- Hannes

-- 
Danh
