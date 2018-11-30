Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE325211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 06:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeK3Rzw (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 12:55:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55809 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Rzw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 12:55:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C61B1EA3F;
        Fri, 30 Nov 2018 01:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bCfY8zMQndVF9SNYIF7Dq15TgWY=; b=FUbJ/P
        rj50x6mQ2DGbCo0hkhPElcrclpfyhOU5n53ySAuPxjfJvypeiW/AS5h0fwVqnKu5
        KOcvVABTeqSkxMTzeJUnYCczwMbXiwzlGCZKnbt3/4tCUshRtR5I+DxSojN7F47H
        QzJPtVFWyXwOCZwSdLdmG/PLWfAABG1oCOUKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f89zh2JcBHoE2tg1STvC+K52C+P7xzI2
        kNdAQ7FKFreSrNvb1QqphTcUfD7rWQLblbl3OjEY8m4GJomqt2CDrH7JhZ8O0XXf
        G7Mswjtm+i2iD3P5Duf5c5r0Vi2tAQQOrucrA/HYqcG+rMDc2vltYaSZKjAQzdVh
        /AIiBc53hW0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34F121EA3E;
        Fri, 30 Nov 2018 01:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 510FC1EA3D;
        Fri, 30 Nov 2018 01:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Elijah Newren <newren@gmail.com>, dan@fabulich.com
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <87pnunxz5i.fsf@evledraar.gmail.com>
        <CACsJy8DCKQctO+rf=xP5gVVUy9XBq35Z1xSbfwB30nDJMMJsrA@mail.gmail.com>
Date:   Fri, 30 Nov 2018 15:47:30 +0900
In-Reply-To: <CACsJy8DCKQctO+rf=xP5gVVUy9XBq35Z1xSbfwB30nDJMMJsrA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 30 Nov 2018 06:37:06 +0100")
Message-ID: <xmqqmuprkqnx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0051A98-F46B-11E8-B3DA-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> core.uiVersion is a big no no to me. I don't want to go to someone's
> terminal, type something and have a total surprise because they set
> different ui version. If you want a total UI redesign, go with a new
> prefix, like "ng" (for new git) or something instead of "git".

Yup, very good point to keep in mind.
