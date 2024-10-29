Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C3197A92
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223211; cv=none; b=si2/uriJ8fA6QNBlICAkmLtJG1GQ6ojypDFq+SXGxangkNlQ6ufLT+lRtQH8dBkJIlxiDQ9KiI5eoB5C6cFGtZa0VQEJeXBra7RbJTlTCR5fKWLdMfoa6wl46xmO8zhaKYcoLXr5yycK0rQPYuYKB98R/GZUcxdJNJciE1znD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223211; c=relaxed/simple;
	bh=qdahxeiinzOKK/n+oWyUeRVFbXMHFrFM5PAHOGIwjl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF/GS4e4GlDrJz0DILkNx50jihwtnpDULiHgI9nTrwlGRE2aXsfzI/DioDda3DYFltV5VWq6Qh60bBZknlvxJR+ySceye3ROGjofR+NIJZ0FlvSyLYVRGTUbCUw153uW3SjO+AIpodzT4i7LkKhyhP1YJtHzF5xkao07sY0YiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hSau2i4X; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hSau2i4X"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38fa1f82fso51531657b3.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730223207; x=1730828007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uehMDedYxZ9Y8Q+9mv7ZKPbORAb+22oVYJD8KdK44s0=;
        b=hSau2i4XsXgfIMMWe/6RvgCoyqnmcH2OA+omibWgJY2GJ5CGncTC4hVbhEYtFssn/K
         HsZp/tyv6N6Bs+yPdFRojzRTsSOvNWch/xitH+Cd5g4X95hOYvF/JKa6vSixN+tosfED
         WPSICDZFAJImcJ8o2gPehINMue1F0Y1V51oD1UIALhny+r7n4TaQ6T8z/e4bh13pTyYL
         +u+2vj7xtbr9IOiT0N+uGVwIELmzd05sY1O8baoM0qM3s96M7kTo4ygEFQSUPhfFYJJG
         FrfeO2NUFxNv2yO+o5em/eSVma+xwMbx3t6dAR5anqlfkBnrPTZEI0vB4UTLYFrJMcVC
         U6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730223207; x=1730828007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uehMDedYxZ9Y8Q+9mv7ZKPbORAb+22oVYJD8KdK44s0=;
        b=LLzikepV5U2SFQl2ZS7hMHFgToLxHH53Ul7DRWwKFt0CrPrAbG/EQJif4rbIBg0Abb
         x2FxzjY+xTS9r+97eB5KkG6KMEK/AicCyJDC6/8wh4Wvl6tN701FsAfPliYts5TgBLPT
         3waAZHZ6s24uKEfMzISvMaiaQUogx76ZWB7ZRCuZ6BUiYt9r7NzP0RbZ1IynQKZ3HvQ3
         H6ifJDBD637aXr7l8SVp6KnfOxqfmiz7v9iD/buwsZUMsXI6Miqk6GPQBcMYd+2fsBbq
         R4HuEmwOlYcDeuPV/jf3pU9ydjZTj+hHJxo5SB1MYbKp/vAcFcywhUXN6vVpCwSbH7x8
         +9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYgb4SpiIc1FVXx0B1I36DZrzqyXPjfRGkI55ke67VRewrGdXNVCf7t4l5l7XD+l95kg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKG32HcEk3lnk0kx3ao4NxSpyxmqcpVmDBFoaVM36EQ/rvXck
	B2nxI0ehAvHLpwDBoy2MEg9/1zhq0wMImrQokEpyGIZRKC2DcDB2e78pny2+4nGvzmbbJ5WCfAG
	KhmQ=
X-Google-Smtp-Source: AGHT+IGhRMvelZWYCTrLHMVUnKAwfSGjqUUUTu0UQD0NjX3jVhRs3JoI6cnDvtcEhD326HwcAjLbTA==
X-Received: by 2002:a05:690c:ed3:b0:6e2:1527:446b with SMTP id 00721157ae682-6e9d896200bmr113098067b3.3.1730223207466;
        Tue, 29 Oct 2024 10:33:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bafe0asm20656667b3.9.2024.10.29.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:33:27 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:33:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 4/8] packfile: pass down repository to `odb_pack_name`
Message-ID: <ZyEcZXo9SYj1r5w/@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>
 <20241029055039.GA2886077@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029055039.GA2886077@coredump.intra.peff.net>

On Tue, Oct 29, 2024 at 01:50:39AM -0400, Jeff King wrote:
> On Mon, Oct 28, 2024 at 02:43:42PM +0100, Karthik Nayak wrote:
>
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index ffee7d3abd..f4892d7f37 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
> >  	struct strbuf name = STRBUF_INIT;
> >  	int keep_fd;
> >
> > -	odb_pack_name(&name, pack_data->hash, "keep");
> > +	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
>
> Why not pack_data->repo here? It's always going to be set to
> the_repository in this program, but I think minimizing the number of
> references to it still has value.

