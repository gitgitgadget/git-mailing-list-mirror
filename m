Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A9F2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbcISR0b (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:26:31 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38292 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbcISR0a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:26:30 -0400
Received: by mail-wm0-f44.google.com with SMTP id l132so21617858wmf.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L+fn5brdgI9jq7kWB1+ulrzfRz3KAWw7dLRYG5DjN9Q=;
        b=IPf+Zul8UnLhqOAQWSeKBCkDy+Pu7CgrUCHC4Ky7J2doMeVjV0TzPRvo8gzAuii+RI
         ccEiuXfT7cxxGMAW74tPuSuVG0t/KCUJQKmtYbrp0lDobvCoz9/xFDkp9XRbyQZuoucU
         D3kXEdZRgwlOgevbTAZIN8VLv3J3Zc9IyNHoWSykDiASJkYbOkI9QpVART2ZhnPStw/X
         Id2eMwHXYWvOQRyXAy5eddUpaD0OJUw4gY3QKEkDzqyX9fvgpX+yrMnxoQ5D0ubLXQjj
         DYUdBoYx4XTf7AqGVhhVT12PMB+vGuE96uRyIaXPctUH0qm7+4OtXTfpR5nYgp+FqWao
         MDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L+fn5brdgI9jq7kWB1+ulrzfRz3KAWw7dLRYG5DjN9Q=;
        b=F0pVGBBYFXlLi/iKR4FMo9Iq7ZWM1Oyh65mdbMWsOU15VmWFN93j5/YXdZCIRxJtPm
         ZMjVOD08P7pmLCtFwEjmV/QFE671yTYG96EtvBTrbw4eBt2ZCdBx/LP/EwOzQ/KGvVZI
         Ov+18HUwWpd9BjjNGVf5eyutfA9EKKLtOj0C/JAXZUSfe8A00jLNiSjoc9ecxc0FSrVf
         D4Tg3K/qUDqSgBxjewhHBZagknK8Dny03L/Wbclyai8URa8BGDHVDg2MduPZYZv4hHNQ
         KbVYdVg82FQ5xJ2aPRJtZIe8IV7PFWJcrntA0SgciLjtI44qlMmvYHdLFb9wku96arTv
         OdUQ==
X-Gm-Message-State: AE9vXwMQ6yZyCYp+ZTgoLXtFKBsTPVwQp8ujCzA2UuQh8IhSZ4/Vijsqt9C61WG5mOkRKMPW2jf7pinAu+p89uCN
X-Received: by 10.194.164.102 with SMTP id yp6mr24575086wjb.50.1474305987889;
 Mon, 19 Sep 2016 10:26:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Mon, 19 Sep 2016 10:26:27 -0700 (PDT)
In-Reply-To: <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
 <1474073981-96620-1-git-send-email-bmwill@google.com> <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
 <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com> <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Mon, 19 Sep 2016 10:26:27 -0700
Message-ID: <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 10:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think you were clear enough.
>
> Don't read everything other people say in their reviews as pointing
> out issues.  Often trying to rephrase what they read in the code in
> their own words is a good way to make sure the reviewers and the
> original author are on the same page.  The above was one of these
> cases.

That makes sense, I'll be sure to remember that!


>
>>>> +     if (prefix > 0) {
>>>> +             if (ps_strncmp(item, pattern, string, prefix))
>>>> +                     return WM_NOMATCH;
>>>
>>> This says: when we have a set prefix that must literally match, and
>>> that part does not match what we have, it cannot possibly match.
>>>
>>> Is that correct?  What do we have in "name" and "item" at this
>>> point?  We disable the common-prefix optimization, so we do not have
>>> to worry about a pathspec with two elements "sub/dir1/*" and "sub/dir2/*"
>>> giving you "sub/dir" as the common prefix, when you are wondering if
>>> it is worth descending into "sub/" without knowing what it contains.
>>> Is that what guarantees why this part is correct?
>>
>> I adopted this structure from another part of the code.  The caller
>> uses a field in
>> the pathspec item which indicates the location of the first wildcard character.
>> So the prefix (everything prior to the wildcard char) must match
>> literally before
>> we drop into a more expensive wildmatch function.
>
> "Another part of the code" is about tree walking, right?  Weren't
> you saying that part of the code may be buggy or something earlier
> (e.g. pathspec "su?/" vs entry "sub")?

I was refering to the logic that is used to do normal pathspec checking:
'match_pathspec' and the functions it calls, in particular
git_fnmatch.  And the bug I
pointed out before, I believe is due to how the wildmatch function
works.  It requires
that the pattern and the string being compared must match exactly (in
length as well).
The "su?/" case would drop into wildmatch funciton and wouldn't match
against any file
in the directory "sub/file1" for example, because it doesn't exactly
match "su?/".  In the
case of "sub" there is logic prior to the wildmatch function call
which would classify it a
match and return before descending into wildmatch.

> Again, what do we have in "name" and "item" at this point?  If we
> have a submodule at "sub/" and we are checking a pathspec element
> "sub/dir1/*", what is the non-wildcard part of the pathspec and what
> is the "string"?  Aren't then "sub/dir1/" and "sub/" respectively,
> which would not pass ps_strncmp() and produce a (false) negative?

item will be the pathspec_item struct that we are trying to match against.
name will be the file we are trying to match, which should already have the
'prefix' cut off (this is the prefix that is used as an optimization
in the common
case, which isn't used in the submodule case).  The 'prefix' in this function's
context is the part of the pattern prior to the first wildcard character. which
we can do a literal comparison on before descending into the wildmatch function.

> I am starting to have a feeling that the best we can do in this
> function safely is to see if prefix (i.e. the constant part of the
> pathspec before the first wildcard) is long enough to cover the
> "name" and if "name" part does not match to the directory boundary,
> e.g. for this combination
>
>         pathspec = "a/b/sib/c/*"
>         name = "a/b/sub/"
>
> we can say with confidence that it is not worth descending into.
>
> When prefix is long enough and "name" and leading part of the prefix
> matches to the directory boundary, e.g.
>
>         pathspec = "a/b/sub/c/*"
>         name = "a/b/sub/"
>
> we can say it is worth descending into.
>
> If these two checks cannot decide, we may have to be pessimistic and
> say "it may match; we don't know until we descend into it".  When
> prefix is shorter than name, I am not sure if we can devise a set of
> simple rules, e.g.
>
>         pathspec = "a/**/c/*"
>         name = "a/b/sub/"
>
> may match with its ** "b/sub" part and worth descending into, so is
>
>         pathspec = "a/b/*/c/*"
>         name = "a/b/sub/"
>
> but not this one:
>
>         pathspec = "a/b/su[c-z]/c/*"
>         name = "a/b/sub/"
>
> but this is OK:
>
>         pathspec = "a/b/su[a-z]/c/*"
>         name = "a/b/sub/"
>
> So I would think we'd be in the business of counting slashes in the
> name (called "string" in this function) and the pathspec, while
> noticing '*' and '**' in the latter, and we may be able to be more
> precise, but I am not sure how complex the end result would become.
>

I agree, I'm not too sure how much more complex the logic would need
to be to handle
all matters of wildcard characters.  We could initially be more
lenient on what qualifies as
a match and then later (or in the near future) revisit the wildmatch
function (which is complex)
and see if we can add better matching capabilities more suited for
submodules while at the
same time fixing that bug discussed above.
