Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394AE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGAOtZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:49:25 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38718 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGAOtY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:49:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id j199so61105ybg.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9PjuaXJgAK355yX4em4avLdnhDG5NvF1er8oMzp6+Fc=;
        b=chZQZxIRg8OEePqvxGAA+OVy3dO/cY0NsxuoDKuWvLU65IGluhWW2Y7X2Z5Kd7g5FZ
         Z5hwD4Aee0/n5Hl3HQB4qKilRJAYDrwcaVVtzEFxI9b/1v3gBVlP/MttIzwDa1tAXFLW
         XhksLmGqO2ydMVhs8EjgpdsTJ3Zx1EkZx6V2JzooXpeCGOOKJSpZgL8UKlpr1XDpwCUy
         vbyuDGbfyaAZWT8SFq/XVgOTn0l79L4h9KBsKVkbQYpBruSxpdcMl5q3JE20D+S+78uY
         zteRFNrCyDZJFaoPnHrLC7QyQInu4k7qKy3Lzcmewv1cgabDlxdgGbfkEqw0Etq9aqJE
         2PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9PjuaXJgAK355yX4em4avLdnhDG5NvF1er8oMzp6+Fc=;
        b=PFRGw+tnNILqnUonymMJiglMDgKmTdek/gaqqtktvlknmkv4J9uGyM7cq1rCKhQR5v
         WFRv2w3NvGHRQ1Ix7iKSN2iWMvndXFa6ZM3Nko8l3hiKej2GXBYJNswkPTRg/CA/2oCq
         CExlAMlcseLU79bNJh2B2f0yenW8A164i7ymZqNgw9Tul3H7d+2aKccDSb3g95Hu7Qgb
         3hRF3VzBK5H2Inj6zYr9wTL4Xq8OoG8MFLviOzFpOaLoaFYJHYlF6n6CBPJ8ACRiPMC3
         4Mq3aTQDiF+Wrwf7IaGKMXriQZOTwtXI/B8p8NMOyAEWgKAPEcXxadrPLWaIlYa8zdMz
         0WJQ==
X-Gm-Message-State: APjAAAUBFnwDZ+uEusmmxdY6cEX147ZEywb2kr1ckJsafP8lvG8vVzGq
        2tIloZpuTSIaw3sygPRHYRE0/Fa+uVHjkw==
X-Google-Smtp-Source: APXvYqxJnc+loBTto85Oesvbgf+5BJ59Gu7THVexEEmh8Q5WxZ9bHqEGb7ayTmqxgmebPt3dhrEpkg==
X-Received: by 2002:a25:cf43:: with SMTP id f64mr3708473ybg.47.1561992563254;
        Mon, 01 Jul 2019 07:49:23 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:6841:343f:64f7:7ef1])
        by smtp.gmail.com with ESMTPSA id 204sm2517600ywg.67.2019.07.01.07.49.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:49:22 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:49:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] ref-filter.c: find disjoint pattern prefixes
Message-ID: <20190701144918.GB38109@TaylorsMBP5715.attlocal.net>
References: <cover.1561588479.git.me@ttaylorr.com>
 <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
 <CA+P7+xqhFY2gcV=3f8TgemOPPiPnyZU1CgXoNSzoh60bdw1OYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqhFY2gcV=3f8TgemOPPiPnyZU1CgXoNSzoh60bdw1OYQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Thu, Jun 27, 2019 at 04:21:57PM -0700, Jacob Keller wrote:
