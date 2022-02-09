Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797DC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiBICkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245173AbiBIC1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:27:35 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708BC06157B
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:27:33 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o3so711658qtm.12
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZ5AzPyfOGriso2Bn4PsQYZIw/RamdtXu5OaGmKbRHg=;
        b=YTtKFxcASJpC10J8ZIhrQ/+b4yM7cP/YqPWdswSwB/ehiNm0tBKsIZRiELBBhrZfZe
         Ln7vTxlr0ojnMtZt3GsYTCQ240A0SVrTp/jb1cjR8WpwruTDmwqa1JlugsCMXxMfgYqj
         PFjMIBb5TFf5AcHTc0b4JdELvKIt0BWjtCui9LPKMGdNQ3cYGfA0OH0ryH/0J67QtOkZ
         oLbQoLZKshfUEocKKcconUZORn+/Rpfwn0BtTnIifQziSc/2QTlAeYqDPUgEinfGqkrp
         idFFYMVS9gqxsw/ABbTNHERWkT6/+o4vUWLqWgBHW6dsFG/2RntZIYmHdzkswwYJWCxR
         ZFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZ5AzPyfOGriso2Bn4PsQYZIw/RamdtXu5OaGmKbRHg=;
        b=0OHGKWTfGfBpjxQC9pUTsMULdBl16O0IungijMO5psFBpTyKtavNw/hiUDBb2i3TgZ
         oS6QZqKm4OXR5xfErSmDUYiLXszcAy0FvHX+Egk2ljiM5k0e4rTdkG3l1q4FI7ytHhjT
         X2dux96YNixwCuaYCgSskUGcdWl8yb0CznXgEQuazkJ89Qv+ZN11bj6dgBAjzmSTbVGN
         Va1lN6vvkTtdmBhOJJezvtxIEnlx/TLsdBWS7m4Y+kc/dEbh/dAcAnyTBa+nnKh3xqi9
         wNZI3zcHduVuzZ19VhDRWf7SxCfnJtJy/t0hq71cbsgYhKhDIRQtvLqUBF/46SE/DQHm
         HCgg==
X-Gm-Message-State: AOAM531EQmPPqHqdnN6sP0SzwHHPsDNDazhn9TjrmbyIoWQmfsuMofkA
        5MUi/Lb48ZfE3Bp39zeJeiR7EQM9/NA=
X-Google-Smtp-Source: ABdhPJwbhy7CiD+slzXYs3uVqY6kHOWwxINuUFBGpIwdVbzdSdyMfqBD/CKOpPdhdxHDIvHQFvcIHQ==
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr38596qtv.637.1644373652875;
        Tue, 08 Feb 2022 18:27:32 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id y2sm7609344qke.33.2022.02.08.18.27.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 18:27:32 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, robert@coup.net.nz
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Date:   Tue, 08 Feb 2022 21:27:31 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <21ED346B-A906-4905-B061-EDE53691C586@gmail.com>
In-Reply-To: <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

I'm not sure where I went wrong on GGG. Somehow the cc list didn't get tr=
anslated into
cc fields. Here's the PR: https://github.com/git/git/pull/1206. Thanks!

cc'ing folks I meant to cc for this patch series

On 8 Feb 2022, at 21:10, John Cai via GitGitGadget wrote:

> This patch series makes partial clone more useful by making it possible=
 to
> run repack to remove objects from a repository (replacing it with promi=
sor
> objects). This is useful when we want to offload large blobs from a git=

