Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF03920958
	for <e@80x24.org>; Thu, 30 Mar 2017 06:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbdC3GJE (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:09:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52303 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754569AbdC3GJD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:09:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E7AD88801;
        Thu, 30 Mar 2017 02:09:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B3ogOzc+lWSOOz6PMLFcJn/Us+g=; b=Ov5vTj
        vxS73yBIe9Slcr/PIsgNLSKE4Hsg1uMtHckDi+9Edliwop3lGFmgb3VJivY2xz6h
        kbLJtEObzNGl1OaNioLQ5la27X1oeW1aBLtQ65slhW/lDl0R+qsEHckHYNqGm3Xk
        oA2BJQBCEO2YhhPSi6uGy8gfKgTj1+MtpaHEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RkFZOg7kv4uxldsTY+3Z4czI8LbCywND
        Czu4W7d2INyFSh1VJOi4PsDDeak5e0fKSsZus5nPmWiOBjRabacaXVQuldevRjCe
        50AvBYyFjPp8L4e/AoodOHjseJ19pf973FelLqaQZzbwgt5qDB/sOCqMaS3j67XO
        Lj/1Yx/Yx4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9657D88800;
        Thu, 30 Mar 2017 02:09:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBD2B887FE;
        Thu, 30 Mar 2017 02:09:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
        <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
        <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
        <xmqqk278av4x.fsf@gitster.mtv.corp.google.com>
        <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
Date:   Wed, 29 Mar 2017 23:08:59 -0700
In-Reply-To: <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 30 Mar 2017 06:59:45 +0200")
Message-ID: <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E4CA1A6-150F-11E7-8CD1-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think IN_ORDER really only applies to *binary* trees, not arbitrary
> trees like a filesystem.

How true.  Even if we were giving a sorted output (and dir-iterator
doesn't and there is no need for it to), dir/ should come before any
of its contents, so for that application we can use pre-order, and
there is no sensible and useful definition of in-order.

Thanks.
