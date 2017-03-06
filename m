Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDDA20133
	for <e@80x24.org>; Mon,  6 Mar 2017 20:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbdCFU2x (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 15:28:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61154 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932200AbdCFU2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 15:28:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A6F76D6A4;
        Mon,  6 Mar 2017 15:21:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pN8pegUnkcDgwqtubkD4ldo8uxU=; b=oubGOH
        LmKos3JiK1MIe3C2aZPyZklmtVH9izP2WOuTx13kO36goJjgV5G9fJxIgyilcswQ
        lpcrBmhSEdUV6yrJ8NV+OUEbXopjETJPqgC2lcsHXUxVDvEV3evpTG89/D01ejE3
        m5sX9jdq/5IrIDqVmzJKpNZt32fbCF34OVOzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SwSdRmfF8Dq5w0xALLXkgsGkhsEWjuGp
        BEopxx7b6rwH5XaRJmvXLFls28JG3tBkjFw3KoNGRDN1B5fHdVOP+fBeJfCh4cWL
        hxtZ0YsHplYe6fs6xFEc58wrTakUKeIg4XiBsl7hviZGsRY2U6e72V5RGht792Yg
        qjZWhE0OlIQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 338F16D6A3;
        Mon,  6 Mar 2017 15:21:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 856846D6A2;
        Mon,  6 Mar 2017 15:21:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: bisect-helper: we do not bisect --objects
References: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0tzH+QiNM2BMhe9qcKdD0rP9T=Ry94=EPV+=d+7cdLfQ@mail.gmail.com>
Date:   Mon, 06 Mar 2017 12:21:42 -0800
In-Reply-To: <CAP8UFD0tzH+QiNM2BMhe9qcKdD0rP9T=Ry94=EPV+=d+7cdLfQ@mail.gmail.com>
        (Christian Couder's message of "Sat, 4 Mar 2017 00:04:54 +0100")
Message-ID: <xmqqfuiqnokp.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83B7026E-02AA-11E7-8B77-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I think I just copy pasted the code from cmd_rev_list() in
> builtin-rev-list.c and probably didn't realize that revs->tree_objects
> would always be false.
>
> Thanks for spotting this and removing the dead code.

Thanks for a quick confirmation. Just FYI I was looking at this code
because I was trying to assess how involved it would be to teach the
code to do a bisection only on the first-parent chain.