> server onto another git server, or even use an http server through a re=
mote
> helper.
>
> In [A], a --refilter option on fetch and fetch-pack is being discussed =
where
> either a less restrictive or more restrictive filter can be used. In th=
e
> more restrictive case, the objects that already exist will not be delet=
ed.
> But, one can imagine that users might want the ability to delete object=
s
> when they apply a more restrictive filter in order to save space, and t=
his
> patch series would also allow that.
>
> There are a couple of things we need to adjust to make this possible. T=
his
> patch has three parts.
>
>  1. Allow --filter in pack-objects without --stdout
>  2. Add a --filter flag for repack
>  3. Allow missing promisor objects in upload-pack
>  4. Tests that demonstrate the ability to offload objects onto an http
>     remote
>
> cc: Christian Couder christian.couder@gmail.com cc: Derrick Stolee
> stolee@gmail.com cc: Robert Coup robert@coup.net.nz
>
> A.
> https://lore.kernel.org/git/pull.1138.git.1643730593.gitgitgadget@gmail=
=2Ecom/
>
> John Cai (4):
>   pack-objects: allow --filter without --stdout
>   repack: add --filter=3D<filter-spec> option
>   upload-pack: allow missing promisor objects
>   tests for repack --filter mode
>
>  Documentation/git-repack.txt   |   5 +
>  builtin/pack-objects.c         |   2 -
>  builtin/repack.c               |  22 +++--
>  t/lib-httpd.sh                 |   2 +
>  t/lib-httpd/apache.conf        |   8 ++
>  t/lib-httpd/list.sh            |  43 +++++++++
>  t/lib-httpd/upload.sh          |  46 +++++++++
>  t/t0410-partial-clone.sh       |  81 ++++++++++++++++
>  t/t0410/git-remote-testhttpgit | 170 +++++++++++++++++++++++++++++++++=

>  t/t7700-repack.sh              |  20 ++++
>  upload-pack.c                  |   5 +
>  11 files changed, 395 insertions(+), 9 deletions(-)
>  create mode 100644 t/lib-httpd/list.sh
>  create mode 100644 t/lib-httpd/upload.sh
>  create mode 100755 t/t0410/git-remote-testhttpgit
>
>
> base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
206%2Fjohn-cai%2Fjc-repack-filter-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1206=
/john-cai/jc-repack-filter-v2
> Pull-Request: https://github.com/git/git/pull/1206
>
> Range-diff vs v1:
>
>  1:  0eec9b117da =3D 1:  f43b76ca650 pack-objects: allow --filter witho=
ut --stdout
>  -:  ----------- > 2:  6e7c8410b8d repack: add --filter=3D<filter-spec>=
 option
>  -:  ----------- > 3:  40612b9663b upload-pack: allow missing promisor =
objects
>  2:  a3166381572 ! 4:  d76faa1f16e repack: add --filter=3D<filter-spec>=
 option
>      @@ Metadata
>       Author: John Cai <johncai86@gmail.com>
>
>        ## Commit message ##
>      -    repack: add --filter=3D<filter-spec> option
>      +    tests for repack --filter mode
>
>      -    Currently, repack does not work with partial clones. When rep=
ack is run
>      -    on a partially cloned repository, it grabs all missing object=
s from
>      -    promisor remotes. This also means that when gc is run for rep=
ository
>      -    maintenance on a partially cloned repository, it will end up =
getting
>      -    missing objects, which is not what we want.
>      -
>      -    In order to make repack work with partial clone, teach repack=
 a new
>      -    option --filter, which takes a <filter-spec> argument. repack=
 will skip
>      -    any objects that are matched by <filter-spec> similar to how =
the clone
>      -    command will skip fetching certain objects.
>      -
>      -    The final goal of this feature, is to be able to store object=
s on a
>      -    server other than the regular git server itself.
>      +    This patch adds tests to test both repack --filter functional=
ity in
>      +    isolation (in t7700-repack.sh) as well as how it can be used =
to offload
>      +    large blobs (in t0410-partial-clone.sh)
>
>           There are several scripts added so we can test the process of=
 using a
>      -    remote helper to upload blobs to an http server:
>      +    remote helper to upload blobs to an http server.
>
>           - t/lib-httpd/list.sh lists blobs uploaded to the http server=
=2E
>           - t/lib-httpd/upload.sh uploads blobs to the http server.
>      @@ Commit message
>           Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>=

