Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75791D6195
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775975271; cv=none; b=YioAhvLb/vEi09SnLfEXDaLEFThhp6amnXIjkrm9fc8m5vtXuQh6bEN+LrG9bOxvDbmatqGJcEXtqh4sCOBsdSmYHKQkQwG3EaK2dtKjy/l0Fh6dPTU74Dg8UavXFgR90Y0FcUU9DhFNeriJO2ftAThTfLiEz22wfzOYn4WsLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775975271; c=relaxed/simple;
	bh=OYJluIj2jGQAkYQ0Uda0pV/AA1w0pWW3p9hXpm87NX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oMinKIZN5+IwwVj+2es3bCm91eCMqdgmQltRMrMwxiWpLD+tQlDHwVAk9FkJ6sfpKLByOhoJKJjaH9xLN4S1lkBHPykidm2+xn2id/iDkri+X5GCpf3Zi6sXMywIEi4VGlGUgVaVCDE60/6lXL+pqVraFmzh/Sk27xxBSM3Im2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E/y1Azjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiQAjMg+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E/y1Azjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiQAjMg+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B7577A001B;
	Sun, 12 Apr 2026 02:27:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 12 Apr 2026 02:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775975267; x=1776061667; bh=d2QNft2ghj
	PV3dQIx+QY3UdYSrVR6nhtLQh+13brEpw=; b=E/y1AzjxCMprB1AVmKMiBm4lDu
	WMklrilHPey7zNn8hxfsWEDfIgf4IfddIMqd/AOuG17OqQb7dBSdAwa9H8rlgSGa
	JJK0LESdDG6jwQEEwAd13OfZ8Vnbj65KN4lt0hZSUUtLCWP2kJiEiq1OSR+Np7cP
	5dpvp6xjjNPbIYOWMmuaPB2r4So67z4phcuu9ajoCSrY0aGKAGakKi6rjkc3Dd49
	pcZrz0vdroYZBkUa339FjSp9ahl5S2GV+0UuIf9f7ITGUzYw7pZdywrJ3545+m1t
	4g9DtpPmg/kBP3j6EMEwKjyiZ+PjTKdiP4PiQ4Ifl0WIf+yrR3HJ8q4RGcXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775975267; x=1776061667; bh=d2QNft2ghjPV3dQIx+QY3UdYSrVR6nhtLQh
	+13brEpw=; b=CiQAjMg+BSS/vvfsbqlZgLH44vyWC54lx0MG/P/Ocnu18MjrDZm
	T3zkXvZ+UYp7Ay4VxjI56YfKdRF8rtPJADHmrziR2KguWgtzKdhy7+4jVNW+Om7R
	7+MK5x42rCVugf15Gk8w3oZ+ABDdsBNv1Ol09OyLVqtPg8lG2zb+B05M+usF4HMV
	mIZBDS93nuxP2rTyJj3csC2Nf5vohbyXWoeyhjTPBlxjm9mv/c22sBUwZI7dVGJB
	5WGmom0PH+laPQJsieULsvYbfaJFpBLGx/pGHDYqKimPTlxBaH8Nm01Uiacj/1zI
	vG52dB1eHhRBSZVLFWT/eZwsdjCYlb+AgIA==
X-ME-Sender: <xms:YjvbaXsPG6V_U1AeioF4ctw2cHByzBczWZqFMat_LUr7Wd4VZG2YSg>
    <xme:YjvbaVXu7xJiK2SvLwM5-L9ijldInRVeV_mceG4Xkh5pw9j9vxntSi65UtPvLPBS1
    MPyvEmhhwE_6yKR6v96jIx4b-OaAh1JRgw2owkUAD1xAxdE2g5KwA>
