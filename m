Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6AA2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbcGHRXn (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:23:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932652AbcGHRXk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:23:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C8B227F41;
	Fri,  8 Jul 2016 13:23:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KlCSg6E5JQctmr1mXT7lT4dqFLk=; b=r6bs73
	5z82I4JWirAGfVj3gjbajoCK3D2bkKmd4O92JilYb7vuKZWjM52QxZ40ig5hiTLc
	skYtQDBhPoXIBM7V/4APkx1fXhqRhqpmgETU0jeYOzVFcp/3x3u+BznN54vPRO4M
	fZdBScPPEYYPfkqqhx0AuaWEwm0cR++gC4gL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pZnVZwZP4c92WZj+g7/Za1YkE2BiWLzQ
	96rXG2X+rKD71PoPbU4gBwLZkyXghG+WI/E11phGhevep0Nyy2YfYCtzAeG6QsZg
	2IEzyhjAbp8QFdVILQc43AoIILD+bDns8yXGWhM5wdNLuMNv6MV1skRRiR1lI4w7
	k7Rw3jqyTBk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 53C4227F40;
	Fri,  8 Jul 2016 13:23:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF0F627F3F;
	Fri,  8 Jul 2016 13:23:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Subject: Re: [PATCH v2 2/2] cache-tree: do not generate empty trees as a result of all i-t-a subentries
References: <20160704174807.6578-1-pclouds@gmail.com>
	<20160706184829.31825-1-pclouds@gmail.com>
	<20160706184829.31825-3-pclouds@gmail.com>
	<xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
	<20160707171237.GA31445@duynguyen>
	<xmqqmvltp9f9.fsf@gitster.mtv.corp.google.com>
	<20160708153930.GA19448@duynguyen>
	<xmqqwpkwm8ho.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DkXuszC2f=TVzzXPKz2zvyRKFOVqXRoZGbwfo+oUMP7Q@mail.gmail.com>
Date:	Fri, 08 Jul 2016 10:23:35 -0700
In-Reply-To: <CACsJy8DkXuszC2f=TVzzXPKz2zvyRKFOVqXRoZGbwfo+oUMP7Q@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 8 Jul 2016 18:36:20 +0200")
Message-ID: <xmqq60sgm4bs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4FCB964-4530-11E6-B18F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I thought about that too, then did a grep which showed empty sha1 tree
> was used elsewhere. And thought of sending a patch to define
> $EMPTY_SHA1 in test-lib-functions.sh or somewhere so we don't hard
> code it everywhere, but I didn't. But yeah ls-tree works. The last
> line could be test_must_be_empty actual (a bit stricter than grep 1)

I am OK if you moved $EMPTY_TREE from t4010 to test-lib.sh, added
$EMPTY_BLOB next to it while at it, and remove their definition from
t1501.

t0000, t1100, t3404, t4054 and t5504 have references to 4b825dc64
that may want to be updated to use $EMPTY_TREE.

t5308, t7011, and t7012 defines HI_SHA1 and NULL_SHA1, which may
want to be updated to use $EMPTY_BLOB.

t/lib-pack.sh has one instance of 69de29bb2d1d that may want to be
updated to use $EMPTY_BLOB.
