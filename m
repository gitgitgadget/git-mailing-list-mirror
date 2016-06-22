Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1FD420189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbcFVTcJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:32:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbcFVTcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:32:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3319D26DDB;
	Wed, 22 Jun 2016 15:32:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=foWzGyaTNIJ1gsMevRoFVAkrEXY=; b=x9CzSu
	ClxJXGAqr3BCrOg9j4D2gmSFgv+1nQT8g5jP6qJ6g+Ar0BuuNUVyGoxAyClp6Lgr
	g7y3V7GTJuviYLQ7WOXcE4+/F76DORGyMUAeOP+qPhe9P4yTmYiFac4luCvrNKYM
	o9bF2/sBEEED8lxEWxjKSgZuIlbwjlt/X1nVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DLwFpwbrG/iJ1Fl/9ez2R/STSMfufSaT
	ahQjfd9rae9YzS7fpcf7UxKfuIFioXXnulQTtxOv+RnLlViy3fn6Z6HCePwXXhTH
	Esu9JGZxsy3jFWJEw45g30QmwdIkaXVnD3ZolsL6BL/bMvQNrklm8aEGaKgQgY6a
	zWLnsuTSoTY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C21926DDA;
	Wed, 22 Jun 2016 15:32:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1E5C26DD9;
	Wed, 22 Jun 2016 15:32:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
	<xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com>
	<CACsJy8BQxAkpoT7GVNgtM-0n1pMZeV5TRCiSn6TsYeATWeU=EA@mail.gmail.com>
	<CAPc5daWEoK4Gp138VPstqwCAX+2K=_gSW98brHjmJYNWK4dkZw@mail.gmail.com>
	<CACsJy8BMCjjX7_d73LX8+SiYWA4UUFyU3GGzxSVXMK4xubsKNg@mail.gmail.com>
	<CAPc5daU4K85a883sR0u87fTObakCvv6Z41qxx1WOT2=QdDjZeA@mail.gmail.com>
Date:	Wed, 22 Jun 2016 12:32:04 -0700
In-Reply-To: <CAPc5daU4K85a883sR0u87fTObakCvv6Z41qxx1WOT2=QdDjZeA@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 22 Jun 2016 11:59:40 -0700")
Message-ID: <xmqq4m8lm34b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0130F288-38B0-11E6-861F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think somebody's implementation of "echo" is not POSIX kosher.

Oops, I misspoke.  s/POSIX/XSI/; obviously.

But the conclusion is the same.  echo '\\\tA' may say \\\tA or
backslash HT A, depending on the system, so we cannot rely on that
in tests that are meant to be portable.

