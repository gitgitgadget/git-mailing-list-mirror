Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D661F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfKFBzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:55:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65526 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFBzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:55:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6FADA49F3;
        Tue,  5 Nov 2019 20:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=WZKPl8NOblUZVBFucJyV4usNLWk=; b=JJBgyl
        3F2vjIhGCKUMfGnCuijvJ8ZllXlmYyCZwmmznbhoPmgsE5KrSQpaYS3JOFXF4IJU
        HvgnSB39JRxAWbaQMHZoq3zS1v8mjLy7ryH333ChJGZ/1Mmr/7t2uIwt3M7UZvrX
        BpCNl2BWZDEiBkN2oZHBiCxnxrOtSXqBBdGRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oFYneR3vif4rNZWC2NX2bv5I6vyxWhgR
        ko6YpyUtwwTz+As9H+j9L0Mevum4m/oeSkyDvRvTrcTy7pjMoJLyQ/jMT/RLwndA
        U68DXxQ98mEBg67uDBecwrcgMfpXWsss7mX2HRwVtF1+U0g/Akg7KtjrUnnJirqp
        FaHA9TNg1xY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0630A49F2;
        Tue,  5 Nov 2019 20:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F16BAA49EF;
        Tue,  5 Nov 2019 20:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/4] doc: move author and committer information to git-commit(1)
In-Reply-To: <20191104221822.GA22367@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Nov 2019 17:18:22 -0500")
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-2-sandals@crustytoothpaste.net>
        <20191104221822.GA22367@sigill.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Wed, 06 Nov 2019 10:55:34 +0900
Message-ID: <xmqqwocdwyy1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86EC34C0-0038-11EA-8D66-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we might want to keep documentation that gets too low-level out
> of git-commit(1).
>
> So for instance, this part that got moved from commit-tree:
>
>> +A commit encapsulates:
>> +
>> +- all parent object ids
>> +- author name, email and date
>> +- committer name and email and the commit time.
>> +
>
> I think could just stay there.

Me too ;-)

> ... I wonder if it would make sense to define them there in
> git.txt, giving a more user-facing description. Something like:
>
>   GIT_COMMITTER_NAME::
> 	The human-readable name used in the committer identity when
> 	creating commit or tags objects, or when writing reflogs.
> 	Overrides the user.name config.
>
> and so forth for COMMITTER_EMAIL, AUTHOR_NAME, etc.

Yup, I like that.  Then either commit-tree, commit etc. can refer to
the environment variables section of linkgit:git[1], or perhaps assume
that the readers know that anything common across all subcommands
are there in linkgit:git[1] (I prefer the former).

Thanks.


