From: Dilyan Palauzov <dilyan.palauzov@aegee.org>
Subject: git 2.2.2 annotate crash (strbuf.c:32)
Date: Sun, 08 Feb 2015 22:33:40 +0100
Message-ID: <54D7D634.2050807@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 22:52:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKZlt-0001PU-EG
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 22:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbbBHVv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 16:51:59 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:59547 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbBHVv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 16:51:56 -0500
X-Greylist: delayed 1091 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 16:51:56 EST
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YKZU5-0002y7-Sh; Sun, 08 Feb 2015 22:33:41 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t18LXfJj010456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1423431222; i=dkim+MSA-tls@aegee.org;
	bh=amgeLaW/Q7ffxdeKULI1eFJuIZjcszov0VN+23Sj5E8=;
	h=Date:From:To:Subject;
	b=EepDDwNWarO0Eb5lV+FQ5XXVNvBAgeNTLALxThUIrHNwqxr/C+yKlKssqKya31s1+
	 L0Cxf2bQ6UbOprLeLqeB3PiUeN96sRYasvBeywi+/OUf8NcVjcO2L1ZQsN4mO1MYrw
	 e5e32yFU3gx78KJZPZ13d0LnM4MZv9+yHz32kqWMjH9pSwNswlzCy/ZDvO+ZpLK+1Y
	 7nyIs/r4cietSFW9pHPeJJ1xezh8dApRKjFjFvqE1Vps606Js5oCH4smNxh5gdGhod
	 9IdK4RVPKw2PMKw3aFcvZ2ty21Ti067lnMXE12CLCock3NOm5BTSZ4OfBs/hEOQVOu
	 wCKF9IU+kfUQb9XXESWIUQIcud/wZuZHLhB+hgkmAaw9JEuswsIfIall/qml7yXNf2
	 I9ngRjOa4EabcxxenVHkv+3rgqH69rKkddxE1kE17OPgzzFiRxu6+X31/h7yeg4Z+H
	 ptimosrcGwwUuhcxWFhWv3zLLDpJ5Kn12eWNFudo+0ffUrOe31gfqsq5e7TD2EAhOP
	 +mh0JZvxnLFi6T+JV3Xun227bLq90qN0q2VSw+PBZvZCbTUH7cE0qWTiCIb626Lhyo
	 xSlCicY0VGJSFX52D7fPPbrUagkqtLFfNPXpHpQzmdAjbqnaO9a70dGsxwEBdn8EoU
	 rNxrxC2rvR87sOjK 
