Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D6420988
	for <e@80x24.org>; Tue, 18 Oct 2016 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935481AbcJRVTS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 17:19:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53096 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932872AbcJRVTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 17:19:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16AD647693;
        Tue, 18 Oct 2016 17:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XYRQgJgCXNGlNu0LZzaPMCKpmwQ=; b=ismkn2
        E9TR2eySonzCcea1THSS2qNgP/rddOT7OLU7cg2JZUWr72FJfd1VX3rnpkIlvxiC
        cYW4gcMFPnyvQfz84Ea4AUtuQYJ5x00OBWEVHwiA/PVMikLkCxPWuhmHE/kZwDoC
        InjUqxhi2zOFQwaWllzdZwOATwDtNeS2H1Pso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m+2J0FEi2NFoTdCAAkpW8oKnwgJXPesN
        0qdS8WQU9Dgp6ZCMpSXFZ0odW3BGgKuVkP2fGNP5PZNS9Uw0I+L/h1A4Peu7usT/
        zDN+s/dNcKYU5Cm07KgzzYmpvSqD9m+JM4Ln1V0pnJaAGdlDcFahtsMzGmz/DntQ
        gc0SaVkJUHU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E59647692;
        Tue, 18 Oct 2016 17:19:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83DB047690;
        Tue, 18 Oct 2016 17:19:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
References: <20161018210623.32696-1-sbeller@google.com>
        <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 18 Oct 2016 14:19:12 -0700
In-Reply-To: <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 18 Oct 2016 14:12:19 -0700")
Message-ID: <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85E2741E-9578-11E6-8BBC-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> The remote URL for the submodule can be specified relative
>> ...
>> v3:
>>  * fixed the coding style.
>
> Ah, thanks.  I had a squash queued on top but will replace with this
> one.

Heh, I guess I shouldn't have responded before seeing what this
breaks.  Applied on top of sb/submodule-ignore-trailing-slash, these
seem to break.

    t/trash directory.t3600-rm
    t/trash directory.t7403-submodule-sync
    t/trash directory.t7406-submodule-update
    t/trash directory.t7407-submodule-foreach
    t/trash directory.t7506-status-submodule

Some may be showing broken assumptions of the downstream, two wrongs
compensating each other and correcting one exposing breakage of the
other.  I didn't look at them deeply.
