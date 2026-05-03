Received: from forward400d.mail.yandex.net (forward400d.mail.yandex.net [178.154.239.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F191DF27D
	for <git@vger.kernel.org>; Sun,  3 May 2026 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838222; cv=none; b=HmaeYuGhZnU8Um43nGFFijqGWNpVt2fX5IFlGUittQkNo2VLT6PxyZyTSmjbQRZVLs1wwBDUgMIIn4kJ8IqisRgx/J99zik79WzyRVCj+RoFafIaHrzIv3RgjzHkYLGfGWmIdWepiMoBGBQuEX0dkBGZg7LYy2XVFDNw40K7gD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838222; c=relaxed/simple;
	bh=UipdwfO3FAESWRt8IopshRPneDEY84pqqwqliRcP9oI=;
	h=From:To:Subject:MIME-Version:Date:Message-Id:Content-Type; b=Pioch3Vmc8VqWDtvpyBgpwH78/3Pq8Mwbvj3vL9higSaB5BN7ETG8NeX2vIP3Gnyk5VXst69Tyv8dsNqjXddBTTCZTmvK79dxHUyMDNgNaVGVyqtf1cvnhcnj4sZj9NALpdhY4aoaoZTzISpJE6f3KT6JCIB5BIQwxiEO7uhSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=kYHzF8GE; arc=none smtp.client-ip=178.154.239.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="kYHzF8GE"
Received: from mail-nwsmtp-mxback-production-main-361.klg.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-361.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:32a5:0:640:d58f:0])
	by forward400d.mail.yandex.net (Yandex) with ESMTPS id 88AED805F7
	for <git@vger.kernel.org>; Sun, 03 May 2026 22:50:53 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c42:b7c7:0:640:2848:0 [2a02:6b8:c42:b7c7:0:640:2848:0])
	by mail-nwsmtp-mxback-production-main-361.klg.yp-c.yandex.net (mxback) with HTTPS id QoktqU4vvW20-CCc0RGrS;
	Sun, 03 May 2026 22:50:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1777837853; bh=4//6tWSzDy47AwVUaozTHcWF8jgkBDmNnbqn4AIjlCw=;
	h=Message-Id:Date:Subject:To:From;
	b=kYHzF8GEE/HbUyfQZjmg1YtbTwBOd/MCcEfIXPaSZLZXSXT26jJOrnBfzwe4baae9
	 xTJMn8gqwJu601IpzQRbPFujreNkFObPjGM4A41M4JPU9NXcurHHbf32qE/80z4jal
	 iB95rB4Ya9EXQuA/yppfsvrjrJGWOhY8uXAyV308=
Authentication-Results: mail-nwsmtp-mxback-production-main-361.klg.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by mail-sendbernar-production-main-22.klg.yp-c.yandex.net (sendbernar) with HTTPS id 894843173281d3f8a215484f1ed54813;
	Sun, 03 May 2026 22:50:52 +0300
From: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
To: git@vger.kernel.org
Subject: git 2.54 fails to build for rhel 6 (2.53 builds fine)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sun, 03 May 2026 22:50:52 +0300
Message-Id: <9692091777837852@4991cc90-7cef-4f92-9de9-e195e7f2c04c>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

Hi everyone! I have noticed a problem when trying to build latest git 2.54 in rhel 6,(2.53 builds fine ) nothing has changed on this machine  since I successfully installed 2.53 . My openssl version is 3.5.6. Any Ideas? Below is the log 
~# wget --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.54.0.tar.gz
--2026-05-03 22:19:32--  https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.54.0.tar.gz
Connecting to 192.168.1.2:3128... connected.
Proxy request sent, awaiting response... 200 OK
Length: 12102611 (12M) [application/x-gzip]
Saving to: “git-2.54.0.tar.gz”

100%[======================================>] 12,102,611  1.88M/s   in 6.5s

2026-05-03 22:19:39 (1.78 MB/s) - “git-2.54.0.tar.gz” saved [12102611/12102611]