X-ME-Received: <xmr:YjvbaaiNMRrlpIjBVDnODYUXtoHf3LDx3mKdkIrUjg2VonvBPgbXIjjQrwgslx2nN56ImuRKwj8dz5lIPPKgUnpR3ekqMWNj2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefgeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlohhrvghniihordhpvghgohhrrghrihdvtddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    oheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YjvbaVpwvnRvOpyH3u-xH6O8kpQAd9YTkA8l1JgTa_MgXK6gkU5V4w>
    <xmx:YjvbaYFooH4JUdFsY_NDb_9Zd5rO3AaRifMf_tcBT18CBD85VrdrqA>
    <xmx:YjvbaS5hIwZ2mMzrBEfkRoiRVFl4Zi-yxKRzSpdk9USdNoG8jcbvQA>
    <xmx:YjvbaYebk1j2Ades-M6vVRipn2CC-kBQWYmGaCYCeR8iP6I_LlvpDQ>
    <xmx:Yzvbad-M8CcCK9e9QMUL8SKoxkd7PhgiHVkEhnSXYfz1aMcOc23yKfED>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Apr 2026 02:27:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Eric Sunshine <sunshine@sunshineco.com>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [GSoC PATCH v5 2/6] repack-promisor add helper to fill promisor
 file after repack
In-Reply-To: <3558bb38956b522c91057598db645eb42ffb48b2.1775861047.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Sat, 11 Apr 2026 00:55:11 +0200")
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
	<3558bb38956b522c91057598db645eb42ffb48b2.1775861047.git.lorenzo.pegorari2002@gmail.com>
Date: Sat, 11 Apr 2026 23:27:45 -0700
Message-ID: <xmqqo6jolmla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> +/*
> + * Go through all .promisor files contained in repo (excluding those whose name
> + * appears in not_repacked_basenames, which acts as a ignorelist), and copies
> + * their content inside the destination file "<packtmp>-<dest_hex>.promisor".
> + * Each line of a never repacked .promisor file is: "<oid> <ref>" (as described
> + * in the write_promisor_file() function).
> + * After a repack, the copied lines will be: "<oid> <ref> <time>", where <time>
> + * is the time (in Unix time) at which the .promisor file was last modified.
> + * Only the lines whose <oid> is present inside "<packtmp>-<dest_hex>.idx" will
> + * be copied.
> + * The contents of all .promisor files are assumed to be correctly formed.
> + */
> +static void copy_promisor_content(struct repository *repo,
> +					      const char *dest_hex,
> +					      const char *packtmp,
> +					      struct strset *not_repacked_basenames)
> +{
> +	char *dest_idx_name;
> +	char *dest_promisor_name;
> +	FILE *dest;
> +	struct strset dest_content = STRSET_INIT;
> +	struct strbuf dest_to_write = STRBUF_INIT;
> +	struct strbuf source_promisor_name = STRBUF_INIT;
> +	struct strbuf line = STRBUF_INIT;
> +	struct object_id dest_oid;
> +	struct packed_git *dest_pack, *p;
> +	int err;
> +
> +	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
> +	get_oid_hex_algop(dest_hex, &dest_oid, repo->hash_algo);

This needs to prepare for a corrupt input in dest_hex, which would
result in garbage dest_oid.  The helper function should signal a
failure with its return value, right?

> +	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);

As you earlier mentioned, this use of parse_pack_index() is
perfectly fine.  The call chains that reach here are both from
cmd_repack() that calls either repack_promisor_objects() or
pack_geometry_repack_promisors(), and both ran "pack-objects" to
create a new pack and called finish_repacking_promisor_objects(),
which in turn calls us, so the dest_hex/packtmp we are dealing with
point newly created packfile that is about to become but not yet
completed as a part of this repository.  We know we created it, and
we know "pack-objects" did not fail, so parse_pack_index() being
loose in validation does not pose a practical problem.

This still needs to prepare for parse_pack_index() to return NULL,
though.  

In the above two cases, we should make sure that dest_idx_name gets
freed before we return control to the caller (possibly signaling an
error by returning -1, but the current caller is not expecting to
hear a failure from us and that may be OK).

