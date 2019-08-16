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
	by dcvr.yhbt.net (Postfix) with ESMTP id 299681F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfHPW7Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:59:25 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46299 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfHPW7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:59:25 -0400
Received: by mail-ua1-f67.google.com with SMTP id y19so2615714ual.13
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZoUgW9MYKuckWV/PV4Odc/bnoQsCag8EKAP1qICP20=;
        b=Cs8yR+5tePJVvp4TzQjJWyoAF28tA/mypCjZM9AODG3VgwkB6irqSON/CUsXb7uGgi
         kVbD9LxcgE4bsLzV/qyBgHVNs6N0XsFbxvUWkrpG2hOp5FnpkcBewNqvp+5i8G2Q5UoX
         BfcRqfJDsCvwE389pRSG191ctBa4r8omHQq6toM21AR5+WkG9Su3p7rLkQ41lDqd8xCk
         sRDH2Yez7a9pwZUE8PQmT6sUvxgvExMLFst7RdRHxD6mfjIx1xFMQ7Jy3qWE1fsS40e8
         vHt9IarpJ/Eb9uIRCPl2msHV6r1MlqLg9V7mFIl80zNwyZGHJXna7+Fk5EqDogsGSLYP
         XY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZoUgW9MYKuckWV/PV4Odc/bnoQsCag8EKAP1qICP20=;
        b=UOeU/xeZO/SjHuin5gzVr0ElDK5gNZ4Ep/xsS5K/1SDjOc7qFXq5o36pozMm2+edhf
         2EonEWt+dpXU8IoKfDLkPl2WtQv/xW1ZNnQaxN3zPXsdi03lGY956vW27N4Mp0lQn8Sg
         i9r9btPpV/xOgsEW5JAh7geAqxq7v+6pcclGwuXFyc49zUd2MYUmQpDnH5AopaWFGYyN
         n9177AiyfqYivrJBnUVM+V+h7kTn9wx7NYfxg0FKOJDYjf58Au7HPL1zypmrrl0/p17h
         TzmhIUzl4GIJcXoiaOBQdixQi0aKAkovDirkCa8k36UsJZOxD2sWT2DNO/AB/gpeuUCI
         JP7w==
X-Gm-Message-State: APjAAAVYTssT7Q/2ahUNJPWmRKcg5I0MEaulydXac5qLmlOMlmc/VH2y
        SS2il2xTmHk93TxevWXMl/GJcackLUktrfZI9LQ=
X-Google-Smtp-Source: APXvYqwtXut9scXldVHDVbuiaZzXxRukop3FEdCEfT3kLwKeTXJYpsGua+o4iztdKEy0fW7+f+RiApiAat30/mznU7o=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr1248650uam.81.1565996363944;
 Fri, 16 Aug 2019 15:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190726155258.28561-1-newren@gmail.com> <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-19-newren@gmail.com> <xmqqftm0zrjs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftm0zrjs.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:59:12 -0700
Message-ID: <CABPp-BF6LPszUcKEwFGPr2DuFRZGU00uM-ky5YhKWw+het2QRA@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] merge-recursive: consolidate unnecessary fields
 in merge_options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 3:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >  static inline int merge_detect_rename(struct merge_options *opt)
> >  {
> > -     return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
> > -             opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
> > +     return (opt->detect_renames != -1) ? opt->detect_renames : 1;
> >  }
>
> Every time I see "is it not negative?" (or more generally "is it in
> this range?") converted to "is it not this exact value?", it makes
> me feel uneasy.
>
> > -     opts.rename_limit = opt->merge_rename_limit >= 0 ? opt->merge_rename_limit :
> > -                         opt->diff_rename_limit >= 0 ? opt->diff_rename_limit :
> > -                         1000;
> > +     opts.rename_limit = (opt->rename_limit != -1) ? opt->rename_limit : 1000;
>
> Likewise.  I have no objection to merging two rename-limit to a
> single field (and two detect-renames to a single field).
>
> > @@ -3732,14 +3729,14 @@ static void merge_recursive_config(struct merge_options *opt)
> >  {
> >       char *value = NULL;
> >       git_config_get_int("merge.verbosity", &opt->verbosity);
> > -     git_config_get_int("diff.renamelimit", &opt->diff_rename_limit);
> > -     git_config_get_int("merge.renamelimit", &opt->merge_rename_limit);
> > +     git_config_get_int("diff.renamelimit", &opt->rename_limit);
> > +     git_config_get_int("merge.renamelimit", &opt->rename_limit);
>
> Hmph.  If merge.renameLimit is there, that would overwrite whatever
> we get by reading from diff.renameLimit, so the two fields with
> runtime precedence order can easily be replaced by these two calls.
>
> Nice.
>
> If you have "[diff] renamelimit = -2" in your $GIT_DIR/config, would
> we change behaviour due to the earlier conversion that has nothing
> to do with the theme of this step (i.e. consolidate two variables
> into one)?

At the end of this series, the "merge-recursive: add sanity checks for
relevant merge_options" commit adds some assertions that would fail if
someone passed such a value, regardless of whether this patch was
included or not.  (Are we worried about people having such a config
value and should we support it?  It goes against the documented
values, but I guess someone could have set it anyway even if it seems
odd to set a value that says, "give me whatever the default is.")

If we tried with this specific commit, though, then: diffcore-rename.c
checks for rename_limit <= 0 and sets the value to 32767 in that case,
so it'd have the effect of extending the default merge-related rename
limit.  As far as detect_rename, diff.c treats that as a boolean in
most places (e.g. "if (options->detect_rename)"), and specifically
compares against DIFF_DETECT_COPY in places where copy detection are
relevant.  So, detect_rename would behave the same.

All of that said, I'm happy to restore the is-not-negative checks.
