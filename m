Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A81B1FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 22:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdGRWoV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 18:44:21 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36546 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdGRWoU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 18:44:20 -0400
Received: by mail-pg0-f53.google.com with SMTP id u5so20024013pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GLGwMmwRB0AKmXWytG8a56oYTKxLRvbUyPOC3SDgIxU=;
        b=k53kM+ybSm7RwELoKE9gW9nX2tp1QDkjQT5+ixkx56JvnKd3h2Nq+9COG1yxHAh6Cn
         Hw1nd4J7IWqoH9nH3CrdR1RFWIEiPSTvSPoDqTkUOJP9SRzXzZTtz29ZDCJbpewDXwnG
         BpU+URIfsDZ4uaPSoutWKcBXePUyEcVsNffMeNKFmzBJErbOzThvKPGLmhnEBt2EhHhR
         gyVOlAlKZeZ31u41LK0tVccJvcN+9ZZF7Kzu/EY+AW3iMjNlPtxeJRULenbrYolAUiq8
         wXK4ELCARq5xj+AkiEB577n0ez4wPJ6TvCWgs+yyCpZ5KIA1BXLe9XpLjb+jP9C9hrUJ
         LKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GLGwMmwRB0AKmXWytG8a56oYTKxLRvbUyPOC3SDgIxU=;
        b=mTMVv1yLMb5AtGhGKIjMxu2aGO1FYxkOy0av4W+AYPbJ5dPrcxHzChsSurGJeDu9Vz
         8A1BuS/Wmsx+G1gWLimhawI8TTq6tgHRw2EpeNLfwm+JgfMbt+Yl9PQenIYf7KPjhlhE
         11yQI43dGoaEqkUAlYOTcGc8P6j+tSXOb2DneqKJPd6ig2DHTqpahG9YEuuWzC4oo/Pj
         z+9057YWDxtETJCSP8aJd46UBuD42t5kNlN6+B88+RTHOHMnVgGgaO2+loE2ncNG3qG9
         U6wjRcQs1PtNcbObH/ZAZMh5qNwzuHgMdDnZd2IyAM0HH013vAImX87eaZ4epb3BFDph
         8T5g==
X-Gm-Message-State: AIVw113lbz5ISv6vnlzy9pw+4nModyk54KcazcgCVpT9vpyUe+otBDch
        0Vu3MsouBezuD+Nvm0Sr+XB4fIELNuB9x6pMMQ==
X-Received: by 10.101.76.206 with SMTP id n14mr4013295pgt.154.1500417859455;
 Tue, 18 Jul 2017 15:44:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 15:44:18 -0700 (PDT)
In-Reply-To: <xmqqmv81ml4i.fsf@gitster.mtv.corp.google.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-5-pc44800@gmail.com>
 <CAGZ79kb48kNggPv64ubbBNK-Sk8AW4eXxhZt=PZZCPKr9OiuLQ@mail.gmail.com> <xmqqmv81ml4i.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 15:44:18 -0700
Message-ID: <CAGZ79kYDD076Xbrh19nTPd4DiTsGvO0Zm=P8W-Zv1GFvp9XQOg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 4/8] submodule: port submodule subcommand 'status'
 from shell to C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> +       if (!lstat(list_item->name, &st) && !ce_match_stat(list_item, &st, 0)) {
>>> +               print_status(info, ' ', list_item->name, sub_sha1, displaypath);
>>
>> The question from the last round still stands
>> https://public-inbox.org/git/CAGZ79kb18z5zc9iu3Vv5aVZWJmoZzmwbMVpy89VC-t-ei2M+bw@mail.gmail.com/
>>
>>   I am not an expert in the diff area  and wonder how
>>   the cmd_diff_files functionality is achieved with just a stat call
>>   and then comparing it to  ce_match_stat. 'Using "dirty" ignores
>>   all changes to the work tree of submodules, only changes to the
>>   commits stored in the superproject are shown.' So I'd have
>>   expected ce->oid to be compared (is there an index entry differing,
>>   i.e. more than one stage?)
>
> ce_match_stat() calls into ce_compare_gitlink() for a 160000 entry,
> which would resolve HEAD ref there and compares ce->oid with it.

Oh in that case this should be fine, as in the original we did
"git diff-files --ignore-submodules=dirty <path>",
which did precisely that.

> But as you said, this is probably insufficient to emulate the
> original.  Shouldn't it call into run_diff_files(), which is the
> in-core way to run the equivalent of "diff-files"?

Oh, your comment in [1] was related to cmd_diff_files,
which is more complicated than run_diff_files?
run_diff_files also iterates over all cache entries.
I think we need to be looking at match_stat_with_submodule
to figure out what we need to do.

[1] https://public-inbox.org/git/xmqq60fdoyyt.fsf@gitster.mtv.corp.google.com/
