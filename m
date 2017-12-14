Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D741F404
	for <e@80x24.org>; Thu, 14 Dec 2017 22:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbdLNWNu (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 17:13:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55210 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753272AbdLNWNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 17:13:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35CB2CA47C;
        Thu, 14 Dec 2017 17:13:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lpbnzU+NNlMRldtEtaQGEoeRis0=; b=f9Hmwm
        TXj46h1y/JcQL28MvhrDDBHfdMBQ2cRLYtMXtB8C172abpxHJMph1DXBIDhxYu2M
        CbY1E/8eC3cq+P3ngqRISkqMN8lGquJMKQa3yZCQIq23RoNXpoF0PswoYXzV/qRu
        rAYL2bSPUj7v1KFUhZswpSNw6hos1EFe5SBm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a4Lt4R58ziI6/80fETLRc0SUuCIOURql
        PjSyUQt6lFQovtqnkE0rchkgz9wI3TXj86chb78AD4/3CGglOzPfF2/2PETmpffg
        KbHll6DT6SLYN9f1KFASpmMmNs3Szujj/vhyIPHTfNLbtw5XVHsS8AmaC8qfSq6o
        CuPbDKY6jVw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E0A6CA47B;
        Thu, 14 Dec 2017 17:13:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97884CA479;
        Thu, 14 Dec 2017 17:13:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH 2/2] transport: make transport vtable more private
References: <cover.1513287544.git.jonathantanmy@google.com>
        <cover.1513287544.git.jonathantanmy@google.com>
        <26f276956001a120cc9105b0071762c2fd4a45c5.1513287544.git.jonathantanmy@google.com>
Date:   Thu, 14 Dec 2017 14:13:42 -0800
In-Reply-To: <26f276956001a120cc9105b0071762c2fd4a45c5.1513287544.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 14 Dec 2017 13:44:45 -0800")
Message-ID: <xmqqind9rm95.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F13D332-E11C-11E7-A379-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Move the definition of the transport-specific functions provided by
> transports, whether declared in transport.c or transport-helper.c, into
> an internal header. This means that transport-using code (as opposed to
> transport-declaring code) can no longer access these functions (without
> importing the internal header themselves), making it clear that they
> should use the transport_*() functions instead, and also allowing the
> interface between the transport mechanism and an individual transport to
> independently evolve.

Yay!
