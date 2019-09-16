Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F87F1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391136AbfIPUBg (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:01:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52188 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIPUBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:01:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0248E28993;
        Mon, 16 Sep 2019 16:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mrDVwaNOs49bp8CiVuvLcLUDqsg=; b=V4SfvB
        OD49eeDtNNYpmV/n1D+ELsytptb9R/60m3ckvZ+3fqfwIJwdwZGfSgTovBjCUD3F
        7L5U+edqadzR+gLieofNbWY4cPbastU/brz73wihrclt1oGIAMzOc5rMxF3qrD7f
        MT0s0vG/VV/nfFEWGW7DkDbqNjq4H5SBBGBis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WoUujySRy7ss05LQrqAL6kxOfcscth13
        k8QMFlG9xlbCa1Y6kBXowBpltZ4so3l6MqOC0vOKSdMgR1ePPKgJ1U8lPKQv1DZr
        PlV4RA+aoy0+L36ra3km/zxs4GAPFn06nGMgeC/vAEeAp9BBTvLAhZKcPPK94Z2i
        UJHveFjJ+mM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EECF228992;
        Mon, 16 Sep 2019 16:01:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DB2628990;
        Mon, 16 Sep 2019 16:01:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] fetch: Cache the want OIDs for faster lookup
References: <20190915211802.207715-1-masayasuzuki@google.com>
Date:   Mon, 16 Sep 2019 13:01:32 -0700
In-Reply-To: <20190915211802.207715-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Sun, 15 Sep 2019 14:18:01 -0700")
Message-ID: <xmqqr24g9fj7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8181CFA-D8BC-11E9-AACF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> Debugging this, it seems most of the time is spent on iterating the want refs to
> see OIDs are included there. This patch speeds up this process by using oid_set.
> Now the client can send a fetch request almost immediately.

Wonderful.  Thanks.
