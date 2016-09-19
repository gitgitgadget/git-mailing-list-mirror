Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA0E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 19:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbcISTog (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 15:44:36 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:53244 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbcISTof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 15:44:35 -0400
Received: from [84.168.70.3] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bm4UR-0005VZ-09; Mon, 19 Sep 2016 21:44:31 +0200
Date:   Mon, 19 Sep 2016 21:44:29 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 1/2] serialize collection of changed submodules
Message-ID: <20160919194412.GA62429@book.hvoigt.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914173124.GA7613@sandbox>
 <xmqqintvlpqv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqintvlpqv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 10:27:04AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > +static struct sha1_array *get_sha1s_from_list(struct string_list *submodules,
> > +		const char *path)
> > +{
> > +	struct string_list_item *item;
> > +	struct sha1_array *hashes;
> > +
> > +	item = string_list_insert(submodules, path);
> > +	if (item->util)
> > +		return (struct sha1_array *) item->util;
> > +
> > +	hashes = (struct sha1_array *) xmalloc(sizeof(struct sha1_array));
> > +	/* NEEDSWORK: should we add an initializer function for
> > +	 * sha1_array ? */
> > +	memset(hashes, 0, sizeof(struct sha1_array));
> > +	item->util = hashes;
> 
> 
> 	/* NEEDSWORK: should we have SHA1_ARRAY_INIT etc.? */
> 	item->util = xcalloc(1, sizeof(struct sha1_array));

Ok will do.
