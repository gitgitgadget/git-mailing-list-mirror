Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F20C1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbcLGWjk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:39:40 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36411 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbcLGWjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:39:39 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so166017731pgc.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NlFoaL87whO+9enI5XAwkRexcf0jR0u/VDm20gYd7So=;
        b=oVar2ConOu2f8ExxvLRlqv9+8/qXuT419BlWi2Lje0SLmixeE9ll/k9ATGXUtSYBfH
         9B//YeOH7jUtW2LTmPlIS83DZmxjSuSsYuaZzgMKi2u+aMeAf+HRUv6gw7wtMvef5IXI
         GdIt/ZMsQ3/0XohgxEAcBKQl3pyWmZYRV6VIbrPnAsg7PDTWpcMk0KdLmHmLsV/cu7PJ
         +6HYnpocq9iYbSEYvuCK5GNgGS2FHp5hodw9k7dmvq0bOiyW5/YGN6xzl933U1uK/RNC
         CpY+HO1ljMw8dXpu+yyqB9nQ+fJW7WYvp7JNLreYTA49TpfaP/rzFI3ONtAR8DlD0T3G
         qNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NlFoaL87whO+9enI5XAwkRexcf0jR0u/VDm20gYd7So=;
        b=L9UT1sycyOL9l/RAwUy6X5FtdsL43/uod/+6LDo9PW317TtIYyqwcpPM4B1Y+5JfiZ
         0IQp4DeMPchkOlURu2r3kUNkW1VpQ4pLt/8uKPKPWXxSNlZS7E8P4g2+SkzL/FjaXftm
         /Q/lG4/LW9q7hVqfzwfkwX+H/HZ8R5C9R/u9LHsnKBx4OuSbeeR3+yzucERTLfCDdW0s
         5aukkPbesXBcZjc8cGQrA96LmrPPiOXqGSYEIorH+CIMGyoyT8a8wgP8PbqlpuEe9gav
         doBvVKoC0MxLxdvK4avCqSBYBKF7unxNQGN3NvT60UlTVyL82fBreG/phuprP72QnZ7J
         jChw==
X-Gm-Message-State: AKaTC03g/qlHFqKS7utNj42dh9AgOK74y9gLmtVvSiU6xa8OEnnzK8nlaVT7W2wGHiI3ZxdZ
X-Received: by 10.98.36.195 with SMTP id k64mr70565074pfk.126.1481150378476;
        Wed, 07 Dec 2016 14:39:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id y73sm44870729pfa.68.2016.12.07.14.39.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:39:37 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:39:36 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/17] pathspec: factor global magic into its own function
Message-ID: <20161207223936.GD116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-12-git-send-email-bmwill@google.com>
 <CACsJy8D9SAOYtzPTuGnst3J7qCUjMuGMrZ=KNH0MLSxMrq4krw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D9SAOYtzPTuGnst3J7qCUjMuGMrZ=KNH0MLSxMrq4krw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > Create helper functions to read the global magic environment variables
> > in additon to factoring out the global magic gathering logic into its
> > own function.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  pathspec.c | 120 +++++++++++++++++++++++++++++++++++++------------------------
> >  1 file changed, 74 insertions(+), 46 deletions(-)
> >
> > diff --git a/pathspec.c b/pathspec.c
> > index 5afebd3..08e76f6 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -87,6 +87,74 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
> >         strbuf_addf(sb, ",prefix:%d)", prefixlen);
> >  }
> >
> > +static inline int get_literal_global(void)
> > +{
> > +       static int literal_global = -1;
> > +
> > +       if (literal_global < 0)
> > +               literal_global = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT,
> > +                                             0);
> 
> These zeros look so lonely. I know it would exceed 80 columns if we
> put it on the previous line. But I think it's ok for occasional
> exceptions. Or you could rename noglob_global to noglob.

I was thinking the same thing but was so torn between the char limit.  I
think it's probably ok to rename these vars by drooping the global since
the function name themselves indicate they are global.
-- 
Brandon Williams
