Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07071F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 06:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbcICG5z (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 02:57:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:64135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbcICG5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 02:57:55 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MCOdh-1bp7Ry2V73-0095h8; Sat, 03 Sep 2016 08:57:31
 +0200
Date:   Sat, 3 Sep 2016 08:57:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kevin Daudt <me@ikke.info>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/34] sequencer: support a new action: 'interactive
 rebase'
In-Reply-To: <20160902211332.GA28305@ikke.info>
Message-ID: <alpine.DEB.2.20.1609030845490.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <5ffec2e588a4edc4902e1ab3a2ec3a73a7c3625b.1472633606.git.johannes.schindelin@gmx.de> <20160902211332.GA28305@ikke.info>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bo8ol9TQ+dflaYQZ+YZw6a1PW7r3S+jsqJM6agc7RV8Z/awxSd4
 DBxCcD/eDiLzRtIUKq2nPbSKh4j1Cg9iLW/wcXz4niRMkk5v4CcFVNY34v3g/gf+6stvDCo
 AGJj73s5LQ5yF7MhAg1t06dAaPR7iSxGugTJHkmA/tlcwqQKZJJ7divGK/TUrdidSLolU+U
 1cRHDvv3THep1EZbH7G6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3FMLxyEfD/Q=:jDBB7maf9vHbiKa/piMtRu
 0iWdQUSxaWULp7tyLdCeVSE3SulV4qxDwDZtwa+T/ZkC/RcCruXBMtnuJlJcQZ6XukLg+Im1b
 puiN8fccAOmGR1ERa0GjULWoAAWJfEfhF2kh303r3UYfL4ar8uQc5hchxssCfU2SOCmksQloF
 TfQgyd7wzOrC0iPCzyFWh+aofFhw0L0LHLGZDunOBy56vqxN/pgjIa5GC7DOHQ9dm7e384ZFA
 M6+LMDy/CLhIeRiLbI6qVQagGBvleQX9UAuBVveuBjrpFUGZEB2/MgCulgwHglUK/98wGySzL
 zYXDE57sK5NBHIccIZNAwB9DxtBuQwgD/re4yp3zTLWTuH6vZru1PXlhFz0vC9KtfKDcQl3ky
 17rO9oWwsd2+n+88iXkS3eFEddgfe2hDR7PfzeLet3b+dGL6ellhMNkLuFWp5u4R8ncMN2asW
 dFNaavOfP6qE/8l/K1QWsnT0iEdAwSTNehl1iRpetTSklkTsnxMR8ILC2x4lGcQxDnmvbzsdT
 7/aGdacBRJLvLqrtW5SeX6IUOpTZa5yZlnxcO3+avQIMtyFiDmQlS+PUP8Tlxb+roCZYI7Zq1
 aQzleo7WuM1hOrexLUfhwxIAdiTTWotBVqhaCWLzKR7BS/QzFJEvs0d2S5NVZvYvgegvI79xp
 SmidS5nNXI5iZ2mejeKA3Q1qJWLeE3KfCrSwuNBfb0bm+9sOA98XxRRZ2PtFRDzSXbzvRjaLr
 FaS3S1/yEjO6RxU7oY4AH0G/Ze75JiRXksPGzU4kXK2DvpymKCs+14iHEzbbmAAtL+vvlXtP1
 HFXUpfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On Fri, 2 Sep 2016, Kevin Daudt wrote:

> On Wed, Aug 31, 2016 at 10:54:02AM +0200, Johannes Schindelin wrote:
> > @@ -43,16 +51,20 @@ static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
> >  /* We will introduce the 'interactive rebase' mode later */
> >  static inline int is_rebase_i(const struct replay_opts *opts)
> >  {
> > -	return 0;
> > +	return opts->action == REPLAY_INTERACTIVE_REBASE;
> >  }
> >  
> >  static const char *get_dir(const struct replay_opts *opts)
> >  {
> > +	if (is_rebase_i(opts))
> > +		return rebase_path();
> >  	return git_path_seq_dir();
> >  }
> >  
> >  static const char *get_todo_path(const struct replay_opts *opts)
> >  {
> > +	if (is_rebase_i(opts))
> > +		return rebase_path_todo();
> >  	return git_path_todo_file();
> >  }
> 
> This patch fails to apply for me because function is_rebase_i has never
> been introduced before (no record of it anywhere). Currently, only
> IS_REBASE_I macro is present.

I did not send out a new iteration of the prepare-sequencer patch series
(mostly because I wanted reviewers to look at the later patch series,
rather than re-review a 2nd iteration of something they already saw).

But I did address the concerns mentioned in the review already, of course,
because part of the reason to show those patch series was to get valuable
feedback before including the work in Git for Windows v2.10.0.

You can find the current iteration of the prepare-sequencer here:
https://github.com/dscho/git/compare/libify-sequencer...prepare-sequencer

Please note that I will most likely try to address some l10n concerns
before sending out the next iteration of the patch series.

The patch introducing is_rebase_i() (and no longer IS_REBASE_I()) is:
https://github.com/dscho/git/commit/76d272020bb72618957308f06083c807efe59aca

If you want to have the latest iteration of the entire patch thicket, just
`git fetch https://github.com/dscho/git interactive-rebase`. I update that
more frequently than I send out updates via mail.

Ciao,
Johannes
