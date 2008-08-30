From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Sat, 30 Aug 2008 12:33:26 +0200
Message-ID: <237967ef0808300333t2cd4e354xd461f7bfead40f4c@mail.gmail.com>
References: <20080828171533.GA6024@blimp.local>
	 <20080828212722.GF6439@steel.home>
	 <237967ef0808290758p2bd1de55idcb9ad9150389b2b@mail.gmail.com>
	 <81b0412b0808300312h53605ac8p2d60784ca2178a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 12:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZNmz-0001HS-6X
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 12:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbYH3Kda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 06:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbYH3Kda
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 06:33:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:16084 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYH3Kd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 06:33:29 -0400
Received: by ey-out-2122.google.com with SMTP id 6so437291eyi.37
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fDQF4SsrlvkErW+X9eaMdvzxk/pNNIAdQP3sxsungSs=;
        b=VJ0F81Qv/dVu6lHHJaBCJGEtyVLAKhVmwTD5/N48U5vuIgz6/zQm0OTc2bfZfl2mlf
         G9bj+bvguK6RbnAIncjLEc/HNCcDgbs9g2MllZApFa6/lUvrxJl6WL68DjJmKHsya1bt
         y+5dsb3psC2gs959Ff84ZB9pWnn/zg+PpJqQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ucb6kgKGge6NvQP/SKd8GCO/utUz9KqfYJQ6trZl1R/MkoYl7VikRCDxCRVHLqBs1C
         lUrnVCruieNnGz6UJ0AfrmZaGYevtAKeCLC/gbZ0xMuHMzvfx1zeSOybIG3Bi763/AT6
         hZAqIqrNZ8DkVk6rN4oQG+TqDc8lgm5BWu2g4=
Received: by 10.210.19.4 with SMTP id 4mr3016448ebs.134.1220092406248;
        Sat, 30 Aug 2008 03:33:26 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Sat, 30 Aug 2008 03:33:26 -0700 (PDT)
In-Reply-To: <81b0412b0808300312h53605ac8p2d60784ca2178a0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94373>

2008/8/30 Alex Riesen <raa.lkml@gmail.com>:
> 2008/8/29 Mikael Magnusson <mikachu@gmail.com>:
>> I merged the branch in pu into next, which I think should work, but I get
>> these segfaults for some commands... I tried running in gdb but even with
>
> Can't reproduce in master, will try with next later, am busy right now, sorry.
>
>> -g3 I only get nonsense backtraces, not sure why.
>
> Remove -O2 from CFLAGS:
>
>  $ make CFLAGS="-O0 -ggdb"

Hm, I only had CFLAGS set in the env, maybe that's not enough, or maybe it
was that I had it set to -gdwarf-2 -g3 instead of -ggdb3. At any rate, I got
this now:

% git fotch
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xa7ce56c0 (LWP 13043)]
0x41b61490 in ?? () from /lib/libc.so.6
(gdb) bt
#0  0x41b61490 in ?? () from /lib/libc.so.6
#1  0x41b634b0 in realloc () from /lib/libc.so.6
#2  0x41b62fdb in malloc () from /lib/libc.so.6
#3  0x080f63e6 in xmalloc (size=24) at wrapper.c:20
#4  0x080f6471 in xmemdupz (data=0x816a44f, len=23) at wrapper.c:45
#5  0x080f64e9 in xstrndup (str=0x816a44f "refs/remotes/origin/man",
len=23) at wrapper.c:54
#6  0x080dc05c in parse_refspec_internal (nr_refspec=6,
refspec=0x816a010, fetch=1, verify=0)
    at remote.c:505
#7  0x080dc3ca in parse_fetch_refspec (nr_refspec=6,
refspec=0x816a010) at remote.c:613
#8  0x080dc512 in remote_get (name=0x8169458 "origin") at remote.c:649
#9  0x0806cd4d in cmd_fetch (argc=0, argv=0xafc2d578, prefix=0x0) at
builtin-fetch.c:620
#10 0x0804bb3c in run_command (p=0x8123498, argc=1, argv=0xafc2d578)
at git.c:238
#11 0x0804bccc in handle_internal_command (argc=1, argv=0xafc2d578) at git.c:380
#12 0x0804bfea in main (argc=1, argv=0xafc2d578) at git.c:500
(gdb) bt full
#0  0x41b61490 in ?? () from /lib/libc.so.6
No symbol table info available.
#1  0x41b634b0 in realloc () from /lib/libc.so.6
No symbol table info available.
#2  0x41b62fdb in malloc () from /lib/libc.so.6
No symbol table info available.
#3  0x080f63e6 in xmalloc (size=24) at wrapper.c:20
	ret = (void *) 0x0
