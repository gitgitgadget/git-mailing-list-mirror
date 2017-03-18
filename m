Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5878A2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 22:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdCRWpj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 18 Mar 2017 18:45:39 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:49657 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdCRWpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 18:45:39 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4CB0BB63895
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 23:18:56 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id B2EFA200398
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 23:17:10 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
Date:   Sat, 18 Mar 2017 23:17:10 +0100
Message-ID: <1595815.mnbOBApe2i@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170318175353.24578-1-jn.avila@free.fr> <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le samedi 18 mars 2017, 12:41:22 CET Junio C Hamano a écrit :
> Jean-Noel Avila <jn.avila@free.fr> writes:
> > Providing git in localized version is a good step for general adoption
> > of the tool. But as of now, if one needs to refer to the manual pages,
> > they are still confronted to english. The aim is to provide
> > documentation to users in their own language.
> 
> Please outline how the end result looks like here.  Where are the
> localized man pages installed?  Do installers get to choose to build
> and install the localization for some but not all languages and if
> so how?  etc.
> 
> > signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> 
> s/sign/Sign/;
> 
> > -man: man1 man5 man7
> > +man: man1 man5 man7 man_l10n
> 
> Hmmm, at least in the early days of the topic, I'd prefer that "make
> doc" and "make install" I need to run dozens of times a day from the
> toplevel not to require po4a.
> 
> Thanks.

Fair enough. 

Anyway, now I see  there's a take away from the discussion thread. Right now 
the man pages are tagged with the actual version of git, because the 
documentation is supposed to change at the same pace as the code. But that may 
not be true for translations, In this case, the automatic running of po4a will 
generate fuzzy matches which are not going to be used in the translated texts, 
leading to patchworked manpages, depending on the level of acceptance of 
untranslated entities.

If we want to freeze the translated manpages at a given version of git until a 
new version of the manpages is fully translated, we'll have to commit the 
translated .txt and force in some way the version to freeze (not using the 
generic asciidoc target of the Makefile).  But, that may drag the version of 
translations far behind the original if translation is stalled.

Or maybe people will not be so upset by mixed language manpages when the 
translation is lagging, but will prefer to have a "best available translation" 
of up-to-date pages. Plus that would be managed automatically by po4a's level 
of translation threshold to effectively generate a translated man page as long 
as the untranslated parts are still sparse in the mixed-up text.

For now, I keep this last option.
