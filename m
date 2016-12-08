Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074A51FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 00:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933111AbcLHAgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 19:36:07 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35175 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbcLHAgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 19:36:07 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so167515237pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRzbjloSO6Xch2pMPK+O5RiNaW7pdNDjG5fzsKW909o=;
        b=lXVxbj6CCeWuogPMnKVKgRwApdXhH7X7+tN1ECic1jtZ9UQkwE+LNb0OpWERV5wNKI
         fFUsURypkrT3x/WlVurCQMl8mBrRx4IcKObb/h3WtGKicqgkAWFG+QlBfxD1X/S3wLzW
         KjslOCOzPWlFLSDd26/DEyldjIZxcmXHXNjM/lTyq7SBn5hQjM/EiXT/k+5x8sEnAF/4
         OKzLV/YZ0O3dFrOpbDvFaRJpMEGdsVVH+2tg/5w+AxklEyF4h67q8UvioDoWp9wW+Td9
         +GUUS3OjAbUZy+NZtXbKsvXGbFquzmdTXsot9bFm2FMX7pclA4jt455EGP596pSLMx7a
         wTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRzbjloSO6Xch2pMPK+O5RiNaW7pdNDjG5fzsKW909o=;
        b=mN2IKtRHEYUvNqdd6Y5wBdnZLeUqB7/O2xVvp5pNi02uNkR44WxyoeQ1uZt7x4djHv
         GwNylyAsAHESPOjnjT6txVU7PTMqEX9rwLNM3nlk/9ZMCJKpiljGWk5toZhtqI+8CWcL
         bOW4zXYqNFyF39zYTAu+Wk6vFn7C0YPbIh7BGi74BuM0Ehd9gFt03il4NT7yy+pu1ZU3
         YIXndAG+olu6//qyehL5/OKHPgszjkT98DXskaPZwtuzz2YPlFnlVX1229tddvzbrQAc
         E4opARo6Aw7hy4Dp/luHMlP8bmdOSK2rEKlhi7AT+tNURc+GqE3MT3SwhDUf11Jh3kYc
         Leeg==
X-Gm-Message-State: AKaTC02uFVHIdE+XnlU+c7rOcydCqA+80pUFe8uTRT/0rIDT/rNXXt9fq7SGgtJNAVcU+OuS
X-Received: by 10.84.139.129 with SMTP id 1mr154749068plr.178.1481157366079;
        Wed, 07 Dec 2016 16:36:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id n24sm45263867pfb.0.2016.12.07.16.36.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 16:36:05 -0800 (PST)
Date:   Wed, 7 Dec 2016 16:36:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] mv: convert to using pathspec struct interface
Message-ID: <20161208003604.GK116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-2-git-send-email-bmwill@google.com>
 <CACsJy8Bm+Nif_PL1=BzTYLKGrnz94rjKOB=_PXz6OB47Js6v2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Bm+Nif_PL1=BzTYLKGrnz94rjKOB=_PXz6OB47Js6v2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > Convert the 'internal_copy_pathspec()' function to use the pathspec