#4  0x080f6471 in xmemdupz (data=0x816a44f, len=23) at wrapper.c:45
	p = 0x0
#5  0x080f64e9 in xstrndup (str=0x816a44f "refs/remotes/origin/man",
len=23) at wrapper.c:54
	p = 0x0
#6  0x080dc05c in parse_refspec_internal (nr_refspec=6,
refspec=0x816a010, fetch=1, verify=0)
    at remote.c:505
	rlen = 23
	llen = 0
	is_glob = 0
	lhs = 0x816a440 "refs/heads/man:refs/remotes/origin/man"
	rhs = 0x816a44f "refs/remotes/origin/man"
	i = 4
	st = 0
	rs = (struct refspec *) 0x8169d88
#7  0x080dc3ca in parse_fetch_refspec (nr_refspec=6,
refspec=0x816a010) at remote.c:613
No locals.
#8  0x080dc512 in remote_get (name=0x8169458 "origin") at remote.c:649
	ret = (struct remote *) 0x8169ef0
#9  0x0806cd4d in cmd_fetch (argc=0, argv=0xafc2d578, prefix=0x0) at
builtin-fetch.c:620
	remote = (struct remote *) 0x804b2d4
	i = 1
---Type <return> to continue, or q <return> to quit---
	ref_nr = 0
	exit_code = 0
	refs = (const char **) 0x0
#10 0x0804bb3c in run_command (p=0x8123498, argc=1, argv=0xafc2d578)
at git.c:238
	status = -1346186104
	st = {st_dev = 582794214293012544, __pad1 = 0, __st_ino = 1103151906,
st_mode = 5,
  st_nlink = 0, st_uid = 0, st_gid = 135692352, st_rdev =
582794423264539853, __pad2 = 54328,
  st_size = 579290465871466043, st_blksize = 0, st_blocks =
577791495034295448, st_atim = {
    tv_sec = -1346180215, tv_nsec = 1103274272}, st_mtim = {tv_sec = 135692296,
    tv_nsec = 1103269876}, st_ctim = {tv_sec = 1090632864, tv_nsec = 0},
  st_ino = 580626572881613928}
	prefix = 0x0
