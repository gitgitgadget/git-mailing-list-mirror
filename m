Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0271A239A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863845; cv=none; b=i0EH8Z6D6J9XLw+2IW+/i9BLwf3IRyNse0sIg9EFhmiNA7gge3Y/48nuaDCZSJUxjw8XBDKOdJDA1Q02QKr/1aFx1SYUW96L6n8y2JDi/uu65rr8UtjPb29OhXu6mfVr81PAA9epnFw277NkOLX8bulFFXo0rfLNrbBD37tf+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863845; c=relaxed/simple;
	bh=PuY9ijr6H13tYpWuPRZdqmlZuA4cor7w4EvcXEVT4/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfAlVpNClYKZibBeLdwPdTGtjj9oWELciSDyi7XOVnIHjibMoCiJ+UZHejoY7clsZPUdVcarcou9ruvQRQnDh2ULEV0aNeakmq1IVlI6md3U40pAJ/2C9msjAS8SNypPdaw+UjHKqkdir3Y5a44WbbCBDXvzSs0qGjRDyGYhHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DseI6dfK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LL3BNR2y; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DseI6dfK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LL3BNR2y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B70257A01C4;
	Fri, 10 Apr 2026 19:30:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 19:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775863842; x=1775950242; bh=xa9C652P5G
	/WUK3jlUYZxg14tL27r2JH9DmN5W7xNyc=; b=DseI6dfKYAT9OEn3W1yynBHqUf
	7onLNIyuXybl9LXDAZfNyJ+sJYVj8t+dqiO2kDdexDLuh+KiBNWvCUhnkNT6aUCS
	d9lHi4rhpV7V3gVcLFv1uaVE2nK6ojJJObtwMYFxdIHmiyyVhqpWjmVqHDUyq+Ku
	K8ucGf7cnOuNb6UJ2HE9sq8SH/78f7mG6G9ewnrLJSZ/ZrD5awpgIr4ekGaNrdhB
	HzEpQh1llvWXFDg0G3QQ+DC/PqxC85J7MYA1B3UFaezhmEc7Be4MAMbVjxuwNECN
	Em8tLcbNiRa7owtbjNHEMlqHgT2ZTakJeLl91Z6ZQng4z2yp/VGs4JkNIqMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775863842; x=1775950242; bh=xa9C652P5G/WUK3jlUYZxg14tL27r2JH9Dm
	N5W7xNyc=; b=LL3BNR2ytlS4/1o9zoRYCf5ev7U3CYZZvbOF9zLnZ01aDEnvCh6
	SFUsk8p0ylFn8qW5q9K21BaOwmWuqMnL7fWvr8NE4hWeRYagoi6n2Aen/IZaMOlX
	1JY2oowdJKZZfEhE7z+YxAOgAEpx/wTKlDbdoKHwpIrBWAvHjGf6xHI9RxdTelMi
	YjGX5FfQgd1RuStE3bJbxVKq1edm+wPdckGW+l63hQtNctE1XeKr7cMOWhEoOqhG
	mML/0YqFHEAgVRJ7ykXN0dd9YOyhIwGzjrPThswIyyMVsLG05le1KxiMkOsVNEug
	Sd318ePzO0QeCTFoHJ1Ifpi8EdjjUKAgVTA==
X-ME-Sender: <xms:IojZafS8x8VFem59HxVyFuFRSj2i3K8qDmr7aC8dXPG14eHADSO1Zg>
    <xme:IojZadWSiuqnxCENFrta8Y0eYaitPEkDotlN4zmkUtXcu-yZfNiVXy9itahV_MuX5
    c8VaKIF6Sa0scf5O_Vm4e_bnd2-b7By1S06WPslyCOfVY866FZeyA>
X-ME-Received: <xmr:IojZaZQb7uK4nRC_6lPqFai4dVWkRSRnotMJzdRYuJ-UwnaDFOV1hVgGiDiD3bD6lNIPFBc7YnzmlkitLLRLBkHNjg0wIXFqxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IojZaV23DYEJStq0p6BXfjcdL2YiFpfJp7w1YNIib2NgaIM7bjKXQA>
    <xmx:IojZaZd4blFZxl40gpfBphiHU9vr67REb5qonCq9jjufnNRlwOHk3w>
    <xmx:IojZadN5l-I9CtQNveGb7R6sCWBHtetg-BdIolIp23URB3VcfNwhiA>
    <xmx:IojZadXZNm6ABmiepFzif3dDVq9ZSCUStWFvbFb_384f83HV7JRjow>
    <xmx:IojZaa0Tj9JUKkYFZNjrCbZIG-uzlMCXTyR_ean1YPPdRTfcJCLQMeUG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 19:30:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>, Patrick Steinhardt
 <ps@pks.im>
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
Date: Fri, 10 Apr 2026 16:30:40 -0700
Message-ID: <xmqqo6jqmlzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> +	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);

parse_pack_index() has this comment:

        /*
         * Parse the pack idx file found at idx_path and create a packed_git struct
         * which can be used with find_pack_entry_one().
         *
         * You probably don't want to use this function! It skips most of the normal
         * sanity checks (including whether we even have the matching .pack file),
         * and does not add the resulting packed_git struct to the internal list of
         * packs. You probably want add_packed_git() instead.
         */
        struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
                                            const char *idx_path);

The function can return NULL, but this caller does not seem to be
prepared for it to return NULL (i.e., the loop introduced by the
repo_for_each_pack() macro we see below, nobody assumes dest_pack
could be NULL).

But what pack index file are we parsing here?  Isn't it already part
of the running system that we should be able to find on the list of
packfiles in the packfile store?  Is this because we lack "find a
packfile on this packfile store by name" API, because what we want
to find if each of <oid>s we have appear in the particular packfile
or not, and packfile_list_find_oid() is not sufficiently precise (i.e.
"the object appears in one of the packfile on the list" is not what
we want to know, "the object appears in this particular packfile" is)?

	Patrick CC'ed primarily because this part of the API and the
	data structures have been reshuffled to add quite a lot of
	abstraction since I last looked at the area.

As close_pack_index(dest_pack) does not release resources held by
dest_pack itself (even though the region of mmaped memory that is
pointed at by its index_data member is unmapped), I think that is
where the memory leak is breaking the CI jobs (see my other message).

But I am not sure if the use of parse_pack_index() - close_pack_index()
API is the right thing to use here.



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
> +
> +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
> +			get_oid_hex_algop(line_sections.items[0].string, &oid, repo->hash_algo);
> +			if (!find_pack_entry_one(&oid, dest_pack)) {
> +				string_list_clear(&line_sections, 0);
> +				continue;
> +			}
> +
> +			/* If <time> doesn't exist, retrieve it and add it to line */
> +			if (line_sections.nr < 3)
> +				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);
> +
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
