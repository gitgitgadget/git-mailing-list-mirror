Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D313209FD
	for <e@80x24.org>; Fri, 26 May 2017 01:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946500AbdEZBUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 21:20:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32838 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946470AbdEZBUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 21:20:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so42477403pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2JqtrzdvMy4de8EhQRAThbnrJ0HhGe1khZO2/Yt2Gv8=;
        b=SUiT2PC6WS+Wu6/TcBwJcNo29Zr9AI2kSrbawK46/At5RWZZjBwRGHtWGrxjkVvPgu
         SMS9ZFpQIhK7eJAJvc62d4N0OP9+ICXShsxkQUb3hLs4LKLwHX6+uuqKoe/68eeLAuEn
         7PqcVVoViL6ocmDoRbxory7hJJKlj11UsS5uNMaS3b6hHzEohQ0p5o0ckWYgKBvnY5xI
         9IPmQbvwR+rBEiviUlayxmJoFR86ONdpCrfOc9pWiAdiXlqibaray+0AcMKkq1P473fH
         TT4FtMi1QFACictfY6d/VS9ZsOpiRZMlOqOcJ4+fO3oYZYtaeaaeU1aaambG2Wz5OxDA
         h7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2JqtrzdvMy4de8EhQRAThbnrJ0HhGe1khZO2/Yt2Gv8=;
        b=o3f9l4Ik85gIkpOytwKcYUZPxJfKJIwXx9fNqTwTg1DsQn3z/greNCUZf2JwYOOMLn
         A/aToKvS9DrSugjuIyFAqRvIopVI3CKPV9SivTTW7ZlmrFRlNhvgoNQuPyoc7jYkaaAt
         uLox9ZV2QKH5OuVUrLYYvhzGtluxlUihAEeEGfLXkYnze00FvsbDLQrAwOWrNnx2fgmL
         1Nz51AuyLde4hcwhTr6ghwDdYmNITDPj3QbwQ+aS9T04FQQCO90MixN6P2+nw3y/utmj
         MpSXlsEsmaeI3BbAkO6ckuyaIsOkzk4WLqjQktSYRKC8hC8n2dF8Oeo6MIi5AY82sYRN
         xRRg==
X-Gm-Message-State: AODbwcCHiaxzieWqPgSYdqFyakGa/n4jwqoBLJu28yA3KiPHxzOH7Zim
        Wso24pYsgUauHA==
X-Received: by 10.98.224.1 with SMTP id f1mr48546846pfh.116.1495761633814;
        Thu, 25 May 2017 18:20:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id l63sm14474538pfb.68.2017.05.25.18.20.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 18:20:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv5 00/17] Diff machine: highlight moved lines.
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <xmqq7f15e8pu.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYO8DoTDCXCk1uSFSAJA5JusD-t4BZoQfGy5n9DF34EvA@mail.gmail.com>
Date:   Fri, 26 May 2017 10:20:32 +0900
In-Reply-To: <CAGZ79kYO8DoTDCXCk1uSFSAJA5JusD-t4BZoQfGy5n9DF34EvA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 May 2017 09:31:27 -0700")
Message-ID: <xmqq8tlkct27.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As you turn on/off normal coloring via "color.diff" and this only extends
> the coloring scheme, I have the impression "color" is the right section.
> Maybe color.diffStyle=[normal/enhanced] and "enhanced" means this
> feature for now?

Hmph, I thought the intent of color.diff is "is the diff command
itself is colored?"  In other words, color.diff=false should give
you monochrome if you say "diff --word-diff", etc.

> The only option in the "diff" section related to color is diff.wsErrorHighlight
> which has a very similar purpose, so "diff.colorMoved" would fit in that
> scheme.

I didn't have "should diff output highlight whitespace errors?" in
mind when I wrote the message you are responding to, but yes, that
is quite similar to "should diff output show lines moved and lines
deleted/added differently?".

> So with these questions, I wonder if we want to color moved lines
> as "color.diff.context" (i.e. plain white text in the normal coloring scheme)
> This would serve the intended purpose of
> dimming the attention to moved lines.

Yes, but two points.

 (1) We want to do so while making it obvious where the boundary
     between two moved blocks of text whose destination (for
     moved-deleted lines) or source (for moved-added lines) is.

 (2) My message was an impression from using the code to review a
     patch that is meant to be "move without changing other things".
     For other purposes, there may be cases where moved ones may
     want to be highlighted, not dimmed.

> Regarding the last point of marking up adjacent blocks (which would
> indicate that there is a coherency issue or just moving from different
> places), we could highlight the last line of the previous block
> and first line of the next block in their "normal" colors (i.e.
> color.diff.old and color.diff.new).

Hmm.  That is an interesting thought.
