Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F744DA528
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449229; cv=none; b=bXJYn3zAHqve7Byg8ui17Af0IKqSk5fPfHhome7uD+ei4aCaEv74s19bMJEFanumkWxTXe+QMujFD0FW3gXf6yLbsXAtoGa8atHqz2ixRT6WGxGLRR3DdlBn+8LhZgMRZAI8pKZBJ4Vsk4A0+rFi+4r88tpdrve39CAvyeDwGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449229; c=relaxed/simple;
	bh=pP3ZOL3aYN1RMPTjrVYRpnEwRAaMQFahqP1xx5uSMMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=M/ydXBxediP9b3NtLevuzXqyPcwQ1P54vNaOHYSQUj+rtIdTyAGILdIBTxSfLDXlZq2wd2G/r85+86RAy9nMTwnVxqPq6s3SwTSOpBj0bSY597fOBTtF/ynstsNheX/eU8tFyVr+fQ6hNp7Iyl1SDBkN/mcpOE7J+2eC4su976I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VVqwrhGi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bez0ufoR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VVqwrhGi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bez0ufoR"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A851EC02BA;
	Thu,  3 Sep 2026 11:27:06 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 03 Sep 2026 11:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1788449226; x=1788535626; bh=ah
	jqKJBcmB9VMokXQftx8E6HMVE6ka1Af0aOpd/6JkA=; b=VVqwrhGiij/PH30cOy
	UO8zch9I1ae8/2Jzl/JRzH99TjMvaIyQDUwJEcTAVyP/Sd3RZOJzBOVdy/mxNdnA
	UVCHxmXUAbUM1Ij9yPFQqr541kymKgKpPrHjkJJR8WKsfWmSdLwqgWGvSs0PCCKd
	OKki/VkSdj7LgTYWTQ7IKfmN5lVs+Kyeq0ogxXeEWEPyYIvj0ISfuaYW4IbxIrks
	ZLONx5MGuWFgMqCXbBVn/SBfkwf8oukhG6r2bSibPI/lujH5reeoJ9kIvF64VFNF
	y2el28GRK1wW6FPCaH0x/Z7unheQKuvZrUXwuHPf7S81e2a0kkNoljlqI8qUOt9M
	z/nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788449226; x=1788535626; bh=ahjqKJBcmB9VMokXQftx8E6HMVE6
	ka1Af0aOpd/6JkA=; b=bez0ufoRWlwa+mGnToEh7xOW5jpaNbmL2fG2VyY/1325
	eEykXJnaaRJUvIkqxSt9miUtvH8LXVdyrnUyMe+gAK2TK1va1ELfFkCoCS+QcKiI
	koC3uQhw3pdeY5+NJ0lqXSvHUh7Dl5vMKKR7aGFWz1ZWzjezVzUYG3jG8YI3mLK9
	D6xgNd5Gdc2fdvKKrsXrrHOj6jqr5E5m7v0mQMSh39HLZwAQlsD/lJXdJ7VaGUeQ
	S8bjrwUPTsYvyBkIsviHA6gX9F/0q1X0dhLg22lsxfNuHLba5GXlDKVNQcGcU9nD
	EgUCtFdPrvrAARJYNcLfro+FaHpZ+D5aVLOg2/Dm4Q==
X-ME-Sender: <xms:yJGZapKNuC45Qsx-ajRlxf4j6K8rHZoU4wByt44lO6YvY4qvkq_1Slw>
    <xme:yJGZav9G7K3K6LBjCDQ23xWTtCOUl3pKm4eG55FIQZBLNcpQ29W3Mc_PB2EsBnUt7
    iqSPYLm5m9KRmO6PM06vqdRto8ADvydx5CSx0Val31YxIEUzWSYatg>
