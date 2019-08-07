Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C12C1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 19:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbfHGTTW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 15:19:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60472 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfHGTTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 15:19:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 657FB7850F;
        Wed,  7 Aug 2019 15:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zUTjFvcbvDb17NE9knk8QNuwdNE=; b=pDyWyH
        SaOhD9A9e7Y49eEHR6sNh3JDTx1LWXMXjrejrf8ImA7Oxn5ufAsFJRoyojKqJ0UF
        0uqJb59SAO8HH+tD0rlKiFZNYja56ghUF6mZzsLM/fNApXWWUeSTjzyvdwoJpHHz
        yHDcUs6lW4FtDamw2kSVEZKHknc9ef7elOzOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aGR6Lr8Lt0U/BXRekn0LOamPFTAAgUdW
        I0RnZFm0lNP0KqFQR+/qa16LfN0pZ13/QkMgkH3GYIT8kSbj/yM/1EV7FL+VyGY7
        JEdAkH2dI7LUUhaFqNjLBKzIHQ4aY1H4c16I54cxVGkdvNy1yphUY6B+Fzb3snC/
        4sFJOL1uHGU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C5327850E;
        Wed,  7 Aug 2019 15:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86BD97850D;
        Wed,  7 Aug 2019 15:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v4] documentation: add tutorial for revision walking
References: <20190806231952.39155-1-emilyshaffer@google.com>
Date:   Wed, 07 Aug 2019 12:19:12 -0700
In-Reply-To: <20190806231952.39155-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Tue, 6 Aug 2019 16:19:52 -0700")
Message-ID: <xmqqwofohjgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E4F54A4-B948-11E9-8B9F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v3, only a couple of minor changes from Jonathan Tan - thanks.
>
> I'm dropping the updates for the RFC set, since they're incremental from
> now. Next time you all see them they will be in a form which we would
> hope to maintain over a long period of time, checked into source -
> likely in the form of an mbox or dir of .patch file.

Sure.

> I think the tutorial itself is pretty much ready...

A few comments after skimming this round; none of them may be a show
stopper, but others may have different opinions.

 - There is still a leftover "TODO: checking CLI options"; is that
   something we postpone teaching?

 - This is an offtopic tangent, but "my first contribution" being an
   addition of an entire command probably mistakenly raised the bar
   to contributors a bit too much.  A typical first contribution is
   a typofix, fix to a small (e.g. off-by-one) bug, etc.

 - For a revision walk tutorial, not seeing any mention of pathspec
   filtering and associated history simplification is somewhat
   unsatisfying.  On the other hand, I expect that enumeration of
   objects contained within commits is (hence various --filter
   options are) totally uninteresting for end users who run the
   command interactively and view the output of the command on
   screen.

 - Enumeration of objects is useful at least in three places in Git:
   (1) enumerate objects to be packed, with some filtering based on
   various criteria; (2) enumerate objects that are reachable from
   anchor points like refs, index, reflog, etc., to discover what
   are not reachable and can be discarded; (3) enumerate objects
   that still matter (i.e. the opposite of (2)) so that they can be
   fed to validation mechanisms (e.g. "cat-file --batch-check").  If
   this were titled "My first object enumeration", the reaction led
   to the latter half of the previous point may not have occurred
   (pathspec filtering would still be relevant, but not as
   much---for packing to create a narrow clone, you do not want to
   use pathspec with history simplification, but you would want to
   use something more like "root and intermediate trees that are
   necessary to cover these paths" filter in the
   list--objects-filter layer).

And from the point of view of the last item, I would think the new
document is covering a need that is different from what we
traditionally would call "revision walk", which is more about "git
log", not the upstream of "git pack-objects", which this new
document is more geared towards.

Unless "git walken" is an exercise of how to write code that does
random thing, use of --grep filter however may be out of place,
though.  I do not offhand think of a use case where --grep would be
useful in the revision walk/object enumeration that is placed
upstream of "pack-objects".

Thanks.

