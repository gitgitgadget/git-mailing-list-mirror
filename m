Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7615DC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiAFTZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:25:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60367 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiAFTZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:25:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D126B10650A;
        Thu,  6 Jan 2022 14:25:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dSPXZIP05IeikE79pqeVqTJXlBeesiS8oM/p2i
        l7lp4=; b=jGRQp/bAtYnxDMeIUXIIstc7vGKg8zlQSoSqNBAZKXXHeT4gx4UFbR
        k8nVLN9mOOflypUkXhKXAQtK/TBLp8djGHoy+8H50SwTrzm4BYZPMEV5Xtb7os5F
        E+h4iMkotm4IpD8tWviqm0QQUUHZoA/H6BY+ybDPk39aOLoNQhuyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABE48106508;
        Thu,  6 Jan 2022 14:25:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AC57106506;
        Thu,  6 Jan 2022 14:25:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in
 subdirectories
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
        <xmqqsfu1g64s.fsf@gitster.g>
        <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
        <xmqqbl0pg3s7.fsf@gitster.g>
        <CABPp-BFfuDMQXCZg_5YXQLaPtc9nyrJaq8J6VEDVsaiEMeeZMA@mail.gmail.com>
        <xmqq7dbdg1k6.fsf@gitster.g>
        <CABPp-BF=-1aZd=nFHF6spo7Ksa7f7Wb7ervCt0QvtNitMY=ZBA@mail.gmail.com>
Date:   Thu, 06 Jan 2022 11:25:01 -0800
In-Reply-To: <CABPp-BF=-1aZd=nFHF6spo7Ksa7f7Wb7ervCt0QvtNitMY=ZBA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 5 Jan 2022 17:08:43 -0800")
Message-ID: <xmqqy23sd5v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58CA6E5E-6F26-11EC-B862-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Jan 5, 2022 at 4:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > Are you possibly confusing pathspecs with gitignore patterns here?
>> > (Or am I?)  Or are you suggesting that sparse-checkout be modified to
>> > accept either gitignore-style files or pathspecs and handle both?
>>
>> Much closer to the latter (actually, removing ignore patterns, and
>> make the subsystem work with pathspecs).
>
> Oh, interesting.  That'd at least suggest you're also happy to get rid
> of the ignore patterns in this subsystem if we find a feasible
> transition plan to do so.  I'll keep that in mind.  :-)

It is more like "I've never used it and I'll probably never use it
myself, so I have no data as to how badly we will be hurting
existing users".
