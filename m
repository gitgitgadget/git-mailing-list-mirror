Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7FC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A0020897
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KsqIa/Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQUEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:04:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57452 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:04:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EBC67C756;
        Wed, 17 Jun 2020 16:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TEPKM+a1XQBd
        thyL/t+7D6TGvlg=; b=KsqIa/WqOSwNI4tM9p00Qekv5Ovsr2L3jxEs/omhGZfW
        At2L8qdbU1D2uOaPK1XeEIL6rEY/xFyzFMj7Q2CgAUtxk3cLMdFu4gjoFxjXcpnr
        CxD3d+mKI0QemZLK70z1huK5zuv+qByjkoTLyTRYM9Vzjf7GOQ2448w7EtCmhzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gwxrlF
        quqN8zHYooGasR8okQSyIar+Ft2AUFCP6SBYFy5ox0xyrprqhx/wL5iA7uz0NX30
        uEUyjphtqCpEUnmgTQ9UlnHa6zJ8M9T0z1NWRmGuQtY/1SnCOXOsWPyiU1JGnTM0
        KjxWGxusHF/rCuNHDoAMCEQWMCCu/POOpz4q4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 563437C755;
        Wed, 17 Jun 2020 16:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCCA17C754;
        Wed, 17 Jun 2020 16:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
References: <20200505104849.13602-1-alban.gruin@gmail.com>
        <20200615152715.GD2898@szeder.dev> <20200615215020.GE2898@szeder.dev>
        <20200616070645.GF2898@szeder.dev>
Date:   Wed, 17 Jun 2020 13:04:30 -0700
In-Reply-To: <20200616070645.GF2898@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 16 Jun 2020 09:06:45 +0200")
Message-ID: <xmqq1rmdv4q9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C177FF04-B0D5-11EA-A9EE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Mon, Jun 15, 2020 at 11:50:20PM +0200, SZEDER G=C3=A1bor wrote:
>> On Mon, Jun 15, 2020 at 05:27:15PM +0200, SZEDER G=C3=A1bor wrote:
>> >       - Should we even allow 'splitIndex.sharedIndexExpire=3Dnow'?

Good analysis.  The most conservative might end up to be to disable
splitindex altogether but perhaps we can first set a reasonable
minimum to the expiration to say 10min?
