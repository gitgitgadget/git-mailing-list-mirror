Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C2E1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdLKX1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:27:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63098 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdLKX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:27:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E4BDB2A66;
        Mon, 11 Dec 2017 18:27:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AoTX4IdrvSyhb022svJO6xunFFw=; b=FzvXpB
        gpneQcKBz7ANTFU6tO+a+bAI3//qRweGNAuYxRGaFdWAztW3uETWs5ZECLE9tSCQ
        dnpoeDvOzKGnL0yQENjaOKD8qYzLa005uNc0vroyyCqVnNcF78Isw+s4rYH1iAid
        W5KzNLyfcQDabVOpsPFLHBJgI586RADDfhD5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DXpauNyapGFIWs+1Qd++v7vw1InQ/7qF
        dSMDVVKSzVW5cMJHim5BF+a4JHy6ai2bAlF2UvnH4C3h7aYZ3lkCS0c26JSyokI9
        +nj94J4VmFojw6jBOHjMAC0NMeHJe7SMKrAicWilQ7SZ5w3F2M3o1XJxmhCD4V1t
        HSxHaW0Ij8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 970ACB2A65;
        Mon, 11 Dec 2017 18:27:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 185E8B2A64;
        Mon, 11 Dec 2017 18:27:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>
Date:   Mon, 11 Dec 2017 15:27:14 -0800
In-Reply-To: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com> (Randall
        S. Becker's message of "Sat, 9 Dec 2017 17:07:57 -0500")
Message-ID: <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D24D9B0C-DECA-11E7-B3A6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3e39e28..4f1e6df 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -39,6 +39,8 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
>  MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
>  MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
>
> +GIT_MAN_REF = master
> +
>  OBSOLETE_HTML += everyday.html
>  OBSOLETE_HTML += git-remote-helpers.html
>  DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
> @@ -415,14 +417,14 @@ require-manrepo::
>         then echo "git-manpages repository must exist at $(MAN_REPO)"; exit
> 1; fi
>
>  quick-install-man: require-manrepo
> -       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO)
> $(DESTDIR)$(mandir)
> +       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO)
> $(DESTDIR)$(mandir) $(GIT_MAN_REF)

I suspect that this patch is line-wrapped and unusable for the final
application, but I think what the change wants to do makes total
sense---we are already letting the builder specify where the other
repositories for docs are, and it is not such a big stretch to let
them also say which branch or tag they want their documentation
from.
