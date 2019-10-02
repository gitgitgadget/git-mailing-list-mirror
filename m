Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FBD1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 14:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfJBOQS (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 10:16:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfJBOQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 10:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ABFDAD17;
        Wed,  2 Oct 2019 14:16:16 +0000 (UTC)
Date:   Wed, 2 Oct 2019 16:16:15 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: git crash in range-diff
Message-ID: <20191002141615.GB17916@kitsune.suse.cz>
References: <20190923101929.GA18205@kitsune.suse.cz>
 <nycvar.QRO.7.76.6.1910021129010.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1910021129010.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 02, 2019 at 11:41:53AM +0200, Johannes Schindelin wrote:
> Hi Michal,
> 
> On Wed, 2 Oct 2019, Michal Suchánek wrote:
> 
> > I get a crash in range-diff. It used to work in the past but I don't use
> > it often so can't really say if this is a regression or a particular
> > data triggering the crash.
> 
> It would always be helpful to add a Minimal, Complete & Verifiable
> Example with your bug reports. If that is too much of a burden ;-) at
> least try to give a Complete & Verifiable Example.

It is not always clear what the minimal and verifiable example is. So I
sent the report in case somebody can see something obviously broken try
to suggest such examples, etc.

> 
> And indeed, when I look at the variable `line`:
> 
> >           ws_rule = 0, lines_added = 0, lines_deleted = 0, score = 0, extension_linenr = 0, is_toplevel_relative = 0, inaccurate_eof = 0,
> >           is_binary = 0, is_copy = 0, is_rename = 0, recount = 0, conflicted_threeway = 0, direct_to_threeway = 0, crlf_in_old = 0,
> >           fragments = 0x0, result = 0x0, resultsize = 0, old_oid_prefix = "c452d7c1308d", '\000' <repeats 52 times>,
> >           new_oid_prefix = "dd7b242a4c00", '\000' <repeats 52 times>, next = 0x0, threeway_stage = {{hash = '\000' <repeats 31 times>}, {
> >               hash = '\000' <repeats 31 times>}, {hash = '\000' <repeats 31 times>}}}
> >         root = {alloc = 0, len = 0, buf = 0x555555a64920 <strbuf_slopbuf> ""}
> >         linenr = 4
> >         p = <optimized out>
> >         cp = {argv = 0x555555a6a390, args = {argv = 0x555555a6a390, argc = 12, alloc = 24}, env_array = {
> >             argv = 0x555555a2f760 <empty_argv>, argc = 0, alloc = 0}, pid = 3068, trace2_child_id = 0, trace2_child_us_start = 0,
> >           trace2_child_class = 0x0, trace2_hook_name = 0x0, in = 0, out = 3, err = 0, dir = 0x0, env = 0x555555a2f760 <empty_argv>,
> >           no_stdin = 1, no_stdout = 0, no_stderr = 0, git_cmd = 1, silent_exec_failure = 0, stdout_to_stderr = 0, use_shell = 0,
> >           clean_on_exit = 0, wait_after_clean = 0, clean_on_exit_handler = 0x0, clean_on_exit_handler_cbdata = 0x0}
> >         buf = {alloc = 6816, len = 5924,
> >           buf = 0x555555a864c0 " ## Metadata ##\nAuthor: Michal Suchanek <msuchanek@suse.de>\n\n ## Commit message ##\n    Refresh sorted section.\n\n    - Refresh patches.suse/powerpc-dump-kernel-log-before-carrying-out-fadump-o.patch wi"...}
> >         contents = {alloc = 947512, len = 679767, buf = 0x7ffff7e69010 "commit 999192044274522b2d5820f40cd1a7436cce31b9"}
> >         util = 0x555555a6a600
> >         in_header = 0
> >         line = 0x7ffff7e6aea0 "diff --git series.conf series.conf\nindex c452d7c1308d..dd7b242a4c00 100644\n--- series.conf\n+++ series.conf\n@@ -47,17 +47,14 @@\n#\t", '#' <repeats 56 times>, "\n#\t# sorted pat"...
>                                             ^^^^^^^^^^^ ^^^^^^^^^^^
> 
> I see that neither old nor new name start with the expected `a/` and
> `b/`, respectively. But that `1` that was passed to
> `parse_git_diff_header()` is the `p_value`, i.e. the number of leading
> directories to strip from the file names.
> 
> And when there is nothing to strip, but it was told to strip something,
> I guess `parse_git_diff_header()` just ignores it and leaves `new_name`
> unassigned.
> 
> So here is how you can chase this down further:
> 
> - Why are those `a/` and `b/` prefixes missing? They should not be
>   missing, they should be generated by default,

Unless you change the default so you get sane filenames (without those
crazy useless prefixes) that you can cut and paste into a text editor. I
even tried to link a and b to . so I can access the files with the
filenames git gives by default but then git fails miserably.

>   and `range-diff` expects
>   them.

So it should set up the configuration so that it gets them.

> 
>   Probably some funny config setting in your setup, something that
>   should probably be explicitly overridden by the `range-diff` machinery
>   when generating those patches that are then fed into `read_patches()`.

So the minimal verifiable example is I suppose

diff.noprefix=true

Thanks

Michal