X-ME-Proxy-Cause: dmFkZTEmc+bXTHKypv66+7fOczTvi+PLFqGC0kfVAlCRRD3dtLf3ticC67m+6Vwfmm4cSs
    mlo+aII2bpRm4saN/UT9h+pNYNf3OczL9XlBEJ96WYGduvShcwU5Y25lQqY3AOZwPtm7AN
    7miXDVsIwYV5zEZFvBztzYYHllu+tCzAym0p/gw/vB2toTVPUYlXXMETDGl5P/WQDj0oPt
    vEJOAkXfPi6q1YDtbaZ79AkQAgirwLNW75ACbR0ASrdDztpakECoBqnsWs4St+o1ObIYqo
    6IFQ7XH+hPSWZDTpgQUvNwlalFYng91cZDvKlb/zmvotHBubYoojsYYhGUL8v7+rA3lNQ4
    BEZEqelV6D2BOMI4YtFohk8epl/TUmwkNK1xAH2MPhiIdwNHrTnGgj5I88+gxfiM5RUXXN
    jqqqZk1gfkYtntHpQ8pggj8Hi0UKqYn/aNANtLxNVssZk7pVoz3bGLJ/omgH7C/F2GvCoX
    d/eYHaMYQAJRqoCDHOXsMlPShuuUfObH0mbJjZEqzPoGl7oQL+c+nb2TIQeVSeCccdvL2i
    NfcRIbpDHwBmcxCqx4Set8Wl/ykB1VhIaigfOWQYI2EzuJFvrxzZT7fPufd8hK4yJDWkCP
    p4z2QU97pUlh7L0TdQuwii4DoitjooFNBjYgA5b5nQVO4MPMR8x39iuadNTw
X-ME-Proxy: <xmx:yZGZaj19aS8OljS9PJPkNKu7c9_4TJDkjLY0HHbcfvRvSth_J4LUvA>
    <xmx:yZGZagBqhXiAx8mA60MVbW7mBHMHoQLL6GK_8raoiZCv6tZFIsUcug>
    <xmx:yZGZaref0M8k_FD2Pxqi32H6nbOW5OqEo0PvhWs8KJZfBLo6Vavj6w>
    <xmx:yZGZalhWnnfE11hTuCUibtRTtf-NqbLPJ7jmH6n0KgP--T4R8F81Ig>
    <xmx:ypGZaqtcwcD42qYqY5AC7BgCNtxe44UmBG-8gHQKz3-aZgUaLOfdPXai>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 81DB722C007D; Thu,  3 Sep 2026 11:27:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 17:26:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <04faa984-5b56-406b-baa9-dbb4b5eab259@app.fastmail.com>
Subject: history: 'reword HEAD' surfaces a memory leak
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I get a sanitizer error when I run a simple reword command:

    $ make SANITIZE=3Daddress install
    $ GIT_EDITOR=3Dtrue git history reword \
        --dry-run 3cb9185f65410273787f74333cc027d2ea5daada
    update HEAD eeb9d4b5c4041739c0a19b4043924513c8aad2d2 3cb9185f6541027=
3787f74333cc027d2ea5daada

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    =3D=3D116999=3D=3DERROR: LeakSanitizer: detected memory leaks

    Direct leak of 283 byte(s) in 1 object(s) allocated from:
        #0 0x712d2f6b4887 in __interceptor_malloc ../../../../src/libsan=
itizer/asan/asan_malloc_linux.cpp:145
        #1 0x61970a5757b2 in do_xmalloc /home/kristoffer/programming/git=
-worktree/git-leakcheck/wrapper.c:55
        #2 0x61970a575ec0 in do_xmallocz /home/kristoffer/programming/gi=
t-worktree/git-leakcheck/wrapper.c:89
        #3 0x61970a575ec0 in do_xmallocz /home/kristoffer/programming/gi=
t-worktree/git-leakcheck/wrapper.c:79
        #4 0x61970a575ec0 in xmallocz_gently /home/kristoffer/programmin=
g/git-worktree/git-leakcheck/wrapper.c:102
        #5 0x61970a309ca0 in unpack_compressed_entry /home/kristoffer/pr=
ogramming/git-worktree/git-leakcheck/packfile.c:1732
        #6 0x61970a310bf0 in unpack_entry /home/kristoffer/programming/g=
it-worktree/git-leakcheck/packfile.c:1885
        #7 0x61970a311fbf in cache_or_unpack_entry /home/kristoffer/prog=
