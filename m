Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038231F453
	for <e@80x24.org>; Wed, 24 Oct 2018 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJXUwB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 16:52:01 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40531 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJXUwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 16:52:00 -0400
Received: by mail-qt1-f170.google.com with SMTP id z9-v6so5401369qto.7
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSJYX2U6XoykxxHAbBpMlG63zc1Sg41PQqC4ZOgTIVs=;
        b=i9Kk1vtdSpjMV5B6P/6vj99CMfHeO73gej73znYcoJpB0lY/6JqBV/N+7/F7lDCxpP
         Rmw+KImP6CiQKNiI1Xa6iL6e99W3qVmTTQ4rd7Xsjx3bOqi/tkmGq9FLb78j24mHgPwH
         Hu1jEz9JMIhTvoCOUNJwxANPA7x3xqfANjMa7hyxOsOp0wnEiSSaHvfQmKEwoDa3mywJ
         Q4Yqr2jx2VnHruILEP6bWNjV2uqaCT5VmCWi4B9JTpvDAOSZTd14GkdOqMR/mrCrx0EC
         XPZKNP+u8D34zOYTV3eJFcvQXLYFGVWBkSDp7FPvW8+6nGOeLK6K2OhH6pWiXihnCE3J
         ERkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSJYX2U6XoykxxHAbBpMlG63zc1Sg41PQqC4ZOgTIVs=;
        b=kecA+pgkKkgmLDDgePfmsI8Y0PbJUQMm3JXTVYJCcnsoaJqsv9CG5OEBI7OSB/NAex
         EzUBnwR+i98ZyR4NJpBvDKSOkWI1+qvf2UMrNw5UozbsJIrPUMWwgZeIL82veKYpgNFu
         orUSgFFSqKi+8abQhkJv/PdDnQTcZRoj+vL15rcsOrD/jDhJKwCITKIsSL0IGEKSvztq
         VXqvBJS6ql0PQqSW+LJbDmNTplfsqbxSQUNNcVLgt68HLm17wePlLar4one4f4YbJgyY
         C38BkstfIDIdlZoDTUuTWka4K8GGkJN2LMsts686liba0diO7G1+NlRrlklGQqcuC7Hq
         eIGQ==
X-Gm-Message-State: AGRZ1gLSuEdcQjG1s3zmOXLuK3u/2EIsACqkEEAdFqhSz/BaXxU4g9fA
        JBTL+XG2VYeQlnidQOtlijbVrd8n
X-Google-Smtp-Source: AJdET5fq3Mmy1rpBLMUIprz02NMg7wIN+IaDQSlq6qOi3sJIbgjsFQpAQFZWQctk/DfqUWI7ObRb3w==
X-Received: by 2002:ac8:ac5:: with SMTP id g5-v6mr2150296qti.384.1540383845167;
        Wed, 24 Oct 2018 05:24:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:1357])
        by smtp.gmail.com with ESMTPSA id i65sm4229796qkh.49.2018.10.24.05.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 05:24:04 -0700 (PDT)
Date:   Wed, 24 Oct 2018 05:24:01 -0700
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com
Subject: Re: [RFC] cherry-pick notes to find out cherry-picks from the origin
Message-ID: <20181024122401.GD4182586@devbig004.ftw2.facebook.com>
References: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping, thanks.

-- 
tejun
