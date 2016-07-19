Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAB81FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbcGSSFH (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:05:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752914AbcGSSFF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:05:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A025D2D9B5;
	Tue, 19 Jul 2016 14:05:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zUK7Q1rsYMjgcZpfkPE9WxAV3w0=; b=P8BT54
	tGGGu+qFSDoGZkt9VT39RkPRXGDS5JIq/zMKjdmBS01WSzhCNAG/WIWkuT1Ire8p
	olHweHidO8CJkar9kM8ZT34nE8TXkqiaY/FU93vyeKAa6EKEcvTeDVSCmNvfwSVU
	mOKDyWuuST4Y7buDS29JvCqvwbBirXBwJUlRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=le01bO/Xp7ZCxQQ6urcxTdyClpRCJDro
	YU62/UpYLS/QlEiZGElhmRocKJbfOc3BDIk+Q6zPpZRtfp0vMMjCNeJIWwPlcS4G
	naWuZl0bu1UJG8SJrWQdMZYJI/9qURradvpkUoo6V9GvKZf0MXGJvqnpRgXx/NS4
	kQ2S3pUfCIo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 989F22D9B4;
	Tue, 19 Jul 2016 14:05:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F04BC2D9B3;
	Tue, 19 Jul 2016 14:05:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Antoine Tenart <antoine.tenart@ack.tf>
Cc:	git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] worktree: add: introduce the --name option
References: <20160719144701.571-1-antoine.tenart@ack.tf>
Date:	Tue, 19 Jul 2016 11:04:59 -0700
In-Reply-To: <20160719144701.571-1-antoine.tenart@ack.tf> (Antoine Tenart's
	message of "Tue, 19 Jul 2016 16:47:01 +0200")
Message-ID: <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50C9FCBE-4DDB-11E6-AC0E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Antoine Tenart <antoine.tenart@ack.tf> writes:

> Adds a --name option allowing to specify the name of a worktree when
> creating it. This allows to have multiple worktrees in directories
> having the same name (e.g. project0/foo, project1/foo etc...). This
> commit keeps the previous behaviour by making it the default value, i.e.
> by using $(basename <path>) as the worktree name when the --name option
> isn't used.
>
> Two new test cases are added to ensure the --name option does not break
> other functionalities and is working properly.
>
> Finally, the documentation is updated to reflect this --name option
> addition.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@ack.tf>
> ---

Hmm, is this related to an earlier discussion

    https://public-inbox.org/git/20160625051548.95564-1-barret%40brennie.ca/

in any way, or is it an independent invention?

The conclusion of that discussion thread was roughly "users
shouldn't even _care_ about the name, and if they have to use name
to identify the worktrees to do certain things right now, reducing
the need for such 'certain things', not making it easy to give a
user-defined name to a worktree, is the way to go", IIRC.