> +	/* Open the .promisor dest file, and fill dest_content with its content */
> +	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
> +	dest = xfopen(dest_promisor_name, "r+");
> +	while (strbuf_getline(&line, dest) != EOF)
> +		strset_add(&dest_content, line.buf);
> +
> +	repo_for_each_pack(repo, p) {
> +		FILE *source;
> +		struct stat source_stat;
> +
> +		if (!p->pack_promisor)
> +			continue;
> +
> +		if (not_repacked_basenames &&
> +			strset_contains(not_repacked_basenames, pack_basename(p)))
> +			continue;
> +
> +		strbuf_reset(&source_promisor_name);
> +		strbuf_addstr(&source_promisor_name, p->pack_name);
> +		strbuf_strip_suffix(&source_promisor_name, ".pack");
> +		strbuf_addstr(&source_promisor_name, ".promisor");
> +
> +		if (stat(source_promisor_name.buf, &source_stat))
> +			die(_("File not found: %s"), source_promisor_name.buf);
> +
> +		source = xfopen(source_promisor_name.buf, "r");
> +
> +		while (strbuf_getline(&line, source) != EOF) {
> +			struct string_list line_sections = STRING_LIST_INIT_DUP;
> +			struct object_id oid;
> +
> +			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
> +			string_list_split(&line_sections, line.buf, " ", 3);

The strbuf's contents line.buf[] is read/write, so we could use
line_sections that is initialized with NODUP and call
split_in_place() to avoid unnecessary small allocations and
deallocations, no?

More importantly, we say "split into up to 3 pieces".  What happens
if this is totally malformed and there is only one word?  Should we
still trust this line and try to carry it forward?  I doubt it.

> +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
> +			get_oid_hex_algop(line_sections.items[0].string, &oid, repo->hash_algo);

Or the first word split is not a sane hexadecimal string that
get_oid_hex() fails?

It would be the simplest to ignore/skip the line, just like what you
do to a correctly formated line about an irrelevant <oid> (iow, the
if() statement immediately below).

> +			if (!find_pack_entry_one(&oid, dest_pack)) {

Assuming that the object name was read correctly, if the pack we
just created does not have the <oid> we read from the existing
.promisor file, this line we just read has nothing to do with the
repacked result, so we ignore it, which sounds fine.

> +				string_list_clear(&line_sections, 0);
> +				continue;
> +			}
> +
> +			/* If <time> doesn't exist, retrieve it and add it to line */
> +			if (line_sections.nr < 3)
> +				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);

Should we also validate line_sections[1] in some way?  I am not sure
if we want to call check_ref_format() on it.

If we insist that .nr is at least 2 immediately after we split the
string, and make sure the line begins with <oid> (i.e., parsable as
hex object name) that might be sufficient.  I dunno.

> +			/*
> +			 * Add the finalized line to dest_to_write and dest_content if it
> +			 * wasn't already present inside dest_content
> +			 */
> +			if (strset_add(&dest_content, line.buf)) {
> +				strbuf_addbuf(&dest_to_write, &line);
> +				strbuf_addch(&dest_to_write, '\n');
> +			}
> +
> +			string_list_clear(&line_sections, 0);
> +		}
> +
> +		err = ferror(source);
> +		err |= fclose(source);
> +		if (err)
> +			die(_("Could not read '%s' promisor file"), source_promisor_name.buf);
> +	}
> +
> +	/* If dest_to_write is not empty, then there are new lines to append */
> +	if (dest_to_write.len) {
> +		if (fseek(dest, 0L, SEEK_END))
> +			die_errno(_("fseek failed"));
> +		fprintf(dest, "%s", dest_to_write.buf);
> +	}
> +
> +	err = ferror(dest);
> +	err |= fclose(dest);
> +	if (err)
> +		die(_("Could not write '%s' promisor file"), dest_promisor_name);
> +
> +	close_pack_index(dest_pack);

As we discussed, 

	free(dest_pack);

is missing.

> +	free(dest_idx_name);
> +	free(dest_promisor_name);
> +	strset_clear(&dest_content);
> +	strbuf_release(&dest_to_write);
> +	strbuf_release(&source_promisor_name);
> +	strbuf_release(&line);
> +}
> +
>  static void finish_repacking_promisor_objects(struct repository *repo,
>  					      struct child_process *cmd,
>  					      struct string_list *names,