[sun] ~# tar -xf git-2.54.0.tar.gz
[sun] ~# cd git-2.54.0
[sun] git-2.54.0#  ./configure && make -j $(nproc)  CSPRNG_METHOD= &&  make -j $(nproc) install  CSPRNG_METHOD= && make -j $(nproc) clean
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
checking for gcc... /usr/local/gcc-13.4.0/bin/gcc-13.4
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... yes
checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... none needed
checking for stdio.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for strings.h... yes
checking for sys/stat.h... yes
checking for sys/types.h... yes
checking for unistd.h... yes
checking for size_t... yes
checking for working alloca.h... yes
checking for alloca... yes
configure: CHECKS for programs
checking whether the compiler supports GNU C... (cached) yes
checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... (cached) yes
checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features...(cached) none needed
checking for inline... inline
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... yes
checking for gar... no
checking for ar... ar
checking for gtar... gtar
checking for gnudiff... no
checking for gdiff... no
checking for diff... diff
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for curl_global_init in -lcurl... yes
checking for curl-config... curl-config
configure: Setting CURL_LDFLAGS to '-L/usr/local/lib -lcurl'
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -lc... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for inet_ntop... yes
checking for inet_pton... yes
checking for hstrerror... yes
checking for basename in -lc... yes
checking if libc contains libintl... yes
checking for libintl.h... yes
configure: CHECKS for header files
checking for sys/select.h... yes
checking for poll.h... yes
checking for sys/poll.h... yes
checking for inttypes.h... (cached) yes
checking for old iconv()... no
checking whether iconv omits bom for utf-16 and utf-32... no
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct itimerval... yes
checking for struct stat.st_mtimespec.tv_nsec... no
checking for struct stat.st_mtim.tv_nsec... yes
checking for struct dirent.d_type... yes
checking for struct passwd.pw_gecos... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking how to run the C preprocessor... /usr/local/gcc-13.4.0/bin/gcc-13.4 -E
checking for egrep -e... /bin/grep -E
checking whether the platform regex supports REG_STARTEND... yes
checking whether system succeeds to read fopen'ed directory... yes
checking whether snprintf() and/or vsnprintf() return bogus value... no
checking whether the platform uses typical file type bits... yes
configure: CHECKS for library functions
checking for libgen.h... yes
checking for paths.h... yes
checking for libcharset.h... no
checking for strings.h... (cached) yes
checking for locale_charset in -liconv... no
checking for locale_charset in -lcharset... no
checking for clock_gettime... no
checking for CLOCK_MONOTONIC... yes
checking for sync_file_range... yes
checking for library containing sync_file_range... none required
checking for setitimer... yes
checking for library containing setitimer... none required
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for memmem... yes
checking for library containing memmem... none required
checking for strlcpy... no
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for initgroups... yes
checking for library containing initgroups... none required
checking for getdelim... yes
checking for library containing getdelim... none required
checking for BSD sysctl... no
checking for sysinfo... yes
checking for POSIX Threads with ''... no
checking for POSIX Threads with '-mt'... no
checking for POSIX Threads with '-pthread'... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
config.status: executing config.mak.autogen commands
GIT_VERSION=2.54.0
    * new build flags
    * new link flags
    CC base85.o
    * new prefix flags
    CC bisect.o
    CC blame.o
    CC blob.o
    CC bloom.o
    CC branch.o
    CC bundle-uri.o
    CC bundle.o
    CC cache-tree.o
    CC cbtree.o
    CC chdir-notify.o
    CC checkout.o
    CC chunk-format.o
    CC color.o
    CC column.o
    CC combine-diff.o
    CC commit-graph.o
    CC commit-reach.o
    CC commit.o
    CC common-exit.o
    CC common-init.o
    CC compat/nonblock.o
    CC compat/obstack.o
    CC compat/open.o
    CC compat/terminal.o
    CC compiler-tricks/not-constant.o
    CC config.o
    CC connect.o
    CC connected.o
    CC convert.o
    CC copy.o
    CC credential.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC delta-islands.o
    CC diagnose.o
    CC diff-delta.o
    CC diff-merges.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diffcore-rotate.o
    CC dir-iterator.o
    CC dir.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC ewah/bitmap.o
    CC ewah/ewah_bitmap.o
    CC ewah/ewah_io.o
    CC ewah/ewah_rlw.o
    CC exec-cmd.o
    CC fetch-negotiator.o
    CC fetch-pack.o
    CC fmt-merge-msg.o
    CC fsck.o
    CC fsmonitor.o
    CC fsmonitor-ipc.o
    CC fsmonitor-settings.o
    CC gettext.o
    CC git-zlib.o
    CC gpg-interface.o
    CC graph.o
    CC grep.o
    CC hash-lookup.o
    CC hash.o
    CC hashmap.o
    GEN command-list.h
    CC hex.o
    CC hex-ll.o
    CC hook.o
    CC ident.o
    CC json-writer.o
    CC kwset.o
    CC levenshtein.o
    CC line-log.o
    CC line-range.o
    CC linear-assignment.o
    CC list-objects-filter-options.o
    CC list-objects-filter.o
    CC list-objects.o
    CC lockfile.o
    CC log-tree.o
    CC loose.o
    CC ls-refs.o
    CC mailinfo.o
    CC mailmap.o
    CC match-trees.o
    CC mem-pool.o
    CC merge-blobs.o
    CC merge-ll.o
    CC merge-ort.o
    CC merge-ort-wrappers.o
    CC merge.o
    CC midx.o
    CC midx-write.o
    CC name-hash.o
    CC negotiator/default.o
    CC negotiator/noop.o
    CC negotiator/skipping.o
    CC notes-cache.o
    CC notes-merge.o
    CC notes-utils.o
    CC notes.o
    CC object-file-convert.o
    CC object-file.o
    CC object-name.o
    CC object.o
    CC odb.o
    CC odb/source.o
    CC odb/source-files.o
    CC odb/streaming.o
    CC oid-array.o
    CC oidmap.o
    CC oidset.o
    CC oidtree.o
    CC pack-bitmap-write.o
    CC pack-bitmap.o
    CC pack-check.o
    CC pack-mtimes.o
    CC pack-objects.o
    CC pack-refs.o
    CC pack-revindex.o
    CC pack-write.o
    CC packfile.o
    CC pager.o
    CC parallel-checkout.o
    CC parse.o
    CC parse-options-cb.o
    CC parse-options.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC path-walk.o
    CC pathspec.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC prio-queue.o
    CC progress.o
    CC promisor-remote.o
    CC prompt.o
    CC protocol.o
    CC protocol-caps.o
    CC prune-packed.o
    CC pseudo-merge.o
    CC quote.o
    CC range-diff.o
    CC reachable.o
    CC read-cache.o
    CC rebase-interactive.o
    CC rebase.o
    CC ref-filter.o
    CC reflog-walk.o
    CC reflog.o
    CC refs.o
    CC refs/debug.o
    CC refs/files-backend.o
    CC refs/reftable-backend.o
    CC refs/iterator.o
    CC refs/packed-backend.o
    CC refs/ref-cache.o
    CC refspec.o
    CC reftable/basics.o
    CC reftable/block.o
    CC reftable/blocksource.o
    CC reftable/error.o
    CC reftable/fsck.o
    CC reftable/iter.o
    CC reftable/merged.o
    CC reftable/pq.o
    CC reftable/record.o
    CC reftable/stack.o
    CC reftable/system.o
    CC reftable/table.o
    CC reftable/tree.o
    CC reftable/writer.o
    CC remote.o
    CC repack.o
    CC repack-cruft.o
    CC repack-filtered.o
    CC repack-geometry.o
    CC repack-midx.o
    CC repack-promisor.o
    CC replace-object.o
    CC repo-settings.o
    CC replay.o
    CC repository.o
    CC rerere.o
    CC reset.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC send-pack.o
    CC sequencer.o
    CC serve.o
    CC server-info.o
    CC setup.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC sparse-index.o
    CC split-index.o
    CC stable-qsort.o
    CC statinfo.o
    CC strbuf.o
    CC string-list.o
    CC strmap.o
    CC strvec.o
    CC sub-process.o
    CC submodule-config.o
    CC submodule.o
    CC symlinks.o
    CC tag.o
    CC tempfile.o
    CC thread-utils.o
    CC tmp-objdir.o
    CC trace.o
    CC trace2.o
    CC trace2/tr2_cfg.o
    CC trace2/tr2_cmd_name.o
    CC trace2/tr2_ctr.o
    CC trace2/tr2_dst.o
    CC trace2/tr2_sid.o
    CC trace2/tr2_sysenv.o
    CC trace2/tr2_tbuf.o
    CC trace2/tr2_tgt_event.o
    CC trace2/tr2_tgt_normal.o
    CC trace2/tr2_tgt_perf.o
    CC trace2/tr2_tls.o
    CC trace2/tr2_tmr.o
    CC trailer.o
    CC transport-helper.o
    CC transport.o
    CC tree-diff.o
    CC tree-walk.o
    CC tree.o
    CC unpack-trees.o
    CC upload-pack.o
    CC url.o
    CC urlmatch.o
    CC usage.o
    CC userdiff.o
    CC utf8.o
    CC varint.o
    CC versioncmp.o
    CC walker.o
    CC wildmatch.o
    CC worktree.o
    CC wrapper.o
    CC write-or-die.o
    CC ws.o
    CC wt-status.o
    CC xdiff-interface.o
    CC xdiff/xdiffi.o
    CC xdiff/xemit.o
    CC xdiff/xhistogram.o
    CC xdiff/xmerge.o
    CC xdiff/xpatience.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC unix-socket.o
    CC unix-stream-server.o
    CC compat/simple-ipc/ipc-shared.o
    CC compat/simple-ipc/ipc-unix-socket.o
    CC sha1dc_git.o
    CC sha1dc/sha1.o
    CC sha1dc/ubc_check.o
    CC sha256/block/sha256.o
    CC compat/linux/procinfo.o
    CC compat/fopen.o
    CC compat/strlcpy.o
    CC compat/qsort_s.o
    CC http-backend.o
    CC imap-send.o
