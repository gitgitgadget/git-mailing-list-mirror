Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DC91FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 14:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbcK1OJp (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 09:09:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:61084 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932253AbcK1OJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 09:09:43 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqm3a-1cgpUp10J0-00eI6P; Mon, 28
 Nov 2016 15:09:37 +0100
Date:   Mon, 28 Nov 2016 15:09:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Luis Ressel <aranea@aixah.de>
cc:     git@vger.kernel.org
Subject: Re: [feature request] Make "commit --only" work with new files
In-Reply-To: <20161125175619.19e13e59@gentp.lnet>
Message-ID: <alpine.DEB.2.20.1611281505270.117539@virtualbox>
References: <20161125175619.19e13e59@gentp.lnet>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:osm4JgQvRgt9SXlJGR2D02J3rZJl81rKAjrDvPTI82YukPlz1Af
 1slYSeI6Q1o0zTilwz1xULZqK65gRSiUu0H1essdev3/qEt/lQdNrGzwlRaPW5frH7Vx+K/
 ioLseFEajtfT+QH7vAUS7By4HsTSQMt6EPPXIYllUhcmvUh0e3sarbvXTgXOt41regLNxjK
 2OnC/xV4Ki68E28A+m/Fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iG6u5n2TCV8=:AYqvAvkWNmMPkt8kIGW7Fa
 Q+P8dplEObT4ztSD6CflvGuvItm7DUJwjopBSHxGcef2OGodpeDD3UQrco5vtfqUIRCBxCE0W
 bUGvkpi/qS/xth9UA25rraiPuHciISP7eqcXOSS8L+EVHvohGkPmr41LtYptC7Wb0Bb8yyJhV
 FE0WH8AiDb1naKY7V0m8Xr9ik+bwOvUqhjEoNvHYp8z0wrPxewuTz7cRUQ3pph8jV4SCiKbZD
 7IaF6l07SvTBqj8+KAjZixcvwM4Z2GRMrxPmfw/vYTxZSNS1ffWt8tjCU3vysbahYjrFqMVqm
 Gg/z7tUaUkHOdKUFjU6ns735T/IuD2LF97wGKUBFRf9u8wLKSQC0qajq/9tuhCjDIEzs6Yj5C
 DWt1dT9gsOvu+Gr3ANjojhb7OoZq4+6N8lfcalqaKXxZmIgzogvACooB8OsBWvzSopvhL9m1y
 0jL3FfBKuP8SJovmeX4Nho5M5m4D783QttFrGVW4NVUPFsPwhAiY3VCIWAnUx37dhaBxVFzjm
 EbHrj+qziEPOjOF+9z2GKZAPPG469QA2UvUcKG5NXMJNrkSRpcp0LibotXTEi7MDSM7LioyYx
 WYUT+h/1RDZ8xcS5JCEzmY3uxzjDR3/YIaDU0YMOjeB7AZG5+o1CKpVcUYqjxhcLXFU7deX6f
 VyP7c3tcnLqFY1lPNRqVRmDJ4+lT0t3/xkygwTnOOYf/S5pjiJZ5K5CoVFVQNTMbwM7nrpHwX
 y4Msh/zQsJdXYa9va/YWjMHH/Mpvc9BRGeGIVRNwxUVNibTEhzypfSAfSmrhiH4gOThA2XsxH
 dhYKPHM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luis,

On Fri, 25 Nov 2016, Luis Ressel wrote:

> currently "git commit --only <file>" only works if <file> is already
> checked into the repo, but not with newly created and still untracked
> files (builtin/commit.c:list_path() throws the error "error: pathspec
> '<file>' did not match any file(s) known to git.")
> 
> I don't think this limitation is intented. I've had a look at the
> relevant part of builtin/commit.c, but unfortunately it wasn't obvious
> to me how to fix this.

The best way to go about it is probably to define the desired behavior
first, in the form of a patch to the test suite. Personally, I would
extend t/t7509-commit.sh with a new test case.

Then, once you have that test case (that should be marked with
test_expect_failure, because it fails for now), you can use a debugger
such as gdb to single-step into the relevant function (I guess
"prepare_index()" is a good candidate) to find out why the files are not
added.

From there, it should be easier to figure out what to patch, and how.

Good hunting!
Johannes
