Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B72D1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 22:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbcHNWzi (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 18:55:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751015AbcHNWzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 18:55:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CBD58340DE;
	Sun, 14 Aug 2016 18:55:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xpmJcgOpJWAjysdYyt4Q7wSMFVE=; b=euvdHC
	DgEjuYlQ2s07zX+RA1VpkM2nYJQ+nLwO82JapYDjG7VlGy43LRL4gOh8C9J6Zokc
	tcXgF5kSWctgnCTpITCnq0HmpV3w/Ul3q+7PJbPJYwiocYqv5ta+FNU9cc1N7frn
	dwm4AZ5FSn68ACKWz9ni2qNZtqqHb+42AjOxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RimMsQP6vskCQK8hymDPcOYsdjsF7VDs
	iSDN8O9cRG3Hid9QuG0k1SgBU19Xql8S3ENeOSlmifLDhQrQmmMVTHXj/FMOJ7CJ
	snWQzkziMgWMZdgikEhqN5WYchgwl39qMGrEaUCU3sJ9AKdGLm1E2tGO0A3GBITo
	Kirsgew5sA4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5694340DD;
	Sun, 14 Aug 2016 18:55:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4999B340DC;
	Sun, 14 Aug 2016 18:55:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"GitList" <git@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] doc: commit: --fixup/--squash can take a commit revision
References: <20160814214630.1312-1-philipoakley@iee.org>
	<20160814214630.1312-2-philipoakley@iee.org>
	<xmqq60r3knoz.fsf@gitster.mtv.corp.google.com>
	<6ACCC850AC434350B15AADC19F02760B@PhilipOakley>
Date:	Sun, 14 Aug 2016 15:55:33 -0700
In-Reply-To: <6ACCC850AC434350B15AADC19F02760B@PhilipOakley> (Philip Oakley's
	message of "Sun, 14 Aug 2016 23:45:37 +0100")
Message-ID: <xmqqbn0vj6ze.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36985AA6-6272-11E6-9859-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> I think the
>> use of "commit" in an angle-bracket-pair in the label for the
>> section, i.e. "--fixup=<commit>", has been considered to be clear
>> enough to tell that you can use usual extended SHA-1 syntax to
>> specify the commit you want to talk about,
>
> I certainly hadn't picked up on that ability to use the extended sha1
> syntax (specifying revisions...) here.

By "has been considered", I meant that the documentation text is
still open for improvement.  I just didn't find rewording "commit"
with "commit revision" is that improvement we need there.

Perhaps we need to have somewhere central a section that explains
various notations used in the documentation set.  I think it is safe
to say something like "unless otherwise qualified, <commit> (or any
object type in an angle-bracket-pair) is used as a placeholder to
take any acceptable way to spell object names (cf. gitrevisions for
details)" these days [*1*].


[Footnote]

*1* In ancient days I think some plumbing commands only took 40-hex
object names, but as far as I know they've all been updated.
