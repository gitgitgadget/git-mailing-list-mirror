Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78AFA1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbdLMSLL (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 13:11:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59122 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753691AbdLMSLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 13:11:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92078B64DB;
        Wed, 13 Dec 2017 13:11:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZEeiHaaJr9ZxjqQXYySIvFhYqhU=; b=U163/I
        8KRTWpc+OoJZFNYQ5EdURvrc6cjg5Bbmkzwvz3dgnpWmeiIkmrYQKwDTLXfHpVLi
        iXCcAGwTNw7TX7v4mIWfhgJj/YLzr8zfSk7Y4CGp5E9xezZ98/2HPrrOHQzXFGWp
        ivMDK2/eN01AnG/qlwOWF51B6YJqE3WbGHjXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lai4agONvbjLrIS68DvQslhwHdygzv+2
        6vBRlcbK8WpugTnzhmmdiyvB/USENLaMvPkMWBcuPhGSUyH6Y8wRcpGewUktOnFf
        5h3MSZY8SR2tmfTRT7k4i4/yhSMaWyZP/3C28hNvf3VnjQtuFTLpjKMLs3moDqDO
        VaIzodcBg1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 897BAB64DA;
        Wed, 13 Dec 2017 13:11:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE8B7B64D7;
        Wed, 13 Dec 2017 13:11:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        peff@peff.net, patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
        <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
        <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
        <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com>
        <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org>
        <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com>
        <xmqq1sjz3frf.fsf@gitster.mtv.corp.google.com>
        <D2973852-BDF4-4251-8DE3-CE6AAD303A5F@gmail.com>
Date:   Wed, 13 Dec 2017 10:11:01 -0800
In-Reply-To: <D2973852-BDF4-4251-8DE3-CE6AAD303A5F@gmail.com> (Lars
        Schneider's message of "Wed, 13 Dec 2017 18:57:55 +0100")
Message-ID: <xmqqzi6mwlai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FADD6D6A-E030-11E7-8EC5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> ... In a perfect world I think I would store
> the encoding of a file in the tree object. I didn't pursue that solution
> as this would change the Git data model which would open a can of worms
> for a problem that not that many people have (almost everyone is on
> UTF-8 anyways).

Having that "encoding" trailt recorded in the tree that contains the
blob would mean that the same blob can be recorded with one
"encoding" trait in a tree, and in a different tree it can be
recorded with a different "encoding" trait.  I doubt it really makes
sense.

