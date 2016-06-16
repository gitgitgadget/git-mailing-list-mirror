Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CEC1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcFPSUi (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:20:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbcFPSUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 14:20:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB0F5254D4;
	Thu, 16 Jun 2016 14:20:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AbaRcSao0bqYzNmcn+PXr0WDS9o=; b=AA2+oj
	slGExQaKuhbdUlHg6/xmzdij9EdcURHpXoEHTMhU1YSgg6kYW98zW0KMhBA7CSWz
	852V8Di4fk3/8EyTXvG2HaIAjh0cZJgmWrO9o5ByJFD3KGmX+LykSUTMPGTegfD7
	nmhl17phIy0VrNhrozIlGdTXDN2z4NHx3N3xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nY8qgEYhdVSzveQnx8gNe6JlEfHZ2PmU
	2DbwQrwrcz2TDT2IOavZVZfpMl3wBOA8KtHjuwq04et/lp27Q3VHYb9kxcw3hXEO
	28cg3uuu1GHHpmguCudcBW8LmU6wU+i1gCszlGpx/WXQeQzxCrxWhMseCzZ/gQK/
	gJlXBmlAPBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E216C254D3;
	Thu, 16 Jun 2016 14:20:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A126254D2;
	Thu, 16 Jun 2016 14:20:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/7] gpg-interface cleanups
References: <20160616093248.GA15130@sigill.intra.peff.net>
Date:	Thu, 16 Jun 2016 11:20:33 -0700
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jun 2016 05:32:48 -0400")
Message-ID: <xmqqy4653si6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04F07DDC-33EF-11E6-B72F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This started off with Michael's patch to sign_buffer, which is at the
> tip, and then me trying to address the possible deadlocks there and in
> verify_signed_buffer. While I was in the area, I took the opportunity to
> do a few cleanups.
>
> It's unclear to me whether the deadlocks are possible in practice; see
> patch 5 for discussion.

I do recall thinking about the verification side and coming up with
the same conclusion as yours when we queued that code (i.e. they
need to read the whole thing before checking).

> My guess is probably not, but the amount of code
> to support doing it right is not all that much. But if we don't like it,
> we can drop 4-6.

Let's keep all of them; they all looked reasonable.

> Patch 7 is still authored by Michael, but has been massaged greatly by
> me. I'll comment more directly on the changes there.
>
>   [1/7]: gpg-interface: use child_process.args
>   [2/7]: verify_signed_buffer: drop pbuf variable
>   [3/7]: verify_signed_buffer: use tempfile object
>   [4/7]: run-command: add pipe_command helper
>   [5/7]: verify_signed_buffer: use pipe_command
>   [6/7]: sign_buffer: use pipe_command
>   [7/7]: gpg-interface: check gpg signature creation status

Thanks.
