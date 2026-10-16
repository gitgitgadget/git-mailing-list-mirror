Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993DF26C3BD
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183677; cv=none; b=ju8/36CTqNWXifOOwvfy4OXZ4zoniJX48MvIsghSAyw2KY3ceKLdl8NLgxKK8zjAsJmieZ6DC3zzVBQd/d13UM9xRWhu+th2t0ROfnbQFQ2MfBPmSoSk2QyMqipeArWWwhn7rcIdrz9IqPkoMMsaLaASkiJjUq12V/7K3n9seRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183677; c=relaxed/simple;
	bh=Oof5LgQABhSGnZxNgY6Ruogsf3GBelfiUlS0vD79+vY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbeHyfM+Wx28MZSvLTA/M9puQzqyOhzGj+RaqqbNWYuixTc45hP97bP2hNc2fvSZtC0qefg4mmwVUmGFH3ynqb21Xfo/3B4kljW+dAvt7CgUDh1OGE6ufG1n1SaieRF/1YIV6MRoOD3ru/ePeIVgkqGHtgVt+fdGtJJame+abCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iu/KE/vb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jT8Y3wsY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iu/KE/vb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jT8Y3wsY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E344214000E0
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 16:47:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 16:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792183674; x=1792270074; bh=5YL9IKubpY
	UcewLzubmuNMsuS01ZTA9oY+wU/sgBEOM=; b=iu/KE/vb1auy6BE9mjwoTpNBea
	uw8BsbzKTUIxql67C9ijNVJrkmYsUOnEGNwc87vrzmyd2AFSIpl8TF72FFzpZsrb
	E6lGAA8IbVofsYhXQlwNjJzHgE8+oznlcAk55BeYgAu1EUddlZJgVh0hyLFjAoQp
	EcZaOy2CbPGan92lU680TVhEXto6rp6qRalMz5nEDz94m9eJj1qp3rs2n35mDWZh
	DgmFTCeHIqRon3StvvG7e0HdbmfM7iNhD+xEdTZGiOakSz2wVgFPNl7L+3sRUi6x
	0+4yuxiG6V3BK03RWNwVAlTGuAX+4x751SMpStmS1DVGGOPv3qdZbu515xXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792183674; x=1792270074; bh=5YL9IKubpYUcewLzubmuNMsuS01ZTA9oY+w
	U/sgBEOM=; b=jT8Y3wsY5ghrxTo3yQ4MV8lgJ8HNBxH+BLrty6FQxFgNKCXo/SD
	KO4Fn2FtP5O05vR4JW4ZFzXp6dg0hMVvCVxC+X6sm0EaVYuFTzIyPqE376A5/vn7
	qJLLdC9Z1vuk7Jg7nwjE1ShpMtDc5bVMchs7VKLBPTiumxbJoa7t2PhxwR3WuRbu
	VRDTTwQxONtjz4R0pIkumH4zssXpvF/UwnIdUuljkSwSAWfi/4od8rx4GckC5t8Z
	cji+JwGvbjICYViXJljvUPEIidMFAgGoNnFCRShrD3+ck63AbanCey+U6MhaMyQm
	/4lmocHDbhfvGYxI43HrcTqCiW/VlmRI4qQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792183674; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MmozPjL4KvWgIwAxc8Ghzb74ixLDvNZX94jJMce2w4unpdX
	B3aDdsqKXcY56a9//QiGQgE5J5p9pMisk7PKUn+vXnZ9OiVhmU4Roy1KTCzOd8xW
	hn2hxrMt1H2rLq0ESQ3s/s03J59cOoRxFXKrq/i+YkzV/NoZgxtHFvk6k3CDPheD
	IvbpNVDPbvXHpPmwBWWsRWhlZ0qBJjvh7nEF76G2tcdTUVmXp1tkKAyjDYONdluy
	/JnBVH9193E0C1S21c2izaoMxUnKrZYu5xSlfeyXXDpeXf25+HqsDL3c3mW86aj5
	9rj69dSxC3gbEvz1kI7zGLjFXkm32OMPu8LPS5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Yfb1sf8VmAq107tDXJW6ised8Oh2xxUtjbNjA/EKXyc=:Oof5LgQABhSGnZxNgY6Ruogsf3GBelfiUlS0vD79+vY=;