Yeah, I had pointed out a similar thing when I looked at this patch in
the message above yours in this thread.

I think we reached the same conclusion that this isn't strictly
incorrect, because in all of the instances that I looked at, p->repo is
equal to the_repository, so from an external behavior perspective, the
two are equivalent choices.

But I agree that the point is to *use* p->repo and not rely directly on
'the_repository', so that your suggestion here is a good one.

> Earlier I mentioned that another helper could simplify many of these
> sites a little. What I meant was this (on top of what's in your series):
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 9056447bd0..976cb1d77b 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -806,19 +806,19 @@ static char *keep_pack(const char *curr_index_name)
>  	struct strbuf name = STRBUF_INIT;
>  	int keep_fd;
>
> -	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
> +	pack_hashfile(pack_data, &name, "keep");
>  	keep_fd = odb_pack_keep(name.buf);
>  	if (keep_fd < 0)
>  		die_errno("cannot create keep file");
>  	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
>  	if (close(keep_fd))
>  		die_errno("failed to write keep file");
>
> -	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
> +	pack_hashfile(pack_data, &name, "pack");
>  	if (finalize_object_file(pack_data->pack_name, name.buf))
>  		die("cannot store pack file");
>
> -	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
> +	pack_hashfile(pack_data, &name, "idx");
>  	if (finalize_object_file(curr_index_name, name.buf))
>  		die("cannot store index file");
>  	free((void *)curr_index_name);
> @@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
>
>  	for (k = 0; k < pack_id; k++) {
>  		struct packed_git *p = all_packs[k];
> -		odb_pack_name(p->repo, &name, p->hash, "keep");
> +		pack_hashfile(p, &name, "keep");
>  		unlink_or_warn(name.buf);
>  	}
>  	strbuf_release(&name);
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 7d6c47ffd9..d3b5e7e112 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
>  	pl = red = pack_list_difference(local_packs, min);
>  	while (pl) {
>  		printf("%s\n%s\n",
> -		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
> +		       pack_hashfile(pl->pack, &idx_name, "idx"),
>  		       pl->pack->pack_name);
>  		pl = pl->next;
> G 	}
> diff --git a/packfile.c b/packfile.c
> index cfbfcdc2b8..d81a62eb84 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -46,6 +46,11 @@ char *odb_pack_name(struct repository *repo, struct strbuf *buf,
>  	return buf->buf;
>  }
>
> +char *pack_hashfile(struct packed_git *p, struct strbuf *out, const char *ext)
> +{
> +	return odb_pack_name(p->repo, out, p->hash, ext);
> +}
> +
>  static unsigned int pack_used_ctr;
>  static unsigned int pack_mmap_calls;
>  static unsigned int peak_pack_open_windows;
> diff --git a/packfile.h b/packfile.h
> index 3409aef35d..43c19d7bba 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -32,6 +32,9 @@ struct pack_entry {
>  char *odb_pack_name(struct repository *repo, struct strbuf *buf,
>  		    const unsigned char *hash, const char *ext);
>
> +/* Like odb_pack_name(), but pull repo and hash from existing packed_git. */
> +char *pack_hashfile(struct packed_git *p, struct strbuf *out, const char *ext);
> +
>  /*
>   * Return the basename of the packfile, omitting any containing directory
>   * (e.g., "pack-1234abcd[...].pack").
>
>
> While coming up with the name, though, I had some second thoughts. The
> interface implies that its the way you should derive a pack-related
> filename from a packed_git. But it really is mis-designed for that
> purpose! The packed_git struct has "foo.pack" or similar in its
> pack_name field, and the correct way to derive the .idx, .bitmap, .keep,
> etc, is by string substitution. While we do tend to name packs
> pack-$hash.pack, most of the code will happily work on
> "some-arbitrary-name.pack". And that's why we have so few
> odb_pack_name() calls in the first place.
>
> IMHO the ones in fast-import should probably be doing that suffix
> replacement instead (and probably we should have a decent helper to
> facilitate that; you can grep for strip_suffix.*pack to see places that
> could potentially use it).
>
> All that said, I don't think it's worth derailing your series to deal
> with that cleanup. That can come later if we want. And if we do that,
> then the pack_hashfile() I suggested above would have no callers,
> because it's the wrong approach.

Heh. I feel like you and I just discussed this on the list together a
couple of days ago. Indeed, there are quite a few that would benefit
from such a cleanup (there are even more if you search for
'strip_suffix.*idx', which would work similarly).

> I do think it's probably worth changing your series to use the
> packed_git repo pointers we already have available, though (i.e., the
> cases I pointed out inline above).

But yeah, we can take that up as a secondary step on top of this series
if we wend up wanting to do that in the future.

Thanks,
Taylor
