Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26F31F4F8
	for <e@80x24.org>; Wed, 11 Jan 2017 22:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdAKWMP (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 17:12:15 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34795 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750901AbdAKWMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 17:12:14 -0500
Received: by mail-io0-f176.google.com with SMTP id l66so4613836ioi.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 14:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JPYwGHe/u6OU8306WoDzwSHgCIPbFB6jHxuFWZfndIY=;
        b=o5MO+a5/7pj5C3LjsDvW55kQNl/VcLiyBG6vraUZ5lTt6fLFZaMkCLC0y783e64HLz
         n7+SZQnUR1wzdEzvvn8mrfBRDwBrEZNv+8WE9WMnNYqhddrW3qwm4H9rnxFGXOnIC7xK
         vGUqgAq1b06jOpk5OcrXqaryq1jYsfSPJZbLvSuMvbfCXfhEF5ZZABHnoZXztMkYAK7N
         F5BwxoRdi5LnF0BnsgszFIJUDjt4APpn/cyW1t0UKtZf2KIZYvUYCmVjShaV6nn+dQZ2
         Ov0mO+TeDutikXuLNiWMZJDM3OEDVgK9Q4a1V355NB7TfeHCPGHSHicXyr9n4ouTyatM
         sZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JPYwGHe/u6OU8306WoDzwSHgCIPbFB6jHxuFWZfndIY=;
        b=UqhA7kUdLHKkPFJ5pOASeuTmQrh2gRg7sRX5q8wa0uqK/SqISvvZ7aZq5MrO9d2BHP
         xLfDZ3dZjfxARtYaxoE+NXKlapjW+7Mf+It9LAYR9+0Ohi11cVyFkyDpi1zffUIPo1N/
         v0TG17eWyx/b2WSajx2tiYPkFUo7wuWNNtMgv6szm6gp4y6RNIKN8MGNR9CbDdq7+vsO
         ny3u7UiBkdlS7UrfXbhCt2gJDdSeYK0/Dw+aNwhm8tAoc/l9DpUtOdet7ShV/R8+JtcY
         vB5uSBMRo6XJavO0IaKgyVWltK3PuFMKweL0qpxHbVXvXhbExFn+HKWcuPhwRSF5fy2v
         EXnQ==
X-Gm-Message-State: AIkVDXLPH0ud2zmeNZHabg4TpSY4UdD6L+rxAdk0Dq59BRhJBzUMPRzsAciGQMqIfGpVy2lUCtRIVIhPdTsek2WJ
X-Received: by 10.107.3.160 with SMTP id e32mr10377783ioi.52.1484172733204;
 Wed, 11 Jan 2017 14:12:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 11 Jan 2017 14:12:12 -0800 (PST)
In-Reply-To: <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
References: <20170110014542.19352-1-sbeller@google.com> <20170110014542.19352-5-sbeller@google.com>
 <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Jan 2017 14:12:12 -0800
Message-ID: <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
Subject: Re: [PATCH 4/4] unpack-trees: support super-prefix option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Add support for the super-prefix option for commands that unpack trees.
>> For testing purposes enable it in read-tree, which has no other path
>> related output.
>
> "path related output"?  I am not sure I understand this.

Well, s/path related output/output of paths/.

> When read-tree reads N trees, or unpack_trees() is asked to "merge"
> N trees, how does --super-prefix supposed to interact with the paths
> in these trees?  Does the prefix added to paths in all trees?

Internally the super-prefix is ignored. Only the (input and) output
is using that super prefix for messages.

It was introduced for grepping recursively into submodules, i.e.

invoke as

    git grep --recurse-submodules \
      -e path/inside/submodule/and/further/down
    # internally it invokes:
    git -C .. --super-prefix .. grep ..
    # which operates "just normal" except for the
    # input parsing and output

The use case for this patch is working tree related things, i.e.
    git checkout --recurse-submodules
    # internally when recursing we call "git read-tree -u", but
    # reporting could be:
    Your local changes to the following files would be overwritten by checkout:
      path/inside/submodule/file.txt


>
> Did you mean that read-tree (and unpack_trees() in general) is a
> whole-tree operation and there is no path related input (i.e.
> pathspec limiting), but if another command that started in the
> superproject is running us in its submodule, it wants us to prefix
> the path to the submodule when we report errors?

Yes. I tried to explain it better above, but you got it here.

>
> If that is what is going on, I think it makes sense, but it may be
> asking too much from the readers to guess that from "Add support for
> the super-prefix option".

I need to enhance the commit message by a lot then.

>
>> --- a/t/t1001-read-tree-m-2way.sh
>> +++ b/t/t1001-read-tree-m-2way.sh
>> @@ -363,6 +363,15 @@ test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
>>       test -f a/b
>>  '
>>
>> +cat <<-EOF >expect &&
>> +     error: Updating 'fictional/a' would lose untracked files in it
>> +EOF
>> +
>> +test_expect_success 'read-tree supports the super-prefix' '
>> +     test_must_fail git --super-prefix fictional/ read-tree -u -m "$treeH" "$treeM" 2>actual &&
>> +     test_cmp expect actual
>> +'
>> +
>
> Preparing the expected output "expect" outside test_expect_success
> block is also old-school.  Move it inside the new test?

I looked into that. What is our current stance on using single/double quotes?
Most tests use single quotes for the test title as well as the test
instructions,
such that double quotes can be used naturally in there. But single quotes
cannot be used even escaped, such that we need to do a thing like

sq="'"

test_expect_success 'test title' '
    cat <<-EOF >expect &&
        error for ${sq}path${sq}
    EOF
    test instructions go here
'

though that is not used as often as I would think as
grep \${sq} yields t1507 and t3005.

>
> Hmph, as a reader of the code, I do not even want to wonder how
> expensive get_super_prefix() is.  If the executable part of the
> above were written like this, it would have been easier to
> understand:
>
>         if (super_prefix_len < 0) {
>                 if (!get_super_prefix())
>                         super_prefix_len = 0;
>                 else {
>                         int i;
>                         ... prepare buf[] and set super_prefix_len ...;
>                 }
>         }
>
>         if (!super_prefix_len)
>                 return path;
>
>         ... use buf[] to do the prefixing and return it ...
>

good point. I'll fix that.
