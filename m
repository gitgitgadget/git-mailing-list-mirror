Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE7DC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 07:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7693B221FE
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 07:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbhAOHXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 02:23:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55146 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbhAOHXW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 02:23:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA16E117143;
        Fri, 15 Jan 2021 02:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2LUHsOMA6JtN0BvIZcXhPK7PXc4=; b=U9NWb0
        4V20r0cYyrfykMSc19ZV+ft2yuSBDpbd+XAAx8HO2XNWm8nTafo0dBqYoqxC3lUj
        nWn7+me0gH+pWd4IZF3Z2ypb+7WcEpuqjSaIllduyjS0ex1vkTkxfiyupX2H3At2
        gerM30zoZTmJm7NuFEIbo8sY01cPzZ6JeD3aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lz+ppznUT+dFnc9HTQiPyF+BC7/mRDQM
        FcZ1ahZ/mmDi1iF4VwgHXOGHU1s3DhR72kxaCAb2FbgpG/ndC++n5m/0HH+c6+PD
        z3RllVSPqIhUujAUBxSMx+EqDnp0K801TePSqQlv161Mrm7qD+gNv1ihiHRJheZr
        /ZHWGO9G3PE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C558E117142;
        Fri, 15 Jan 2021 02:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C32E117141;
        Fri, 15 Jan 2021 02:22:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
        <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
        <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
        <xmqq4kjpelza.fsf@gitster.c.googlers.com>
        <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
        <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
        <87k0si5k75.fsf@evledraar.gmail.com> <YADZSsVqyGnArF0n@google.com>
        <YADaJ1gfbxQaLGXf@google.com>
Date:   Thu, 14 Jan 2021 23:22:34 -0800
In-Reply-To: <YADaJ1gfbxQaLGXf@google.com> (Emily Shaffer's message of "Thu,
        14 Jan 2021 15:56:23 -0800")
Message-ID: <xmqqft32u0jp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70E6D3D4-5702-11EB-9B50-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Taking the time to redesign commit format (e.g. use user.id instead of
> user.name/user.email) ...

I have seen that "ID", which doesn't have permanent association to
<name, email>, has been raised as a solution from time to time, but
I am not quite sure what problem is being solved.  At some point,
you'd need to translate the "ID" to a way humans use to refer to
each other---you cannot forever be saying "Ah, commits by this
contributor #70763 is consistently good and seems to know the
history traversal quite well.  We wish who it is so that we can ask
to review what we have been working on."

So we must have a mapping from ID to <name, email> or something.
How is that mapping maintained?  Even though Git is a version
tracking system and the mapping will change over time, we'll only
keep the "latest"?  That may not work very well, as a work for hire
contract a company made with one of the project participants would
have been made with a real person with a name, not just an anonymous
contributor #70763---the work done under the contract would not
become invalid merely because mapping from ID to <name, email>
changes, and those who made contract with a person with a certain
name would want to make sure the contributor #70763 who made the
work is actually who they thought they had contract with.

If we do not keep track of the change of the mapping ourselves, the
ecosystem around us will start doing so to fill the gap, so I do not
think use of "ID" would help you dissociate from your past self,
while keeping the credit for your past commits.

And if the mapping is version controlled in such a way that an "ID"
can be used to look up its name at any given time in the past, it
would not be so different from what we already have.

One advantage I could imagine that "ID" based system may have is
that one who wants to completely dissociate from an older name
and/or email can just start using a totally different "ID" with
totally different name, and pretend that s/he has no relationship
with the old person associated with the old "ID", and nobody would
be able to tell.  But again, I suspect that it can also be done
without "ID".  So...

> ... also gives us room to improve other things we
> don't like about the commit format (e.g. limited to single author).

I personally think having "author" is a mistake, iff some people do
not like "limited to a single author".  You can write everybody's
name in the trailer as "Co-Authored-by:" and at that point you do
not need any author in the commit object header.

But that is so miniscule a feature that I do not think it is worth
making a backward incompatible change to change the number of the
commit object header for the author from 1 to either 0 or many.

Anyway, thanks for an opportunity for a (somewhat) fun thought
experiment.

Goodnight.
