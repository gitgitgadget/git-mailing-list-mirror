Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07CE720960
	for <e@80x24.org>; Fri, 14 Apr 2017 01:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdDNBku (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 21:40:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56817 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751255AbdDNBks (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 21:40:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 675E28976A;
        Thu, 13 Apr 2017 21:40:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dbKaDuK9qEhT
        EvBFExp9/WJSRbA=; b=QrCGOpgu3qTJtyXbbRDciQpZLUJr51WAzbFyVHhd9+qw
        aZ48oxlZD8KuxlM6036hZPaLJ7voz/65wXo+emQ51vXl5HpqzlapyBtEUBuaFRj7
        YL+9Vz5FUG75Dcg7LDzAU9iM+YT+FeNwRaxRZCsEMUrB5KxFXB9De7tLxFgvjAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qkfivV
        UzR0Q8Roj1zGjMWkv2Ya0fmrK2S631BosCfeOqnTX/ApA0tIkK5DVkR3cal2Z6OB
        O7dUGp/mi+Bk5tr+UNvspH8rxKltniutCIziYYSNGGq7pwVpCkwDLVtYEFAysAyP
        XyzXXRnHZcAKr6H088uTzwBCrGx7Kf9oxPcWo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54FC489769;
        Thu, 13 Apr 2017 21:40:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B37E289768;
        Thu, 13 Apr 2017 21:40:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/5] Kill manual ref parsing code in worktree.c
References: <20170318100206.5980-1-pclouds@gmail.com>
        <20170404102123.25315-1-pclouds@gmail.com>
Date:   Thu, 13 Apr 2017 18:40:45 -0700
In-Reply-To: <20170404102123.25315-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 4 Apr 2017 17:21:18 +0700")
Message-ID: <xmqqk26nojfm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61A4DD78-20B3-11E7-9167-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> v4 adds a new patch, 2/5, which makes the hashmap related functions in
> refs.c generic, so I could add a new map for worktree ref stores and
> not abuse submodule hashmap.
>
> I mentioned about moving these hashmap back to submodule.c and
> worktree.c where it can map more than just ref stores (in worktree
> case, we can cache 'struct worktree', for example). But I'm not doing
> it now to keep things small.
>
> The commit message in 1/5 is rephrased a bit, hopefully clearer.

Michael, does this look good to replace what has been queued?

I did not spot any discussion on this topic after v4 when I skimmed
the backlog messages, so I am hoping that I can pick this up without
having to worry about seeing another reroll immediately after that
(in which case I'd have been better off if I tended other topics in
flight in the meantime).

Thanks, both.


