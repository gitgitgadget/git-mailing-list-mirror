Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5973FE64A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534887; cv=none; b=kCvkQrqZYyymQU6Xb+2+k5TaIoK2bA/7lZ1mQXbQw3uqu17bqb0x5w/eVevVqahE0IpZw0M6/N2OwteV7YtRKkfA71sTRhcWX70kZ+kURuG0dtaszUlA28Nxn4gwKwhOFf78VodfYVZ7O9+OTQkzedF8l+6W7RIM332Zn456j1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534887; c=relaxed/simple;
	bh=BI9whyx1P4wEWZe70uU1r445MKZF9RgZYhARIsrOhs0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz71R7PYFEC7btBvE1pK7n4qBAhVhYk5y4TnQY2y+DB4DeHAfARSgdMDtZvbcI9j8HWRRhuHPKEKrPqUbLd88ux7LlRNd0GqREa7Ht9ImZbqGCZoIMMaav34J95TmcdpN2DL7/1iLjzhgFWNBdIlgns8sdqB2eeejPqkoCesT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Vdf/1ZeE; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Vdf/1ZeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1774534871; x=1774794071;
	bh=1kZ+RJR+WBD3NjvzWbpErAjJNAcHyPHDZSTbjTT1RZw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Vdf/1ZeEFWC6t8NjXDseiiOc35sx1/e443ksGRaVRLK+82xGO1Q1RQ356OdXkAN9X
	 +CR5JmHpvCLgWIsJCkU35rV0GAIThDu9rHlqS3dB0n+uehPZUU1M1oxqjhrgdtRMeA
	 hfkX2QI6DtgL3eJ8ecy0XSDB1Y/JF/JrMrs1HoXrzN2Mr8TCqU4qmbZcGAwDZHUfNP
	 F0tgKEKFzgeAODvsb7FyflkHaHFt+Rio/7EBEef6c3YJzZduDoSIAowlhPFnnJf06x
	 gQMULhJOOEaaazqeyAU82G4HPR5RhHWEE31qI2SZeEQmLfMd8D5gnc2YSKKuDCm6Ca
	 mLyWXozhnKiMQ==
Date: Thu, 26 Mar 2026 14:21:07 +0000
To: Patrick Steinhardt <ps@pks.im>
From: apaterson@pm.me
Cc: Aaron Paterson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] odb: add write_packfile, for_each_unique_abbrev, convert_object_id
Message-ID: <DpRTZzuEPU7m8kvCckzHYEK380REXLfunHXO4hE3qgAZsKPSNtyqkBT2oRzusMxvIDgLVkt4FOis0HKBTEJPIRQgcbYM6QZdpzN6-Y-F7WE=@pm.me>
In-Reply-To: <acU7eJ0MpUVhCs6-@pks.im>
References: <pull.2074.git.1774530437562.gitgitgadget@gmail.com> <pull.2074.v2.git.1774532383055.gitgitgadget@gmail.com> <acU7eJ0MpUVhCs6-@pks.im>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: 8da39a5715e90d8505cf6d5044d9d10a19ead392
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Of course, and my apologies, gitgadget is not formatting these messages as =
clearly as I would like them to be.

Both this series and the last were adapted from my fork that supports [1] w=
ith a feature similar to gitremote-helpers. My hope is that the fork can co=
nverge with master so that sqlite-git can become redistributable. The local=
 backends vtable was already a step in this direction, so the question is i=
f letting users bring their own local backends, the way they currently can =
with helpers for remote backends, is in scope for git core.

Either way, it sounds like series 1 will be covered by upstream, so next I =
would like to contribute support for git-local-* helpers. This allows users=
 to create .git repositories with storage formats other than packs and buil=
tin alternatives like reftables, which seems appropriate as direct sqlite s=
upport would probably be out of scope for core. Local helpers are already i=
mplemented in [2] but if it makes sense to hold off and rebuild it after e.=
g. ps/odb-generic-object-name-handling is merged, I am not in such a rush.

[1] https://github.com/mayCXC/sqlite-git
[2] https://github.com/gitgitgadget/git/compare/master...MayCXC:git:ps/seri=
es-2-helpers-v3.patch

- Aaron

On Thursday, March 26th, 2026 at 7:58 AM, Patrick Steinhardt <ps@pks.im> wr=
ote:

> On Thu, Mar 26, 2026 at 01:39:43PM +0000, Aaron Paterson via GitGitGadget=
 wrote:
> > From: Aaron Paterson <apaterson@pm.me>
> >
> > Add three vtable methods to odb_source that were not part of the
> > recent ps/odb-sources and ps/object-counting series:
> >
> >  - write_packfile: ingest a pack from a file descriptor. The files
> >    backend chooses between index-pack (large packs) and
> >    unpack-objects (small packs below fetch.unpackLimit). Options
> >    cover thin-pack fixing, promisor marking, fsck, lockfile
> >    capture, and shallow file passing.
> >
> >  - for_each_unique_abbrev: iterate objects matching a hex prefix
> >    for disambiguation. Searches loose objects via oidtree, then
> >    multi-pack indices, then non-MIDX packs.
> >
> >  - convert_object_id: translate between hash algorithms using the
> >    loose object map. Used during SHA-1 to SHA-256 migration.
>=20
> This will conflict with ps/odb-generic-object-name-handling, which
> already introduces generic callbacks for `for_each_unique_abbrev()`.
> There's also ongoing work by Justin to handle writing packfiles via the
> ODB transaction interface.
>=20
> > Also add ODB_SOURCE_HELPER to the source type enum, preparing for
> > the helper backend in the next commit.
>=20
> Huh.
>=20
> > The write_packfile vtable method replaces the pattern where callers
> > spawn index-pack/unpack-objects directly. fast-import already uses
> > odb_write_packfile() and this allows non-files backends to handle
> > pack ingestion through their own mechanism.
>=20
> I'm again a bit puzzled, same as with your previous patch series. It
> would be nice to collaborate on this topic, but that will require a bit
> more coordination than just sending in a patch series as things are
> quite in flux here.
>=20
> Patrick
> 
