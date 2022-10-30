Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4DC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ3SmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3SmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:42:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C00B9FFF
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:42:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e15so8337549iof.2
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mE03mHvGJd5wlG6NbZNfZ0TXW7IkyAWQ7f86EYlcNgU=;
        b=7ziH9ZdEkj7Bck03FDa7alB2le5hQEI5/4y7dM707t164XnTioZVAyDAVpjwQjZvP+
         wyg5SIqUTQITyFLBVEJuNUQsKu2X3iH7Jfm2sTV0K/qgDB8B9yPvtsNS9OqMhICo1CyL
         rx8+1f0nDlH4mZ6V+DI3YLft3s9TMgenySLrWMD8jPe99++lKPMWI7ot1/HBg1Ryc/i3
         4fwj7iukxSGZEZtW64JqTOZDED8Ghlm40kZF9Vyzu+jGCda14JwEW0QyAJK0fkJLopVC
         J09bkfFlSPeY2jEbIt1lgthg5n3MvzCSCJMMQqMeaX1TrguBtEn7gK/OwMT0+kY296W+
         ooCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE03mHvGJd5wlG6NbZNfZ0TXW7IkyAWQ7f86EYlcNgU=;
        b=Nfn5VI8nkVhRzNqn3z2KrBnyLkdQTJG/L+T4mS7HXLwCQkQnwsfuSJ/tpKDVOrLJcl
         Oyfu8CkCya8Z+8gCigJ05nJlJmhrEV8ynapM0diyH9yvHgoWCh5sU/C8op3YswLm/++z
         +sQkBVRA7XqqiDuuzsWtebys4ukWYYDrvjaUTvr1pI476iin6Fxsf7jAtcu8rr//2n8u
         ciz4kCDnGd90zAemEkFyEuK3Jc8TEKEiwcnZEftmNFCFr6Lg+olYtKYXbESqUb5lrW9B
         rU24ZByyc5DpEWyetZ8MBtBEoCY82CNsqENTPVodPPR7aw/cO0gFpMH8apzjRueTKTmN
         nnkQ==
X-Gm-Message-State: ACrzQf3X5RPUpdGw0lWqE0wIMoEytOIhN/XW6Ac9jPrat0jaCc7JLlv9
        Dl2ETHUOnORgSCRAn6qxsyOCSQ==
X-Google-Smtp-Source: AMsMyM5BhsFwrG2FzBa6/OciJdO0Ffk4G/09J38+pplVqTdxUVoNqwDwnheChtnmY9MnOSFYd41wzg==
X-Received: by 2002:a05:6602:2c02:b0:690:b560:7fae with SMTP id w2-20020a0566022c0200b00690b5607faemr4837092iov.169.1667155329923;
        Sun, 30 Oct 2022 11:42:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e6-20020a921e06000000b003002d1ba94esm1779485ile.42.2022.10.30.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:42:09 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:42:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>, Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, avarab@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y17FeGeWqEE7CWQS@nand.local>
References: <xmqqtu5zyndk.fsf@gitster.g>
 <20220829024803.47496-1-tenglong.tl@alibaba-inc.com>
 <Y1mp23NHB0qzKsPR@nand.local>
 <Y1rt+uOKwlP5PIrT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1rt+uOKwlP5PIrT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 04:45:46PM -0400, Jeff King wrote:
> On Wed, Oct 26, 2022 at 05:42:51PM -0400, Taylor Blau wrote:
>
> > At GitHub, we actually *do* remove this warning entirely:
> >
> > --- >8 ---
> >
> > From: Jeff King <peff@peff.net>
> > Subject: [PATCH] pack-bitmap: drop "ignoring extra bitmap" warning
>
> A blast from the past. You didn't include the Date field, but this was
> from ~2017.

I'll blame you for that one, since this output comes from your
'git print-patch's script, which only prints out the From: and Subject:
headers. ;-)

> > For the general case of what ships in git.git, I *do* find this warning
> > useful. It's helpful when hacking on pack-bitmap.c to know if you've
> > messed up, and it's useful to see the filename of the affected
> > bitmap(s).
>
> It feels like you might be a special case, though. Most people are not
> hacking on the bitmap code. :)
>
> I wonder if you'd be better served by having good tracing for the bitmap
> code. Then it could tell you lots of things, like which bitmap it
> actually opened, which ones it ignored, etc. Of course you'd have to
> remember to enable that tracing when you're working in the area.

Yeah, I wouldn't be sad to see this get moved to the trace2 mechanism.
In fact, I almost prefer that approach, since server operators and
developers can still debug the bitmap machinery, but end-users of forges
like GitHub won't see the output.

Maybe that is the best approach forward. Teng Long: does that sound OK
to you?

> So it may not be worth worrying about. It does seem like it would be
> easy to reorder open_pack_bitmap_1() to look for a bitmap file first and
> only open the idx if it finds something.

Yeah, I had always thought that it was odd that we had to go through all
of the repository's possible bitmaps and try to open them one by one. It
might be interesting to have a file that lists the path of _the_
bitmap, which we consult first and then try and open that pack or MIDX
bitmap. But I dunno.

> > I think we could reasonably change the warning to
> >
> >     warning(_("ignoring extra bitmap file: %s"),
> >             basename(packfile->pack_name));
> >
> > since the rest of the path is obvious based on which repository you're
> > working in. So that would be a reasonable change to shorten up the
> > output a little bit.
>
> Yeah. If we are going to keep the warning, this makes much better sense.
> Possibly we could even just skip_prefix() on the object directory,
> though I think in practice it amounts to the same thing.

I agree, they end up the same in either approach you take.

Thanks,
Taylor
