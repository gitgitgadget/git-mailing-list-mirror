Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB44207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 12:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbcJLM6V (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 08:58:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:54513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755278AbcJLM6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 08:58:07 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MePcd-1bUnMb1XrD-00QAue; Wed, 12 Oct 2016 14:57:06
 +0200
Date:   Wed, 12 Oct 2016 14:57:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: support the --stdin option
In-Reply-To: <xmqqeg3mai1b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610121449190.3492@virtualbox>
References: <cover.1476202100.git.johannes.schindelin@gmx.de> <2c7a52e43be710c7f37c4886629bda38df183c21.1476202100.git.johannes.schindelin@gmx.de> <xmqqeg3mai1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8dVXy3bHn00imXHY57SCKnqkemZRy1DKbkRl7ukwQV1Q64i/Qqi
 g5B6ikcZ4/BWE2W/RcPHArnTOOf4dmmuYszFLJZCjsPlrsHCEVIVye1HuEK6p50OPLnZCLL
 B3SpQBCpOowfqjaOb1cmIzX3mOsfXNq6tv79GUedZlL9oVY/KLoAbIvyP8euYRmQCQOzi1c
 lxmiuBeKyRhUl8+bH/l0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I9A0oy/p6gs=:7EST7wkMlnadF2yz3YKei1
 acewR1VkXofhSEX6NZDOHzq/A5ACRCHxlyvqCbALa6UCql7nBSGmicHyP79Gb0s4re+YArKsb
 PyzR2hixxh5wrMJJxUcnesaoAyKqdW29gv2cNqVKMiIiofTJximbb9zUrluSNF6+LY3+b65zv
 F/DxGZXv8l+0mmwYJC0EMGVessdbYJ/vIw0BSxf6QpcxKyG7VF4z3xNam/ZxGB8aPEwEWASfu
 /8iwsQqFo+YPNNMrEtY143VVjYTN0cl5y4jQwsCKrDzYbnW8t4bK0fW1POyNbC1jnmS+kI6pW
 JMXjm8J4zuX3qblMxIoB5i8kzWyW3FDD8wZ/finghYRmb60HcQjjqdm4y65UqjOInucvvxGEn
 OS7wm3xXpQk/PiX8F8x/7CSD3Bff4m9/S4RI3objX7TyPuj6Xz/Df9guxWKSLA8V2QFUcTcfr
 vogcdTgHFD86bN60JdCKKlbzwwygB/Xn3InXbTrbKqtYkQsFb54RXMfE8Zet6oPU2Mm2FfS6j
 KqgPX8Tzq4HkrF5HmVNrQsTuzhWuOHCEfhmgtBMg/3/QQuQOLaCg1Z7IpiJljhUCIjtXZknuf
 Mu7SboOIBsOjW/kgnTH1B2X6+NTBey2Ko/egVcOfLsLFHocBgpmR8QZ3BIZ7i6vkehjicv8Rq
 acJSKl90JXWS7Bk4/3YnRoxUs9S576su7XNyO+u3PL4oodI0FJxeHZ+EvdbhxFJHNWOTCFmoW
 lc3PaShY+gR2QLgifRLYSZzSfpZ2lF2p/TQ7a/sRVntvUkhSZOo2WVXRQhuguJCGAQ9Sui2lp
 j2VD4N4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +	if (read_from_stdin) {
> > +		strbuf_getline_fn getline_fn = nul_term_line ?
> > +			strbuf_getline_nul : strbuf_getline_lf;
> > +		int flags = PATHSPEC_PREFER_FULL |
> > +			PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP;
> > +		struct strbuf buf = STRBUF_INIT;
> > +		struct strbuf unquoted = STRBUF_INIT;
> > +
> > +		if (patch_mode)
> > +			die(_("--stdin is incompatible with --patch"));
> > +
> > +		if (pathspec.nr)
> > +			die(_("--stdin is incompatible with path arguments"));
> > +
> > +		if (patch_mode)
> > +			flags |= PATHSPEC_PREFIX_ORIGIN;
> 
> Didn't we already die above under that mode?

Oh right. Copy/paste fail.

> > +		while (getline_fn(&buf, stdin) != EOF) {
> > +			if (!nul_term_line && buf.buf[0] == '"') {
> > +				strbuf_reset(&unquoted);
> > +				if (unquote_c_style(&unquoted, buf.buf, NULL))
> > +					die(_("line is badly quoted"));
> > +				strbuf_swap(&buf, &unquoted);
> > +			}
> > +			ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
> > +			stdin_paths[stdin_nr++] = xstrdup(buf.buf);
> > +			strbuf_reset(&buf);
> > +		}
> > +		strbuf_release(&unquoted);
> > +		strbuf_release(&buf);
> > +
> > +		ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
> > +		stdin_paths[stdin_nr++] = NULL;
> 
> It makes sense to collect, but...

It does, doesn't it? I really would have loved to start resetting right
away, but if the list were not sorted and traversed at the same time as
the tree-ish, the performance would just be suboptimal.

I think that is an important point and I adjusted the commit message
accordingly.

> > +		parse_pathspec(&pathspec, 0, flags, prefix,
> > +			       (const char **)stdin_paths);
> 
> ...letting them be used as if they are pathspec is wrong when
> stdin_paths[] contain wildcard, isn't it?  
> 
> I think flags |= PATHSPEC_LITERAL_PATH can help fixing it.  0/2 said
> this mimicks checkout-index and I think it should by not treating
> the input as wildcarded patterns (i.e. "echo '*.c' | reset --stdin"
> shouldn't be the way to reset all .c files --- that's something we
> would want to add to the test, I guess).

True. I adjust the flags accordingly now.

Thanks,
Dscho