> On Wed, Jun 26, 2019 at 3:44 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
>
> Ok, now I've got some time to look at the code itself.
>
> >  ref-filter.c            | 89 +++++++++++++++++++++++++++++------------
> >  t/t6300-for-each-ref.sh | 26 ++++++++++++
> >  2 files changed, 89 insertions(+), 26 deletions(-)
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 8500671bc6..3e10fd647b 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -20,6 +20,7 @@
> >  #include "commit-slab.h"
> >  #include "commit-graph.h"
> >  #include "commit-reach.h"
> > +#include "argv-array.h"
> >
> >  static struct ref_msg {
> >         const char *gone;
> > @@ -1790,21 +1791,62 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
> >         return match_pattern(filter, refname);
> >  }
> >
> > -/*
> > - * Find the longest prefix of pattern we can pass to
> > - * `for_each_fullref_in()`, namely the part of pattern preceding the
> > - * first glob character. (Note that `for_each_fullref_in()` is
> > - * perfectly happy working with a prefix that doesn't end at a
> > - * pathname component boundary.)
> > - */
> > -static void find_longest_prefix(struct strbuf *out, const char *pattern)
> > +static int qsort_strcmp(const void *va, const void *vb)
> >  {
> > -       const char *p;
> > +       const char *a = *(const char **)va;
> > +       const char *b = *(const char **)vb;
> >
> > -       for (p = pattern; *p && !is_glob_special(*p); p++)
> > -               ;
> > +       return strcmp(a, b);
> > +}
> >
> > -       strbuf_add(out, pattern, p - pattern);
> > +static void find_longest_prefixes_1(struct string_list *out,
> > +                                 struct strbuf *prefix,
> > +                                 const char **patterns, size_t nr)
> > +{
> > +       size_t i;
> > +
> > +       for (i = 0; i < nr; i++) {
> > +               char c = patterns[i][prefix->len];
> > +               if (!c || is_glob_special(c)) {
> > +                       string_list_append(out, prefix->buf);
> > +                       return;
> > +               }
> > +       }
>
> Ok, so we loop over the patterns, find the last character up to our
> current prefix length, and check if it's either the end of the string,
> or a special glob character. I assume that the patterns are sorted so
> that prefix->len never goes past the array?

That's right. The idea here is that if we compare two patterns character
by character, we can detect where the references "split", and thus
constitute membership of unique disjoint sets.

Consider the following example:

  refs/heads/a
  refs/heads/b
             ^

Here, we were given, say 'git for-each-ref refs/heads/a refs/heads/b',
and appropriate queries are:

  - '*'
  - 'refs/*'
  - 'refs/heads/*'
  - 'refs/heads/a' with 'refs/heads/b'

When we have advanced our cursor up until the position where the
patterns read 'a', and 'b', respectively, we have built up so far as our
pattern: 'refs/heads/'. We would like to realize that those two can
create two queries, so when we discover that 'a' != 'b', we "split" the
strbuf into two patterns in the next level of recursion.

One alternative view is that we are trying to construct the shortest
paths from the root of the tree to the leaf 'NUL' nodes as below:

                   a --- NUL
                 /
  refs --- heads
                 \
                   b --- NUL

> If we find one, we just add this to the list and return, since we
> found an unambigous one.
>
> Otherwise, we keep searching recursively.
>
> So, prefix is a strbuf, and its length will initially be zero. So, we
> check all patterns, up to the prefix length and check the character
> just past the end of our prefix. If it matches a NUL or glob
> character, then we have found an exact match up to a glob, so this
> gets returned.

Right: two additional wrinkles here.

One is that we don't have very careful handling of wildcard characters,
i.e., between 'a*c' and '*bc' we give up and split those at 'a*', and
'*b' (an equally good query would be '**c'), so treat the presence of a
wildcard character the same way we would a disagreement in character as
above.

The second wrinkle is that we originally wrote this patch looking for
disagreements in _ref component_, i.e., that given 'refs/heads/a' with
'refs/tags/a', we would split because 'heads != tags', not 'h != t'. The
references backend (to my surprise) does per-character matching, so
that's why we do it, too.

> Here, we're going to loop from beginning to end of all of the strings.
>
> > +               /*
> > +               * Set "end" to the index of the element _after_ the last one
> > +               * in our group.
> > +               */
> > +               for (end = i + 1; end < nr; end++) {
> > +                       if (patterns[i][prefix->len] != patterns[end][prefix->len])
> > +                               break;
> > +               }
> > +
>
> We break on the first string which doesn't have the same length as our
> current prefix, but start with the ones after the current loop
> iteration.
>
> > +               strbuf_addch(prefix, patterns[i][prefix->len]);
> > +               find_longest_prefixes_1(out, prefix, patterns + i, end - i);
> > +               strbuf_setlen(prefix, prefix->len - 1);
> > +

Right, we have a potentially long list of patterns underneath that we
have just covered, so we can skip those.

> We'll add the next character to the prefix, and then find longest
> prefixes again.
>
> This basically has us recurse and keep adding additional characters,
> essentially splitting the strings apart by their disjoint sets.
>
> I think this works, but it's definitely not clear from reading exactly
> what is going on. I think this algorithm would benefit from a comment,
> since it doesn't quite seem to match your description in the commit
> message.
> > +       find_longest_prefixes_1(out, &prefix, sorted.argv, sorted.argc);
> > +
> > +       argv_array_clear(&sorted);
> > +       strbuf_release(&prefix);

Fair enough, I'm happy to add a comment if others like, too.

Thanks,
Taylor
