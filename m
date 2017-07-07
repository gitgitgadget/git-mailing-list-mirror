Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C79920357
	for <e@80x24.org>; Fri,  7 Jul 2017 20:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbdGGUQC (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 16:16:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35441 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdGGUP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 16:15:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so5851504pfq.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c8aRaOkN0qmUMf7EldpKY0Q64XBLsVaFu1H/d3oDKB0=;
        b=RsQjorpYARbR69QzaRudZLNOHBGi4C3JeYkEAKHKiHCbcwpUtHsULdbT0w6NVmVNIR
         HRoNC8KnhPPDMFJaFeX3zVbdDXNV9kGlVjoMYd6E8tdEOrrBBHhYNM0ZIckrcqVs89E5
         NsD3P1JSdcclb1v5fRmPS0xCmsRKbEhqJOS/e6naNbKFcuOY/ON4gasFp+XhJrUhhofS
         qkI2ogRTwvWjC0yEYlgwvbobQvOk66ZX651S38inWLyI4Addd74hEggDKyAjSWHZj/64
         HSDMQPRJlLGRIIfyQ8LIyP30szdQwCWZSFFo3t9WHsP4EH3KHt47Yuvav/+ObR7+catN
         D7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c8aRaOkN0qmUMf7EldpKY0Q64XBLsVaFu1H/d3oDKB0=;
        b=Wwlzy71VeN3q0TZqqC96hEYEjPIRbf3bb/MKZPQez856iJE0kTlBVUyzusGM7jqHnH
         /4qks7fWf2QDHSFkcZJvIFO/W8gUBW894USNm/Q0Yqm0ssTGKYmC70LAAhvY2Ypzlojd
         oq1AXb6pkzoYFKYpVm6odlktNoF8SmBBbcyim+trX9T7vMBfXXfcoSLkZgclXWEm1hP0
         5YLk4IKkfdRVTDxUTZrNWL3nhBVm8+xQNy1ryUq3UhLs8yVICBIgPrrSIDUJItE2bJ2I
         r8txxNqefe0cdS4N3NWigZtu5xwZUWP1Lf7C+Z/ysgye7a1MghVlbztkm+KMoHpjxY13
         cSKQ==
X-Gm-Message-State: AIVw112Xt4peIG12ty1MxAvHfNv1XzPektl8ZCOWbblj/PoDykYkAeD4
        imJ9BTJ4PF+f5A==
X-Received: by 10.84.232.77 with SMTP id f13mr4830519pln.172.1499458557124;
        Fri, 07 Jul 2017 13:15:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id o6sm6183698pgs.43.2017.07.07.13.15.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 13:15:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 0/4] reflog-walk fixes for maint
References: <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
        <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
        <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
        <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
        <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
        <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
        <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
        <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
        <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
        <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
Date:   Fri, 07 Jul 2017 13:15:54 -0700
In-Reply-To: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 7 Jul 2017 04:36:37 -0400")
Message-ID: <xmqqy3s09f5x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  All made sense to me after reading them twice.

