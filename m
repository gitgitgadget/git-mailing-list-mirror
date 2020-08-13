Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD830C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86863206B2
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vveeqWi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMSZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:25:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61311 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHMSZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D179B79D9C;
        Thu, 13 Aug 2020 14:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H+CalKVHrZovrqBdSSszUS9aPNs=; b=vveeqW
        i038FslIaK/chtbGb0hScFUEKY8SRh+0B4kLARaQ9Vufh8HzujZhCgkanFe2Wq0t
        9ziT+oxZWtjdYFulKcXQNEdgqg6eePczFbYCVuvDLozfFtnYE1C5rOnJL/eQigaD
        29xYfyGlF25nnwT5FXOBd73m/ACBzCRLKWFKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EaW2r1Nb4TB3R8vTTgsv1v/bOe9lCOxR
        X70K3n8u4++LTjGzqiJI/CgAUxS8I1RNMjoT8UeuMcAlLSqQrGL+EA2AviB6VL67
        E9uETk7clO7mTeLRVTXhEmJibSAz+jIwANIlS3zt6Rnt3TS6thEt/OMkXbJYUBAu
        cGf7DzlcKBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C93A779D9B;
        Thu, 13 Aug 2020 14:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AE3A79D9A;
        Thu, 13 Aug 2020 14:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
References: <20200813145515.GA891139@coredump.intra.peff.net>
        <20200813145936.GC891370@coredump.intra.peff.net>
        <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
        <20200813173845.GA1598703@coredump.intra.peff.net>
Date:   Thu, 13 Aug 2020 11:25:44 -0700
In-Reply-To: <20200813173845.GA1598703@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 13 Aug 2020 13:38:45 -0400")
Message-ID: <xmqqa6yy2yjb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67155E96-DD92-11EA-B52D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>     macros). That could change eventually of course, but it's not like
>     switching back to a stand-alone at that point is a big deal.

If it is not a big deal, then I am fine, but at the same time it
becomes unclear why we can say "we can use X and Y niceties only
available for builtins".


