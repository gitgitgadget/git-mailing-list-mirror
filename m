Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C481C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0769720842
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lS7UinaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgAJTg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:36:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56134 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgAJTg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 14:36:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 425744292F;
        Fri, 10 Jan 2020 14:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nGfPZSbJ5QDulnmuR3/BKL/gxGM=; b=lS7Uin
        aItoSqDCHBwKV51u8RbO5mXgFt+EYNhGtQULo/3aqZ/5efwYsLXi52+7HZb+Vn/h
        6tl+StJ4DG0j/E2jvQfExu71LbwcrR+4s9CmreUrISA0FVbp5r5DVa8D7MgRJer4
        cDokTDNGyBHR1Idna4GuVYVlJmN/m7Qc4exwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RB9d+2PaHTpJ0fFW6hm7FWOlzOt/H1sP
        QcmZ2ci1wRLkNbIFNK9hK+51OC802dWECxLUt09q+U3upeA2M5LkE1pdNQKYDavu
        EqUBO89h5LlmD6Tj1rIa9NlKQtTFgCippX6njjVw2jG826i0FpABXo1FWc78ZGrI
        o262oegGd90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E034292E;
        Fri, 10 Jan 2020 14:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D44D4292D;
        Fri, 10 Jan 2020 14:36:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Wood <carlo@alinoe.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodule update  strange output behavior.
References: <20200109192040.46aaa01e@hikaru>
        <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
        <xmqq8smgz9as.fsf@gitster-ct.c.googlers.com>
        <20200110101251.3b9f9332@hikaru>
Date:   Fri, 10 Jan 2020 11:36:54 -0800
In-Reply-To: <20200110101251.3b9f9332@hikaru> (Carlo Wood's message of "Fri,
        10 Jan 2020 10:12:51 +0100")
Message-ID: <xmqqblrbm7c9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EEFA720-33E0-11EA-8544-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Wood <carlo@alinoe.com> writes:

> It seems to me that the other part of the problem is printing
> this output for submodules when nothing (needed to be) is fetched.

Hmm, I am not sure if that is a reasonable expectation.  Would it be
possible to tell if there is something that needs to be fetched
without attempting to contact the other side?
