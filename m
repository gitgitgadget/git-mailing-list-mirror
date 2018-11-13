Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9CC1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKMLFG (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:05:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55119 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:05:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 342EC10D0E0;
        Mon, 12 Nov 2018 20:09:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gqB+vjBSX7QIG21T17Ws0et/3MI=; b=osuEj2
        aXW9JuaVFymDCQsHfxKBEcvO4Jp2V8zmcOY+lU1lM1cgC2ZSnJ+Y/UgB1uIdsZVH
        XRcbRb98pOFH9o/65Y/TXhhnTXgKhYH+ym4a4che547ZAyziFbz8eUT/h8z8iMZ2
        Q5bkUfctExJ6x+YfH3vDvnCaHZS2fyIOEFOmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N5sBP4tegWKC+JFGJJ6aTs3wfMbwy5+c
        3AFobiLmfwFwMGDs6jrUdMn0ELAOb5hdbwt/+1jKE8IWJ2dbLAGUcwiAd74mLy5c
        KdL2vqcyD0DMpvGyTu53RpSJ7Kd03xdjABEFYrdbEd+Exwu4Q+yqDzlR3e2st8/v
        rRExd9AM8Mo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D18910D0DF;
        Mon, 12 Nov 2018 20:09:23 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E3D710D0DE;
        Mon, 12 Nov 2018 20:09:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
Date:   Tue, 13 Nov 2018 10:09:21 +0900
In-Reply-To: <20181113003938.GC170017@google.com> (Jonathan Nieder's message
        of "Mon, 12 Nov 2018 16:39:38 -0800")
Message-ID: <xmqqpnv9zsu6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C167014C-E6E0-11E8-A30B-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> As with EOIE, popular versions of Git do not support the new IEOT
> extension yet.  When accessing a Git repository written by a more
> modern version of Git, they correctly ignore the unrecognized section,
> but in the process they loudly warn
>
> 	ignoring IEOT extension
>
> resulting in confusion for users.

Then removing the message is throwing it with bathwater.  First
think about which part of the message is confusiong and then make it
less confusing.

How about

	hint: ignoring an optional IEOT extension

to make it clear that it is totally harmless?

With that, we can add advise.unknownIndexExtension=false to turn all
of them off with a single switch.


