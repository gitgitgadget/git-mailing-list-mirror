Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E011F461
	for <e@80x24.org>; Mon, 13 May 2019 08:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEMIrE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 04:47:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62914 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMIrE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 04:47:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6CF14FB0E;
        Mon, 13 May 2019 04:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JwdkyjnXllNj3Nqv8Qr/XgNWnVQ=; b=us+O37
        QeNxIYtTJtHG2bDHAgTwmoVLVDGcA/t0Vt0i1hrZ+dHoJTCt9CnqoZA+6plgIHJp
        76zYFV4HPiB6FRxN3OikfO8jGAtoJbFigZCYcBDBnwZ0KEuAfS+luZz1HJ1QdUTz
        A1KTla9tdVYZ5RtFL6hu0oyj85/7Ab4QX5olQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=STa6b5O5ZE2pRf6bCtt6ehK9M2HHFJAf
        xo+WL5t17oYBEPkSV2cbZJbYdx8Sr+lRIilOsdkjs/LVBXtpCtD1ThfcXZ7+i3Z2
        TxZODVzQ5dwGJicZxLjpPJgyP2e5G5mw4TDUGLINM1zxwl29REURpMPJR0qfzSRk
        Up+UKYKnNPg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C30B14FB0D;
        Mon, 13 May 2019 04:47:01 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FC3F14FB0B;
        Mon, 13 May 2019 04:47:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
References: <20190508105607.178244-1-gitster@pobox.com>
        <20190509114830.29647-4-avarab@gmail.com>
        <CAPig+cTJFTkJ7N+ksrN-nHeLzNmCbDpVgLRBJZtMjTsKSE_ijA@mail.gmail.com>
Date:   Mon, 13 May 2019 17:46:59 +0900
In-Reply-To: <CAPig+cTJFTkJ7N+ksrN-nHeLzNmCbDpVgLRBJZtMjTsKSE_ijA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 9 May 2019 14:04:23 -0400")
Message-ID: <xmqqr292bv24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC3A2EA2-755B-11E9-B35E-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> All the rest are things where the command-line should simply override
>> the config values, and by reading the config first the config code
>> doesn't need all this "let's not set it was on the command-line"
>
> ECANTPARSE "let's not set it was on the command-line"

I took it as "let's not set it, if it was on the command-line".