>           Signed-off-by: John Cai <johncai86@gmail.com>
>
>      - ## Documentation/git-repack.txt ##
>      -@@ Documentation/git-repack.txt: depth is 4095.
>      - 	a larger and slower repository; see the discussion in
>      - 	`pack.packSizeLimit`.
>      -
>      -+--filter=3D<filter-spec>::
>      -+	Omits certain objects (usually blobs) from the resulting
>      -+	packfile. See linkgit:git-rev-list[1] for valid
>      -+	`<filter-spec>` forms.
>      -+
>      - -b::
>      - --write-bitmap-index::
>      - 	Write a reachability bitmap index as part of the repack. This
>      -
>      - ## builtin/repack.c ##
>      -@@ builtin/repack.c: struct pack_objects_args {
>      - 	const char *depth;
>      - 	const char *threads;
>      - 	const char *max_pack_size;
>      -+	const char *filter;
>      - 	int no_reuse_delta;
>      - 	int no_reuse_object;
>      - 	int quiet;
>      -@@ builtin/repack.c: static void prepare_pack_objects(struct chil=
d_process *cmd,
>      - 		strvec_pushf(&cmd->args, "--threads=3D%s", args->threads);
>      - 	if (args->max_pack_size)
>      - 		strvec_pushf(&cmd->args, "--max-pack-size=3D%s", args->max_pac=
k_size);
>      -+	if (args->filter)
>      -+		strvec_pushf(&cmd->args, "--filter=3D%s", args->filter);
>      - 	if (args->no_reuse_delta)
>      - 		strvec_pushf(&cmd->args, "--no-reuse-delta");
>      - 	if (args->no_reuse_object)
>      -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, =
const char *prefix)
>      - 				N_("limits the maximum number of threads")),
>      - 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("byt=
es"),
>      - 				N_("maximum size of each packfile")),
>      -+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
>      -+				N_("object filtering")),
>      - 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
>      - 				N_("repack objects in packs marked with .keep")),
>      - 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>      -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, =
const char *prefix)
>      - 		if (line.len !=3D the_hash_algo->hexsz)
>      - 			die(_("repack: Expecting full hex object ID lines only from p=
ack-objects."));
>      - 		string_list_append(&names, line.buf);
>      -+		if (po_args.filter) {
>      -+			char *promisor_name =3D mkpathdup("%s-%s.promisor", packtmp,
>      -+							line.buf);
>      -+			write_promisor_file(promisor_name, NULL, 0);
>      -+		}
>      - 	}
>      - 	fclose(out);
>      - 	ret =3D finish_command(&cmd);
>      -
>        ## t/lib-httpd.sh ##
>       @@ t/lib-httpd.sh: prepare_httpd() {
>        	install_script error-smart-http.sh
>      @@ t/t0410-partial-clone.sh: test_expect_success 'fetching of miss=
ing objects from
>       +	git -C server rev-list --objects --all --missing=3Dprint >objec=
ts &&
>       +	grep "$sha" objects
>       +'
>      ++
>      ++test_expect_success 'fetch does not cause server to fetch missin=
g objects' '
>      ++	rm -rf origin server client &&
>      ++	test_create_repo origin &&
>      ++	dd if=3D/dev/zero of=3Dorigin/file1 bs=3D801k count=3D1 &&
>      ++	git -C origin add file1 &&
>      ++	git -C origin commit -m "large blob" &&
>      ++	sha=3D"$(git -C origin rev-parse :file1)" &&
>      ++	expected=3D"?$(git -C origin rev-parse :file1)" &&
>      ++	git clone --bare --no-local origin server &&
>      ++	git -C server remote add httpremote "testhttpgit::${PWD}/server=
" &&
>      ++	git -C server config remote.httpremote.promisor true &&
>      ++	git -C server config --remove-section remote.origin &&
>      ++	git -C server rev-list --all --objects --filter-print-omitted \=

>      ++		--filter=3Dblob:limit=3D800k | perl -ne "print if s/^[~]//" \
>      ++		>large_blobs.txt &&
>      ++	upload_blobs_from_stdin server <large_blobs.txt &&
>      ++	git -C server -c repack.writebitmaps=3Dfalse repack -a -d \
>      ++		--filter=3Dblob:limit=3D800k &&
>      ++	git -C server config uploadpack.allowmissingpromisor true &&
>      ++	git clone -c remote.httpremote.url=3D"testhttpgit::${PWD}/serve=
r" \
>      ++	-c remote.httpremote.fetch=3D'+refs/heads/*:refs/remotes/httpre=
mote/*' \
>      ++	-c remote.httpremote.promisor=3Dtrue --bare --no-local \
>      ++	--filter=3Dblob:limit=3D800k server client &&
>      ++	git -C client rev-list --objects --all --missing=3Dprint >clien=
t_objects &&
>      ++	grep "$expected" client_objects &&
>      ++	git -C server rev-list --objects --all --missing=3Dprint >serve=
r_objects &&
>      ++	grep "$expected" server_objects
>      ++'
>       +
>        # DO NOT add non-httpd-specific tests here, because the last par=
t of this
>        # test script is only executed when httpd is available and enabl=
ed.
>
> -- =

> gitgitgadget