#11 0x0804bccc in handle_internal_command (argc=1, argv=0xafc2d578) at git.c:380
	p = (struct cmd_struct *) 0x8123498
	cmd = 0x8169a3c "fetch"
	i = 26
	commands = {{cmd = 0x8104ebd "add", fn = 0x804c905 <cmd_add>, option = 5}, {
    cmd = 0x8104ec1 "annotate", fn = 0x804cc70 <cmd_annotate>, option = 1}, {
    cmd = 0x8104eca "apply", fn = 0x805362c <cmd_apply>, option = 0}, {
    cmd = 0x8104ed0 "archive", fn = 0x80542e5 <cmd_archive>, option = 0}, {
    cmd = 0x8104ed8 "blame", fn = 0x805889e <cmd_blame>, option = 1},
{cmd = 0x8104ede "branch",
    fn = 0x805a62f <cmd_branch>, option = 1}, {cmd = 0x8104ee5 "bundle",
    fn = 0x805adb8 <cmd_bundle>, option = 0}, {cmd = 0x8104eec "cat-file",
    fn = 0x805b6b1 <cmd_cat_file>, option = 1}, {cmd = 0x8104ef5 "checkout",
    fn = 0x805d865 <cmd_checkout>, option = 5}, {cmd = 0x8104efe
"checkout-index",
    fn = 0x805c123 <cmd_checkout_index>, option = 5}, {cmd = 0x8104f0d
"check-ref-format",
    fn = 0x805bb84 <cmd_check_ref_format>, option = 0}, {cmd =
0x8104f1e "check-attr",
    fn = 0x805b94c <cmd_check_attr>, option = 1}, {cmd = 0x8104f29 "cherry",
    fn = 0x8078c23 <cmd_cherry>, option = 1}, {cmd = 0x8104f30 "cherry-pick",
---Type <return> to continue, or q <return> to quit---
    fn = 0x8094c96 <cmd_cherry_pick>, option = 5}, {cmd = 0x8104f3c "clone",
    fn = 0x805ef85 <cmd_clone>, option = 0}, {cmd = 0x8104f42 "clean",
    fn = 0x805ddb3 <cmd_clean>, option = 5}, {cmd = 0x8104f48 "commit",
    fn = 0x8062115 <cmd_commit>, option = 5}, {cmd = 0x8104f4f "commit-tree",
    fn = 0x805fcbd <cmd_commit_tree>, option = 1}, {cmd = 0x8104f5b "config",
    fn = 0x80632c5 <cmd_config>, option = 0}, {cmd = 0x8104f62 "count-objects",
    fn = 0x8063f14 <cmd_count_objects>, option = 1}, {cmd = 0x8104f70
"describe",
    fn = 0x8064ce4 <cmd_describe>, option = 1}, {cmd = 0x8104f79 "diff",
    fn = 0x80663da <cmd_diff>, option = 0}, {cmd = 0x8104f7e "diff-files",
    fn = 0x80650d8 <cmd_diff_files>, option = 1}, {cmd = 0x8104f89
"diff-index",
    fn = 0x806530c <cmd_diff_index>, option = 1}, {cmd = 0x8104f94 "diff-tree",
    fn = 0x80657f0 <cmd_diff_tree>, option = 1}, {cmd = 0x8104f9e
"fast-export",
    fn = 0x8067c10 <cmd_fast_export>, option = 1}, {cmd = 0x8104faa "fetch",
    fn = 0x806ccb5 <cmd_fetch>, option = 1}, {cmd = 0x8104fb0 "fetch-pack",
    fn = 0x806adeb <cmd_fetch_pack>, option = 1}, {cmd = 0x8104fbb
"fetch--tool",
    fn = 0x80692be <cmd_fetch__tool>, option = 1}, {cmd = 0x8104fc7
"fmt-merge-msg",
    fn = 0x806defb <cmd_fmt_merge_msg>, option = 1}, {cmd = 0x8104fd5
"for-each-ref",
    fn = 0x806fc5b <cmd_for_each_ref>, option = 1}, {cmd = 0x8104fe2
"format-patch",
    fn = 0x8077b7e <cmd_format_patch>, option = 1}, {cmd = 0x8104fef "fsck",
    fn = 0x8071106 <cmd_fsck>, option = 1}, {cmd = 0x8104ff4 "fsck-objects",
    fn = 0x8071106 <cmd_fsck>, option = 1}, {cmd = 0x8105001 "gc", fn
= 0x80719b9 <cmd_gc>,
    option = 1}, {cmd = 0x8105004 "get-tar-commit-id", fn = 0x809be66
<cmd_get_tar_commit_id>,
    option = 0}, {cmd = 0x8105016 "grep", fn = 0x807308e <cmd_grep>,
option = 3}, {
    cmd = 0x810501b "help", fn = 0x8074bd2 <cmd_help>, option = 0}, {
    cmd = 0x8105020 "http-fetch", fn = 0x80a057c <cmd_http_fetch>,
option = 1}, {
    cmd = 0x810502b "init", fn = 0x8075a8d <cmd_init_db>, option = 0}, {
    cmd = 0x8105030 "init-db", fn = 0x8075a8d <cmd_init_db>, option = 0}, {
    cmd = 0x8105038 "log", fn = 0x8076c36 <cmd_log>, option = 3}, {cmd
= 0x810503c "ls-files",
    fn = 0x8079e63 <cmd_ls_files>, option = 1}, {cmd = 0x8105045 "ls-tree",
---Type <return> to continue, or q <return> to quit---
    fn = 0x807ae13 <cmd_ls_tree>, option = 1}, {cmd = 0x810504d "ls-remote",
    fn = 0x807a797 <cmd_ls_remote>, option = 0}, {cmd = 0x8105057 "mailinfo",
    fn = 0x807d1ef <cmd_mailinfo>, option = 0}, {cmd = 0x8105060 "mailsplit",
    fn = 0x807db6e <cmd_mailsplit>, option = 0}, {cmd = 0x810506a "merge",
    fn = 0x808016f <cmd_merge>, option = 5}, {cmd = 0x8105070 "merge-base",
    fn = 0x8080fe6 <cmd_merge_base>, option = 1}, {cmd = 0x810507b
"merge-file",
    fn = 0x80810f0 <cmd_merge_file>, option = 0}, {cmd = 0x8105086
"merge-ours",
    fn = 0x8081438 <cmd_merge_ours>, option = 1}, {cmd = 0x8105091
"merge-recursive",
    fn = 0x8084c44 <cmd_merge_recursive>, option = 5}, {cmd =
0x81050a1 "merge-subtree",
    fn = 0x8084c44 <cmd_merge_recursive>, option = 5}, {cmd = 0x81050af "mv",
    fn = 0x808509d <cmd_mv>, option = 5}, {cmd = 0x81050b2 "name-rev",
    fn = 0x8086090 <cmd_name_rev>, option = 1}, {cmd = 0x81050bb
"pack-objects",
    fn = 0x808aa1a <cmd_pack_objects>, option = 1}, {cmd = 0x81050c8
"peek-remote",
    fn = 0x807a797 <cmd_ls_remote>, option = 0}, {cmd = 0x81050d4 "pickaxe",
    fn = 0x805889e <cmd_blame>, option = 1}, {cmd = 0x81050dc "prune",
    fn = 0x808badd <cmd_prune>, option = 1}, {cmd = 0x81050e2 "prune-packed",
    fn = 0x808b60a <cmd_prune_packed>, option = 1}, {cmd = 0x81050ef "push",
    fn = 0x808bf9f <cmd_push>, option = 1}, {cmd = 0x81050f4 "read-tree",
    fn = 0x808c418 <cmd_read_tree>, option = 1}, {cmd = 0x81050fe "reflog",
    fn = 0x808e264 <cmd_reflog>, option = 1}, {cmd = 0x8105105 "remote",
    fn = 0x8090076 <cmd_remote>, option = 1}, {cmd = 0x810510c "repo-config",
    fn = 0x80632c5 <cmd_config>, option = 0}, {cmd = 0x8105118 "rerere",
    fn = 0x8090669 <cmd_rerere>, option = 1}, {cmd = 0x810511f "reset",
    fn = 0x8090e44 <cmd_reset>, option = 1}, {cmd = 0x8105125 "rev-list",
    fn = 0x8092096 <cmd_rev_list>, option = 1}, {cmd = 0x810512e "rev-parse",
    fn = 0x80932a0 <cmd_rev_parse>, option = 0}, {cmd = 0x8105138 "revert",
    fn = 0x8094c4e <cmd_revert>, option = 5}, {cmd = 0x810513f "rm",
fn = 0x80950b5 <cmd_rm>,
    option = 1}, {cmd = 0x8105142 "send-pack", fn = 0x8096982
<cmd_send_pack>, option = 1}, {
    cmd = 0x810514c "shortlog", fn = 0x809769a <cmd_shortlog>, option = 2}, {
---Type <return> to continue, or q <return> to quit---
    cmd = 0x8105155 "show-branch", fn = 0x8098c0c <cmd_show_branch>,
option = 1}, {
    cmd = 0x8105161 "show", fn = 0x80767e8 <cmd_show>, option = 3},
{cmd = 0x8105166 "status",
    fn = 0x8061d60 <cmd_status>, option = 5}, {cmd = 0x810516d "stripspace",
    fn = 0x809a78d <cmd_stripspace>, option = 0}, {cmd = 0x8105178
"symbolic-ref",
    fn = 0x809a8db <cmd_symbolic_ref>, option = 1}, {cmd = 0x8105185 "tag",
    fn = 0x809b51a <cmd_tag>, option = 1}, {cmd = 0x8105189 "tar-tree",
    fn = 0x809bca4 <cmd_tar_tree>, option = 0}, {cmd = 0x8105192
"unpack-objects",
    fn = 0x809d17c <cmd_unpack_objects>, option = 1}, {cmd = 0x81051a1
"update-index",
    fn = 0x809e85c <cmd_update_index>, option = 1}, {cmd = 0x81051ae
"update-ref",
    fn = 0x809f1d8 <cmd_update_ref>, option = 1}, {cmd = 0x81051b9
"upload-archive",
    fn = 0x809f7a8 <cmd_upload_archive>, option = 0}, {cmd = 0x81051c8
"verify-tag",
    fn = 0x80a0353 <cmd_verify_tag>, option = 1}, {cmd = 0x81051d3 "version",
    fn = 0x80c5376 <cmd_version>, option = 0}, {cmd = 0x81051db "whatchanged",
    fn = 0x80764c0 <cmd_whatchanged>, option = 3}, {cmd = 0x81051e7
"write-tree",
    fn = 0x80a0434 <cmd_write_tree>, option = 1}, {cmd = 0x81051f2
"verify-pack",
    fn = 0x809ff24 <cmd_verify_pack>, option = 0}, {cmd = 0x81051fe "show-ref",
    fn = 0x809a0cc <cmd_show_ref>, option = 1}, {cmd = 0x8105207 "pack-refs",
    fn = 0x808b2e8 <cmd_pack_refs>, option = 1}}
	ext = ""
#12 0x0804bfea in main (argc=1, argv=0xafc2d578) at git.c:500
	cmd = 0xafc2eb89 "fotch"
	slash = 0xafc2eb85 "git"
	done_alias = 0

-- 
Mikael Magnusson