X-ME-Sender: <xms:eo3San4koF3cHqNLSTY5pFkzmacDleYCH39C5jalSxWvUOMUdp7-2g>
    <xme:eo3Sagn_kZ0_hOWDvs9uyAhIw-QmeA2VOB91srydSikNme4lxaG28bJ28NLlYFITs
    PXk0x1UQxgj5huMjy7JcuLseWA9_G6tuIk0vId7u-8-IDqvK26Brzs>
X-ME-Received: <xmr:eo3SaoQHW3U1sTGWJ1Pdv6Y9HOVzA2-Q-y7H3auXf94ZTu-YB2wr3bPGlZr_ogJ_SKT7t6lB0qlKwmQkd5_8SsU4TiWiLcqyJMND>
X-ME-Proxy-Cause: dmFkZTE9bYlc9NBS8HXxOQSXNw/bWedIl1brsV2WHDXjKUvCTyDUwGT8qk7TU5nEKPM5Lh
    WiTACTMPk732JGKX+NS6b/1Fa29f4e8Zbb8mdD+p5eTafTHAbO5tMGWjGUvw9vgPwWljsZ
    ZcP19zKtyIq+6tYp8vlaN91zf0dJ+zGs2uiLrusHSv/e4FmDi0DYfXqmZrtCHRSrqzIePH
    i1yGTJsq03o6vu0AWmpT27FRdzB49h791dMXkP/U1gmN8OApqrZEHosWsq3ISNlBIbIiCY
    OjIluZTlUXcwHtodV7x1VZXPPBUn5B7nmfKoco4R6fBmGj/UH3+YbumgMYVM+LPNoIlDHH
    WsPyaosswKZQfzOVus8tcNMiWcE8GAO+ATRCUuPVQLLoPgbkTfpQyVb4rFwvc6lr3q/dgD
    X06NmEgjF4u4zFTfjG56uV2W2urBvVRpatRZVADs5f1dfXVwZ2XrxzcVVGRgNJ+OkvHfRs
    uuMFT5ukKU2F5yR7A7mRBnkSlIxapn7vM2s9xFY2baYb1sLLwxBuLpD4Tc7q7bTGUmlHc9
    /uF+WWC2Bx7MOA/Ny0JbVhrzlYy5quoYoDdn7GKixFiSdsKmU4+AvxHVspeSRNZ4CIJr7l
    A0OebV8MnqBixriPlTtpKY9h6d1rdu6wmOTTApDSRSdA7myOtkoKtDhMuTWw
X-ME-Proxy: <xmx:eo3SavE6IAoWpgl0c3psooa_Uffg8zBI-ZusaVexOtgQw7__OJvAPw>
    <xmx:eo3SatFtT_82yPSbQ7li3-4KZUaZpvTo98YNwZWarEntoObeBFx4Vw>
    <xmx:eo3SatSmVxvT7mCyh-SZvZyylLw9Op31ncnu8JDbqqphceR8diKt6g>
    <xmx:eo3SauL2rBU_K0FqrxVskNjIdQBAvZZtT9sOlO48z6gGr_96XhtZdg>
    <xmx:eo3SajchDRbx6nYGOamaxwL3oFxYFzbQRwGEO9qUtprB1Eg4uNOjSCUX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 16:47:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  coygeek@gmail.com,  ben.knoble@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3] repack: do not rebuild packs on --dry-run
In-Reply-To: <20261016191344.82688-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Sat, 17 Oct 2026 00:43:44 +0530")
References: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
	<20261016191344.82688-1-r.siddharth.shrimali@gmail.com>
Date: Fri, 16 Oct 2026 13:47:53 -0700
Message-ID: <xmqqse25e5ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> "git repack --drop-filtered --dry-run" is documented to list the
> objects that would be dropped "without rebuilding any pack or
> deleting anything", but it does both.
>
> This is a bug in cmd_repack(): after printing the candidates, the
> --dry-run block falls through into the regular repack code.
> repack_promisor_objects() writes a new promisor pack, and with -d,
> existing_packs_remove_redundant() deletes the old packs.
>
> The existing guard only skips the implied "delete_redundant = 1", so
> it does not stop an explicit -d, and it does not stop the new pack
> from being written either.
>
> This has been broken since --dry-run was introduced in 1e746b00aa
> (builtin/repack: add --drop-filtered and --dry-run options). The
> --dry-run block never returned early, so a dry run has always gone
> on to do a regular repack. It was not broken by a later change.

As a part of an answer to a question "was this broken from the
beginning, or is it a regression?", the last sentence may have
value, but as part of a standalone proposed log message, it sounds
weird, don't you think?  You already clearly said this was broken
since the beginning.