> > struct interface from using the deprecated 'get_pathspec()' interface.
> >
> > In addition to this, fix a memory leak caused by only duplicating some
> > of the pathspec elements.  Instead always duplicate all of the the
> > pathspec elements as an intermediate step (with modificationed based on
> > the passed in flags).  This way the intermediate strings can then be
> > freed prior to duplicating the result of parse_pathspec (which contains
> > each of the elements with the prefix prepended).
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/mv.c | 45 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> Stefan did something similar last year [1] but I couldn't find why it
> did not get merged. Not sure if the reasons are still relevant or
> not...
> 
> [1] http://public-inbox.org/git/%3C1438885632-26470-1-git-send-email-sbeller@google.com%3E/
> 
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index 2f43877..4df4a12 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2006 Johannes Schindelin
> >   */
> >  #include "builtin.h"
> > +#include "pathspec.h"
> >  #include "lockfile.h"
> >  #include "dir.h"
> >  #include "cache-tree.h"
> > @@ -25,25 +26,43 @@ static const char **internal_copy_pathspec(const char *prefix,
> >  {
> >         int i;
> >         const char **result;
> > +       struct pathspec ps;
> >         ALLOC_ARRAY(result, count + 1);
> > -       COPY_ARRAY(result, pathspec, count);
> > -       result[count] = NULL;
> > +
> > +       /* Create an intermediate copy of the pathspec based on the flags */
> >         for (i = 0; i < count; i++) {
> > -               int length = strlen(result[i]);
> > +               int length = strlen(pathspec[i]);
> >                 int to_copy = length;
> > +               char *it;
> >                 while (!(flags & KEEP_TRAILING_SLASH) &&
> > -                      to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
> > +                      to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
> >                         to_copy--;
> > -               if (to_copy != length || flags & DUP_BASENAME) {
> > -                       char *it = xmemdupz(result[i], to_copy);
> > -                       if (flags & DUP_BASENAME) {
> > -                               result[i] = xstrdup(basename(it));
> > -                               free(it);
> > -                       } else
> > -                               result[i] = it;
> > -               }
> > +
> > +               it = xmemdupz(pathspec[i], to_copy);
> > +               if (flags & DUP_BASENAME) {
> > +                       result[i] = xstrdup(basename(it));
> > +                       free(it);
> > +               } else
> > +                       result[i] = it;
> > +       }
> > +       result[count] = NULL;
> > +
> > +       parse_pathspec(&ps,
> > +                      PATHSPEC_ALL_MAGIC &
> > +                      ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
> > +                      PATHSPEC_KEEP_ORDER | PATHSPEC_PREFER_CWD,
> > +                      prefix, result);
> > +       assert(count == ps.nr);
> > +
> > +       /* Copy the pathspec and free the old intermediate strings */
> > +       for (i = 0; i < count; i++) {
> > +               const char *match = xstrdup(ps.items[i].match);
> > +               free((char *) result[i]);
> > +               result[i] = match;
> 
> Sigh.. it looks so weird that we do all the parsing (in a _copy_
> pathspec function) then remove struct pathspec and return the plain
> string. I guess we can't do anything more until we rework cmd_mv code
> to handle pathspec natively.
> 
> At the least I think we should rename this function to something else.
> But if you have time I really wish we could kill this function. I
> haven't stared at cmd_mv() long and hard, but it looks to me that we
> combining two separate functionalities in the same function here.
> 
> If "mv" takes n arguments, then the first <n-1> arguments may be
> pathspec, the last one is always a plain path. The "dest_path =
> internal_copy_pathspec..." could be as simple as "dest_path =
> prefix_path(argv[argc - 1])". the special treatment for this last
> argument [1] can live here. Then, we can do parse_pathspec for the
> <n-1> arguments in cmd_mv(). It's still far from perfect, because
> cmd_mv can't handle pathspec properly, but it reduces the messy mess
> in internal_copy_pathspec a bit, I hope.
> 
> [1] c57f628 (mv: let 'git mv file no-such-dir/' error out - 2013-12-03)
> 
> >         }
> > -       return get_pathspec(prefix, result);
> > +
> > +       clear_pathspec(&ps);
> > +       return result;
> >  }
> >
> >  static const char *add_slash(const char *path)
> > --
> > 2.8.0.rc3.226.g39d4020
> >
> 
> 
> 
> -- 
> Duy

Actually, after looking at this a bit more it seems like we could
technically use prefix_path for both source and dest (based on how the
current code is structured) since the source's provied must all exist (as
in no wildcards are allowed).  We could drop using the pathspec struct
completely in addition to renaming the function (to what I'm still
unsure).  I agree that this code should probably be rewritten and made a
bit cleaner, I don't know if that fits in the scope of this series or
should be done as a followup patch.  If you think it fits here then I
can try and find some time to do the rework.

-- 
Brandon Williams
