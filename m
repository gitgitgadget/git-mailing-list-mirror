Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3962018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcF1RpU (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:45:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752046AbcF1RpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 13:45:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D162125ACD;
	Tue, 28 Jun 2016 13:44:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bVwA8UFblScAmPrQ9bBsKU+MY+I=; b=owykbs
	MmgXI5INsHPTNzEdVE4aiEflbbMH/9U8PHSmez23iCVsbf+QNR3YVekaNGfGox2Q
	QcscnWK97V6iQYV+nE4TcmwQhgOr7E9tGiTx2DbELxq0mwPAk80Wp+2boOKzM2RQ
	fASWpqk/c1+02SPSblknesFOSfjER4pA5EUj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MHLtIU1Nj2eKuCom20bkOZBa98XQQt38
	b2WBUea1ix8zKcYxMQwRWtzteUyM0PfJniSUv9Q/0aXZFIaqCbAz2X7yYs/VD2AB
	T/0IKlujL9HmP2+khuEHxeEdvegl7HEslZEz3OPsEM6hGelTTF6IiK+N/dGaEwrl
	9XCMxb8yVws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C915625ACB;
	Tue, 28 Jun 2016 13:44:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D31925ACA;
	Tue, 28 Jun 2016 13:44:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, novalis@novalis.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
	<576650E7.70107@alum.mit.edu>
	<xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com>
	<xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
	<8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com>
	<576B9081.3020405@alum.mit.edu> <5772421F.3030100@alum.mit.edu>
Date:	Tue, 28 Jun 2016 10:44:24 -0700
In-Reply-To: <5772421F.3030100@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 28 Jun 2016 11:23:43 +0200")
Message-ID: <xmqq1t3h9pjb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5003364-3D57-11E6-82A9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> (I suppose that `REFNAME_ALLOW_ONELEVEL` was
> meant for checking partial reference names, for example to vet "foo"
> that the caller wants to pass to `git branch`, which automatically turns
> it into `refs/heads/foo`.)

Correct.

> In summary, `check_refname_format()` is in some ways less strict than
> `refname_is_safe()`. For example, it allows reference names like
> `git-p4-tmp/6` or even `git-p4-tmp`.

Again, correct.

> I don't know what I was thinking. Long ago, when I refactored and
> documented check_refname_format(), I realized that the checks are
> surprisingly lax and that the `REFNAME_ALLOW_ONELEVEL` option is
> misleading. But I was new to the project and wasn't brave or energetic
> enough to do something about it. Meanwhile I guess I forgot that it
> never got fixed. Commit
>
> d0f810f0 2014-09-03 refs.c: allow listing and deleting badly named refs
>
> , which introduced `refname_is_safe()`, perhaps muddled the situation by
> adding a "fallback" check that is not strictly laxer than the main check.
>
> Where does that leave us?
>
> * It is currently possible to create and delete references with
>   names that are neither within `refs/` nor ALL_CAPS (though not
>   remotely).
>
> * Such references do not participate in reachability checks, so
>   they have to be considered semi-broken.
>
> * Users could create chaos (though not remotely) by creating a
>   loose "reference" whose name coincides with that of another
>   file under `$GIT_DIR`.
>   (`git update-ref objects/info/alternates HEAD` anyone?)

All correct.

> * `git-p4` is apparently the only code within the Git project that
>   was making use of this questionable freedom.

True.

> * Presumably there is user code in the wild that creates and uses
>   such references.

I doubt it, if they value their data.  .git/p4-tmp or .git/p4-tmp/6
are not just "partly broken"--they are just as transient as things
like MERGE_HEAD in that the objects pointed by them are subject to
be pruned.

> I think we need to get this under control, but given that we've allowed
> such references (albeit partly broken) for a long time, we probably need
> to provide an escape hatch to aid the transition. I'm skeptical that the
> mh/split-under-lock patch series is the best place to start such a
> campaign. On the other hand, I don't want that patch series to open up
> any new avenues to creating references that escape `$GIT_DIR`.
>
> Let me think for a bit about the next step. Input is welcome.
>
> In any case, I think that Lars's patch to `git-p4` is a good thing.

Thanks.
