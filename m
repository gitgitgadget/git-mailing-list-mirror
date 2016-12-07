Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A19C1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbcLGUEb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:04:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54587 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932568AbcLGUE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:04:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E40285561C;
        Wed,  7 Dec 2016 15:04:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m4Pnne70OzhYNsOCR2NqSqDg17Y=; b=WeWgkn
        oUMxDV8y7N8sCKE/viNQrUQ89W8FIAt6OskptzK80M14snrjYUn4Atcimqxoxr6y
        tPgOujTLFvJclyK2T3b1lUsizt/tGjikkVvIOhzhgF8rGD/Ji3eT551bWPRE5KGD
        Hxf7Th76jP3GN/y+fumQtmgGGpDO+XdmpsYtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QUjWzmsjelceO0kaSiFL6UVGLCeirvdv
        0ltVNf9LrhFDzABypVbTCoCWPdmbVKmXl3etwdAujiLTKJFNG1+9nwm+qsrIAOgp
        bPFJLpdCWblyxOZB0AqyjwtsmE7MBV10jsbETciBHC53mD3O2akgcApgkHA1cJ2D
        a379fRWe0HU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCA305561B;
        Wed,  7 Dec 2016 15:04:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 574865561A;
        Wed,  7 Dec 2016 15:04:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
        <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
Date:   Wed, 07 Dec 2016 12:04:27 -0800
In-Reply-To: <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net> (Stephan Beyer's
        message of "Wed, 7 Dec 2016 19:36:17 +0100")
Message-ID: <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BEE70B0-BCB8-11E6-A1B3-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> [1] By the way: git cherry-pick --quit, git rebase --forget ...
> different wording for the same thing makes things unintuitive.

It is not too late to STOP "--forget" from getting added to "rebase"
and give it a better name.

Having said that, I have a feeling that these options do not have to
exist; isn't their presence just a symptom that the "--abort" for
the command misbehaves?  Isn't the reason why there is no need for
"am --quit" because its "--abort" behaves more sensibly?

