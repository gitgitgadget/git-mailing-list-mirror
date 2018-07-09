Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151D71F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeGIR1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:27:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38614 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeGIR1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:27:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id x13-v6so4203308pfh.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nobnf/diLpuII9SpY9/nJZZYFHKz/s7ZQ7Gh2oVxDas=;
        b=ZmgYoz9+e5c71wZTnH9/f2ZW0Q9PpP3g4NlrYQkYsmgRENE9wBpoZZl8Qsvkj1ulCX
         8lFl4+xRPuaG34/VXRDLxBPLMaestGIJFldF4iYvnQpL2absneDhJONuEVCu9hYZLPC8
         HIaxaLH0sdq38LEExHvdvrGHHET1MtqjtZcapKDU53DFoX2UO4gR3zoiUehZN4JoyOD/
         nzhSWnYM8WwND+BvSsvBaSUa3Irr4iY99JPXofBO29a2baru9+PU41d6EqRBBmWhMxmS
         CNhYW8gx4fo0s20gNLQjGyYOtxuLE5EkD9TykhP2KAUp5DlxHFdluOmpTWTjHWLpUIqa
         GeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nobnf/diLpuII9SpY9/nJZZYFHKz/s7ZQ7Gh2oVxDas=;
        b=ryEZmH5L2XxXEbJpWs7mIUrwBY92Em57DS0EhRbfAi5rDs42ame4c94vOdlY2SAvNE
         fGlWjeG1EgZXkH6iAz6paMoZxBPsIuxTQY1SzMYQ/zr4usZi0qX8fzEmGEc657d3HUXS
         aPaBXvnVtVNibYRFSjUey8vfUtiz6xfFEx0WViswLBc6XKnKZR6EqYekvWp8ypEdn4Xl
         wE3wjbWiRjd8SO/zrJzDxwPCv1vbNRNoL6BHezkiXomQHzwPoJpUQk509Jr/u5cV3eCU
         OiZsdWAwnzeQ19JMR19bL3DyyjO4I+rsvWuL4+eKJOxXpM9wbg082fsGThqTEz5rKeRm
         uAjg==
X-Gm-Message-State: APt69E0vZTsiIc0zaULArtXm89bO91TunJ97ev4UyTtVx/o0qlBLlkh2
        O2Q/JdT507trHn1cZj26ygdIXQ==
X-Google-Smtp-Source: AAOMgpdxR41LlXpsde9pHpDn3cZaiybCCafDxe7uzItpUofrh0aGaI7xczpnxjYgULVOHjZ7s5Epkw==
X-Received: by 2002:a62:2605:: with SMTP id m5-v6mr22254324pfm.223.1531157239413;
        Mon, 09 Jul 2018 10:27:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m26-v6sm13607236pfg.61.2018.07.09.10.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:27:18 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:27:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
Message-ID: <20180709172716.GA81741@google.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net>
 <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
 <CAGZ79kaJKjWj9SY-cZYYcKShuooh3nuRqf26CzhCsusTXX42NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaJKjWj9SY-cZYYcKShuooh3nuRqf26CzhCsusTXX42NA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09, Stefan Beller wrote:
> On Mon, Jul 9, 2018 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 7/8/2018 7:36 PM, brian m. carlson wrote:
> > > 100 bytes is not sufficient to ensure we can write a commit message
> > > buffer when using a 32-byte hash algorithm.  Increase the buffer size to
> > > ensure we have sufficient space.
> > >
> > > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > > ---
> > >   refs/files-backend.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > > index a9a066dcfb..252f835bae 100644
> > > --- a/refs/files-backend.c
> > > +++ b/refs/files-backend.c
> > > @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
> > >       char *logrec;
> > >
> > >       msglen = msg ? strlen(msg) : 0;
> > > -     maxlen = strlen(committer) + msglen + 100;
> > > +     maxlen = strlen(committer) + msglen + 200;
> > >       logrec = xmalloc(maxlen);
> > >       len = xsnprintf(logrec, maxlen, "%s %s %s\n",
> > >                       oid_to_hex(old_oid),
> >
> > nit: 100 is not enough anymore, but wasn't a very descriptive value. 200
> > may be enough now, but I'm not sure why.
> 
> That line was touched in by Michael in 7bd9bcf372d (refs: split filesystem-based
> refs code into a new file, 2015-11-09) and before that by Ronnie in 2c6207abbd6
> (refs.c: add a function to append a reflog entry to a fd, 2014-12-12)
> and introduced
> by Junio in 8ac65937d03 (Make sure we do not write bogus reflog
> entries., 2007-01-26)
> and it appears to me that 2*40 + 5 ought to be sufficient, but no
> comments or commit
> messages are found as to why we rather choose 100.

Whats the reason for not using a strbuf here so that we don't have to
play with magic numbers?

-- 
Brandon Williams