Received: from [192.168.0.2] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.14.5) with ESMTPSA id t18LXfJj010456
	(version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 8 Feb 2015 21:33:42 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263534>

Hello,

I use git 2.2.2 and on my system git annotate crashed with the following 
log.

Kind regards
   Dilyan

(gdb) bt full
#0  0x00007fe420649655 in raise () from /lib64/libc.so.6
No symbol table info available.
#1  0x00007fe42064aad8 in abort () from /lib64/libc.so.6
No symbol table info available.
#2  0x00007fe42068928b in __libc_message () from /lib64/libc.so.6
No symbol table info available.
#3  0x00007fe42068ee36 in malloc_printerr () from /lib64/libc.so.6
No symbol table info available.
#4  0x00007fe42068fbb3 in _int_free () from /lib64/libc.so.6
No symbol table info available.
#5  0x000000000041335a in strbuf_release (sb=0x7fff44797480) at strbuf.c:32
         sb = 0x7fff44797480
#6  commit_info_destroy (ci=0x7fff447973e0) at builtin/blame.c:1646
No locals.
#7  find_alignment (option=0x7e8220 <output_option>, sb=0x7fff447972f0) 
at builtin/blame.c:2117
         suspect = 0xd71230
         ci = {
           author = {
             alloc = 0,
             len = 0,
             buf = 0x810540 <strbuf_slopbuf> ""
           },
           author_mail = {
             alloc = 0,
             len = 0,
             buf = 0x810540 <strbuf_slopbuf> ""
           },
           author_time = 959115099,
           author_tz = {
             alloc = 0,
             len = 0,
             buf = 0x810540 <strbuf_slopbuf> ""
           },
           committer = {
             alloc = 0,
             len = 0,
             buf = 0x810540 <strbuf_slopbuf> ""
           },
           committer_mail = {
             alloc = 0,
             len = 0,
             buf = 0x810540 <strbuf_slopbuf> ""
           },
           committer_time = 959115099,
           committer_tz = {
             alloc = 0,
             len = 0,
             buf = 0x810540 <strbuf_slopbuf> ""
           },
           summary = {
             alloc = 26,
             len = 25,
             buf = 0xe05b50 <incomplete sequence \330>
           }
         }
         num = <optimized out>
         longest_src_lines = 13
         largest_score = 175
         e = 0xd45c80
         longest_dst_lines = 12
         compute_auto_abbrev = 1
         auto_abbrev = 7
#8  cmd_blame (argc=<optimized out>, argv=<optimized out>, 
prefix=prefix@entry=0x0) at builtin/blame.c:2797
         revs = {
           commits = 0xd222a0,
           pending = {
             nr = 0,
             alloc = 0,
             objects = 0x0
           },
           boundary_commits = {
             nr = 0,
             alloc = 0,
             objects = 0x0
           },
           cmdline = {
             nr = 0,
             alloc = 0,
             rev = 0x0
           },
           ref_excludes = 0x0,
           prefix = 0x0,
           def = 0x0,
           prune_data = {
             _raw = 0x0,
             nr = 0,
             has_wildcard = 0,
             recursive = 0,
             magic = 0,
             max_depth = 0,
             items = 0x0
           },
           sort_order = REV_SORT_IN_GRAPH_ORDER,
           early_output = 0,
           ignore_missing = 0,
           ignore_missing_links = 0,
           dense = 1,
           prune = 0,
           no_walk = 0,
           show_all = 0,
           remove_empty_trees = 0,
           simplify_history = 1,
           topo_order = 0,
           simplify_merges = 0,
           simplify_by_decoration = 0,
           tag_objects = 0,
           tree_objects = 0,
           blob_objects = 0,
           verify_objects = 0,
           edge_hint = 0,
           limited = 0,
           unpacked = 0,
           boundary = 0,
           count = 0,
           left_right = 0,
           left_only = 0,
           right_only = 0,
           rewrite_parents = 0,
           print_parents = 0,
           show_source = 0,
           show_decorations = 0,
           reverse = 0,
           reverse_output_stage = 0,
           cherry_pick = 0,
           cherry_mark = 0,
           bisect = 0,
           ancestry_path = 0,
           first_parent_only = 0,
           line_level_traverse = 0,
           diff = 0,
           full_diff = 0,
           show_root_diff = 0,
           no_commit_id = 0,
           verbose_header = 0,
           ignore_merges = 1,
           combine_merges = 0,
           dense_combined_merges = 0,
           always_show_header = 0,
           shown_one = 0,
           shown_dashes = 0,
           show_merge = 0,
           show_notes = 0,
           show_notes_given = 0,
           show_signature = 0,
           pretty_given = 0,
           abbrev_commit = 0,
           abbrev_commit_given = 0,
           use_terminator = 0,
           missing_newline = 0,
           date_mode_explicit = 0,
           preserve_subject = 0,
           disable_stdin = 1,
           leak_pending = 0,
           track_linear = 0,
           track_first_time = 0,
           linear = 0,
           date_mode = DATE_ISO8601,
           abbrev = 7,
           commit_format = CMIT_FMT_MEDIUM,
           loginfo = 0x0,
           nr = 0,
           total = 0,
           mime_boundary = 0x0,
           patch_suffix = 0x0,
           numbered_files = 0,
           reroll_count = 0,
           message_id = 0x0,
           from_ident = {
             name_begin = 0x0,
             name_end = 0x0,
             mail_begin = 0x0,
             mail_end = 0x0,
             date_begin = 0x0,
             date_end = 0x0,
             tz_begin = 0x0,
             tz_end = 0x0
           },
           ref_message_ids = 0x0,
           add_signoff = 0,
           extra_headers = 0x0,
           log_reencode = 0x0,
           subject_prefix = 0x0,
           no_inline = 0,
           show_log_size = 0,
           mailmap = 0x0,
           grep_filter = {
             pattern_list = 0x0,
             pattern_tail = 0x7fff44797918,
             header_list = 0x0,
             header_tail = 0x7fff44797928,
             pattern_expression = 0x0,
             prefix = 0x0,
             prefix_length = 0,
             regexp = {
               buffer = 0x0,
               allocated = 0,
               used = 0,
               syntax = 0,
               fastmap = 0x0,
               translate = 0x0,
               re_nsub = 0,
               can_be_null = 0,
               regs_allocated = 0,
               fastmap_accurate = 0,
               no_sub = 0,
               not_bol = 0,
               not_eol = 0,
               newline_anchor = 0
             },
             linenum = 0,
             invert = 0,
             ignore_case = 0,
             status_only = 1,
             name_only = 0,
             unmatch_name_only = 0,
             count = 0,
             word_regexp = 0,
             fixed = 0,
             all_match = 0,
             debug = 0,
             binary = 0,
             allow_textconv = 0,
             extended = 0,
             use_reflog_filter = 0,
             pcre = 0,
             relative = 1,
             pathname = 1,
             null_following_name = 0,
             color = -1,
             max_depth = -1,
             funcname = 0,
             funcbody = 0,
             extended_regexp_option = 0,
             pattern_type_option = 0,
             color_context = '\000' <repeats 39 times>,
             color_filename = '\000' <repeats 39 times>,
             color_function = '\000' <repeats 39 times>,
             color_lineno = '\000' <repeats 39 times>,
             color_match_context = "\033[1;31m", '\000' <repeats 32 times>,
             color_match_selected = "\033[1;31m", '\000' <repeats 32 
times>,
             color_selected = '\000' <repeats 39 times>,
             color_sep = "\033[36m", '\000' <repeats 34 times>,
             regflags = 4,
             pre_context = 0,
             post_context = 0,
             last_shown = 0,
             show_hunk_mark = 0,
             file_break = 0,
             heading = 0,
             priv = 0x0,
             output = 0x0,
             output_priv = 0x0
           },
           graph = 0x0,
           skip_count = -1,
           max_count = -1,
           max_age = 18446744073709551615,
           min_age = 18446744073709551615,
           min_parents = 0,
           max_parents = -1,
           include_check = 0x0,
           include_check_data = 0x0,
           diffopt = {
             orderfile = 0x0,
             pickaxe = 0x0,
             single_follow = 0x0,
             a_prefix = 0x5a0f0e "a/",
             b_prefix = 0x5a0f11 "b/",
             flags = 2097408,
             touched_flags = 6291840,
             filter = 0,
             use_color = -1,
             context = 3,
             interhunkcontext = 0,
             break_opt = -1,
             detect_rename = 0,
             irreversible_delete = 0,
             skip_stat_unmatch = 0,
             line_termination = 10,
             output_format = 0,
             pickaxe_opts = 0,
             rename_score = 0,
             rename_limit = -1,
             needed_rename_limit = 0,
             degraded_cc_to_c = 0,
             show_rename_progress = 0,
             dirstat_permille = 30,
             setup = 0,
             abbrev = 7,
             prefix = 0x0,
             prefix_length = 0,
             stat_sep = 0x0,
             xdl_opts = 0,
             stat_width = 0,
             stat_name_width = 0,
             stat_graph_width = 0,
             stat_count = 0,
             word_regex = 0x0,
             word_diff = DIFF_WORDS_NONE,
             found_changes = 0,
             found_follow = 0,
             set_default = 0x0,
             file = 0x7fe4209be160 <_IO_2_1_stdout_>,
             close_file = 0,
             pathspec = {
               _raw = 0x0,
               nr = 0,
               has_wildcard = 0,
               recursive = 0,
               magic = 0,
               max_depth = 0,
               items = 0x0
             },
             pathchange = 0x0,
             change = 0x4ab165 <diff_change>,
             add_remove = 0x4aaced <diff_addremove>,
             format_callback = 0x0,
             format_callback_data = 0x0,
             output_prefix = 0x0,
             output_prefix_length = 0,
             output_prefix_data = 0x0,
             diff_path_counter = 0
           },
           pruning = {
             orderfile = 0x0,
             pickaxe = 0x0,
             single_follow = 0x0,
             a_prefix = 0x0,
             b_prefix = 0x0,
             flags = 2049,
             touched_flags = 2049,
             filter = 0,
             use_color = 0,
             context = 0,
             interhunkcontext = 0,
             break_opt = 0,
             detect_rename = 0,
             irreversible_delete = 0,
             skip_stat_unmatch = 0,
             line_termination = 0,
             output_format = 0,
             pickaxe_opts = 0,
             rename_score = 0,
             rename_limit = 0,
             needed_rename_limit = 0,
             degraded_cc_to_c = 0,
             show_rename_progress = 0,
             dirstat_permille = 0,
             setup = 0,
             abbrev = 0,
             prefix = 0x0,
             prefix_length = 0,
             stat_sep = 0x0,
             xdl_opts = 0,
             stat_width = 0,
             stat_name_width = 0,
             stat_graph_width = 0,
             stat_count = 0,
             word_regex = 0x0,
             word_diff = DIFF_WORDS_NONE,
             found_changes = 0,
             found_follow = 0,
             set_default = 0x0,
             file = 0x0,
             close_file = 0,
             pathspec = {
               _raw = 0x0,
               nr = 0,
               has_wildcard = 0,
               recursive = 0,
               magic = 0,
               max_depth = 0,
               items = 0x0
             },
             pathchange = 0x0,
             change = 0x55b66c <file_change.lto_priv.974>,
             add_remove = 0x55b640 <file_add_remove.lto_priv.973>,
             format_callback = 0x0,
             format_callback_data = 0x0,
             output_prefix = 0x0,
             output_prefix_length = 0,
             output_prefix_data = 0x0,
             diff_path_counter = 0
           },
           reflog_info = 0x0,
           children = {
             name = 0x0,
             size = 0,
             nr = 0,
             hash = 0x0
           },
           merge_simplification = {
             name = 0x0,
             size = 0,
             nr = 0,
             hash = 0x0
           },
           treesame = {
             name = 0x0,
             size = 0,
             nr = 0,
             hash = 0x0
           },
           notes_opt = {
             use_default_notes = -1,
             extra_notes_refs = {
               items = 0x0,
               nr = 0,
               alloc = 0,
               strdup_strings = 0,
               cmp = 0x0
             }
           },
           count_left = 0,
           count_right = 0,
           count_same = 0,
           line_log_data = {
             name = 0x0,
             size = 0,
             nr = 0,
             hash = 0x0
           },
           saved_parents_slab = 0x0,
           previous_parents = 0x0,
           break_bar = 0x0
         }
         path = <optimized out>
         sb = {
           final = 0xcdb260,
           commits = {
             compare = 0x4843a9 <compare_commits_by_commit_date>,
             insertion_ctr = 4891,
             cb_data = 0x0,
             alloc = 24,
             nr = 0,
             array = 0xd2bc90
           },
           revs = 0x7fff447977e0,
           path = 0xcd7910 "timsieved/parser.c",
           final_buf = 0xd24a30 "/* parser.c -- parser used by 
timsieved\n * Tim Martin\n * 9/21/99\n *\n * Copyright (c) 1994-2008 
Carnegie Mellon University.  All rights reserved.\n *\n * Redistribution 
and use in source and binary forms"...,
           final_buf_size = 24507,
           ent = 0xd222c0,
           num_lines = 984,
           lineno = 0xd2aa00
         }
         o = <optimized out>
         ent = <optimized out>
         dashdash_pos = <optimized out>
         lno = <optimized out>
         final_commit_name = <optimized out>
         type = OBJ_NONE
         range_list = {
           items = 0x0,
           nr = 0,
           alloc = 0,
           strdup_strings = 0,
           cmp = 0x0
         }
         output_option = 1
         opt = 0
         show_stats = 0
         revs_file = 0x0
         contents_from = 0x0
         options = {{
             type = OPTION_SET_INT,
             short_name = 0,
             long_name = 0x597660 "incremental",
             value = 0x7e81bc <incremental>,
             argh = 0x0,
             help = 0x583a10 "Show blame entries as we find them, 
incrementally",
             flags = 2,
             callback = 0x0,
             defval = 1
           }, {
             type = OPTION_SET_INT,
             short_name = 98,
             long_name = 0x0,
             value = 0x7e81ac <blank_boundary>,
             argh = 0x0,
             help = 0x583a48 "Show blank SHA-1 for boundary commits 
(Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 1
           }, {
             type = OPTION_SET_INT,
             short_name = 0,
             long_name = 0x5ab91d "root",
             value = 0x7e8194 <show_root>,
             argh = 0x0,
             help = 0x583a80 "Do not treat root commits as boundaries 
(Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 1
           }, {
             type = OPTION_SET_INT,
             short_name = 0,
             long_name = 0x584f1e "show-stats",
             value = 0x7e81b0 <show_stats>,
             argh = 0x0,
             help = 0x584f29 "Show work cost statistics",
             flags = 2,
             callback = 0x0,
             defval = 1
           }, {
             type = OPTION_BIT,
             short_name = 0,
             long_name = 0x584f43 "score-debug",
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583ab8 "Show output score for blame entries",
             flags = 2,
             callback = 0x0,
             defval = 64
           }, {
             type = OPTION_BIT,
             short_name = 102,
             long_name = 0x584f4f "show-name",
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583ae0 "Show original filename (Default: auto)",
             flags = 2,
             callback = 0x0,
             defval = 16
           }, {
             type = OPTION_BIT,
             short_name = 110,
             long_name = 0x584f59 "show-number",
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583b08 "Show original linenumber (Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 32
           }, {
             type = OPTION_BIT,
             short_name = 112,
             long_name = 0x5a0c9f "porcelain",
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583b30 "Show in a format designed for machine 
consumption",
             flags = 2,
             callback = 0x0,
             defval = 8
           }, {
             type = OPTION_BIT,
             short_name = 0,
             long_name = 0x584f65 "line-porcelain",
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583b68 "Show porcelain format with per-line commit 
information",
             flags = 2,
             callback = 0x0,
             defval = 520
           }, {
             type = OPTION_BIT,
             short_name = 99,
             long_name = 0x0,
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583ba0 "Use the same output mode as git-annotate 
(Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 1
           }, {
             type = OPTION_BIT,
             short_name = 116,
             long_name = 0x0,
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583bd8 "Show raw timestamp (Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 4
           }, {
             type = OPTION_BIT,
             short_name = 108,
             long_name = 0x0,
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583c00 "Show long commit SHA1 (Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 2
           }, {
             type = OPTION_BIT,
             short_name = 115,
             long_name = 0x0,
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583c28 "Suppress author name and timestamp 
(Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 128
           }, {
             type = OPTION_BIT,
             short_name = 101,
             long_name = 0x584f74 "show-email",
             value = 0x7e8220 <output_option>,
             argh = 0x0,
             help = 0x583c60 "Show author email instead of name 
(Default: off)",
             flags = 2,
             callback = 0x0,
             defval = 256
           }, {
             type = OPTION_BIT,
             short_name = 119,
             long_name = 0x0,
             value = 0x7e8190 <xdl_opts>,
             argh = 0x0,
             help = 0x584f7f "Ignore whitespace differences",
             flags = 2,
             callback = 0x0,
             defval = 4
           }, {
             type = OPTION_BIT,
             short_name = 0,
             long_name = 0x5a2cf1 "minimal",
             value = 0x7e8190 <xdl_opts>,
             argh = 0x0,
             help = 0x583c98 "Spend extra cycles to find better match",
             flags = 2,
             callback = 0x0,
             defval = 2
           }, {
             type = OPTION_STRING,
             short_name = 83,
             long_name = 0x0,
             value = 0x7e8228 <revs_file>,
             argh = 0x5b272a "file",
             help = 0x583cc0 "Use revisions from <file> instead of 
calling git-rev-list",
             flags = 0,
             callback = 0x0,
             defval = 0
           }, {
             type = OPTION_STRING,
             short_name = 0,
             long_name = 0x59b571 "contents",
             value = 0x7e8200 <contents_from>,
             argh = 0x5b272a "file",
             help = 0x583d00 "Use <file>'s contents as the final image",
             flags = 0,
             callback = 0x0,
             defval = 0
           }, {
             type = OPTION_CALLBACK,
             short_name = 67,
             long_name = 0x0,
             value = 0x7e8210 <opt>,
             argh = 0x584f9d "score",
             help = 0x583d30 "Find line copies within and across files",
             flags = 1,
             callback = 0x408280 <blame_copy_callback>,
             defval = 0
           }, {
             type = OPTION_CALLBACK,
             short_name = 77,
             long_name = 0x0,
             value = 0x7e8210 <opt>,
             argh = 0x584f9d "score",
             help = 0x583d60 "Find line movements within and across files",
             flags = 1,
             callback = 0x4082d9 <blame_move_callback>,
             defval = 0
           }, {
             type = OPTION_CALLBACK,
             short_name = 76,
             long_name = 0x0,
             value = 0x7e81e0 <range_list>,
             argh = 0x584fa3 "n,m",
             help = 0x583d90 "Process only line range n,m, counting from 
1",
             flags = 0,
             callback = 0x4e5311 <parse_opt_string_list>,
             defval = 0
           }, {
             type = OPTION_CALLBACK,
             short_name = 0,
             long_name = 0x5a2c80 "abbrev",
             value = 0x7e1b90 <abbrev>,
             argh = 0x5ac835 "n",
             help = 0x583dc0 "use <n> digits to display SHA-1s",
             flags = 1,
             callback = 0x4eda2e <parse_opt_abbrev_cb>,
             defval = 0
           }, {
             type = OPTION_END,
             short_name = 0,
             long_name = 0x0,
             value = 0x0,
             argh = 0x0,
             help = 0x0,
             flags = 0,
             callback = 0x0,
             defval = 0
           }}
         ctx = {
           argv = 0xcd77d8,
           out = 0xcd77c0,
           argc = 0,
           cpidx = 2,
           opt = 0x0,
           flags = 5,
           prefix = 0x0
         }
         cmd_is_annotate = <optimized out>
         ranges = {
           alloc = 0,
           nr = 0,
           ranges = 0x0
         }
         range_i = <optimized out>
         anchor = <optimized out>
#9  0x0000000000413d45 in cmd_annotate (argc=<optimized out>, 
argv=<optimized out>, prefix=0x0) at builtin/annotate.c:21
         args = {
           argv = 0xcd77c0,
           argc = 3,
           alloc = 24
         }
         i = <optimized out>
#10 0x000000000040f19f in run_builtin (argv=0x7fff44798280, argc=2, 
p=0x7e3a58 <commands.lto_priv+24>) at git.c:351
         status = <optimized out>
         help = <optimized out>
         st = {
           st_dev = 1,
           st_ino = 0,
           st_nlink = 140734342201968,
           st_mode = 543312808,
           st_uid = 32740,
           st_gid = 0,
           __pad0 = 1,
           st_rdev = 140734342201360,
           st_size = 140734342203448,
           st_blksize = 140617791849317,
           st_blocks = 0,
           st_atim = {
             tv_sec = 140617776354880,
             tv_nsec = 13463760
           },
           st_mtim = {
             tv_sec = 140734342204489,
             tv_nsec = 140734342201360
           },
           st_ctim = {
             tv_sec = 140734342203448,
             tv_nsec = 140734342201968
           },
           __unused = {140734342201568, 0, 5074673}
         }
         prefix = <optimized out>
#11 handle_builtin (argc=2, argv=0x7fff44798280) at git.c:530
         p = 0x7e3a58 <commands.lto_priv+24>
         cmd = <optimized out>
         i = <optimized out>
#12 0x0000000000405ac5 in run_argv (argv=0x7fff447980b8, 
argcp=0x7fff447980ac) at git.c:576
         done_alias = 0
#13 main (argc=2, av=<optimized out>) at git.c:685
         done_help = 0
         was_alias = 0
         argv = 0x7fff44798280
         cmd = 0x7fff44798838 "annotate"
(gdb)
