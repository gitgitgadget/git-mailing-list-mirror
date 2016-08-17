Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B011FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbcHQSfK (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 14:35:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752545AbcHQSfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 14:35:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 23533346B3;
	Wed, 17 Aug 2016 14:35:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDie8CHJ80QgixZ8DWGWHfjgD44=; b=NIxjTP
	RW2N2QnCNz+/m3I3xJfVWJKPm8lUILn6VgADmJ6a4fVc1k7oEtg39GiXgu2sWG07
	xXpkMOlUyuiH94DN0W4nK8oqaRdfACtnMF4PzddV2WWwOT+IZfFXJnLM/f0MaQZ7
	8dLmsL+wDPp+PBAKzUeg9+yEtUXJywSbX6U1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A5SKB4beBY88LgzrdyhSz+/gyVueZdy9
	2HksnP6J3fbbE18KTT07GVa/qVC8iUuRfKYZldiW7K3QVVB/Vxw9PhOUyudp3Q+h
	XDNmTulFeMs68bSEcCOA6pQg+0ks5pdrjo5exRa2iA5+Lo81Jde/kr4izry9DhPv
	z6Uz6BR8nxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9327346B1;
	Wed, 17 Aug 2016 14:35:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE5EA346AF;
	Wed, 17 Aug 2016 14:35:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Robert Dailey <rcdailey.lists@gmail.com>
Cc:	Git <git@vger.kernel.org>
Subject: Re: diff --diff-filter on modified but locally deleted files
References: <CAHd499D50TLMYtAovTF80ev0=2u=9yyMNcq6-he3Ba2kXzqW9g@mail.gmail.com>
Date:	Wed, 17 Aug 2016 11:34:58 -0700
In-Reply-To: <CAHd499D50TLMYtAovTF80ev0=2u=9yyMNcq6-he3Ba2kXzqW9g@mail.gmail.com>
	(Robert Dailey's message of "Wed, 17 Aug 2016 13:04:07 -0500")
Message-ID: <xmqq8tvv9rcd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E6D239E-64A9-11E6-91B3-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> My use case is that I do a merge from branch A to branch B. Branch A
> modified a file which is already deleted on B some time before the
> merge.
>
> When I do a `git status -sb`, these locally deleted but remotely
> modified files show up as "DU".
>
> I want to invoke git status or diff (or something else) to get a list
> of these specific conflicts (locally deleted, remotely modified).

As far as "git diff [--cached]" (which is "compare HEAD with the
working tree through index") is concerned, these paths are in the
"U"nmerged category, so you'd give "U" to diff-filter to view them.
Of course, that would give you other kinds of unmerged entries.

If you know they show up as DU, why not "grep DU" in that output?