imap-send.c: In function ‘host_matches’:
imap-send.c:224:45: warning: implicit declaration of function ‘ASN1_STRING_get0_data’; did you mean ‘ASN1_STRING_data’? [-Wimplicit-function-declaration]
  224 |         const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
      |                                             ^~~~~~~~~~~~~~~~~~~~~
      |                                             ASN1_STRING_data
imap-send.c:224:31: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  224 |         const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
      |                               ^
imap-send.c: In function ‘verify_hostname’:
imap-send.c:274:47: warning: passing argument 1 of ‘X509_NAME_ENTRY_get_data’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  274 |             (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
      |                                               ^~~~~~~~~~~
In file included from /usr/include/openssl/ssl.h:156,
                 from git-compat-util.h:193,
                 from imap-send.c:27:
/usr/include/openssl/x509.h:1040:59: note: expected ‘X509_NAME_ENTRY *’ {aka ‘struct X509_name_entry_st *’} but argument is of type ‘const X509_NAME_ENTRY *’ {aka ‘const struct X509_name_entry_st *’}
 1040 | ASN1_STRING *   X509_NAME_ENTRY_get_data(X509_NAME_ENTRY *ne);
      |                                          ~~~~~~~~~~~~~~~~~^~
    CC http.o
    CC sh-i18n--envsubst.o
    CC shell.o
    CC http-walker.o
    CC http-fetch.o
    CC http-push.o
    CC remote-curl.o
    * new script parameters
    * new perl-specific parameters
    GEN git-p4
    GEN git-instaweb
    CC git.o
    CC builtin/add.o
    CC builtin/am.o
    CC builtin/annotate.o
    CC builtin/apply.o
    CC builtin/archive.o
    CC builtin/backfill.o
    CC builtin/bisect.o
    CC builtin/blame.o
    CC builtin/branch.o
    GEN hook-list.h
    CC builtin/bundle.o
    CC builtin/cat-file.o
    CC builtin/check-attr.o
    CC builtin/check-mailmap.o
    CC builtin/check-ignore.o
    CC builtin/check-ref-format.o
    CC builtin/checkout--worker.o
    CC builtin/checkout-index.o
    CC builtin/checkout.o
    CC builtin/clean.o
    CC builtin/clone.o
    CC builtin/column.o
    CC builtin/commit-graph.o
    CC builtin/commit-tree.o
    CC builtin/commit.o
    CC builtin/config.o
    CC builtin/count-objects.o
    CC builtin/credential-cache--daemon.o
    CC builtin/credential-cache.o
    CC builtin/credential-store.o
    CC builtin/credential.o
    CC builtin/describe.o
    CC builtin/diagnose.o
    CC builtin/diff-files.o
    CC builtin/diff-index.o
    CC builtin/diff-pairs.o
    CC builtin/diff-tree.o
    CC builtin/diff.o
    CC builtin/difftool.o
    CC builtin/fast-export.o
    CC builtin/fast-import.o
    CC builtin/fetch-pack.o
    CC builtin/fetch.o
    CC builtin/fmt-merge-msg.o
    CC builtin/for-each-ref.o
    CC builtin/for-each-repo.o
    CC builtin/fsck.o
    CC builtin/fsmonitor--daemon.o
    CC builtin/gc.o
    CC builtin/get-tar-commit-id.o
    CC builtin/grep.o
    CC builtin/hash-object.o
    GEN config-list.h
    CC builtin/history.o
    CC builtin/hook.o
    CC builtin/index-pack.o
    CC builtin/init-db.o
    CC builtin/interpret-trailers.o
    CC builtin/last-modified.o
    CC builtin/log.o
    CC builtin/ls-files.o
    CC builtin/ls-remote.o
    CC builtin/ls-tree.o
    CC builtin/mailinfo.o
    CC builtin/mailsplit.o
    CC builtin/merge-base.o
    CC builtin/merge-file.o
    CC builtin/merge-index.o
    CC builtin/merge-ours.o
    CC builtin/merge-recursive.o
    CC builtin/merge.o
    CC builtin/merge-tree.o
    CC builtin/mktag.o
    CC builtin/mktree.o
    CC builtin/multi-pack-index.o
    CC builtin/mv.o
    CC builtin/name-rev.o
    CC builtin/notes.o
    CC builtin/pack-objects.o
    CC builtin/pack-redundant.o
    CC builtin/pack-refs.o
    CC builtin/patch-id.o
    CC builtin/prune-packed.o
    CC builtin/prune.o
    CC builtin/pull.o
    CC builtin/push.o
    CC builtin/range-diff.o
    CC builtin/read-tree.o
    CC builtin/rebase.o
    CC builtin/receive-pack.o
    CC builtin/reflog.o
    CC builtin/refs.o
    CC builtin/remote-ext.o
    CC builtin/remote-fd.o
    CC builtin/remote.o
    CC builtin/repack.o
    CC builtin/replace.o
    CC builtin/replay.o
    CC builtin/repo.o
    CC builtin/rerere.o
    CC builtin/reset.o
    CC builtin/rev-list.o
    CC builtin/rev-parse.o
    CC builtin/revert.o
    CC builtin/rm.o
    CC builtin/send-pack.o
    CC builtin/shortlog.o
    CC builtin/show-branch.o
    CC builtin/show-index.o
    CC builtin/show-ref.o
    CC builtin/sparse-checkout.o
    CC builtin/stash.o
    CC builtin/stripspace.o
    CC builtin/submodule--helper.o
    CC builtin/symbolic-ref.o
    CC builtin/tag.o
    CC builtin/unpack-file.o
    CC builtin/unpack-objects.o
    CC builtin/update-index.o
    CC builtin/update-ref.o
    CC builtin/update-server-info.o
    CC builtin/upload-archive.o
    CC builtin/upload-pack.o
    CC builtin/var.o
    CC builtin/verify-commit.o
    CC builtin/verify-pack.o
    CC builtin/verify-tag.o
    CC builtin/worktree.o
    CC builtin/write-tree.o
    GEN git-mergetool--lib
    GEN git-sh-i18n
    GEN git-sh-setup
    CC scalar.o
    CC daemon.o
    CC common-main.o
    CC abspath.o
    CC add-interactive.o
    CC add-patch.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC apply.o
    CC archive-tar.o
    CC archive-zip.o
    CC archive.o
    CC attr.o
    CC help.o
    GEN version-def.h
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-quiltimport
    GEN git-request-pull
    GEN git-submodule
    GEN git-web--browse
    GEN GIT-PERL-HEADER
    CC builtin/bugreport.o
    CC builtin/help.o
    CC version.o
    GEN git-cvsexportcommit
    GEN git-archimport
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-send-email
    GEN git-svn
    AR libgit.a
    LINK git-daemon
    LINK git-http-backend
    LINK git-imap-send
    LINK git-sh-i18n--envsubst
    LINK git-shell
/usr/local/bin/ld: warning: libssl.so.3, needed by /usr/local/lib/libcurl.so, may conflict with libssl.so.10
    LINK git-http-fetch
/usr/local/bin/ld: warning: libcrypto.so.3, needed by /usr/local/lib/libcurl.so,may conflict with libcrypto.so.10
/usr/local/bin/ld: imap-send.o: undefined reference to symbol 'ASN1_STRING_get0_data@@OPENSSL_3.0.0'
/usr/local/bin/ld: /usr/local/openssl/lib/libcrypto.so.3: error adding symbols:DSO missing from command line
collect2: error: ld returned 1 exit status
make: *** [Makefile:3003: git-imap-send] Error 1
make: *** Waiting for unfinished jobs....
 cd ~
[sun] ~# git --version
git version 2.53.0
[sun] ~# git --version^C
[sun] ~# ^C
[sun] ~# openssl version
OpenSSL 3.5.6 7 Apr 2026 (Library: OpenSSL 3.5.6 7 Apr 2026)

