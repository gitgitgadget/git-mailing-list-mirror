Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E6BC2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 23:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8C7217D8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 23:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xkIds8Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDPXe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:34:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57407 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgDPXe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 19:34:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7993AB008C;
        Thu, 16 Apr 2020 19:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YnoRc1t41SqYp2UmzogOJgQNbDg=; b=xkIds8
        Vz3zI/BVYiG2SrIG6I4gxtyGUAzaqmgOTbiILxOMmmUSwtFmWXLo9SLSSZdEWuXY
        Cj7a6IISXJ9AKYQbcpJJ1sBScTOH+cJyRSa284W5ErAqg3Fez0N/agVOcsGyYwp9
        cx0LcyQ/zSAwhBBBq/sIlA0UA/CobiQBW+Pmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QtANjJCixVPFJsHIi0SyY2N7LHvP2TCh
        zqzaXLZr2vOxlDNj1D6SgruDN/zlYzU+sWv9p2ElrsRwVTQD39+9LVnQWJ4M4pPe
        cqykqXXtORxukpZi9GEvZxgn7wFpbIEHM8iwKwhrfrmGUkcH61O8rDanePFkVMsf
        Px4TEH1UiVM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 723E3B008A;
        Thu, 16 Apr 2020 19:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDE28B0088;
        Thu, 16 Apr 2020 19:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <20200416211208.xqnnrkvcl2jw3ejr@doriath>
        <20200416213009.GA1721147@coredump.intra.peff.net>
        <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
        <20200416224708.zr4dlrz4hpaqsz2s@doriath>
        <20200416230554.bhk2yfycjwjpxggy@doriath>
Date:   Thu, 16 Apr 2020 16:34:22 -0700
In-Reply-To: <20200416230554.bhk2yfycjwjpxggy@doriath> (Damien Robert's
        message of "Fri, 17 Apr 2020 01:05:54 +0200")
Message-ID: <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDD46858-803A-11EA-B4E4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> Here were the two reasons for the RFC of this patch e3165570dfca690ea1a71518799153f6350777ae
> ...
> This means that I get the fallback of 'origin' if no remote is specified.
> So if I set a pushRemote="foobar" but no remote, then remote.c will
> consider we are in a triangular workflow but git push will not.

OK, so in short, what is queued in 'next' is quite borked X-<.  I
don't mind reverting the merge then.

Thanks.
