Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBBA1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbcHaIHy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:07:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:51911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752600AbcHaIHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:07:51 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MKIEQ-1bdMfP2fUk-001iwV; Wed, 31 Aug 2016 10:07:45
 +0200
Date:   Wed, 31 Aug 2016 10:07:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when
 reading options
In-Reply-To: <xmqqfupm3ya1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608311005210.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de> <xmqqfupm3ya1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kGstRT55nMewoPlYKaIx1k4p9dGxM2ZX8eS4lldb+PpFuXqei6B
 MST4JjXr2G6FO3q0xcNUDpu0TYHoKXloGKd5AI1BDFTfluJ8CJWWnAVfQgN1GEOPHLKHqlO
 +tQxgXv850raGy9xDPYXYO3Mci7lr649Q/apa5jfAp1vhbZTjDm+q6za9Ys1hM9lZSRuM5b
 dCFSLrWKRSeSTn0piPm4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NibUJel3ssg=:U0b0Go2s9XTnRuekS6Nzee
 1lsFgnYg+sTgL+JPliV+zO8lk1nZhIX81YoQav1CEuGTyJOpoJZ+var2zGQiWeWGoPCr/Wkb+
 qIdMi3cVrasjQfOvs3sbf2brQqkUc/dIvn/IH2JcpagTzh5n4eYCHC3k7TMDYQRO6QzFMze4n
 KsnlBt+OAqlAWLICz3PQChmx/RuaDpCa73M4/VW1Yn77TBCa23rmZjjQDPsGjQ9XD2uiWF9GF
 TSU5oWlW0pthu77jj7gNT/fAhaEa0AB6vMwbo79TI40pKSZ/dY8FLiLRitprCT1oiN+afJaBS
 kxn+IIR/8ow0o1d6ITMa46S+HxJBD0mHKJNHmFXkw9a3V/U0sUOMsNVnEoZCnZDTYF0qfd1Xn
 3QRui+Ya8WpxAVrlloSm5Cn5Z4t+AcwNyBYCigeZuhtAHQsP86s/ctKbxypSPOju8awFmyRiZ
 uPm6uoKL5EWA8otaMKgXydahdfuk4HBqnFeUdfCWyzE18bubBzF76oDwXPIqJpZolcuwxWRIy
 d4bGccrtOUuJc3H2e6QKQyty9KaExafgfCdqtVGMVNGpHAewBEThKwbBvnORnievxGj3KiWrJ
 HgIGnQ3BgSx18I3iSpeUZRUcTyKwCgRujgZCK1c9Yryo30cLVzMkupAspM7bLdDVIvltjsNiC
 Zo7VxNCRK1SSWNhh7G8PCmUOZzlzcuJSmTYCAjXFuisLJh34wQUCm71FpauT2ziqaF9lgZSrR
 hYF8IYgqVuTFnm5altCC4ECaWX8+zaog2t/3nDvg+ldD1c3rkM7J+B5WZus9lBjj0RwaSFZv/
 RZt598J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -811,13 +813,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
> >  		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
> >  	else if (!strcmp(key, "options.mainline"))
> >  		opts->mainline = git_config_int(key, value);
> > -	else if (!strcmp(key, "options.strategy"))
> > +	else if (!strcmp(key, "options.strategy")) {
> >  		git_config_string(&opts->strategy, key, value);
> > -	else if (!strcmp(key, "options.gpg-sign"))
> > +		sequencer_entrust(opts, (char *) opts->strategy);
> > +	}
> > +	else if (!strcmp(key, "options.gpg-sign")) {
> >  		git_config_string(&opts->gpg_sign, key, value);
> > +		sequencer_entrust(opts, (char *) opts->gpg_sign);
> > +	}
> >  	else if (!strcmp(key, "options.strategy-option")) {
> >  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
> > -		opts->xopts[opts->xopts_nr++] = xstrdup(value);
> > +		opts->xopts[opts->xopts_nr++] =
> > +			sequencer_entrust(opts, xstrdup(value));
> >  	} else
> >  		return error(_("Invalid key: %s"), key);
> 
> Hmm.
> 
> I would have expected a call to sequencer_opts_clear(&opts) once the
> machinery is done with the options structure,

It is part of sequencer_remove_state().

> and among these places where an old value in opts->field is overwritten
> by a new one would get
> 
> 	free(opt->field); opt->field = ... new value ...;

That is *exactly* what we *cannot* do.

You see, the replay_opts struct is *not necessarily* populated by
read_populate_opts(). So we really cannot tell whether we are free to
free(opt->field) or whether some other code still wants to reference that
memory in the end (or for that matter, whether it was malloc()ed).

That is the *precise* reason for the existence of sequencer_entrust().

Ciao,
Dscho
