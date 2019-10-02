Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D27B1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 08:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfJBIVm convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 Oct 2019 04:21:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfJBIVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 04:21:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2D2EAE3A
        for <git@vger.kernel.org>; Wed,  2 Oct 2019 08:21:38 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:21:37 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: git crash in range-diff
Message-ID: <20190923101929.GA18205@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I get a crash in range-diff. It used to work in the past but I don't use
it often so can't really say if this is a regression or a particular
data triggering the crash.

It is not 100% broken - it woks on some other ranges.

Thanks

Michal


Script started on 2019-09-23 12:15:54+0200
[0;32m✔[0;0m [0;33m~/kernel-source[0;0m [[0;35mSLE15-SP2[0;0m ↑·82[0;0m|[0;36m…17791[0;0m[1;34m⚑ 9[0;0m[0;0m] 
[0;37m12:15[0;0m $ gdb --args git range-diff 76ac02e3549..cd5f86d59a73 76ac02e3549..3b77e5866178
GNU gdb (GDB; openSUSE Leap 15.0) 8.2
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-suse-linux".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://bugs.opensuse.org/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from git...Reading symbols from /usr/lib/debug/usr/lib/git/git-2.23.0-lp150.2.2.x86_64.debug...done.
done.
(gdb) r
Starting program: /usr/bin/git range-diff 76ac02e3549..cd5f86d59a73 76ac02e3549..3b77e5866178
Missing separate debuginfo for /usr/lib64/libpcre2-8.so.0
Try: zypper install -C "debuginfo(build-id)=fc416d8eaba5b7885c5042011cee1dc1ce3e5b10"
Missing separate debuginfo for /lib64/libz.so.1
Try: zypper install -C "debuginfo(build-id)=e7ce95ccdb1c6c047ea33e32c0ae3a2f12b6d00e"
Missing separate debuginfo for /usr/lib64/libsha1detectcoll.so.1
Try: zypper install -C "debuginfo(build-id)=c64e737e69cc4b1498976d7d56c8962715199280"
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 3067]
[Detaching after fork from child process 3068]
[?1049h[22;0;0t[?1h=
Program received signal SIGSEGV, Segmentation fault.
__strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:62
62		VPCMPEQ (%rdi), %ymm0, %ymm1
(gdb) bt full
#0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:62
No locals.
#1  0x00005555556cf00f in strbuf_addstr (s=<optimized out>, sb=0x7fffffffd2d0) at strbuf.h:292
No locals.
#2  read_patches (range=range@entry=0x555555a69340 "76ac02e3549..cd5f86d59a73", list=list@entry=0x7fffffffd640) at range-diff.c:126
        patch = {new_name = 0x0, old_name = 0x0, def_name = 0x0, old_mode = 33188, new_mode = 0, is_new = 0, is_delete = 0, rejected = 0, 
          ws_rule = 0, lines_added = 0, lines_deleted = 0, score = 0, extension_linenr = 0, is_toplevel_relative = 0, inaccurate_eof = 0, 
          is_binary = 0, is_copy = 0, is_rename = 0, recount = 0, conflicted_threeway = 0, direct_to_threeway = 0, crlf_in_old = 0, 
          fragments = 0x0, result = 0x0, resultsize = 0, old_oid_prefix = "c452d7c1308d", '\000' <repeats 52 times>, 
          new_oid_prefix = "dd7b242a4c00", '\000' <repeats 52 times>, next = 0x0, threeway_stage = {{hash = '\000' <repeats 31 times>}, {
              hash = '\000' <repeats 31 times>}, {hash = '\000' <repeats 31 times>}}}
        root = {alloc = 0, len = 0, buf = 0x555555a64920 <strbuf_slopbuf> ""}
        linenr = 4
        p = <optimized out>
        cp = {argv = 0x555555a6a390, args = {argv = 0x555555a6a390, argc = 12, alloc = 24}, env_array = {
            argv = 0x555555a2f760 <empty_argv>, argc = 0, alloc = 0}, pid = 3068, trace2_child_id = 0, trace2_child_us_start = 0, 
          trace2_child_class = 0x0, trace2_hook_name = 0x0, in = 0, out = 3, err = 0, dir = 0x0, env = 0x555555a2f760 <empty_argv>, 
          no_stdin = 1, no_stdout = 0, no_stderr = 0, git_cmd = 1, silent_exec_failure = 0, stdout_to_stderr = 0, use_shell = 0, 
          clean_on_exit = 0, wait_after_clean = 0, clean_on_exit_handler = 0x0, clean_on_exit_handler_cbdata = 0x0}
        buf = {alloc = 6816, len = 5924, 
          buf = 0x555555a864c0 " ## Metadata ##\nAuthor: Michal Suchanek <msuchanek@suse.de>\n\n ## Commit message ##\n    Refresh sorted section.\n\n    - Refresh patches.suse/powerpc-dump-kernel-log-before-carrying-out-fadump-o.patch wi"...}
        contents = {alloc = 947512, len = 679767, buf = 0x7ffff7e69010 "commit 999192044274522b2d5820f40cd1a7436cce31b9"}
        util = 0x555555a6a600
        in_header = 0
        line = 0x7ffff7e6aea0 "diff --git series.conf series.conf\nindex c452d7c1308d..dd7b242a4c00 100644\n--- series.conf\n+++ series.conf\n@@ -47,17 +47,14 @@\n#\t", '#' <repeats 56 times>, "\n#\t# sorted pat"...
        current_filename = 0x555555a6b010 "scsi-cxlflash-Mark-expected-switch-fall-throughs.patch"
        offset = <optimized out>
        len = 107
        size = 671943
#3  0x00005555556cf304 in show_range_diff (range1=0x555555a69340 "76ac02e3549..cd5f86d59a73", 
    range2=0x555555a6a360 "76ac02e3549..3b77e5866178", creation_factor=60, dual_color=1, diffopt=diffopt@entry=0x7fffffffda60)
    at range-diff.c:505
        res = 0
        branch1 = {items = 0x0, nr = 0, alloc = 0, strdup_strings = 1, cmp = 0x0}
--Type <RET> for more, q to quit, c to continue without paging--c
        branch2 = {items = 0x0, nr = 0, alloc = 0, strdup_strings = 1, cmp = 0x0}
#4  0x00005555555de7c8 in cmd_range_diff (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/range-diff.c:80
        creation_factor = 60
        diffopt = {orderfile = 0x0, pickaxe = 0x0, single_follow = 0x0, a_prefix = 0x5555557b3780 "", b_prefix = 0x5555557b3780 "", line_prefix = 0x0, line_prefix_length = 0, flags = {recursive = 0, tree_in_recursive = 0, binary = 0, text = 0, full_index = 0, silent_on_remove = 0, find_copies_harder = 0, follow_renames = 0, rename_empty = 1, has_changes = 0, quick = 0, no_index = 0, allow_external = 0, exit_with_status = 0, reverse_diff = 0, check_failed = 0, relative_name = 0, ignore_submodules = 0, dirstat_cumulative = 0, dirstat_by_file = 0, allow_textconv = 0, textconv_set_via_cmdline = 0, diff_from_contents = 0, dirty_submodules = 0, ignore_untracked_in_submodules = 0, ignore_dirty_submodules = 0, override_submodule_config = 0, dirstat_by_line = 0, funccontext = 0, default_follow_renames = 0, stat_with_summary = 0, suppress_diff_headers = 0, dual_color_diffed_diffs = 0, suppress_hunk_header_line_count = 0}, filter = 0, use_color = -1, context = 3, interhunkcontext = 0, break_opt = -1, detect_rename = 0, irreversible_delete = 0, skip_stat_unmatch = 0, line_termination = 10, output_format = 0, pickaxe_opts = 0, rename_score = 0, rename_limit = -1, needed_rename_limit = 0, degraded_cc_to_c = 0, show_rename_progress = 0, dirstat_permille = 30, setup = 0, abbrev = 12, ita_invisible_in_index = 0, ws_error_highlight = 4096, prefix = 0x0, prefix_length = 0, stat_sep = 0x0, xdl_opts = 8388608, anchors = 0x0, anchors_nr = 0, anchors_alloc = 0, stat_width = 0, stat_name_width = 0, stat_graph_width = 0, stat_count = 0, word_regex = 0x0, word_diff = DIFF_WORDS_NONE, submodule_format = DIFF_SUBMODULE_SHORT, objfind = 0x0, found_changes = 0, found_follow = 0, set_default = 0x0, file = 0x7ffff7309720 <_IO_2_1_stdout_>, close_file = 0, output_indicators = "+- ", pathspec = {nr = 0, has_wildcard = 0, recursive = 0, recurse_submodules = 0, magic = 0, max_depth = 0, items = 0x0}, pathchange = 0x0, change = 0x55555566a3a0 <diff_change>, add_remove = 0x55555566a8b0 <diff_addremove>, change_fn_data = 0x0, format_callback = 0x0, format_callback_data = 0x0, output_prefix = 0x0, output_prefix_data = 0x0, diff_path_counter = 0, emitted_symbols = 0x0, color_moved = COLOR_MOVED_NO, color_moved_ws_handling = 0, repo = 0x555555a53b20 <the_repo>, parseopts = 0x0}
        simple_color = -1
        range_diff_options = {{type = OPTION_INTEGER, short_name = 0, long_name = 0x555555785379 "creation-factor", value = 0x7fffffffd928, argh = 0x555555786937 "n", help = 0x55555578d0c0 "Percentage by which creation is weighted", flags = 0, callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x55555578d05c "no-dual-color", value = 0x7fffffffd92c, argh = 0x0, help = 0x55555578d06a "use simple diff colors", flags = 2, callback = 0x0, defval = 1, ll_callback = 0x0, extra = 0}, {type = OPTION_END, short_name = 0, long_name = 0x0, value = 0x0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0}}
        options = 0x0
        res = 0
        range1 = {alloc = 26, len = 25, buf = 0x555555a69340 "76ac02e3549..cd5f86d59a73"}
        range2 = {alloc = 26, len = 25, buf = 0x555555a6a360 "76ac02e3549..3b77e5866178"}
#5  0x000055555557146d in run_builtin (argv=<optimized out>, argc=<optimized out>, p=<optimized out>) at git.c:445
        status = <optimized out>
        help = <optimized out>
        st = {st_dev = 93824997553696, st_ino = 140737336887026, st_nlink = 140737488347232, st_mode = 114, st_uid = 0, st_gid = 1436972576, __pad0 = 21845, st_rdev = 5522724075126890240, st_size = 93824997553824, st_blksize = 93824997553696, st_blocks = 140737488346480, st_atim = {tv_sec = 140737488350949, tv_nsec = 140737488347232}, st_mtim = {tv_sec = 93824997324640, tv_nsec = 140737488346640}, st_ctim = {tv_sec = 140737337196512, tv_nsec = 140737488346480}, __glibc_reserved = {93824994140141, 93824997552896, 93824993439848}}
        prefix = <optimized out>
        status = <optimized out>
        help = <optimized out>
        st = <optimized out>
        prefix = <optimized out>
        nongit_ok = <optimized out>
#6  handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:674
        args = {argv = 0x555555a2f760 <empty_argv>, argc = 0, alloc = 0}
        cmd = <optimized out>
        builtin = 0x555555a13f70 <commands+1968>
#7  0x0000555555572575 in run_argv (argv=0x7fffffffddd0, argcp=0x7fffffffdddc) at git.c:741
        done_alias = 0
        cmd_list = {items = 0x0, nr = 0, alloc = 0, strdup_strings = 0, cmp = 0x0}
        seen = <optimized out>
        done_alias = <optimized out>
        cmd_list = <optimized out>
        seen = <optimized out>
        args = <optimized out>
        i = <optimized out>
        i = <optimized out>
        sb = <optimized out>
        item = <optimized out>
#8  cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:872
        was_alias = <optimized out>
        cmd = 0x7fffffffe488 "range-diff"
        done_help = <optimized out>
#9  0x00005555555710a8 in main (argc=4, argv=0x7fffffffe068) at common-main.c:52
        result = <optimized out>
(gdb) l
57		andl	$(2 * VEC_SIZE - 1), %ecx
58		cmpl	$VEC_SIZE, %ecx
59		ja	L(cros_page_boundary)
60	
61		/* Check the first VEC_SIZE bytes.  */
62		VPCMPEQ (%rdi), %ymm0, %ymm1
63		vpmovmskb %ymm1, %eax
64		testl	%eax, %eax
65	
66	# ifdef USE_AS_STRNLEN
(gdb) quit
A debugging session is active.

	Inferior 1 [process 3063] will be killed.

Quit anyway? (y or n) y
[K[7mlines ?-?/? (END)[27m[K[K[?1l>[?1049l[23;0;0t[0;32m✔[0;0m [0;33m~/kernel-source[0;0m [[0;35mSLE15-SP2[0;0m ↑·82[0;0m|[0;36m…17791[0;0m[1;34m⚑ 9[0;0m[0;0m] 
[0;37m12:16[0;0m $ gdb --args git range-diff 76ac02e3549..cd5f86d59a73 76ac02e3549..3b77e5866178[C[C[C[C[C[C[C[Cldd `which git`[K
	linux-vdso.so.1 (0x00007ffe55bfd000)
	libpcre2-8.so.0 => /usr/lib64/libpcre2-8.so.0 (0x00007f125f849000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f125f632000)
	libsha1detectcoll.so.1 => /usr/lib64/libsha1detectcoll.so.1 (0x00007f125f428000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f125f20a000)
	librt.so.1 => /lib64/librt.so.1 (0x00007f125f002000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f125ec48000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f125ffdc000)
[0;32m✔[0;0m [0;33m~/kernel-source[0;0m [[0;35mSLE15-SP2[0;0m ↑·82[0;0m|[0;36m…17791[0;0m[1;34m⚑ 9[0;0m[0;0m] 
[0;37m12:16[0;0m $ exit

Script done on 2019-09-23 12:16:17+0200
