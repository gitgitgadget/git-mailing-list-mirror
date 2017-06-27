Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC0820401
	for <e@80x24.org>; Tue, 27 Jun 2017 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdF0OxI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 10:53:08 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36716 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdF0OxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 10:53:04 -0400
Received: by mail-qk0-f179.google.com with SMTP id p21so27075649qke.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MUzxzfTSOPcOfF29hBvAoSSQ7zgMhHFBBsW3EUCQTvs=;
        b=aeUqlw87GE58vuOh3ap0jcz9X+gYne8cT7ahifa6t9dKdKyfuY64MId6JEnXf23HlQ
         eYOG+d4L4A89MzJolEYoFmfSDPRLsuBH2VZONRQ7uhRD0IHU7Jw4Fznxd5YrkrjVZ8sC
         2gK9hE8g/B1+eeM8Uuy0wxmymdfll5X8gHRkoSlQlOlcfSvsmziM/IdWdIk9d2o3oNld
         cGWJXURsqxhwhFvT7WkiJVUMsW5hi4lblDNPxbuGA0PIHPueT5v4QrRzG/syZiU7/wuo
         vNyAoCpHrLdtIAdJCU/AldsoqMQ2FFgiHvlnIW1JHIh1Xy09b0Vsl68CDmz2F+LqLpsD
         /W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MUzxzfTSOPcOfF29hBvAoSSQ7zgMhHFBBsW3EUCQTvs=;
        b=NIV6NRqwE+V56Lq5iXocQeJbAC0kQY/ON5QxaFc1x46m3csSAbPSKWb/JnSInjSUtH
         pHZiRIFDnzWEoRsKtQ8ui+CR4bZB1nUKmXAMIETz4bNh3FyZBfZQ8s0fclBLXd/Z7uZR
         5MPUfT0fT9RTtyOghoAsiVtdj+zLOe3OVXORg0UKmaQfJzPzvUGHpk061DqdoWBWu9pk
         l9AyeTAtWT6osI0z/XEFLncT6t/0EeRWj2nkYlBYurmQW+gZRkg2hPyVroolsKVIV3NG
         W1xa1+DnJvTiM1TvKNeDomUXGmY5xMiEa5TCV0OhO4i6ONGrvAapTLG51E7xGhize4SB
         Ih2w==
X-Gm-Message-State: AKS2vOwnstR+rjvTX3Jq9rmTbfcetD5THhStHlzqvasxCPhlS0fFLydH
        djhEhHSpHrbDPywr/vsig2EbYdmZyQ==
X-Received: by 10.55.106.7 with SMTP id f7mr6990002qkc.189.1498575182369; Tue,
 27 Jun 2017 07:53:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.35.253 with HTTP; Tue, 27 Jun 2017 07:53:01 -0700 (PDT)
In-Reply-To: <vpqshini3r6.fsf@anie.imag.fr>
References: <20170608005535.13080-1-joel@teichroeb.net> <20170608005535.13080-6-joel@teichroeb.net>
 <20170611212739.GA7737@hank> <CA+CzEk9i8H2BAUrL854WJELCTa-O1ONMWa0uOcTsW=WxnB_22Q@mail.gmail.com>
 <20170625210909.GB7737@hank> <vpqshini3r6.fsf@anie.imag.fr>
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Tue, 27 Jun 2017 15:53:01 +0100
Message-ID: <CALgYhfPQXNZYv758+8ZB32aFLpNXNerfOeYt0QLHDWFZ-FQwDA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2017 at 8:53 AM Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > After the line
> >
> > test -n "$seen_non_option" || set "push" "$@"
> >
> > it's not possible that $# is 0 anymore, so this will never be
> > printed.  From a quick look at the history it seems like it wasn't
> > possible to trigger that codepath for a while.  If I'm reading things
> > correctly 3c2eb80fe3 ("stash: simplify defaulting to "save" and reject
> > unknown options", 2009-08-18) seems to have introduced the small
> > change in behaviour.
>
> Indeed. That wasn't on purpose, but I seem to have turned this
>
>         case $# in
>         0)
>                 push_stash &&
>                 say "$(gettext "(To restore them type \"git stash apply\")")"
>                 ;;
>
> into dead code.
>
> > As I don't think anyone has complained since then, I'd just leave it
> > as is, which makes git stash with no options a little less verbose.
>
> I agree it's OK to keep is as-is, but the original logic (give a bit
> more advice when "stash push" was DWIM-ed) made sense too, so it can
> make sense to re-activate it while porting to C.

I'd be happy either way.  If we decide to restore the original behaviour, I
think it should be done in a separate patch, as the test case will need
some adjustments.  That way we can keep this patch purely as the
conversion step, which makes it a bit easier to review.

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
