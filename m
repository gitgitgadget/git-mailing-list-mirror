Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C6C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E477205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t96aquwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgEMVV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:21:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62462 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgEMVV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 17:21:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 413A56424B;
        Wed, 13 May 2020 17:21:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ohUtQcgg/MENORkPHobdgPcZ1pk=; b=t96aqu
        wp8Fj4pAXaokF4dABytgTVKvWDveKiuoMeTpSMeOdJX9lhcdF7KYWJAdfLCFCPxW
        RKwYBofgN7b/5a1sLfyWwQd+vnAaU03jE55GQNgYQK9AqKXLo1rV7z0zO/KrG11r
        UI86t4aEYdjTB6vwNHYj+9wMeWklNJmtYgCxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CcX2kTbyQxxfy98/H9SKfpByyXCDZMIP
        j+n2bzVVGC8LVH+trujSlWsEg9jk9nH90ItbBdGkd9N3HzClBuqL7VNtBYgD+gqZ
        oMIxIrBRi2BPMAAS3ZjQpfwHeU7YPyvjA2e0XnByFKsZuqzwEyxFr5hNJpeJCCa3
        wFdMPvfkoqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 384386424A;
        Wed, 13 May 2020 17:21:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95C4664249;
        Wed, 13 May 2020 17:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 00/13] Reftable support git-core
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <xmqq8shyq90r.fsf@gitster.c.googlers.com>
        <CAFQ2z_Oz4EgP7m1vBjack7FaFRg1BvwoDVuR2SpaZwS577-HgA@mail.gmail.com>
Date:   Wed, 13 May 2020 14:21:22 -0700
In-Reply-To: <CAFQ2z_Oz4EgP7m1vBjack7FaFRg1BvwoDVuR2SpaZwS577-HgA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 12 May 2020 09:49:28 +0200")
Message-ID: <xmqqblmrsf8t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1D6D912-955F-11EA-97CC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, May 12, 2020 at 2:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>> As I already said earlier today [*1*], I think some parts of the
>> series can be reviewed before the "dense code" part, so let's draw
>> the line between patch 8 and 9 (or patch 7 and 8) and try to see if
>> we can get the parts before the line reviewed adequately and merge
>> them to at lesat 'next' during this cycle, which will close in 3
>> weeks.
>
> I concocted 7 (write pseudorefs) yesterday in an hour or so. It looks
> like it passes tests, but I think it could do with more scrutiny. I
> propose to merge 1-6, and leave 7-8 until I figure out how pseudorefs
> and worktree refs really work.

OK.  Today's pushout has the boundary at that spot between 6 and 7.
