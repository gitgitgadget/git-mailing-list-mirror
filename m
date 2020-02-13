Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549DC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86012206ED
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ctk+h1Z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBMQzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:55:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51012 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBMQzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 11:55:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C8F7BB95F;
        Thu, 13 Feb 2020 11:55:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3bUGuGVvtYI07Fwr1tJEe7ZjgAo=; b=Ctk+h1
        Z7CHiGqKXY2Oqr16Nyv7Eb/8+QSSLsbJf8Q2gzdjg9U3nifHG0mk5sDcaNIVrc3B
        Aakr24MM4H1nlOuVBBPxRL99p6f4H1t/bOM3Sp1IURdmpdKRIQoADoDhqOo6cwXu
        rVxyViV3SewVY29Ncvir1L5hZI/K+/1x3JuOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dgegabbor87856bxX0ALY1WW0I1qL4Qs
        N5QUWPv5GMRT5amQJel5EaaCO66CUh0dMpo6elytHGOhelYhdRDTmb49SfETO7c8
        ESmkTD8Qc2ZhP+M1umFYbkNoYAjvKAck9RnbK/5/roEbYWJM/I1K2O086Y09zIf9
        6b8kqzdtupE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 642DFBB95C;
        Thu, 13 Feb 2020 11:55:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56527BB958;
        Thu, 13 Feb 2020 11:55:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] [RFC PATCH] stash save/push: add --index-only option
References: <20200212235033.782656-1-eantoranz@gmail.com>
        <CAOc6etbkMJf9qSNMU4fD4KeHE6NuMRUuQf_cBos_oxuYwaaeAA@mail.gmail.com>
        <xmqqblq3t6w1.fsf@gitster-ct.c.googlers.com>
        <CAOc6etYA79mTHB595cCVphmYmFECYvgPgV09SNo-pdEPEVD37w@mail.gmail.com>
Date:   Thu, 13 Feb 2020 08:55:17 -0800
In-Reply-To: <CAOc6etYA79mTHB595cCVphmYmFECYvgPgV09SNo-pdEPEVD37w@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Thu, 13 Feb 2020 07:21:54
        -0600")
Message-ID: <xmqqr1yys9ze.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DD0EF2C-4E81-11EA-B048-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Fair enough. It's ok to explain here, right?

Yes, absolutely.   How it works is 

 - an author comes up with a patch and its explanation and
   justificaiton, 

 - reviewers ask clarifications on what was unclear, point out what
   was wrong in the code, etc., and then 

 - the author responds with "here is what I meant", "yeah, you're
   right that the code is wrong--would it be right to write it this
   way?", and/or "not really, the code is OK because ...", etc.

All that exchange is to come up with a more polished version that
has correct code that is explained and justified in a clear manner.

The next iteration the author then sends would of course include the
fixes to bugs pointed out during the review, but also would explain
and justify the change better---the explanation in the original did
not convey what the author wanted to tell, but the explanation the
author gave during the review discussion did so better, so the new
iteration can learn from that exchange.

> There's no simple way to stash only
> what you have on index while retaining your working tree state.

Yes, that much can be inferred from what it does ("there is no easy
way to do X, so I am adding X").

The question is why would one want to do X in the first place.

IIUC, the simplest workflow using the new feature may go like this:

	$ edit file ;# edit a bit
	$ git add file
	$ edit file ;# even even more
	$ git stash --cached

After all of the above is done, "git stash list" may show that there
is a single stash that records the changes you made to the file
right after you added it, without your further changes (because you
are taking what is in the index).  Your working tree has all the
changes you made to file, both before and after "git add", and your
index is clean.

After you got yourself into this state where your index is clean,
your working tree file has all changes, and your stash entry has
only the earlier half of the change, what are you going to do with
that stash entry?  If we learn the answer to that question, perhaps
we may find (or we may even have) a better or easier way to achieve
whatever you were planning to do with that stash entry by some other
means---it might not even involve "git stash"---but without knowing
that, we cannot tell if the new feature is a good idea.

Thanks.
