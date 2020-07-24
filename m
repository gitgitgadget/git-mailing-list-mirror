Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8643EC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ADF20674
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5OHHv0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGXAFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:05:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53458 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGXAFY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 20:05:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1F11D5E60;
        Thu, 23 Jul 2020 20:05:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qgyWGHaVMcocKPqqjp0KBap8UoQ=; b=Q5OHHv
        0sXwGbVzOA0B3ZUGqWQm07k1jhCBs1xpvy6bUKPlociD/KKwiPpeqTVs88kamdO1
        rjNAgdw/ocAPKADFrFLp2jpOKdlUZoX2n8E0DcfETQv4xhbi8vjtdQUCex1ay/mu
        qfXpqLu5gNy1ifO5XObS2VLvB7gKwawvQJ9nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DFRRaPc5nPPmrxOJhnxlo50RHs8x7vOB
        /5HYPDFrKly7kQTosbebsIffobGaCMeDorpCd9BvDY4jSD6zLkkOM3yGUZMMz8Hv
        1KHUsXffKiK3iyv7e4Gf7RmG6jsrUDzwDzOGnmBC4jnziJ69RlSwd+dAGycD0nsL
        1Xef9Cv4/ec=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB33BD5E5F;
        Thu, 23 Jul 2020 20:05:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39FF2D5E5E;
        Thu, 23 Jul 2020 20:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 34/39] t: add test_oid option to select hash algorithm
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
        <20200723010943.2329634-35-sandals@crustytoothpaste.net>
        <CAPig+cT36rhfMzOTH8L59cyoBKQQoF92nJ-Unccm+yf9RCgXMQ@mail.gmail.com>
        <20200723233815.GB1758454@crustytoothpaste.net>
        <CAPig+cQPfAD8Jcm2WC4XCE+tFqQsV5e0yAtN0_Txb5ro1Rhifg@mail.gmail.com>
Date:   Thu, 23 Jul 2020 17:05:18 -0700
In-Reply-To: <CAPig+cQPfAD8Jcm2WC4XCE+tFqQsV5e0yAtN0_Txb5ro1Rhifg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 23 Jul 2020 19:46:41 -0400")
Message-ID: <xmqqo8o5ok01.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CD8FB88-CD41-11EA-908C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 23, 2020 at 7:39 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On 2020-07-23 at 04:51:32, Eric Sunshine wrote:
>> > On Wed, Jul 22, 2020 at 9:11 PM brian m. carlson
>> > <sandals@crustytoothpaste.net> wrote:
>> > > +               --hash=*)
>> > > +                       algo="${1#--hash=}" &&
>> >
>> > Bikeshedding: I wonder if this should be named "--algo"?
>>
>> We already have a use of this in t5515; I appear to have accidentally
>> sent it in an earlier series.  I can, of course, change it, but I don't
>> feel strongly that one or the other is better.  If you do feel strongly,
>> or you think it's confusing, I'm happy to change it.
>
> I don't feel strongly about it and wouldn't insist that it be changed.

I am in favor of "algo", but let's leave the patch noise outside the
series.  It is something we can do after the dust settles.

And when such a clean-up comes, I'll try to remember pointing out
the case/arms)/esac indentation rule ;-)

Thanks.
