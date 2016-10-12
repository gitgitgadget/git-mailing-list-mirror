Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81243207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbcJLNPW (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:15:22 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:58470 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbcJLNPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:15:20 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buJK4-0006zw-IX; Wed, 12 Oct 2016 15:11:52 +0200
Date:   Wed, 12 Oct 2016 15:11:49 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 1/3] serialize collection of changed submodules
Message-ID: <20161012131149.GC84247@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
 <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
 <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 10:59:29AM -0700, Stefan Beller wrote:
> On Fri, Oct 7, 2016 at 8:06 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > +static void free_submodules_sha1s(struct string_list *submodules)
> > +{
> > +       int i;
> > +       for (i = 0; i < submodules->nr; i++) {
> > +               struct string_list_item *item = &submodules->items[i];
> 
> You do not seem to make use of `i` explicitely, so
> for_each_string_list_item might be more readable here?

Will change.

> > @@ -603,12 +645,23 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
> >                 die("revision walk setup failed");
> >
> >         while ((commit = get_revision(&rev)) != NULL)
> > -               find_unpushed_submodule_commits(commit, needs_pushing);
> > +               find_unpushed_submodule_commits(commit, &submodules);
> >
> >         reset_revision_walk();
> >         free(sha1_copy);
> >         strbuf_release(&remotes_arg);
> >
> > +       for (i = 0; i < submodules.nr; i++) {
> > +               struct string_list_item *item = &submodules.items[i];
> 
> You do not seem to make use of `i` explicitely, so
> for_each_string_list_item might be more readable here?

As above.

Cheers Heiko
