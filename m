Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F211F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbeB1TTj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:19:39 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:38603 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933272AbeB1TTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:19:35 -0500
Received: by mail-pl0-f52.google.com with SMTP id d4-v6so2105114pll.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=or+t7b0M0mgS+8DcZFIk7/EcHho9tyZIXk6cBi48Okk=;
        b=HzjS5ny18P+8i+RNiJx6gX4Kqt/VRzd8pcN8YnDir3FGHQXAAC0VBpQMXbH/DAAWNr
         tR8eUfmYTiDuQtT9hsd/kB4u41hzvUqV8Cuu+0eMcZabWnoUCuRRsp7+4WMCf48mhnAe
         EYFWie3sE13G9uRfa7qh7wai42gDo0FpwW60nWaiZScZWEp77ZDYyu3ETtoUs+c34VS/
         8giiDUxHcUIA431uBhaAJA0F340o7RHhJ8YzUDeBKdKdk/jgurh1ZsV2LZUOpeVXI9wr
         1vtGkjMH5xzHj6ydKO/MAp9eCM7F0WyQ91BDIfV9eeXoJsLi3lShiykHkI4lNfFAQbtv
         Cv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=or+t7b0M0mgS+8DcZFIk7/EcHho9tyZIXk6cBi48Okk=;
        b=R4sIG+fyg58oPemJlxEEy3WRPD46tJkxTaVMB8W1PsswibVxduWYe0RT6h441I6H7d
         GDT/s8o+Njo2dZV7dZu2KFpB0VeoxetaERt2b16Upc1uU8Ns+4eYkLNxLQX6+OGxW9Kx
         dt5R94wIFX2VfnoZV8+WMmUdifhPXDn+Bn86FnNnBE9aw/aYxYOircD8Bl1nKIw8E57B
         6NitK0urRE9id8QjH7y6MT59UVzeB6HOuROq/9H1baD3GQsJtJhUAgT957pn4N6oJ2yj
         ZVxtI5lXxM+fmj2k4z/uoAZDr5Cjosb+s2zOQbxlYhKvT2QL/DHl+jW0Zf7h4Qua5TB0
         qKtQ==
X-Gm-Message-State: APf1xPBcmG9IHOXaqwRFzbW8cGOQ3Xe3xlwY+zWyaWwPZTez4xVOKKeB
        itg3LDgzADdf8A5sOpBx1YU=
X-Google-Smtp-Source: AH8x225IEDCPmWWj860KZQZWKUD9OB4kYyOiOc7QrKzjSaCsGJTeQIQHvTgSbdn4kmLs6VVf2aQauw==
X-Received: by 2002:a17:902:694c:: with SMTP id k12-v6mr18746700plt.133.1519845574487;
        Wed, 28 Feb 2018 11:19:34 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b88sm5077512pfd.108.2018.02.28.11.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 11:19:33 -0800 (PST)
Date:   Wed, 28 Feb 2018 11:19:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] Moving global state into the repository object
 (part 2)
Message-ID: <20180228191931.GF251290@aiede.svl.corp.google.com>
References: <20180228010608.215505-1-sbeller@google.com>
 <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kaDVrn6Qw_xsdyBST6XfJMXs43qDWx8jY2J9VsXwDKm5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaDVrn6Qw_xsdyBST6XfJMXs43qDWx8jY2J9VsXwDKm5Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Wed, Feb 28, 2018 at 9:57 AM, Junio C Hamano <gitster@pobox.com> wrote:

>> Wait a minute.  Is that topic ever shown to work well together with
>> other topics in flight and are now ready to be built upon?  I had an
>> impression that it is just starting to get serious reviews.
>
> And I had the impression the serious reviews were done and fine;
> the only issue would be demonstrating its working fine with other
> series, where I was also worrying about conflicts with
> brians series. And to address that, I'd just send series in small sizes.

Some of the patches looked cooked to me and others still do not look
cooked yet.  I marked the former with Reviewed-by.  In general, a few
things can help to make the process easier for me:

 1. Giving a quick reply to a review to say how the comments were
    resolved, sometimes even with a resend of that one patch to
    illustrate.  That way the conversation can continue and the
    individual patch can get to a reviewed state faster, without
    having to chase between different rerolls of the entire series.

    This also has an effect of making the review process more
    collaborative: perhaps after seeing how you address their
    comments, a reviewer may have another idea that they suggest via a
    patch to squash in, etc.

 2. In a reroll, summarizing the result of previous reviews by
    including acks as appropriate and Reviewed-by if a reviewer
    granted it.  This helps with reviewing the reroll since it tells
    people where to focus their attention.

[...]
> Is there anything that a contributor can help with that eases
> refactoring series in flight?

For helping reviewers, see above.

For helping Junio, what I've seen people occasionally do is to locally
run a "trial merge" against next and pu and see what semantic or
lexical conflicts arise.  In the cover letter you can describe these
and give Junio advice to make applying the patch easier for him.

[...]
> Sorry for the miscommunication, though,

FWIW, even though part 1 doesn't look done to me yet, it looks *close*
to done, and I was happy to see the sneak peek at part 2.

Thanks,
Jonathan
