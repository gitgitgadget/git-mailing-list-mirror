From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 12 Feb 2013 21:48:18 +0100
Message-ID: <511AAA92.4030508@gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com> <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com> <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com> <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:48:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Mmf-0004XG-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab3BLUs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:48:26 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:49694 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025Ab3BLUsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:48:22 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so242395eek.20
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nIVYS6fKSJ9cfTq5Q7VPkBXIrnTf2mpwElPqD7xY/qo=;
        b=H6+YtyULmoRlbSwTCaQYNA/AdF6EwECViQReAUyB/xE3aufccVEOXo69U+fx73gT3T
         hXzWpTK3yhhbSDsurL0qXY6+1owmH9qDTm7lH/OEBjxai10D3psMQ7H4iI4NMkWsmTV+
         DK1ooBIuwwOW9vyysLqlDpRzTNcCcxVK9yT+8ct1v0sMV8Ho34XVH7/fg/FaI4EZoll7
         THwhsUlSDv3wHhCLxc47fRDYkpr61+x/t/THuJcz+d4I6Ke31z4eCWeKh2R7Q4yBRkh9
         feIlkMZP8DeVpdKgk3dWRUNiIrFn57APP7xvaJ9NdIroB7DJ+7QMM+52aKDfEvlHjJfl
         GTCg==
X-Received: by 10.14.199.135 with SMTP id x7mr66398287een.18.1360702100645;
        Tue, 12 Feb 2013 12:48:20 -0800 (PST)
Received: from [10.1.100.52] ([77.244.111.149])
        by mx.google.com with ESMTPS id s3sm31409364eem.4.2013.02.12.12.48.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 12:48:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216195>

Am 11.02.2013 04:53, schrieb Duy Nguyen:
> On Sun, Feb 10, 2013 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> Karsten Blees has done something similar-ish on Windows, and he posted
>> the results here:
>>
>> https://groups.google.com/forum/#!topic/msysgit/fL_jykUmUNE/discussion
>>

The new hashtable implementation in fscache [1] supports O(1) removal and has no mingw dependencies - might come in handy for anyone trying to implement an inotify daemon.

[1] https://github.com/kblees/git/commit/f7eb85c2

>> I also seem to remember he doing a ReadDirectoryChangesW version, but
>> I don't remember what happened with that.
> 
> Thanks. I came across that but did not remember. For one thing, we
> know the inotify alternative for Windows: ReadDirectoryChangesW.
> 

I dropped ReadDirectoryChangesW because maintaining a 'live' file system cache became more and more complicated. For example, according to MSDN docs, ReadDirectoryChangesW *may* report short DOS 8.3 names (i.e. "PROGRA~1" instead of "Program Files"), so a correct and fast cache implementation would have to be indexed by long *and* short names...

Another problem was that the 'live' cache had quite negative performance impact on mutating git commands (checkout, reset...). An inotify daemon running as a background process (not in-process as fscache) will probably affect everyone that modifies the working copy, e.g. running 'make' or the test-suite. This should be considered in the design.

> I copy "git status"'s (impressive) numbers from fscache-v0 for those
> who are interested in:
> 
> preload | -u  | normal | cached | gain
> --------+-----+--------+--------+------
> false   | all | 25.144 | 3.055  |  8.2
> false   | no  | 22.822 | 1.748  | 12.8
> true    | all |  9.234 | 2.179  |  4.2
> true    | no  |  6.833 | 0.955  |  7.2
> 

Note that I wasn't able to reproduce such bad 'normal' values in later tests, I guess disk fragmentation and/or virus scanner must have tricked me on that day...gain factors of 2.5 - 5 are more appropriate.


However, the difference between git status -uall and -uno was always about 1.3 s in all fscache versions, even though opendir/readdir/closedir was served entirely from the cache. I added a bit of performance tracing to find the cause, and I think most of the time spent in wt_status_collect_untracked can be eliminated:

1.) 0.939 s is spent in dir.c/excluded (i.e. checking .gitignore). This check is done for *every* file in the working copy, including files in the index. Checking the index first could eliminate most of that, i.e.:

(Note: patches are for discussion only, I'm aware that they may have unintended side effects...)

@@ -1097,6 +1097,8 @@ static enum path_treatment treat_path(struct dir_struct *dir,
                return path_ignored;
        strbuf_setlen(path, baselen);
        strbuf_addstr(path, de->d_name);
+       if (cache_name_exists(path->buf, path->len, ignore_case))
+               return path_ignored;
        if (simplify_away(path->buf, path->len, simplify))
                return path_ignored;
---


2.) 0.135 s is spent in name-hash.c/hash_index_entry_directories, reindexing the same directories over and over again. In the end, the hashtable contains 939k directory entries, even though the WebKit test repo only has 7k directories. Checking if a directory entry already exists could reduce that, i.e.:

@@ -53,14 +55,23 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
 	unsigned int hash;
 	void **pos;
 	double t = ticks();
+	struct cache_entry *ce2;
+	int len = ce_namelen(ce);
 
-	const char *ptr = ce->name;
-	while (*ptr) {
-		while (*ptr && *ptr != '/')
-			++ptr;
-		if (*ptr == '/') {
-			++ptr;
-			hash = hash_name(ce->name, ptr - ce->name);
+	while (len > 0) {
+		while (len > 0 && ce->name[len - 1] != '/')
+			len--;
+		if (len > 0) {
+			hash = hash_name(ce->name, len);
+			ce2 = lookup_hash(hash, &istate->name_hash);
+			while (ce2) {
+				if (same_name(ce2, ce->name, len, ignore_case)) {
+					add_since(t, &hash_dirs);
+					return;
+				}
+				ce2 = ce2->dir_next;
+			}
+			len--;
 			pos = insert_hash(hash, ce, &istate->name_hash);
 			if (pos) {
 				ce->dir_next = *pos;
---


Tests were done with the WebKit repo (~200k files, ~7k directories, 15 .gitignore files, ~100 entries in root .gitignore). Instrumented code can be found here: https://github.com/kblees/git/tree/kb/git-status-performance-tracing

Here's the performance traces of 'git status -s -uall'

Before patches:

trace: at builtin/commit.c:1221, time: 0.523429 s: cmd_status/read_cache_preload
trace: at builtin/commit.c:1223, time: 0.00403477 s: cmd_status/refresh_index
trace: at builtin/commit.c:1231, time: 0.00318494 s: cmd_status/hold_locked_index
trace: at wt-status.c:539, time: 0.00527396 s: wt_status_collect_changes_worktree
trace: at wt-status.c:544, time: 0.00545771 s: wt_status_collect_changes
trace: at wt-status.c:546, time: 1.286 s: wt_status_collect_untracked
trace: at builtin/commit.c:1233, time: 1.29852 s: cmd_status/wt_status_collect
trace: at dir.c:1540, time: 0.00170986 s: read_directory_recursive/strbuf_add
trace: at dir.c:1541, time: 0.00623972 s: read_directory_recursive/opendir
trace: at dir.c:1542, time: 0.00517881 s: read_directory_recursive/readdir
trace: at dir.c:1543, time: 0.992936 s: read_directory_recursive/treat_path
trace: at dir.c:1544, time: 0.277942 s: read_directory_recursive/dir_add_name
trace: at dir.c:1545, time: 0.0014594 s: read_directory_recursive/close
trace: at dir.c:1546, time: 0.939349 s: treat_one_path/excluded
trace: at dir.c:1547, time: 0.0050811 s: treat_one_path/dir_add_ignored
trace: at dir.c:1548, time: 0.00515875 s: treat_one_path/get_dtype
trace: at dir.c:1549, time: 0.00329322 s: treat_one_path/treat_directory
trace: at dir.c:1550, time: 0.222969 s: excluded/prep_exclude
trace: at dir.c:1551, time: 0.00443398 s: excluded/excluded_from_list[EXC_CMDL]
trace: at dir.c:1552, time: 0.699602 s: excluded/excluded_from_list[EXC_DIRS]
trace: at dir.c:1553, time: 0.00475736 s: excluded/excluded_from_list[EXC_FILE]
trace: at read-cache.c:460, time: 0.00967987 s: index_name_pos
trace: at name-hash.c:213, time: 0.190481 s: lazy_init_name_hash
trace: at name-hash.c:216, time: 0.135248 s: hash_index_entry_directories (938865 entries)
trace: at name-hash.c:217, time: 0.0806647 s: index_name_exists
trace: at compat/mingw.c:2137, time: 1.97424 s: command: c:\git\msysgit\git\git-status.exe -s -uall


After patches:

trace: at builtin/commit.c:1221, time: 0.517511 s: cmd_status/read_cache_preload
trace: at builtin/commit.c:1223, time: 0.00405227 s: cmd_status/refresh_index
trace: at builtin/commit.c:1231, time: 0.00322796 s: cmd_status/hold_locked_index
trace: at wt-status.c:539, time: 0.00530057 s: wt_status_collect_changes_worktree
trace: at wt-status.c:544, time: 0.00546062 s: wt_status_collect_changes
trace: at wt-status.c:546, time: 0.322799 s: wt_status_collect_untracked
trace: at builtin/commit.c:1233, time: 0.33536 s: cmd_status/wt_status_collect
trace: at dir.c:1542, time: 0.00120529 s: read_directory_recursive/strbuf_add
trace: at dir.c:1543, time: 0.00476647 s: read_directory_recursive/opendir
trace: at dir.c:1544, time: 0.00502022 s: read_directory_recursive/readdir
trace: at dir.c:1545, time: 0.310515 s: read_directory_recursive/treat_path
trace: at dir.c:1546, time: 0 s: read_directory_recursive/dir_add_name
trace: at dir.c:1547, time: 0.000831234 s: read_directory_recursive/close
trace: at dir.c:1548, time: 0.0668582 s: treat_one_path/excluded
trace: at dir.c:1549, time: 0.000173174 s: treat_one_path/dir_add_ignored
trace: at dir.c:1550, time: 0.000174267 s: treat_one_path/get_dtype
trace: at dir.c:1551, time: 0.00315468 s: treat_one_path/treat_directory
trace: at dir.c:1552, time: 0.039733 s: excluded/prep_exclude
trace: at dir.c:1553, time: 0.000185205 s: excluded/excluded_from_list[EXC_CMDL]
trace: at dir.c:1554, time: 0.0264496 s: excluded/excluded_from_list[EXC_DIRS]
trace: at dir.c:1555, time: 0.000170622 s: excluded/excluded_from_list[EXC_FILE]
trace: at read-cache.c:460, time: 0.00260636 s: index_name_pos
trace: at name-hash.c:224, time: 0.126637 s: lazy_init_name_hash
trace: at name-hash.c:227, time: 0.0500866 s: hash_index_entry_directories (7152 entries)
trace: at name-hash.c:228, time: 0.0790143 s: index_name_exists
trace: at compat/mingw.c:2137, time: 1.00595 s: command: c:\git\msysgit\git\git-status.exe -s -uall
