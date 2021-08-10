Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B82C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 08:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0902861051
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 08:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhHJIFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhHJIFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 04:05:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE71C0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 01:04:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cf5so28926718edb.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zngqhO0gQpRVbz+GoUp0hk1TV6FT2rE2MkUGjJMJygU=;
        b=OQIVSsoJujfuZTRdt1jprvnu8u9Kq7KYBXflk+KgekuqmS7+C/8FI0QTzxmkrL8bRP
         knju255J/gzRzcNgy5pL+LgHrl4l5PFWFbcAnk2ovEyEtWCnl/4ZanDUsQ0g1ULDeVUI
         ndY0wFfvWEzWdscQQNrFNlIxzs7C6D0VZxzo0bIZL0cVCdJfVcD9DSgcSHpFABiJ5LNT
         gT7FYLg7T7e1ceH4x05X4X0e3riJhI985ZE+BNwJYeHY6YpzX/VNqs3C2VYgi45iXYtG
         wMqH4SAJ+TH5AzIBEDs33a3b6H6+JEywJFLv5201bCfCJ8qmUjXeBLhVaT1BAuDGyhCo
         JQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zngqhO0gQpRVbz+GoUp0hk1TV6FT2rE2MkUGjJMJygU=;
        b=APYuz33w1utao+Y/FDr7tZbyjm+gJVPmcWyqFlYYGeQY5gji3EQoZ3ymeOr9RGTYIb
         TdK1FpGHR6BlXhcL7ZAmmQutnAbD/+AVERPDpTanB+d5Q65iEekXdLMfPzfMvGfvVIMU
         /HpNC0YpjtA7JVmcpsRfrVjKdIOQyXyg0bjmXxcKNz+XnI6UWkw7ZY/0TojzuLBCt/bL
         Q8EU6voOjb6+p9brV+uE/yQDEz/K5hkdGougH7OHqQB6w6yb/TfNlr1JoxyiPOgfTp4W
         nYOep7hggW8Wx44w+CbcHoxaFTn5hNZLGWGgGUfuJA1GiThCfH8IT76PVCh15Pvl9wYm
         3RsA==
X-Gm-Message-State: AOAM530GxuCkSrK26ZoQqWpthQWXbZ916ijEjOcs8ugXERt5mJontfJT
        o+pAzUUovSiRha8DJyFH0I0R3s4TMUCbkc/DPyA=
X-Google-Smtp-Source: ABdhPJwblE6Xj+Lut9uoMUBmVl8GkBpI0YdsHPa0SjhEEGcg9A44mcj1rNV+zuhLOYYJ2DLWauqACjuJE9oF1gEwYjY=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr3444355edv.387.1628582695091;
 Tue, 10 Aug 2021 01:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
In-Reply-To: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Aug 2021 10:04:44 +0200
Message-ID: <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 12
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 7:56 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My twelfth week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-12/

Thanks!

> ## Week12 Avoid repetitive parsing
>
> After we brought around `10%` optimization to `git cat-file --batch`
> through skip

s/skip/skipping/

> parse_object_buffer(), let's take a look at the result of gprof again:
>
> ```
>   %
>  time     calls(before)       calls(after)     name
>   1.24               0              349756     format_ref_array_item
>   1.24               0              349756     get_object
>   0.83         4184784             4534690     do_xmalloc
>   0.83               0             1399028     parse_ref_filter_atom
>   0.41         4184936             5932565     memory_limit_check
>   0.41          701711             1400412     strbuf_add
>   0.41               0             1399024     append_atom
>   0.41               0             1399024     quote_formatting
>   0.41              14              349770     strbuf_init
>   0.41               0              349756     populate_value
>   0.00         2100807             2449753     strbuf_grow
>   0.00         1973422             1973568     xmallocz
>   0.00               0             1399024     get_ref_atom_value
>   0.00               0             1399024     grab_values
>   0.00              77              699589     xstrdup
>   0.00              46              699558     xcalloc
> ```
>
> gprof tells us that cat-file --batch will make a lot of copies by
> `xstrdup()`, `strbuf_add()`... after
> using the logic of ref-filter. But at present, the overhead of these
> copies cannot be easily avoided
> due to the inherent logic of ref-filter. So there are no good
> optimization points in ref-filter ? We must
> re-observe the whole problem from a macro perspective.
>
> `oid_object_info_extended()` can get some metadata of the object, e.g.
> `size`, `type`, `deltabase`,
> then we can use `grab_common_values()` to grab them. And those data in
> the content of the object
> like commits' `tree-oid`, `parent-oid` or tags' `deref-oid`, which are
> parsed by `parse_object_buffer()`,
> then in `grab_tag_values()` or `grab_commit_values()`, we can grab
> them. But many attributes of
> commit and tag are not obtained through `parse_object_buffer()`, such
> as `author-info` ,`commiter-info`,
> `tagger-info` etc.
>
> We need to call grab_sub_body_contents(), grab_person() to rescan the
> buffer and extract the data.
> What if we can combine these multiple scanning and parsing into one completion?
> At least intuitively, this has an opportunity to improve performance.

