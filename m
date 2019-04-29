Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDA31F453
	for <e@80x24.org>; Mon, 29 Apr 2019 14:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfD2Oan (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 10:30:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37131 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfD2Oam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 10:30:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so9329066edw.4
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LmnDb/2L3Sn8af5Uus0+w86PtN72yNg7uySL0ZL+gTI=;
        b=cGQUpc638Fr2F9aa7Qwawx7PgvplERSmC/5Z5Ye92PzPa1bGSQkKUKmjavU294OW8j
         Bv6NkAAGjS8PeOQA0iFXMReT+ZtjAMtLyxqZkemA2jTq3KZuqeQMX142cpdPv/d4hko2
         zJe5kfX8sIDwyN24XDGDAm9xMURTQzoRlP69MXVAHje1r+lHacvN43dFUILDrO7PUIcT
         +f0nN5d6NSGVsJFDWxg/Mjhk1QHtd5dJAMFJWnxOJoHxYAe7USIhM2lvey55vRYtwLbF
         qHhrjvnaMbcRDTGFzQoXpdslzeMpNCorXpoLfilcCElZ6ddsIyWa3vzcht82iIz9VCvw
         PyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LmnDb/2L3Sn8af5Uus0+w86PtN72yNg7uySL0ZL+gTI=;
        b=tiCnPMvBQ7Z2lkCUJ9r33v3nud+bHKy6yO3TbVixyQRD3Kyd1UxBqtyHwOVom8Ny8U
         iKz2ooHEYstpBmGIJRh01Nd34SPkcFKfa8jeUV6lEaptLiCUgZgKd0AF5XpL73Jy5spt
         9Cc3qQI7bpeHAfDb/MM4pnQDrX9hSv2lM80ExBBMcXPrtjcWaGLBa9tvCtbnJ03HRO4d
         /iQyaoIvjQCPOB+Qqgdyd33rMnqo9xeXcgxe7SdoUwWJxbdDj0edzeXneJmVmgNe3cFO
         DP9AOsNwYXpAdb5myAmTMwQmpuE4d1BUkXFEerdze3uA3phrCIWiKrkFkBFyNZ11zlKJ
         /bdA==
X-Gm-Message-State: APjAAAVl7esOy3zZEB/Eh6WKYVWF3avMlwoG67DgRTkTpjKNCVldj78w
        fY+vdI5GlJjKCowmAFs69qjpcew0
X-Google-Smtp-Source: APXvYqxVxFybyLNk/47cadx2OEGSHRKEpIwt4V4e+WwOmVHR74Q8ZSSD9YBoBzJB/VlRRoTGa9TFBQ==
X-Received: by 2002:a50:d2d8:: with SMTP id q24mr38622215edg.129.1556548240135;
        Mon, 29 Apr 2019 07:30:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m7sm179210edd.64.2019.04.29.07.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 07:30:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/8] commit-graph: don't early exit(1) on e.g. "git status"
References: <20190314214740.23360-1-avarab@gmail.com> <20190325120834.15529-5-avarab@gmail.com> <87y33vr41k.fsf@evledraar.gmail.com> <3518ad3e-bc4a-c2c3-d4bd-c87f9e828b1c@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <3518ad3e-bc4a-c2c3-d4bd-c87f9e828b1c@gmail.com>
Date:   Mon, 29 Apr 2019 16:30:38 +0200
Message-ID: <87wojcrii9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 29 2019, Derrick Stolee wrote:

> On 4/27/2019 9:06 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> There's still cases left where we'll exit early, e.g. if you do:
>>
>>     $ git diff -U1
>>     diff --git a/commit-graph.c b/commit-graph.c
>>     index 66865acbd7..63773764ce 100644
>>     --- a/commit-graph.c
>>     +++ b/commit-graph.c
>>     @@ -1074,3 +1074,3 @@ void write_commit_graph(const char *obj_dir,
>>             chunk_offsets[1] =3D chunk_offsets[0] + GRAPH_FANOUT_SIZE;
>>     -       chunk_offsets[2] =3D chunk_offsets[1] + hashsz * commits.nr;
>>     +       chunk_offsets[2] =3D chunk_offsets[0] + hashsz * commits.nr;
>>             chunk_offsets[3] =3D chunk_offsets[2] + (hashsz + 16) * comm=
its.nr;
>>
>> Which is obviously bad, but something I encounterd while hacking up [1]
>> we'll still hard die as before this patch on:
>>
>>     $ git status
>>     fatal: invalid parent position 1734910766
>>     $
>
> I really appreciate you digging in deep into these kinds of issues. You
> seem to be hitting corrupted commit-graph files more often than we are
> (in VFS for Git world).

FWIW I've never encountered any of these in the wild. I just started
poking at this in 2ac138d568 ("commit-graph: fix segfault on e.g. "git
status"", 2019-03-25) because I was looking at the commit graph, running
its tests with -d, and we'd segfault previously on e.g. "git status" in
our own graph corruption tests.

> However, we should be _very careful_ when turning some of these errors
> to warnings. At the very least, we should do some high-level planning
> for how to handle this case.

Indeed. I should have been explicit, I don't think it's sane to do
anything except return NULL up the stack and say "the graph is screwed,
we can't use it" when initially parsing it/headers, but reading on...

> The biggest issue is that we have some logic that is run after a call to
> generation_numbers_enabled(), such as the `git rev-list --topo-order`
> logic, that relies on the commit-graph for correctness. If we output a
> warning and then stop using the commit-graph, then we will start having
> commits with finite generation pointing to commits with infinite generati=
on.
>
> Perhaps, with some care, we can alert the algorithm to change the "minimum
> generation" that limits how far we dequeue the priority-queue. Changing it
> to zero will cause the algorithm to behave like the old algorithm.
>
> But, having an algorithm that usually takes 0.1 seconds suddenly take 10+
> seconds also violates some expectations.
>
> Q: How should we handle a detectably-invalid commit-graph?

...I don't think we need to do any paranoid algorithm fallback in
general. As you point out that's going to be a PITA as we read the
actual data in the graph in some cases.

> I think most of your patches have done a good job so far of detecting
> an invalid header, and responding by ignoring the commit-graph. This case
> of a detectable error in the chunk data itself is not something we can
> check on the first load without serious performance issues.
>
> I hope we can decide on a good solution.

...OK, so this is one of those PITA cases. I think it's fine to just
leave it.

Although maybe we'd still want to be more paranoid with O(n) cases like
"--contains" or "--topo-order" and cases that are surely just "look up
my immediate commit data", like "status" dying on this particular error.

But I think it's fine to just decide to nothing about this. I mainly
just wanted to make a note to myself & CC the list in case there was
interest...
