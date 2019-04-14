Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73C020248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDNVKm (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:10:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43771 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:10:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id c20so8702493qkc.10
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0Ssvwf5ms8WDlBQIxNt5hMYANM7+3W3CKJi61gOEeA=;
        b=bPrq7jAUCAJEfpmjoQY/zYi5k5gif+CETbARgWMVhEmLCBQgOsToD6z5noRVmZ4C7q
         SePhaJZ3Ar7TLVOF+op31TdrauWX6jb3vyJF6PxtU+FK1/2o4GCz/cFB/drzUtSIG/JN
         f8FOP3O6ayeQyNPy4/sfjGl8nnOuGRKpUhIEcrGLQwG1VtBxf1m0YjzXTlQzde9A4R2b
         FAgAv9D1jvO0ihj3nD7sbaqdkspoFmuz0afuUFOKZrS1wsRS76g7PcogNEpmu0MYyl4O
         aoXozUZxVxhuu6WukggDwSYM7Iz5hVnGetHyPUG1Mp1/DS96naYoNhhRb1KoswEx5oVb
         OcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0Ssvwf5ms8WDlBQIxNt5hMYANM7+3W3CKJi61gOEeA=;
        b=BlI1S6hgzvlNsj2UX4V+aATG91oxv+bg27ShXf1O+xwYlEvltpYONwETuCQ+3344y7
         fN2SS9s/w7VnKSy3RWP+obVcqGKyBOWWfG+8WYzw4snwjQsrgKw8Gv+ms6gmnnoZndlw
         EknCGYzCiDVZ3aGtH32dh2Jc3PAKsmC0rpKzKmg0sdc8F9hEA/skjWzXSi9oVhec8a/K
         1G0hYE3slzBzaIj+YcQ90vBJHHXqmki+2PxqomzfKj0ltMLAWqwabjBTEL/E+2EX75hN
         PpCARWwGcW4szshIC8uIsUFfInuojj66623u/JpkIZSK1lnY70lqsqpnG/+SImGorBP8
         GOwQ==
X-Gm-Message-State: APjAAAUneMQ42b+qJG/4Ytb+GyCwRq3yaXj1L7p0bhF9envD8HEC5Gr4
        bd3lUfim9Ic5GwZH7eY9/z8zeO4b43rvtnhD4as=
X-Google-Smtp-Source: APXvYqxzeOuVNJvCsTJ4q0+M9L4EG7Rejc552SrskmAmRao0WyPPEGqkP7YnwSlbn6BfVl+/0l1ZI9vrO9epdb+wHC4=
X-Received: by 2002:a37:4a12:: with SMTP id x18mr52430311qka.184.1555276241822;
 Sun, 14 Apr 2019 14:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162409.117264-1-brho@google.com>
In-Reply-To: <20190410162409.117264-1-brho@google.com>
From:   Michael Platings <michael@platin.gs>
Date:   Sun, 14 Apr 2019 22:10:30 +0100
Message-ID: <CAJDYR9SL9JCJjdARejV=NCf9GYn72=bfszXx84iDc416sZm31A@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     Barret Rhoden <brho@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Barret,

This works pretty well for the typical reformatting use case now. I've
run it over every commit of every .c file in the git project root,
both forwards and backwards with every combination of -w/-M/-C and
can't get it to crash so I think it's good in that respect.

However, it can still attribute lines to the wrong parent line. See
https://pypi.org/project/autopep8/#usage for an example reformatting
that it gets a bit confused on. The patch I submitted handles this
case correctly because it uses information about the more similar
lines to decide how more ambiguous lines should be matched.

You also gave an example of:

        commit-a 11) void new_func_1(void *x, void *y);
        commit-b 12) void new_func_2(void *x, void *y);

Being reformatted to:

        commit-a 11) void new_func_1(void *x,
        commit-b 12)                 void *y);
        commit-b 13) void new_func_2(void *x,
        commit-b 14)                 void *y);

The patch I submitted handles this case correctly, assigning line 12
to commit-a because it scales the parent line numbers according to the
relative diff chunk sizes instead of assuming a 1-1 mapping.

So I do ask that you incorporate more of my patch, including the test
code. It is more complex but I hope this demonstrates that there are
reasons for that. Happy to provide more examples or explanation if it
would help. On the other hand if you have examples where it falls
short then I'd be interested to know.

The other major use case that I'm interested in is renaming. In this
case, the git-hyper-blame approach of mapping line numbers 1-1 works
perfectly. Here's an example. Before:

        commit-a 11) Position MyClass::location(Offset O) {
        commit-b 12)    return P + O;
        commit-c 13) }

After:

        commit-a 11) Position MyClass::location(Offset offset) {
        commit-a 12)    return position + offset;
        commit-c 13) }

With the fuzzy matching, line 12 gets incorrectly matched to parent
line 11 because the similarity of "position" and "offset" outweighs
the similarity of "return". I'm considering adding even more
complexity to my patch such that parts of a line that have already
been matched can't be matched again by other lines.

But the other possibility is that we let the user choose the
heuristic. For a commit where they know that line numbers haven't
changed they could choose 1-1 matching, while for a reformatting
commit they could use fuzzy matching. I welcome your thoughts.

-Michael
