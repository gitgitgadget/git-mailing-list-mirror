Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F89F1F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbdLLA1b convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Dec 2017 19:27:31 -0500
Received: from elephants.elehost.com ([216.66.27.132]:57979 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbdLLA0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:26:55 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBC0Qqc2074475
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Dec 2017 19:26:52 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com> <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>
Subject: RE: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
Date:   Mon, 11 Dec 2017 19:26:46 -0500
Message-ID: <006301d372df$e82cf410$b886dc30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKyKGo4qh2sJ7CV4r7D/ydkuQ0kwQIINdwwoXEtFPA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about the response positioning...

I can send you a pull request on github, if you want 😉

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Junio C Hamano
Sent: December 11, 2017 6:27 PM
To: Randall S. Becker <rsbecker@nexbridge.com>
Cc: git@vger.kernel.org
Subject: Re: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile index 
> 3e39e28..4f1e6df 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -39,6 +39,8 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)  
> MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))  MAN_HTML = $(patsubst 
> %.txt,%.html,$(MAN_TXT))
>
> +GIT_MAN_REF = master
> +
>  OBSOLETE_HTML += everyday.html
>  OBSOLETE_HTML += git-remote-helpers.html  DOC_HTML = $(MAN_HTML) 
> $(OBSOLETE_HTML) @@ -415,14 +417,14 @@ require-manrepo::
>         then echo "git-manpages repository must exist at $(MAN_REPO)"; 
> exit 1; fi
>
>  quick-install-man: require-manrepo
> -       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO)
> $(DESTDIR)$(mandir)
> +       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO)
> $(DESTDIR)$(mandir) $(GIT_MAN_REF)

I suspect that this patch is line-wrapped and unusable for the final application, but I think what the change wants to do makes total sense---we are already letting the builder specify where the other repositories for docs are, and it is not such a big stretch to let them also say which branch or tag they want their documentation from.

