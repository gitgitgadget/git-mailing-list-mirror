Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5123320248
	for <e@80x24.org>; Wed, 20 Mar 2019 04:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbfCTEpP (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 00:45:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42280 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfCTEpP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 00:45:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so1149740wrr.9
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 21:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NQQFlzXbTApEkC/ONDzB9crxmfV435b6turVumyws/g=;
        b=k0x8urLtI+EuG3LziQWH/YQZ/csIieafUkJ4EEQYUuiPHY7fnZzRZyh3cjzXsDnUeT
         AO78UpxaOeCabnEJc6a0/hj3BgnvA8lZMPPVULkoHz+1eGVDTCfH4pmcs4AaofMNJhGF
         Z4B5rDv51wcND3MdnhRgwyMJo7MypWbV4CVd2+i/b+pvJf3aq0rLoeYiSixygUSH6X7j
         guFM13vzGVXRp0vIZEyx42d00ahwUzxH8R82zEWGW8yTkI3BT0KuKvrq/kZTxob3up9t
         KKzTYecQikEkJE4GwyLWO7EjEzFlF8axJjLaQxldx44TyLBhvxKR5xCGyacKJyhBTqk8
         G6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NQQFlzXbTApEkC/ONDzB9crxmfV435b6turVumyws/g=;
        b=DqCuB3tveGSsoingd9tkQH4RvqWk2qwXBriANVCakEULJfjGSbIaSeFYWHGTXhiMj0
         CMX/pM4NJksuGEB1/GezeQ2UJBXIEHtyU4o4b3XP2PsrpWKJi1YiRc3Xq3/3c8Io3wEq
         73n91Hi2Xu7O1ZfPfixwrc46sLbayNuUP/S7MDsZtMDthJdnTOBKk/NzXgE2j910rk1+
         w6fQuppqK5HQ+px33etEfOb+eARnecd1aHRQ74YXgV0ZqKIFUQV7xj0iyQHcul2ArGfr
         JEZVMIFEQJjj1dZXl6B0gMnYRXXte0rUvd768rsGC7Cw9K2h+9nFquPnGGwtiatjnX7U
         35Hw==
X-Gm-Message-State: APjAAAWCotFQf9gqOgucXmrBphLod5ZEeEq5VPms/Pd3rxjhBo0lhS5D
        pyTwioIgC30qcnDzugbJJMc=
X-Google-Smtp-Source: APXvYqw1tGuul1Y/jXzpqCs7sTaED899nPMG9HFkivPY/Jquxp7xcDCT4QoPW4/TYla+M8Pmh7V1Zg==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr20170573wrv.83.1553057112144;
        Tue, 19 Mar 2019 21:45:12 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r3sm823148wrm.33.2019.03.19.21.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 21:45:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "C.J. Jameson" <cjcjameson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
Date:   Wed, 20 Mar 2019 13:45:09 +0900
In-Reply-To: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        (C. J. Jameson's message of "Tue, 19 Mar 2019 20:54:48 -0700")
Message-ID: <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"C.J. Jameson" <cjcjameson@gmail.com> writes:

> When cherry-picking from a standard merge commit, the parent should
> always be 1, as it has the meaningful new changes which were added to
> the mainline. If the source commit is unique in some way and a user
> wants to specify a value other than 1, they still can, but it's up to
> them to be aware of which parent is which.

I do not have a firm opinion for or against the "if the commit being
cherry-picked happens to be a merge, cherry-pick it relative to the
first parent by default, without requiring the '-m 1' option".  It
may not be such a bad idea after all.

But I do have a very strong opinion against adding yet another
option that takes an optional argument.  If we want to allow
cherry-picking a merge commit just as easy as cherrry-picking a
single-parent commit, "git cherry-pick -m merge" (assuming 'merge'
is the tip of a branch that is a merge commit) that still requires
the user to say "-m" is not a good improvement.  We should just
accept "git cherry-pick merge" without any "-m" if we want to move
in this direction, I would think.

> --m parent-number::
> ---mainline parent-number::
> +-m [parent-number]::
> +--mainline [parent-number]::
>   Usually you cannot cherry-pick a merge because you do not know which
>   side of the merge should be considered the mainline.  This
>   option specifies the parent number (starting from 1) of
>   the mainline and allows cherry-pick to replay the change
> - relative to the specified parent.
> + relative to the specified parent. The default parent-number is 1.

I somehow sense a total whitespace breakage.  Usually these lines
are HT indented, but I see only a single whitespace indent around
here.

So, the first part of the paragraph needs to get revamped.  It won't
be "because", but "unless", and with your change, you no longer know
which side is mainline---unless you tell Git otherwise, the first
parent is assumed to be the mainline in the new world order.

	-m <parent-number>::
	--mainline <parent-number>::
                When cherry-picking a merge, by default, the first
                parent is taken as the mainline, and the command
                replays the change relative to the first parent of
                the given commit.  If the merge commit you are
                cherry-picking records the mainline as second or
                later parent, you can use this option to replay
                the change relative to the specified parent (parents
                count from 1, which is the first parent).
	+
	The default parent-number is 1.  Giving a parent number
	larger than the number of parent the cherry-picked commit has
	is an error.

or something like that.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index a47b53ceaf..280d1f00a9 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -105,8 +105,8 @@ static int run_sequencer(int argc, const char
> **argv, struct replay_opts *opts)

Line-wrapped patch cannot be applied.

>   OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
>   OPT_NOOP_NOARG('r', NULL),
>   OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
> - OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
> -      N_("select mainline parent"), option_parse_m),
> + { OPTION_INTEGER, 'm', "mainline", &opts->mainline, N_("parent-number"),
> + N_("select mainline parent"), PARSE_OPT_OPTARG, NULL, 1 },

Let's not do optarg.  Use of OPT_INTEGER is fine, if you really want
to, but then you are losing the last caller of option_parse_m() and
the callback function itself must also be removed. 

You'd also need to do a few more things:

#1 make it NONEG, so that we reject "--no-mainline"; in the new
   world order, cherry-picking a non-merge commit is replaying
   against the first parent; there is no situation where use of
   --no-mainline makes sense (perhaps other than cherry-picking the
   initial commit, for which there is no mainline parent).

#2 initialize opts->mainline to 1, so that with no --mainline option
   from the command line, we will still get opt->mainline == 1
   (alternatively, you could initialize opt->mainline == -1 and
   treat opt->mainline <= 0 as if it were set to 1 when the code
   must choose against which parent to replay the changes in a much
   deeper place in the codepath).

#3 think about how you'd loosen option compatibility check around
   --mainline (if you do #2, as opt->mainline would never be 0 now)
   and adjust the verify_opt_compatible() call(s).

#4 as OPT_INTEGER won't ensure that you get a positive integer,
   you'd need to somehow reject --mainline=0 (or --mainline=-1 for
   that matter) given from the command line.
