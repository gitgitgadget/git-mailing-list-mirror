Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5664820987
	for <e@80x24.org>; Fri,  7 Oct 2016 12:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbcJGM20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 08:28:26 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38838 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbcJGM2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 08:28:24 -0400
Received: by mail-it0-f54.google.com with SMTP id o19so14677431ito.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hCeVvDfBUtfnElXMKJk8B8qS2OROTctZg8A8U8r0Ya8=;
        b=fgez0ppUMnawCKtR1Wg90/s/bwueVnHo0q/F5TMxNChsq0SQEdGn3HK872c6kzll/6
         wIGPik4A06/9td9jTXPvyOgUnoc0IRaGGNshLf/B6gd9Ti7yqdt5vwOECMxfKmCHAMO2
         tA6EFJhNskhI3sglfuJ2OC1p2MnALxWOc7AtTZXmz72zNgJwJixvDzJ354uUhkm4aNiH
         YRjcjmzijaeZoF58FViU9k0lNmWy4uo046i2rSy4KpP54H+merclLcdODaWK2JDhaCST
         o64nNizuGScrZU6uBFLC3eelYUSxYmk9+EY2PV87tVYBIJtqIH2N+nbQuc3YE3TH9HOn
         bMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hCeVvDfBUtfnElXMKJk8B8qS2OROTctZg8A8U8r0Ya8=;
        b=kX2n6Amgq/E4AOtvzh8P+ZSXvh+qj5DwvDbq0RUvYKQ/rbFKjttAXEshlaCW5qZdUC
         LQpzsTe4OwdUAy4gwml678ysZdzZg8gRSqDzU3SUT5CnP8EWUS96If+2gKZF9SGQp4PA
         0waMQxsfKn1l+lSTG+Y/dLQOzaJJjoU+PpmwzwrifZsZlz3uT4ii+eAxVLxSjgwoimaI
         miyNEYEW0Bmga3zO9ipFIZ2+1T77LCMXpT1QSp+f3nIyEeNyAzhZlr9USUcWwRwhRKXX
         Ki5I+PNB5EJyLviCjL1Nisj+Es3v2LFrMdWTmwClIxLUDqNZ35NWaxvIcy2+cvyJIjsN
         f8Gg==
X-Gm-Message-State: AA6/9Rk5P3KjGvQqPh9xPuaH91OaCm2U8A5GHrxFqDosskka/RDN387g2KZavyNWB+Mz7B/k451l69hl2KlM6Q==
X-Received: by 10.36.36.214 with SMTP id f205mr38912173ita.50.1475843303744;
 Fri, 07 Oct 2016 05:28:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Fri, 7 Oct 2016 05:27:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610071319520.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Oct 2016 19:27:53 +0700
Message-ID: <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 6:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Thu, 6 Oct 2016, Junio C Hamano wrote:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>> > Throwing something at the mailing list to see if anybody is
>> > interested.
>> >
>> > Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
>> > handling path arguments hard because they are relative to the original
>> > cwd. We set GIT_PREFIX to work around it, but I still think it's more
>> > natural to keep cwd where it is.
>> >
>> > We have a way to do that now after 441981b (git: simplify environment
>> > save/restore logic - 2016-01-26). It's just a matter of choosing the
>> > right syntax. I'm going with '!!'. I'm not very happy with it. But I
>> > do like this type of alias.
>>
>> I do not know why you are not happy with the syntax, but I
>> personally think it brilliant, both the idea and the preliminary
>> clean-up that made this possible with a simple patch like this.
>
> I guess he is not happy with it because "!!" is quite unintuitive a
> construct. I know that *I* would have been puzzled by it, asking "What th=
e
> heck does this do?".

Yep. And I wouldn't want to set a tradition for the next alias type
'!!!'. There's no good choice to represent a new alias type with a
leading symbol. This just occurred to me, however, what do you think
about a new config group for it? With can have something like
externalAlias.* (or some other name) that lives in parallel with
alias.*. Then we don't need '!' (or '!!') at all.
--=20
Duy
