Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5C92018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbcGRUgv (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:36:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751705AbcGRUgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 16:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 420E32D920;
	Mon, 18 Jul 2016 16:36:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t9o7z/5dokHJwCOLrB5yR8Y1Qsw=; b=CF5T3N
	8uhe8zM78Zq/ZwwsmYk5mYUu4lcenfeS84P8vsTKn4DiOLmGLEU1s/FEQod83OG7
	cn7LjFEm/uUmhbej2sWYLI4ihrAccFfQrB7jy7GNPoe8mP33aiRZqdTchQq+Tx2Z
	SBgc4xSLppCmPdTa/YfE7GNcmOrTiKxKeN074=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GzASFwzeGVivJCMCnUUZftrEm8Yavhqq
	Ku0Dhy2kS6vUxhKYYChPGjrt1qcR5E3TNh4n9hnWUyNA2lPo6H4DSrmRIP5PTvKl
	oH988qoppfHl4If5pZN8a4wsLxgmcrC5Ad1oHpoTque0gPrpemwAyqWuWk8nmUGf
	0uXeaAhhOYw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A9DD2D91F;
	Mon, 18 Jul 2016 16:36:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9C812D91E;
	Mon, 18 Jul 2016 16:36:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Parker Moore <parkrmoore@gmail.com>, git@vger.kernel.org,
	cranger@google.com, Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
	<20160716051800.GA2845@sigill.intra.peff.net>
Date:	Mon, 18 Jul 2016 13:36:44 -0700
In-Reply-To: <20160716051800.GA2845@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 16 Jul 2016 01:18:01 -0400")
Message-ID: <xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58A63C5E-4D27-11E6-8E50-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This `name=value` syntax for the -X flag was introduced in Go v1.5
>> (released Aug 19, 2015):
>> 
>> - release notes: https://golang.org/doc/go1.5#link
>> - commit: https://github.com/golang/go/commit/12795c02f3d6fc54ece09a86e70aaa40a94d5131
>> 
>> In Go v1.7, support for the old syntax was removed:
>> 
>> - release notes: https://tip.golang.org/doc/go1.7#compiler
>> - commit: https://github.com/golang/go/commit/51b624e6a29b135ce0fadb22b678acf4998ff16f
>> 
>> This patch includes the `=` to fix builds with Go v1.7+.
>
> With the disclaimer that I have very little experience with Go, this
> seems like a good, well-explained change. My only question would be
> whether people still use pre-v1.5 versions of Go, since it sounds like
> this would adversely affect them if they do. (If it does, it seems the

Yeah, you get something like this:

    $ ./git-remote-persistent-https --print_label
    2016/07/18 13:34:33 unlabeled build; build with "make" to label

which is probably not the end of the world.  The label does not even
identify the version of the source in any way, so I am not sure how
people are depending on that feature anyway ;-)