ramming/git-worktree/git-leakcheck/packfile.c:1528
        #8 0x61970a311fbf in packed_object_info_with_index_pos /home/kri=
stoffer/programming/git-worktree/git-leakcheck/packfile.c:1610
        #9 0x61970a313097 in packed_object_info /home/kristoffer/program=
ming/git-worktree/git-leakcheck/packfile.c:1720
        #10 0x61970a313097 in packfile_store_read_object_info /home/kris=
toffer/programming/git-worktree/git-leakcheck/packfile.c:2214
        #11 0x61970a2caae8 in odb_source_files_read_object_info odb/sour=
ce-files.c:58
        #12 0x61970a2c69a7 in odb_source_read_object_info odb/source.h:3=
26
        #13 0x61970a2c69a7 in do_oid_object_info_extended /home/kristoff=
er/programming/git-worktree/git-leakcheck/odb.c:572
        #14 0x61970a2c69a7 in odb_read_object_info_extended /home/kristo=
ffer/programming/git-worktree/git-leakcheck/odb.c:710
        #15 0x61970a2c7cbe in odb_read_object /home/kristoffer/programmi=
ng/git-worktree/git-leakcheck/odb.c:756
        #16 0x61970a101d5a in repo_get_commit_buffer /home/kristoffer/pr=
ogramming/git-worktree/git-leakcheck/commit.c:399
        #17 0x61970a101d5a in repo_get_commit_buffer /home/kristoffer/pr=
ogramming/git-worktree/git-leakcheck/commit.c:391
        #18 0x61970a346bf6 in repo_logmsg_reencode /home/kristoffer/prog=
ramming/git-worktree/git-leakcheck/pretty.c:716
        #19 0x619709ebbe64 in commit_tree_ext builtin/history.c:127
        #20 0x619709ebd17f in commit_tree_with_edited_message builtin/hi=
story.c:183
        #21 0x619709ebd17f in cmd_history_reword builtin/history.c:717
        #22 0x619709ec186f in cmd_history builtin/history.c:998
        #23 0x619709d87ca0 in run_builtin /home/kristoffer/programming/g=
it-worktree/git-leakcheck/git.c:506
        #24 0x619709d87ca0 in handle_builtin /home/kristoffer/programmin=
g/git-worktree/git-leakcheck/git.c:782
        #25 0x619709d8c9a6 in run_argv /home/kristoffer/programming/git-=
worktree/git-leakcheck/git.c:865
        #26 0x619709d8c9a6 in cmd_main /home/kristoffer/programming/git-=
worktree/git-leakcheck/git.c:986
        #27 0x619709d83f54 in main /home/kristoffer/programming/git-work=
tree/git-leakcheck/common-main.c:9
        #28 0x712d2f229d8f in __libc_start_call_main ../sysdeps/nptl/lib=
c_start_call_main.h:58

    SUMMARY: AddressSanitizer: 283 byte(s) leaked in 1 allocation(s).

The `--dry-run` is optional.

I get this on master, next, and seen, respectively:

1. `master`: 17ff1f98 (Sync with 'master', 2026-09-02)
2. 17ff1f98 (Sync with 'master', 2026-09-02)
3. 99855fed (Merge branch 'cc/early-scan-options' into seen, 2026-09-02)

I do not get this error when testing on the commit that introduced `git
history reword` (see later bisect log).

It=E2=80=99s too technical for me, but it seems that git-history(1) just
triggers a memory leak in the internal library (name?) code. Maybe you
need a packfile and/or a commit graph?

Bisecting told me that the first bad commit is 13763ecf (Merge branch
'ps/receive-pack-shallow-optim', 2026-03-02).

I tried to make an automated test for it but didn=E2=80=99t quite hack i=
t. I got
an ad hoc repo to reproduce. Running a GC or commit-graph (and/or) might
have what have done it.

But it seems to happen every time I run the command in a =E2=80=9Creal r=
epo=E2=80=9D as
long as I don=E2=80=99t violate one of the preconditions (=E2=80=9Ccan=E2=
=80=99t replay merge
commits yet!=E2=80=9D etc.).

