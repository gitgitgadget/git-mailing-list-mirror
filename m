Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92C420954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbdLDQXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:23:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753767AbdLDQXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:23:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDFD5CA294;
        Mon,  4 Dec 2017 11:22:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j1cp9sEEBe0xUdyOmymV2lKpLvQ=; b=iZm6cL
        WcogZebeNxzmHQF/eyIRhlXxc29bF5rH87QatxqI39QUThpB8nbR1eMIoJ2oe+fZ
        /OHEXjK1dDOHO7SQcE8AAVSno2PB5E/vOtaeR2e0bapLlEDAeVdszMHA1SoZGzmK
        Ob5VJm5c3cYzsFyCP/OcdPmfuFrd/gUCHP2kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IhwZfBxr851F+sXqW0srj7P6CsF6Ooe2
        riiVjJBkv/RTV84LFIr4k+jp5OeyeEXrM7MJWeLeH7iSPhcZMnBvUBwnhcecCwVy
        uyrpaJNNEWdbtG9HUL0E0s0hoNHlxIdeAolfu5zfQTSJ1ibdnnIk9a/JEADm1htI
        Z5HLdpKGj0c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5CE4CA293;
        Mon,  4 Dec 2017 11:22:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39230CA292;
        Mon,  4 Dec 2017 11:22:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129195430.10069-1-avarab@gmail.com>
        <20171203115941.16674-1-avarab@gmail.com>
Date:   Mon, 04 Dec 2017 08:22:54 -0800
In-Reply-To: <20171203115941.16674-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 3 Dec 2017 11:59:41 +0000")
Message-ID: <xmqqzi6ympi9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62313808-D90F-11E7-828E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did this immediately after applying; please double check.

Thanks.

1: da337670f5 ! 1: aeae85bdd0 Makefile: replace perl/Makefile.PL with simple make rules
    @@ -27,7 +27,7 @@
         So replace the whole thing with something that's pretty much a copy of
         how we generate po/build/**.mo from po/*.po, just with a small sed(1)
         command instead of msgfmt. As that's being done rename the files
    -    from *.pm to *.pmc just to indicate that they're genreated (see
    +    from *.pm to *.pmc just to indicate that they're generated (see
         "perldoc -f require").

         While I'm at it, change the fallback for Error.pm from being something
    @@ -50,9 +50,9 @@
            it could be set in addition to INSTLIBDIR, but my reading of [7] is
            that this is the desired behavior.

    -     * We don't man pages for all of the perl modules as we used t, only
    -       Git(3pm). As discussed on-list[8] that we were building installed
    -       manpages for purely internal APIs like Git::I18N or
    +     * We don't build man pages for all of the perl modules as we used to,
    +       only Git(3pm). As discussed on-list[8] that we were building
    +       installed manpages for purely internal APIs like Git::I18N or
            private-Error.pm was always a bug anyway, and all the Git::SVN::*
            ones say they're internal APIs.

:
