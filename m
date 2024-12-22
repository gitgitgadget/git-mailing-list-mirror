Received: from mx2.spamfri.dk (mx2.spamfri.dk [193.200.91.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859D143759
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.200.91.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734889856; cv=none; b=h/ZyretV4w+T90PJVTWa4/WE7220PuWraHMNmZt0xPDjdFaYEAzMyVPF9Zh6ca1JR1oEXlvCT2+bHXTWZTWOtVMOfUzSjgTEuXNKJR4KmLoS8xaIbs0nuZEEM9SgrDfH0eVDsFRHPaLdTTJWRVkTiysEeMQvIwM9QlvD46EVrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734889856; c=relaxed/simple;
	bh=QtTYkzscazN1B+IXhCj2v8T7PCut3/0T61ZRv8lTqFo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DY/RqGsuH8SRDks3Cf3VGHjpVftWdiv6uAHaW+3yz1iRfYD3bAKe7ueAvKtAPMU1CXytmRvRD5Cy5zQXIuWJAOmzJOdzQzmdv8zRfCMZvo+f2Lp8UyUM0elViFbayL/cv8RgoWXNXEQaYNosSfxjx9ADFgdfMT4cnCAFmqUodv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbjnet.dk; spf=pass smtp.mailfrom=mbjnet.dk; dkim=pass (2048-bit key) header.d=mbjnet.dk header.i=@mbjnet.dk header.b=BZrtoj00; arc=none smtp.client-ip=193.200.91.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbjnet.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbjnet.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mbjnet.dk header.i=@mbjnet.dk header.b="BZrtoj00"
Received: from smtp1.netgiganten.dk ([195.242.131.30])
	by mx2.spamfri.dk with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mbj@mbjnet.dk>)
	id 1tPPg6-003nzK-72
	for git@vger.kernel.org; Sun, 22 Dec 2024 18:23:46 +0100
Received: by smtp1.netgiganten.dk (Postfix, from userid 8)
	id 03949602B9; Sun, 22 Dec 2024 18:23:42 +0100 (CET)
Received: from web3.netgiganten.dk (web3.netgiganten.dk [195.242.130.13])
	by smtp1.netgiganten.dk (Postfix) with ESMTPS id E8BF260076
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 18:23:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mbjnet.dk;
	s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender
	:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=buiR/VyvDc3HSN07olttjw98kiZ0btkc2YEshXHTFBI=; b=BZrtoj00LE5Hjz+aFdR1q93PPd
	vVyyezqjKQGydUHiaDCmX/YR8vWJ1B+5d7Fsk0t0kO8OPm04lDW/ihLevEpjAETgEQ+vZGXtEv+Oy
	Tpd7gexSK7Y41cjgZgKW9sNAsDTB0hj8IdI0mXRmQq+5QulycNM/2N0kvviMxsk1nlaSkrhT0Z6pO
	r9Qe4TIBppA3Az4dElsNodem9pmxDQvltDpM++jfPo9RPj5HGQGVtowxnx18l/cXeGzHvS1G+LoHX
	DS5R06piHAy+f74q17opqgD0hQm6D4bWYMPRTXhRJZ3e32elpu1BV5DgmzmYeZURwayU4bJdI4jg+
	P/LIFf/Q==;
Received: from 87-49-147-142-mobile.dk.customer.tdc.net ([87.49.147.142]:25649 helo=localhost)
	by web3.netgiganten.dk with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mbj@mbjnet.dk>)
	id 1tPPg3-005FGQ-34
	for git@vger.kernel.org;
	Sun, 22 Dec 2024 18:23:40 +0100
Date: Sun, 22 Dec 2024 18:23:39 +0100
From: Morten Bo Johansen <mbj@mbjnet.dk>
To: git@vger.kernel.org
Subject: [git] bugreport of a segmentation fault
Message-ID: <Z2hLG2xmO9KFRpY5@localhost.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgiGaKeAwhnNV9Y3"
Content-Disposition: inline
Autocrypt: addr=mbj@mbjnet.dk; keydata=
	mDMEXdBcexYJKwYBBAHaRw8BAQdA25O6B8AgupIkX9Udjiot0WMq/qK2zErrVXFLgooeRKK0Ik1
	vcnRlbiBCbyBKb2hhbnNlbiA8bWJqQG1iam5ldC5kaz6IkAQTFggAOBYhBPLf5vsifgOqfBq4q0
	sY0rzOidAhBQJd0Fx7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEEsY0rzOidAhjxIBA
	OSjewm+Rx6n3ujum4/7Ew4388L9DdsZSLE3U2KHa++mAP94CFCbSn+3goyShB/fNUj7DnxpuacA
	+Hl5w/VFnAblCrg4BF3QXHsSCisGAQQBl1UBBQEBB0Ct3hSowkAYn5FsO1opd7uRAuMrgXy1/oS
	rR96cerZxPQMBCAeIeAQYFggAIBYhBPLf5vsifgOqfBq4q0sY0rzOidAhBQJd0Fx7AhsMAAoJEE
	sY0rzOidAhbf4A/2/NzF6wIr5aGQQcF8Iarz6rBpdhvpTPOSI9B0vkSibqAP46Knt5eU3XLvmI9
	qzLXqxriPg9y6ltMNPGeNlv0GzsDQ==
X-Netgiganten-MailScanner-Information: Please contact the ISP for more information
X-Netgiganten-MailScanner-ID: 1tPPg3-005FGQ-34
X-Netgiganten-MailScanner: Found to be clean
X-Netgiganten-MailScanner-SpamCheck: 
X-Netgiganten-MailScanner-From: mbj@mbjnet.dk
X-Get-Message-Sender-Via: web3.netgiganten.dk: authenticated_id: mbj@mbjnet.dk
X-Authenticated-Sender: web3.netgiganten.dk: mbj@mbjnet.dk
X-SpamExperts-Domain: smtp1.netgiganten.dk
X-SpamExperts-Username: 195.242.131.30
Authentication-Results: spamfri.dk; auth=pass smtp.auth=195.242.131.30@smtp1.netgiganten.dk
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.25)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9Mt3evPS3Jd3v9gHGewVRPPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xKs2hwWO1Fm7wz48pUGkvLadmdMHfcHfu3U2C33bOHx6Yd
 +RTjyxUv9Fg9dq5XJDNaa40DxZPJuLUk3zkVKd8pdqDuc9lS3Nx+9iKFZ9qooJJVRKyFCRrxWkR6
 oZhlSr2/F70SBBRYwG7c5vdA7JsLiFKfD1jKgYfH+6S5qDVYoISH9Oy2XZ1lGHF8rSiJXYU//lg2
 u87X7IWpLCLNZN3OaF+P3CGLwqkaQ0xpotL0Mhypt3L7tZhLu6Os9ceqGjHQelPdLZIWapW8lSgO
 kuDXt8NAP2tNgqlZSPO6AG7dtCNL+gnfG+W7o8UhiuOh4WEE5uZ2WvCBuI5bFKfIPNe6y7FKGPph
 vqnLpzhm+ER3DnC76wJtCH5wnnjHu5Mkc5qJy3Urw5SgVthrdgd57Rw2xmmJYrugraZv1BKVjJ8f
 +SdaACh8dah47zhl5ukAfppOmU8wjyrBX7cMW5IOTkxCQUmQ8RXTHY4VikEbNcut+Geht4RUD4Jt
 Efgm30P8kUs3vXZOflWcKA8b6Jh8KSOo4nUsBWF0Xc+ld2bN6gWeOQeYUOp7A73HI6oJg7w/Vocs
 SlejsOFTEc9cZr2k6SQZFRYecsOC28uoxQTK6mMatxJl8c0c0QADuK9x4kSET6sFz+yqxCrxDhjn
 ktqCSGE84hlhMm+aL/f7w0iKeHyWEK6DYKsQxi8+fG4cr4epbAC/J9xMkIOH8ernTPdTNBHMPAlb
 DjazCbhs7qBpykynMu0BxDo0AToOs17x2TmgHdJL6kV0Qzg/84Sijt9dYqbmqzXbqcZ3HZ9ysPIC
 hxQgImk78YqtVjdNQgkwgH2NtGSywoLIH15RuNd/GpMkBuFeH3LEBI1iC95CrMJTROgty0Y1St2j
 Ct3JZWKDadnWNlCXUtRgyNuiFi0rmCabDrs+H95odCWfW4dGROWWpyAkBA==
X-Report-Abuse-To: spam@mx1.spamfri.dk


--OgiGaKeAwhnNV9Y3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In the attachment, I have reported a segmentation fault in git.

Regards,
Morten

--OgiGaKeAwhnNV9Y3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="git-bugreport-2024-12-22-1816.txt"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I had first run the command

   git difftool --no-symlinks --dir-diff

to show a diff between a modified file I intended to commit. After the commit
I ran the command again and git crashed.

What did you expect to happen? (Expected behavior)

  I expected git to show an empty output since the modified file had been
  committed.

What happened instead? (Actual behavior)

  It crashed.

What's different between what you expected and what actually happened?

  The crash

Anything else you want to add:

  Here is the trace which I hope is useful:

    ~/ % coredumpctl debug
               PID: 220080 (git)
               UID: 1000 (mojo)
               GID: 1000 (mojo)
            Signal: 11 (SEGV)
         Timestamp: Sun 2024-12-22 17:55:51 CET (13min ago)
      Command Line: git difftool --no-symlinks --dir-diff
        Executable: /usr/bin/git
     Control Group: /user.slice/user-1000.slice/user@1000.service/kitty-1421-3.scope
              Unit: user@1000.service
         User Unit: kitty-1421-3.scope
             Slice: user-1000.slice
         Owner UID: 1000 (mojo)
           Boot ID: 22b76570d3a848bb9c8ab817b3f01126
        Machine ID: 81a58827c2a04d8185f0370a425305ca
          Hostname: gatsby
           Storage: /var/lib/systemd/coredump/core.git.1000.22b76570d3a848bb9c8ab817b3f01126.220080.1734886551000000.zst (present)
      Size on Disk: 46.4K
           Message: Process 220080 (git) of user 1000 dumped core.
    
                    Stack trace of thread 220080:
                    #0  0x000060193ce06513 n/a (n/a + 0x0)
                    #1  0x000060193cc845c0 n/a (n/a + 0x0)
                    #2  0x000060193cc2e454 n/a (n/a + 0x0)
                    #3  0x000060193cc2ead9 n/a (n/a + 0x0)
                    #4  0x000060193cc297eb n/a (n/a + 0x0)
                    #5  0x00007a67eb5dee08 n/a (libc.so.6 + 0x25e08)
                    #6  0x00007a67eb5deecc __libc_start_main (libc.so.6 + 0x25ecc)
                    #7  0x000060193cc29cb5 n/a (n/a + 0x0)
                    ELF object binary architecture: AMD x86-64
    
    GNU gdb (GDB) 15.2
    Copyright (C) 2024 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.
    Type "show copying" and "show warranty" for details.
    This GDB was configured as "x86_64-pc-linux-gnu".
    Type "show configuration" for configuration details.
    For bug reporting instructions, please see:
    <https://www.gnu.org/software/gdb/bugs/>.
    Find the GDB manual and other documentation resources online at:
        <http://www.gnu.org/software/gdb/documentation/>.

    For help, type "help".
    Type "apropos word" to search for commands related to "word"...
    Reading symbols from /usr/bin/git...

    This GDB supports auto-downloading debuginfo from the following URLs:
      <https://debuginfod.archlinux.org>
    Enable debuginfod for this session? (y or [n]) y
    Debuginfod has been enabled.
    To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
    Downloading 17.81 M separate debug info for /usr/bin/git
    Reading symbols from /home/mojo/.cache/debuginfod_client/9b51ee185a3310bcbbdb7373865b42b912a1b10a/debuginfo...
    [New LWP 220080]
    Downloading 1.53 M separate debug info for /usr/lib/libpcre2-8.so.0
    Downloading 194.53 K separate debug info for /usr/lib/libz.so.1
    Downloading 9.36 M separate debug info for /usr/lib/libc.so.6
    Downloading 1.07 M separate debug info for /lib64/ld-linux-x86-64.so.2
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/usr/lib/libthread_db.so.1".
    Core was generated by `git difftool --no-symlinks --dir-diff'.
    Program terminated with signal SIGSEGV, Segmentation fault.
    Downloading 8.42 K source file /usr/src/debug/git/git-2.47.1/hashmap.c
    #0  hashmap_iter_next (iter=<synthetic pointer>) at /usr/src/debug/git/git-2.47.1/hashmap.c:299
    299iter->next = current->next;
    (gdb) bt
    #0  hashmap_iter_next (iter=<synthetic pointer>) at /usr/src/debug/git/git-2.47.1/hashmap.c:299
    #1  free_individual_entries (map=<optimized out>, entry_offset=<optimized out>) at /usr/src/debug/git/git-2.47.1/hashmap.c:183
    #2  hashmap_clear_ (map=0x7fff638c6aa0, entry_offset=<optimized out>) at /usr/src/debug/git/git-2.47.1/hashmap.c:207
    #3  0x000060193cc845c0 in hashmap_clear_ (map=0x7fff638c6aa0, entry_offset=0) at /usr/src/debug/git/git-2.47.1/hashmap.c:204
    #4  run_dir_diff (extcmd=0x0, symlinks=0, prefix=<optimized out>, child=0x7fff638c6ad0) at builtin/difftool.c:666
    #5  cmd_difftool (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>, repo=<optimized out>) at builtin/difftool.c:801
    #6  0x000060193cc2e454 in run_builtin (p=0x60193d03ed30 <commands.lto_priv+912>, argc=3, argv=0x7fff638c7990, repo=0x60193d04de20 <the_repo.lto_priv>)
        at /usr/src/debug/git/git-2.47.1/git.c:483
    #7  handle_builtin (argc=3, argv=0x7fff638c7990) at /usr/src/debug/git/git-2.47.1/git.c:749
    #8  0x000060193cc2ead9 in run_argv (argcp=0x7fff638c773c, argv=0x7fff638c7760) at /usr/src/debug/git/git-2.47.1/git.c:819
    #9  0x000060193cc297eb in cmd_main (argc=<optimized out>, argv=<optimized out>) at /usr/src/debug/git/git-2.47.1/git.c:954
    #10 main (argc=<optimized out>, argv=<optimized out>) at /usr/src/debug/git/git-2.47.1/common-main.c:64
    (gdb)

    Please review the rest of the bug report below.
    You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.11.0
OpenSSL: OpenSSL 3.4.0 22 Oct 2024
zlib: 1.3.1
uname: Linux 6.12.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Mon, 09 Dec 2024 14:31:57 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

--OgiGaKeAwhnNV9Y3--
