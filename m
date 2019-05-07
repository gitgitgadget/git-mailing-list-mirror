Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F71A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 04:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfEGETm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 00:19:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53200 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGETm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 00:19:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CAED6234F;
        Tue,  7 May 2019 00:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EvOOcgp4Fu5TgPmGnFYRISXWRL8=; b=T4qsii
        zF1+PkhjI7kWroG7znICDIR2PYZf8wUz28rq+EICXwyFh73fuXRBY9mRwsveloI+
        XgbILHjpP69CgtgYhV4bIzomuap1exKpzIaGY4FJ4CsWOmacDit9EL0vbUfFep9Q
        SLptC1qe9ZLQo5Xq73WjUOGoB/rqiYyNOkCFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KXYYXWZCcTYGRdcsGoHJGukBt8KZiWml
        wJpY5j+UExCD13rlDLpvYkgtk37VQWRFr2KkaopH0RueX0wERN2RB7JJPBUwY0Dq
        7LyRzo/3Hg8SFR7JQewR6U/IgYO6OC5mOEBKCS4g4Hix+xTLFA7QLVNyaf0pbejM
        LDilPNGmODY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 043C06234E;
        Tue,  7 May 2019 00:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C5156234C;
        Tue,  7 May 2019 00:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Jeff Schwartz <jefftschwartz@gmail.com>, git@vger.kernel.org
Subject: Re: Request to add option to interactive rebase to preserve latest commit date
References: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com>
        <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com>
        <alpine.DEB.2.20.1905010900260.23829@perkele.intern.softwolves.pp.se>
Date:   Tue, 07 May 2019 13:19:32 +0900
In-Reply-To: <alpine.DEB.2.20.1905010900260.23829@perkele.intern.softwolves.pp.se>
        (Peter Krefting's message of "Wed, 1 May 2019 09:52:32 +0100 (CET)")
Message-ID: <xmqqtve6nbfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 517FAFB8-707F-11E9-86EF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Krefting <peter@softwolves.pp.se> writes:

> Junio C Hamano:
>
>>> Using interactive rebase has one flaw IMHO and that is the way it
>>> handles dating its commit. Can you add an option to interactive rebase
>>> that would make it use the date from the commit that is most recent
>>> and not the date from the commit that is the oldest?
>>
>> I am not sure what you mean by this.  If you interactively rebase
>> the topmost two commits (assuming that since three commits ago, you
>> have a linear history):
>
> I sort of assume that this is when merging several fixup! or squash!
> commits. I often end up adding lines the code to date these with the
> current date, but the date of the last fixup'ed or squash'ed commit
> would probably be better.

Ah, I see.  So if you have (time flows left to right, as usual):

	A---B---C

where B and C are fixup for A, the question is what's the author
ident and author time should be for the resulting single commit.

I think we currently use the ident and time from the original A, and
that is the only right thing to do, as I view

	$ git commit -m A
	$ edit
	$ git commit -a --fixup HEAD ;# create B to fix A
	$ edit
	$ git commit -a --fixup HEAD^ ;# create C to fix A
	$ git rebase --autosquash -i HEAD~3 ;# squash B and C into A

as merely a different way to do the following:

	$ git commit -m A
	$ edit
	$ edit further ;# working tree has an equivalent of C
	$ git commit --amend -a

The principle is "the bulk of the work was done in A, no matter what
is done incrementally by squashing in or amending small refinements;
the primary authorship date and time stays the same as the original".

When the person who is correcting other's change with --amend makes
a contribution that is substantial enough such that the amended HEAD
no longer resembles the original HEAD, there is a mechanism to let
the amender take authorship, i.e. do this at the last step instead

	$ git commit --reset-author --amend -a

in the second sequence.  I do not think there currently is an
equivalent in "rebase -i" language to do so.  

I am still not convinced it is a good idea, but I can see how
another verb that behaves like existing "fixup" or "squash" but use
the authorship not from the updated but from the updating commit
might seem useful.