> Fix it by returning right after the candidates are listed, and add a
> test that checks the pack directory is unchanged with and without -d.

Makes sense.

> A dry run can no longer get past that point, so the two "!dry_run"
> checks that tried to keep it from deleting or dropping anything are
> now redundant.

This makes sense as an explanation on the differences between v2 and
v3, but for those who are reading v3 standalone (which are our
primary target audience, i.e., those who read "git log -p" in the
future), it is on the borderline redundant, as it is a natural part
of what you already described, i.e., return right after giving a
list without doing anything.

Will queue as-is.  I think it is good enough, even though I did
nitpick a couple of points in the above.

Thanks.

> Reported-by: Coy Geek <coygeek@gmail.com>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
> Bug report:
> https://lore.kernel.org/git/CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com/
>
> Changes since v2:
>  - dropped the "!dry_run" checks around the implied -d and the
>    repack_promisor_objects() call, which the early return made
>    redundant

>  builtin/repack.c                | 14 ++++++++++----
>  t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c4360382c1..19894804f0 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -347,18 +347,17 @@ int cmd_repack(int argc,
>  		}
>  
>  		write_bitmaps = 0;
>  
>  		/*
>  		 * Dropping objects means rebuilding the promisor packs
>  		 * without them and then removing the old packs, so the
> -		 * redundant packs must be deleted. Imply -d on a real run.
> +		 * redundant packs must be deleted. Imply -d.
>  		 */
> -		if (!dry_run)
> -			delete_redundant = 1;
> +		delete_redundant = 1;
>  
>  		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
>  
>  		if (ret)
>  			goto cleanup;
>  
>  		/*
> @@ -387,14 +386,21 @@ int cmd_repack(int argc,
>  		if (dry_run) {
>  			struct oidset_iter iter;
>  			const struct object_id *oid;
>  
>  			oidset_iter_init(&drop_oids, &iter);
>  			while ((oid = oidset_iter_next(&iter)))
>  				printf("%s\n", oid_to_hex(oid));
> +
> +			/*
> +			 * Only list the candidates to be dropped; skip
> +			 * the actual repack
> +			 */
> +			ret = 0;
> +			goto cleanup;
>  		}
>  	}
>  
>  	if (delete_redundant && repo->repository_format_precious_objects)
>  		die(_("cannot delete packs in a precious-objects repo"));
>  
>  	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
> @@ -501,15 +507,15 @@ int cmd_repack(int argc,
>  			strvec_push(&cmd.args, "--write-bitmap-index-quiet");
>  	}
>  	if (use_delta_islands)
>  		strvec_push(&cmd.args, "--delta-islands");
>  
>  	if (pack_everything & ALL_INTO_ONE) {
>  		repack_promisor_objects(repo, &po_args, &names, packtmp,
> -			(drop_filtered && !dry_run) ? &drop_oids : NULL);
> +			drop_filtered ? &drop_oids : NULL);
>  
>  		if (existing_packs_has_non_kept(&existing) &&
>  		    delete_redundant &&
>  		    !(pack_everything & PACK_CRUFT)) {
>  			for_each_string_list_item(item, &names) {
>  				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
>  					     packtmp_name, item->string);
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
> index cb36115834..a1c475e4ec 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -131,14 +131,33 @@ test_expect_success '--dry-run does not remove the filtered objects' '
>  	git -C repo -c repack.writeBitmaps=false \
>  		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
>  
>  	# Candidate blob must still be present after a dry run.
>  	git -C repo cat-file -e "$BIG"
>  '
>  
> +test_expect_success '--dry-run leaves the pack directory untouched' '
> +	BIG=$(cat big_oid) &&
> +	packdir=repo/.git/objects/pack &&
> +
> +	for opt in "" -d
> +	do
> +		ls $packdir >before &&
> +
> +		git -C repo -c repack.writeBitmaps=false \
> +			repack --drop-filtered --filter=blob:limit=1k \
> +			--dry-run -a $opt >out &&
> +
> +		ls $packdir >after &&
> +		test_cmp before after &&
> +		test_grep "$BIG" out &&
> +		git -C repo cat-file -e "$BIG" || return 1
> +	done
> +'
> +
>  test_expect_success '--drop-filtered removes the promisor blob locally' '
>  	BIG=$(cat big_oid) &&
>  	SMALL=$(cat small_oid) &&
>  
>  	git -C repo -c repack.writeBitmaps=false \
>  		repack --drop-filtered --filter=blob:limit=1k -a &&