BISECT SCRIPT

Note: hopefully this isn=E2=80=99t sensitive to if there are
refs pointing to that commit. The commit is just
`git rev-parse origin/master`.

```
#!/bin/sh

# No setup. Just use this repo.
make SANITIZE=3Daddress || exit 125
: >err.txt
GIT_EDITOR=3Dtrue ./bin-wrappers/git history reword 3cb9185f65410273787f=
74333cc027d2ea5daada 2>err.txt || {
    grep -q 'detected memory leaks' err.txt && exit 1
}

exit 0
```

BISECT LOG

    $ git bisect log
    git bisect start
    # status: waiting for both 'good' and 'bad' commits
    # bad: [1630431f326e15fcde608827b5ff38422528eb59] The 21st batch
    git bisect bad 1630431f326e15fcde608827b5ff38422528eb59
    # status: waiting for 'good' commit(s), 'bad' commit known
    # good: [d205234cb05a5e330c0f7f5b3ea764533a74d69e] builtin/history: =
implement "reword" subcommand
    git bisect good d205234cb05a5e330c0f7f5b3ea764533a74d69e
    # bad: [27caa6b4f7bce94fc1f07b96bcb0bcef8c5215f5] Merge branch 'en/b=
ackfill-fixes-and-edges'
    git bisect bad 27caa6b4f7bce94fc1f07b96bcb0bcef8c5215f5
    # bad: [6cdef943d28fa7d6964ec570b33a0bff4c80ea8c] Merge branch 'ps/o=
db-sources' into ps/object-counting
    git bisect bad 6cdef943d28fa7d6964ec570b33a0bff4c80ea8c
    # good: [94336d77bcbf4360b67a9454d8bf2e84b3d88ae7] Merge branch 'sd/=
doc-my1c-api-config-reference-fix'
    git bisect good 94336d77bcbf4360b67a9454d8bf2e84b3d88ae7
    # bad: [13763ecf7d92be72beff75c59163c5448d9e085e] Merge branch 'ps/r=
eceive-pack-shallow-optim'
    git bisect bad 13763ecf7d92be72beff75c59163c5448d9e085e
    # good: [bb9c781f4f4be2e6bf6285149ba7007fdaa735e7] Merge branch 'ps/=
history-ergonomics-updates'
    git bisect good bb9c781f4f4be2e6bf6285149ba7007fdaa735e7
    # good: [2cc71917514657b93014134350864f4849edfc83] The 8th batch
    git bisect good 2cc71917514657b93014134350864f4849edfc83
    # good: [664bd4e15a99a477acb616337df0f9fa95c729c3] Merge branch 'ty/=
symlinks-use-unsigned-for-bitset'
    git bisect good 664bd4e15a99a477acb616337df0f9fa95c729c3
    # good: [05c4af5c8f3d7310c8a3b2909d30ce761c6757aa] Merge branch 'kh/=
doc-am-xref'
    git bisect good 05c4af5c8f3d7310c8a3b2909d30ce761c6757aa
    # good: [427d39ca4f4f7a0e66652d92340af43cbda5135e] Merge branch 'ps/=
meson-gitk-git-gui'
    git bisect good 427d39ca4f4f7a0e66652d92340af43cbda5135e
    # good: [34113149cfde760b6b791939c6d8d87d27ca2767] Merge branch 'kh/=
doc-patch-id-4'
    git bisect good 34113149cfde760b6b791939c6d8d87d27ca2767
    # good: [024b4c96976fabdc8b73f4183d6bb8626ffe2c7d] commit: make `rep=
o_parse_commit_no_graph()` more robust
    git bisect good 024b4c96976fabdc8b73f4183d6bb8626ffe2c7d
    # good: [bb5da75d6116c35924a04a418ef4c3182663d0a2] commit: use commi=
t graph in `lookup_commit_reference_gently()`
    git bisect good bb5da75d6116c35924a04a418ef4c3182663d0a2
    # first 'bad' commit: [13763ecf7d92be72beff75c59163c5448d9e085e] Mer=
ge branch 'ps/receive-pack-shallow-optim'
