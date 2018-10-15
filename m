Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9481F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeJOKSG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:18:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52460 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOKSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 06:18:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so17277129wmw.2
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 19:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PfMRTyxnhrSkgGQwkSRIr1pDDNaKqFE26a/SvUSShbQ=;
        b=Tiwix4kXFgFBaycQu3Psjhj1k0Nh89G6JEg9D2jCDr9Xc02EUf/TYKcz/JlofE2iFM
         +/tDlXEAlAgixpf16HmIehyorADpvMGaEi7Ji3SNibzk5dycL4WP5QGzeE0E0NArYrCA
         7RHP/W04n2EqkC6hstQ2Yz1ptWjOWrqxFt2bORE7fhfEnpqeOfpCNY9fgtSx0ZlX6g3D
         QYFiiWx08x1G6x/SBOHl5wKUkbDf3KKV7OqIT/nLuC/C92qTd/ZYd4olXXv4crOWQkFF
         mbBBRBJcBbgRAaVy8q1LUBRId49FErdUp03k8Q7YL3tgrrDLym4O3siyKXP2SxDjAO+s
         AodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PfMRTyxnhrSkgGQwkSRIr1pDDNaKqFE26a/SvUSShbQ=;
        b=oj+7k925OiuS1r3s8gWe9VOEtKoNhL2sqkKkjd6kE3mvext58Dh6WcxAMXU5exZydc
         QtIPd93eLw2qAKhLssrqMAy0nCPUKI6nB47bgMw9+O1FS8SvjurCNBun96G5LDVoNNer
         F7ccbzoUFQ84S7/Q1UQslocU5M9HRGihSsTm6DwYixtrqxyNjtPFmo06XoNJsWL63aUD
         wodNlmqJ8ou8+zDidwqUS1lzsvbNY1LbG+4BZBj/f42pIV5rrVl7GCefSYVKrOxcVW+/
         DZ2fVdy/9+LzJkI+6sEm53ZDfN+JqnrKuUPIPnwInPq02yPtSrHC4bR88xiHSbmctvXn
         eY2Q==
X-Gm-Message-State: ABuFfoiRbjbB/8M/FNw+FNgH+2JDRhQSTvSnyBfJCUGbsCKraKW5O/Gk
        7zHOzL9o6Da2w8GuMPK/cvs=
X-Google-Smtp-Source: ACcGV61MEgMytbMgoTenXmIUUuABXxHQi7PYqRD50eyuVmm/FLhsFn0MlbomuC8+2OMXdPQZptmjyA==
X-Received: by 2002:a1c:b0b:: with SMTP id 11-v6mr10747764wml.25.1539570894952;
        Sun, 14 Oct 2018 19:34:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t82-v6sm7627795wme.30.2018.10.14.19.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 19:34:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] object_id.cocci: match only expressions of type 'struct object_id'
References: <20181008215701.779099-15-sandals@crustytoothpaste.net>
        <20181012131116.23733-1-szeder.dev@gmail.com>
Date:   Mon, 15 Oct 2018 11:34:53 +0900
In-Reply-To: <20181012131116.23733-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 12 Oct 2018 15:11:16 +0200")
Message-ID: <xmqqh8ho6ipe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Most of our semantic patches in 'contrib/coccinelle/object_id.cocci'
> turn calls of SHA1-specific functions into calls of their
> corresponding object_id counterparts, e.g. sha1_to_hex() to
> oid_to_hex().  These semantic patches look something like this:
>
>   @@
>   expression E1;
>   @@
>   - sha1_to_hex(E1.hash)
>   + oid_to_hex(&E1)
>
> and match the access to the 'hash' field in any data type, not only in
> 'struct object_id', and, consquently, can produce wrong
> transformations.

Thanks, will queue.

