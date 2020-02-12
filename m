Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA3C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593020848
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O+PVmNQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLWkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:40:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63258 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:40:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99EF7566D5;
        Wed, 12 Feb 2020 17:40:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b7dPV64JjWFnymNFGI/sZnosNqo=; b=O+PVmN
        Q7w6TvNGq7jAqEVuEynfDw6t03R+XtV1TujBa3bb1zKdj/+fIK/+ARcJn09rhxpl
        1BGi0L6eUQB1NI5TrrpOzVkq9jsc1SGjV8whTX+5f1Ru/56u3n/bYSn50/scKvWf
        Mu0WgaeMBWqqOJdn1LYK6kuQP889Kmge50Amo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a+EifTw6zK5ezR+8wQ2zPArU0zq44Sba
        sbfDTsYU0iVuno8km3WIvdfXwakQTUOm2OFj/d63CCLA96UAPOoJ9belMApScQw1
        TpARKHFyCAhQ1AZrj7T6WadQtYq6v3MDoQyx4v7SmTiYxzyz/I24jSLBXc5aGeHw
        7xWKYJYa6hI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 911E4566D4;
        Wed, 12 Feb 2020 17:40:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8047566D3;
        Wed, 12 Feb 2020 17:40:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1dc on mac
References: <20200212085646.hgq3nv2lf4brbb3j@glandium.org>
        <CAPig+cTfMx_kwUAxBRHp6kNSOtXsdsv=odUQSRYVpV21DnRuvA@mail.gmail.com>
        <20200212223122.svthiwmh3js7i47b@glandium.org>
Date:   Wed, 12 Feb 2020 14:40:37 -0800
In-Reply-To: <20200212223122.svthiwmh3js7i47b@glandium.org> (Mike Hommey's
        message of "Thu, 13 Feb 2020 07:31:22 +0900")
Message-ID: <xmqqk14rtonu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B13F0E70-4DE8-11EA-88F1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> On Wed, Feb 12, 2020 at 11:46:31AM -0500, Eric Sunshine wrote:
>> On Wed, Feb 12, 2020 at 3:57 AM Mike Hommey <mh@glandium.org> wrote:
>> > If I'm not mistaken in my reading of the various files involved, it
>> > looks like for some reason, building git on mac leads to using Apple
>> > Common Crypto for SHA1, rather than SHA1dc, which seems unfortunate.
>> > Is that really expected?
>> 
>> There was a discussion on this topic a while back[1], and it does seem
>> that the behavior you describe is intentional[2].
>
> That discussion predates SHA1dc, though.

Yes, but the essense is the same.  It was phrased as "is there a
good reason to prefer CommonCrypto over block-sha1?" but it really
was "is there a good reason to prefer CommonCrypto over the best we
offer?"  And the best we offer, which used to be block-sha1, is now
sha1dc.
