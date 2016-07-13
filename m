Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08C02018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbcGMRFY (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:05:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751186AbcGMRFW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 13:05:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CBF229EAB;
	Wed, 13 Jul 2016 13:04:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+bx3CQU7bje8
	rDDYz8cSWhavFR8=; b=BCa6W2mgUfv591GpT2pTvN2NetjCB8NND0iJLPq9613W
	aR5NqIIEFILxL3qm/yQ5dkdyYrKbuqM1Y+v6Os4qTAPTYSos0KtKwCXNjtSPsE7e
	SxcRSrspe8uCFX3sCGAtnlqi6vBkBDXKFcCXsJuxqjuvKLP146R3WuTzd0raSPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mA4bbQ
	3KCVc3RhNOFFJnkWcqa7NxdpRO9cljhTnwDc49qlZqp0I4CyZ0nXRqDkungtS1hI
	ImwHfyVHGlPJFl2QsywVpNWr/RphTgmn7ayFVPypBOGU78DYjpc/s7XgwDs9SFFt
	yCZtytfRLYGgMSmkIJPYYzkWYavzwC5DJmwWA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 25B5529EA8;
	Wed, 13 Jul 2016 13:04:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FC8529EA7;
	Wed, 13 Jul 2016 13:04:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jehan =?utf-8?Q?Pag=C3=A8s?= <jehan.marmottard@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Bug report: --invert-grep and --author seems to be incompatible.
References: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
Date:	Wed, 13 Jul 2016 10:04:49 -0700
In-Reply-To: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
	("Jehan =?utf-8?Q?Pag=C3=A8s=22's?= message of "Wed, 13 Jul 2016 18:52:48
 +0200")
Message-ID: <xmqqtwft1nbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9C9EBFA-491B-11E6-874E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jehan Pagès <jehan.marmottard@gmail.com> writes:

>> git log --author=someone --invert-grep --grep=something
>
> But it does not work. Actually it looks like it just returns
> everything (as though I had done a simple `git log`).

Do you see a commit that is by "someone" and has "something" in it
in the output from the command?

I think --author=someone greps the "author " field in the commit
object looking for the hit with "someone", and your request asks to
show commits that either do not have "something" or was not written
by "someone", I would guess.