Yeah, but is there a way to check that we indeed scan or parse the
same objects multiple times? This way we might get an idea about how
much scanning and parsing we could save.

> So I check the implementation
> details of `parse_commit_buffer()` and `parse_tag_buffer()`, maybe we
> can pass some "hook pointer"
> to these parsing functions like `oid_object_info_extended()` does to
> extract only the information we need?

Would this also avoid scanning and parsing the same object many times?

> The commit-slab caught my attention. It can be used to get some
> specified data content from the object.

I thought it was for storing commit data in an efficient way.

> I am thinking about whether it is possible to design a `struct
> object_view` (temporarily called
> `struct commit_view`) to store the offset of the parsed data in the
> object content. `parse_commit_buffer()`
> will check whether we need something for in-depth parsing. Like this:
>
> ```c
> struct commit_view {
> int need_tree : 1;
> int need_parents : 1;
>
> int need_author : 1;
> int need_author_name : 1;
> int need_author_email : 1;
> int need_author_date : 1;
>
> int need_committer : 1;
> int need_committer_name : 1;
> int need_committer_email : 1;
> int need_committer_date : 1;

Is the above info specific for each commit? Or will the above be the
same for all the commits we are processing?

> int tree_offset;
> int tree_length;
>
> int parents_nr;
> int *parents_offset;
> int *parents_length;
>
> int author_offset;
> int author_length;
>
> int author_name_offset;
> int author_name_length;
> int author_email_offset;
> int author_email_length;
> int author_date_offset;
> int author_date_length;
>
> int committer_offset;
> int committer_length;
>
> int committer_name_offset;
> int committer_name_length;
> int committer_email_offset;
> int committer_email_length;
> int committer_date_offset;
> int committer_date_length;
> };
>
> define_commit_slab(commit_view_slab, struct commit_view);

Ok, so the idea is to use the commit slab feature to store the struct
commit_view instances. That seems reasonable to me.

> static struct commit_view_slab view_slab = COMMIT_SLAB_INIT(1, view_slab);
>
> int parse_commit_buffer()
> {
> ...
> if (view->need_author) {
> view->author_offset = bufptr - head;
> view->author_length = ident_len;
> }
> if (view->need_author_name || view->need_author_email ||
>     view->need_author_date) {
> if (split_ident_line(&ident, ident_line, ident_len) ||
> !ident.date_begin || !ident.date_end)
> return error("bad author line in commit %s",
>      oid_to_hex(&item->object.oid));
> if (view->need_author_name) {
> view->author_name_offset = ident.name_begin - head;
> view->author_name_length = ident.name_end - ident.name_begin;
> }
> if (view->need_author_email) {
> view->author_email_offset = ident.mail_begin - head + 1;
> view->author_email_length = ident.mail_end - ident.mail_begin + 2;
> }
> if (view->need_author_date) {
> view->author_date_offset = ident.date_begin - head;
> view->author_date_length = ident.date_end - ident.date_begin;
> }
> }
> ...
> }
>
> ```
>
> It's still in WIP, hope it can bring some help!
>
> There seems to be no tag-slab similar to commit-slab, do we need to invent it?

Let's first see if it helps when doing this for commits only. I also
think that usually the number of tags is much smaller than the number
of commits.

> It seems that GSOC has only the last few weeks left, I'm not sure how
> far this patch series is from
> being merged by the master branch. Performance optimization may have
> no end.

Yeah, but the idea for now is just to make using the ref-filter code
as fast as the current code.

> By the way,
> is there a chance to avoid a large number of copies in the ref-filter?
> This may be another direction.

Yeah, but I think it's less promising than reducing the number of
times objects are scanned or parsed. The first step though should be
to show that it can indeed be reduced further (after the 10%
optimization you made by skipping parse_object_buffer() when
possible).
