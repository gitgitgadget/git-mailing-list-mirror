Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FA81F461
	for <e@80x24.org>; Thu, 29 Aug 2019 17:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfH2R7P (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:59:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51432 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfH2R7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 13:59:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so4646852wmi.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2lLy5BP+GvXAfl/88vTxM4/EGHTW7ozGFhPKCapkigU=;
        b=pullW6xN5Q9okRTSxVgJnzWF9XgqELfwekWnO3CZAl89a7G6Zh2Xsc3rZ9JongkHFs
         myGty4nZBih20zwFmWI5YC5sKjFAC1eLQ4yUxSnX7jk+r+NdgmAS6jKvZyDoY3LoR/3w
         At/335F/W7Cd/j7XWFIAzA/rbMWV626/cwLag+FUouoa38BdM00bcFb+Gsyw+QL/rxrf
         gYNPmMQqX+y66v3tLbEITD73Em5tiKlANG7EqY8nDVL5v+jg9/cKBrPjQixGHH99CjYl
         Rd5YxWdRvldLb/5c/hVmsy9ugurSv7JEysOTpOrRLHwxiy6/eCjYpgoDt8eYF6kmzoUl
         yiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2lLy5BP+GvXAfl/88vTxM4/EGHTW7ozGFhPKCapkigU=;
        b=UCpM9qPOX6oAJ1LgduDx8EXtKwBcFsnTNf54e1ALXcI6yYRu+xS/43jcaUQOcrMWDt
         H+X1AVvAdVOO7R8+s6E46EOPxbyFXqY9298URW33mBvkKNZMyl886rSvAweRThQ6Ivs8
         y+f9F/TQRKhaGQsbbCZOGW7WVPo1iQcKUKch+8CKxHdcM+CC04S7U65P/JSFTra5JUBc
         K/b0uGL6hYhSzOhGPoLnOx25AORymO/gpgajbshO9/sOZfN/quavJtAFjAnp8Kzmtg+C
         65pAaA4tznIyQrO7ekhEEYkt45vEe4MT6pyshWGCmpQGV9oO+4iCbq1NpBTTtlZtt5p6
         bUyw==
X-Gm-Message-State: APjAAAVTWs23bPL/CjOD9/edLYkN0UCPf60YeJ9BWvsgR5AtB05Y3DOA
        kTCMvl/tW2D637wHkBRkwJ8=
X-Google-Smtp-Source: APXvYqzRscYHJBoEzDxq2uv5cnCovFPiGbRh3bivpUiSfBTNY2qIU07r31rE+GYNh0QXcZo4tmflQA==
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr4665396wmg.5.1567101552552;
        Thu, 29 Aug 2019 10:59:12 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id o17sm4101466wrx.60.2019.08.29.10.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 10:59:11 -0700 (PDT)
Date:   Thu, 29 Aug 2019 18:59:10 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] factor out refresh_and_write_cache function
Message-ID: <20190829175910.GB48344@cat>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
 <20190827101408.76757-2-t.gummerer@gmail.com>
 <CAN0heSptSEa6tcRZ3DVZjr7L=A2n7=U9fbnfYOvW0bBJ-M3WKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSptSEa6tcRZ3DVZjr7L=A2n7=U9fbnfYOvW0bBJ-M3WKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/28, Martin Ågren wrote:
> On Tue, 27 Aug 2019 at 12:14, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Getting the lock for the index, refreshing it and then writing it is a
> > pattern that happens more than once throughout the codebase.  Factor
> > out the refresh_and_write_cache function from builtin/am.c to
> > read-cache.c, so it can be re-used in other places in a subsequent
> > commit.
> 
> > +/*
> > + * Refresh the index and write it to disk.
> > + *
> > + * Return 1 if refreshing the cache failed, -1 if writing the cache to
> > + * disk failed, 0 on success.
> > + */
> 
> Thank you for documenting. :-) Should we say something about how this
> doesn't explicitly print any error in case refreshing fails (that is, we
> leave it to `refresh_index()`), but that we *do* explicitly print an
> error if writing the index fails? That caught me off-guard as I looked
> at how you convert the callers.
> 
> And do we actually want that asymmetry? Maybe we do.

I think I needed the error for something while I went through a few
iterations of how to best structure this function, but I don't
remember for what exactly now.  I think it might actually be better to
just return -1 here, and let the caller distinguish and show the error
message if they need to.  That also avoids duplicating the error in
case the caller wants to die on error.

> Might be worth pointing out as you convert the callers how some (all?)
> of them now emit different error messages from before, but that it
> shouldn't matter(?) and it makes sense to unify those messages.

Yeah, I don't think changing the error message should matter, but
unifying them is not actually a goal of this series.  So with what you
pointed out above, I think I'll leave them as they are.

> > +int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);
> 
> > +int repo_refresh_and_write_index(struct  repository *repo,
> > +                                unsigned int refresh_flags,
> > +                                unsigned int write_flags,
> > +                                const struct pathspec *pathspec,
> > +                                char *seen, const char *header_msg)
> > +{
> > +       struct lock_file lock_file = LOCK_INIT;
> > +
> > +       repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
> > +       if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
> > +               return 1;
> > +       if (write_locked_index(repo->index, &lock_file, write_flags))
> > +               return error(_("unable to write index file"));
> > +       return 0;
> > +}
> 
> If `flags` doesn't contain `COMMIT_LOCK`, the lockfile will be closed
> "gently", meaning we still need to either commit it, or roll it back. Or
> let the exit handler roll it back, which is what would happen here, no?
> We lose our handle on the stack and there's no way for anyone to say
> "ok, now I'm done, commit it please" (or "roll it back").
> 
> In short, I think calling this function without providing `COMMIT_LOCK`
> would be useless at best. We should probably let this function provide
> `COMMIT_LOCK | write_flags` or `COMMIT_LOCK | extra_write_flags` or
> whatever. Most callers would just provide "0". Hm?
> 
> Or, we could BUG if the COMMIT_LOCK bit isn't set, but that seems like a
> less good choice to me. If we're so adamant about the bit being set --
> which we should be, IMHO -- we might as well set it ourselves.

Yeah, you're right, making this function use `COMMIT_LOCK | write_flags`
would probably be the best option.  I'll change that, and document it
as well.

Thanks for your review!

> 
> 
> Martin
