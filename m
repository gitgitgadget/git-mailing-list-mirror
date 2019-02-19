Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D161F453
	for <e@80x24.org>; Tue, 19 Feb 2019 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBSTDF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 14:03:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBSTDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 14:03:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so3998866wml.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qtmVzmSj+pnDHIgZrhfIwEx0v/xbDa4pwyN0gs+cvpk=;
        b=HM4Yi9z33ErxmKEsk+79vJ+DciwweN86zAtomG4QDUiMMLBRrFrVV6H4YrrnULjdQh
         /xBbNRjmoSmr+acBs8eiulZ/l+Or0+8e+wm4jVSLyyZC1KtrqNsxI/0zlukFftCXDiHv
         yyckX3yphSfWMgyZdGX8CjEwFhHLTfFmrKUm1FFLlwRYC4uDZ9XW3f9WySrSomX88djQ
         ZmsEEV1BYLFOmvvWlXEGrd5z7rvw3669MXNapdi2UsRDW6KuXQ8PIS1oQtn5kV+pH30g
         S8HwXomfbHTrS5RtWg7TP5SpItk/9Trr5uePlwJaxKJtGdGjxTY94W+dr+aL4j4YP41v
         2uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qtmVzmSj+pnDHIgZrhfIwEx0v/xbDa4pwyN0gs+cvpk=;
        b=khYC4GnIf5ER1GJga/mpqEFDIGSa2hoXhhvPOjDstuogsN003Rr2glLrgkvCncc4bw
         VD6pm2WSdol8dyujhcvUgXcooUuS/0emXXyU+WbkV92h64ysAv+ELMa7J5iSwgqOpmdt
         soF78bGFK9LlJzNd+PXKFiIL51/J5OSaINHAWsuSEQP4UrfN15j1gXQQ9sCgNfbIxQ2o
         s4FAu7qFJRtICppa3KXb6TtN+rqtbN1M2jLdyfmx2vI3UL91nXBKyS43+O73FBvCUJMy
         KazbSJ/MoTXm5nBw39Zgv+DzCbTVMtE/DKCa+9oUuJPXyOxFE40ZjrWhxRdoJhUNYg5c
         1J6Q==
X-Gm-Message-State: AHQUAuZFecl5UC0ubYymWYyHZsXBCsAxpEHTK3dCO00B7/FrM5v8z8bZ
        2lnBrkMOzfKf+YuEDugIcFdpXO8w
X-Google-Smtp-Source: AHgI3IY446bmXDoI1tZECsFOrqdhs5H8vVmTg36CL2It8jUcpXwcD9kJqDkiXpkGNlBpuwA0Z1hOvA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr3957153wme.73.1550602983038;
        Tue, 19 Feb 2019 11:03:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 132sm8228837wmd.27.2019.02.19.11.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:03:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
Date:   Tue, 19 Feb 2019 11:02:59 -0800
In-Reply-To: <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 19 Feb 2019 11:20:48 +0700")
Message-ID: <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Feb 2, 2019 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > Of course we could just do --index and --worktree, each option
>> > restores the respective part. Then it's combinable (and extensible in
>> > the future). But then "git restore" means "git restore --index
>> > --worktree" and typing "git restore --index" effectively removes the
>> > default "--worktree", which seems a bit twisted.
>>
>> Or "git restore --no-worktree" (essentially, instead of saying
>> "keep", say "no" to mean "negation").
>>
>> Incidentally, "git restore --no-index" does not have a counterpart
>> in "git checkout", but I think it is probably a good thing to add;
>> as it has to do far more than "git cat-file blob $tree:$path >$path"
>> these days.
>
> OK this hopefully will be the final design
>
> (git restore) "[--worktree] <paths>" restores worktree paths from index
>
> "--index <paths>" restores the index from HEAD (aka "git reset")
>
> "--source <tree> (--index|--worktree) <paths>" restores index or
> worktree (or both) from <tree>
>
> I'm a bit reluctant to support "git restore --index --worktree
> <paths>" without --source, which should default to HEAD, since it's a
> bit unclear/inconsistent ("git restore --worktree <paths>" defaults to
> index as the source, but here we use a different default source).

Ok, so we grab things from the index by default, but with --source
<tree>, we can tell the command to grab things from the tree.  When
we are explicitly told to update the index with "--index", it would
be nonsense to grab things from the index, so "--source <tree>"
becomes required in that case.  Makes sense.

To summerize and full enumerate all the allowed variants:

 * --index --worktree --source <tree> <path>...

   Update both from a tree; --source <tree> is required.

 * --index --no-worktree --source <tree> <path>...

   Update only the index but not the working tree; --source <tree>
   is required.


 * --no-index --worktree <path>...

   Update only the working tree files without touching the index
   (new feature that cannot be done with the current Git, although
   "cat-file -p >path" may be close enough at times), from the index

 * --no-index --worktree --source <tree> <path>...

   Update only the working tree files without touching the index
   from a tree-ish.

 * --no-index --no-worktree <path>...

   Update nothing, which is a no-op that is not all that useful.

 * --no-index --no-worktree --source <tree> <path>...

   Update nothing, which is a no-op that is not all that useful.

I am getting the impression that to save typing, you would want to
make "--index --worktree" the default (i.e. among the above, only
--no-index and --no-worktree need to be spelled explicitly), but
there is one glitch.  Updating from the index must be spelled
explicitly with "--no-index --worktree".

So perhaps the defaulting rule for the "--index" option must become
a bit more tricky.  Perhaps the rules are:

 * --worktree is the defeault; --no-worktree can be given from the
   command line to countermand it, and --worktree can be given from
   the command line to be more explicit.

 * when --source <tree> is given from the command line, --index is
   the default, and --no-index can be given to countermand it.

 * when --source <tree> is not given from the command line,
   --no-index is the only sensible choice.  It can be given from the
   command line to be more explicit, but giving --index to
   countermand the --no-index default would be an error, as updating
   the index, whether the same update also goes to the working tree,
   must come from a --source <tree>.

Am I following you correctly?

Thanks.
