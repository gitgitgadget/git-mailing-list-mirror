Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143AC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7698920782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sRf+kkHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHYQEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:04:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57531 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgHYQEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:04:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 009257F33E;
        Tue, 25 Aug 2020 12:04:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5qg+6Xu8xhDEz9vh195ABGfToTg=; b=sRf+kk
        HcouITtMckrn96i4SDT9JDtoQn3q7noZvudC7zXoyDNVvBgCoa4DdMavn96tguct
        dgvGQpx9I4a40S2pHfteOit+xaBXIqembbA7LhXBov9zw82YZvc9b9zWbBbNgD+/
        tug61Hn3duYB+4XXmT2A9LloN3VPTyZIwX0gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r8BaSvJ6kIQmPhq7pdNrA1fFYVxQzGog
        Klw3PPZmkyMvcDFlx0H6ix10tcBe9CqS5gi9D0gXUN4sz02Gmqk60gB8eqJvn1/H
        Ne5XvQrNOzvy6Edj/4SOzwb+TmWPpmKaUuWvKCVyxWcpRxRI0iE06Cdqc6hTf534
        qNmMgvQEsrg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC9E77F33D;
        Tue, 25 Aug 2020 12:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C48D7F33A;
        Tue, 25 Aug 2020 12:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet>
        <xmqqblj92lro.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008241445200.56@tvgsbejvaqbjf.bet>
        <xmqqzh6j51j0.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008251006210.56@tvgsbejvaqbjf.bet>
Date:   Tue, 25 Aug 2020 09:03:58 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008251006210.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 25 Aug 2020 10:07:59 +0200 (CEST)")
Message-ID: <xmqqpn7e1zm9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96262784-E6EC-11EA-8661-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But if all you're interested in is the part before the actual email
> address, isn't "Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com>" almost identical to "Johannes Schindelin
> <gitgitgadget@gmail.com>"?

Here is what I often see in my MUA.

O  [  75: Johannes Schindelin    ] Re: [PATCH v2 3/3] ci: stop linking bu...
OA [  20: Johannes Schindelin    ] pw/add-p-allowed-options-fix, was Re: ...
O  [ 106: Johannes Schindelin via] [PATCH] git-gui: accommodate for inten...
O  [  66: Johannes Schindelin via] [PATCH] mingw: improve performance of ...

The "via ..." part may change its length depending on how long the
real real name is, but it is irritating and more importantly conveys
harmful information, as I am trying to be as neutral as I can when
reviewing patches no matteer how they are delivered.
