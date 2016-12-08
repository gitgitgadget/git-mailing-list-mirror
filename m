Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EEE1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbcLHSGT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:06:19 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33784 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbcLHSGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:06:18 -0500
Received: by mail-pf0-f182.google.com with SMTP id d2so84661833pfd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eAeNtKhMoUjpsHMn1cWGXik4GXXTCIdzava/1CV6dRw=;
        b=jw7iPVoz6EMYAobQGdKuXSYZtd5EPgbp7Sgc/bTRlYny0uCZn3rc+mq+uwnxWFMhsY
         Doz/hfe5AQn6iG/OMeLOXKCW1JnBIukwwNJKxsaSk3bRVg6NcQjhPQmI7Ys5cKqCZPNb
         L3X+Wrni6M138IXiuzx9bnejnneGhrFkkdoX957NorFP5CvpEu0SbIHn0YyFOIWw4Kzm
         hwkjN++e1Wb3ryeqLr+3HX2LESqeORYtwuc3Au01e0dJKyvgcRYGPYaPQZ1g45+nJoxb
         AwHVu7vcTOaSNA7eDMA342lJmEERCb16e1AVEf4d+0PicVI3IUPKkANdfm0TCqOrevjv
         PHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eAeNtKhMoUjpsHMn1cWGXik4GXXTCIdzava/1CV6dRw=;
        b=Bju9W3UIBnjLOaWBYbVBYj+GUKlk9HIk8PrSy87eOo1T6u1rX4M+8vcVtYcc2UeAdt
         MwuuJdYP6onS0X1tJyN00hBlGgtP1numlY9Q8LZNArE/5HlVhK0CXPTgp63b3PILBYd2
         RkxRPjtH9pdP21tttL90IZo6Pm4PTsBJ0nJ9WODFg42mHLCNM/F9sCaeqwLQWvJjv+t0
         ihhhN5xBBO2wEW06Ye0+H07xHXSMWG8QgOx3gE1xW28OSbGQN4KDKMP76j92tD88vcIo
         f+tJmKJKJSpN5HXHTIM4/Lz+euEXUXRTW3+O+DmtiIdMV1eJLWQmYOxUpU/4rKWu2RlO
         Al6g==
X-Gm-Message-State: AKaTC00Pitibq1TudlTMOsKnSDrJmnMG8ctbYHpZRbetjyKffbo9ebYXLcmLjAcBXhhs0eMj
X-Received: by 10.99.219.21 with SMTP id e21mr131674108pgg.136.1481220377114;
        Thu, 08 Dec 2016 10:06:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5c3f:7794:7672:2048])
        by smtp.gmail.com with ESMTPSA id 65sm51823298pfn.12.2016.12.08.10.06.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:06:16 -0800 (PST)
Date:   Thu, 8 Dec 2016 10:06:14 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] mv: convert to using pathspec struct interface
Message-ID: <20161208180614.GO116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-2-git-send-email-bmwill@google.com>
 <CACsJy8Bm+Nif_PL1=BzTYLKGrnz94rjKOB=_PXz6OB47Js6v2A@mail.gmail.com>
 <20161208003604.GK116201@google.com>
 <CACsJy8DVuOdRsu4x9iFTwweSVn=RRJYzBTm43ufBevTWMf4Qmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DVuOdRsu4x9iFTwweSVn=RRJYzBTm43ufBevTWMf4Qmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Duy Nguyen wrote:
> On Thu, Dec 8, 2016 at 7:36 AM, Brandon Williams <bmwill@google.com> wrote:
> >> > @@ -25,25 +26,43 @@ static const char **internal_copy_pathspec(const char *prefix,
> >> >  {
> >> >         int i;
> >> >         const char **result;
> >> > +       struct pathspec ps;
> >> >         ALLOC_ARRAY(result, count + 1);
> >> > -       COPY_ARRAY(result, pathspec, count);
> >> > -       result[count] = NULL;
> >> > +
> >> > +       /* Create an intermediate copy of the pathspec based on the flags */
> >> >         for (i = 0; i < count; i++) {
> >> > -               int length = strlen(result[i]);
> >> > +               int length = strlen(pathspec[i]);
> >> >                 int to_copy = length;
> >> > +               char *it;
> >> >                 while (!(flags & KEEP_TRAILING_SLASH) &&
> >> > -                      to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
> >> > +                      to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
> >> >                         to_copy--;
> >> > -               if (to_copy != length || flags & DUP_BASENAME) {
> >> > -                       char *it = xmemdupz(result[i], to_copy);
> >> > -                       if (flags & DUP_BASENAME) {
> >> > -                               result[i] = xstrdup(basename(it));
> >> > -                               free(it);
> >> > -                       } else
> >> > -                               result[i] = it;
> >> > -               }
> >> > +
> >> > +               it = xmemdupz(pathspec[i], to_copy);
> >> > +               if (flags & DUP_BASENAME) {
> >> > +                       result[i] = xstrdup(basename(it));
> >> > +                       free(it);
> >> > +               } else
> >> > +                       result[i] = it;
> >> > +       }
> >> > +       result[count] = NULL;
> >> > +
> >> > +       parse_pathspec(&ps,
> >> > +                      PATHSPEC_ALL_MAGIC &
> >> > +                      ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
> >> > +                      PATHSPEC_KEEP_ORDER | PATHSPEC_PREFER_CWD,
> >> > +                      prefix, result);
> >> > +       assert(count == ps.nr);
> >> > +
> >> > +       /* Copy the pathspec and free the old intermediate strings */
> >> > +       for (i = 0; i < count; i++) {
> >> > +               const char *match = xstrdup(ps.items[i].match);
> >> > +               free((char *) result[i]);
> >> > +               result[i] = match;
> >>
> >> Sigh.. it looks so weird that we do all the parsing (in a _copy_
> >> pathspec function) then remove struct pathspec and return the plain
> >> string. I guess we can't do anything more until we rework cmd_mv code
> >> to handle pathspec natively.
> >>
> >> At the least I think we should rename this function to something else.
> >> But if you have time I really wish we could kill this function. I
> >> haven't stared at cmd_mv() long and hard, but it looks to me that we
> >> combining two separate functionalities in the same function here.
> >>
> >> If "mv" takes n arguments, then the first <n-1> arguments may be
> >> pathspec, the last one is always a plain path. The "dest_path =
> >> internal_copy_pathspec..." could be as simple as "dest_path =
> >> prefix_path(argv[argc - 1])". the special treatment for this last
> >> argument [1] can live here. Then, we can do parse_pathspec for the
> >> <n-1> arguments in cmd_mv(). It's still far from perfect, because
> >> cmd_mv can't handle pathspec properly, but it reduces the messy mess
> >> in internal_copy_pathspec a bit, I hope.
> >>
> >
> > Actually, after looking at this a bit more it seems like we could
> > technically use prefix_path for both source and dest (based on how the
> > current code is structured) since the source's provied must all exist (as
> > in no wildcards are allowed).  We could drop using the pathspec struct
> > completely in addition to renaming the function (to what I'm still
> > unsure).
> 
> Yeah that sounds good too (with a caveat: I'm not a heavy user of
> git-mv nor touching this code a lot, I might be missing something).
> It'll take some looong time before somebody starts converting it to
> use pathspec properly, I guess. prefix_path() would keep the code
> clean meanwhile.

K for now I'll switch to using prefix_path() and rename the function
`internal_prefix_pathspec()` as that is a bit more descriptive.

-- 
Brandon Williams
