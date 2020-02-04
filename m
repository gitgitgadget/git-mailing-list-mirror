Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB7C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFD2166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OooO8U5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBDVZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:25:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59378 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDVZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:25:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 516BEAE58E;
        Tue,  4 Feb 2020 16:25:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lprAE228uhjl
        chGsiDG8rsSM9vU=; b=OooO8U5K3gcPh1aAdAwmRkePfO5Nb2WL6WyqxsTynO7k
        weVcuJmcBfn6FLyhl7VHCkVoQAojXRgly+u8iCSDRqTn9Dw+ZyltOVhlm3eXn+LK
        eeWSdFumbZPeGvJck3LU3HSibvCmIPl2gF7JSL1ewxms8/KXBx7l9Zi5axGjKXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eF6mVT
        xpV++HJvF5IV4pFUDS5DKAUUSasV0bC6XmssYDbvK6KHyyavbsVoLPsme6O8ZLHb
        A8l+dGJ+aA1TpCThsIvtYDc0dGVlS6gGmOwK+gFV+26KMBuPYPex6Wlv8Qw3GAa5
        y5I7hjx0QcyDImwNbngOq69OcqvXBh907a8NM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48F8AAE58D;
        Tue,  4 Feb 2020 16:25:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F365AE589;
        Tue,  4 Feb 2020 16:25:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
References: <20200204010524-mutt-send-email-mst@kernel.org>
        <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
Date:   Tue, 04 Feb 2020 13:25:40 -0800
In-Reply-To: <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 4 Feb 2020 22:10:30 +0100")
Message-ID: <xmqqimkm6o4r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5D25DEA-4794-11EA-9A34-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 04.02.20 um 07:14 schrieb Michael S. Tsirkin:
>> It seems that it's not too hard to make commits such that
>> the standard way of git format-patch -> email -> git am
>> fails.
>
>> A work around is "don't do it" - avoid putting anything that looks lik=
e
>> a unified diff in the commit log.
>>
>> However:
>> - Users don't know what other restrictions exist
>> - User sending the patch has no way to detect failure,
>>   it's only visible to user receiving the patch
>
> Putting a diff in a commit message can be useful, and forbidding it is
> hard to justify.
>
>> Ideas:
>> - validate commit log and warn users?
>
> That's only better than the status quo insofar it turns the issue from
> a hidden pitfall into an open one.
>
>> - find a way to escape text in git format-patch, and unescape in git a=
m?
>
> Like a Lines: header specifying the number of lines in the commit messa=
ge?

I think the existing practice is to indent such a diff in the
message by a few characters.  And I think that makes sense even
without counting its value "as a workaround"---we indent materials
inserted in the message for illustration, and a block of diff is
just that.

