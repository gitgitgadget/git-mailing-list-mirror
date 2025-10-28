Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F92EE617
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643120; cv=none; b=SsD1Yd+YKQwg+kyBBqcyCxYBtFa0lEk411/WHIySM9HnEHgj+0Da4Fvbicfw74IXOa/2fxJWuaV1Lxwa4ueqTk4JMtek5aE98GMbRLgy5YVOwK6JFRulTMCTzuVSEuYva3KRfgHn4qyO0wHx0ZyoGCZ4UvjbxTmlSwG9G1+Ijnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643120; c=relaxed/simple;
	bh=GhWZYFEbc1s4n4JY60FkHFg56Q/xowRsFAU2yh+uEQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOrIWPd9oQFIBVQiME/T6cvdlFcUEj5pn6wKLg9ZHNBEs0j4OeVSjDaILhp9q4ubxM+6fE+AAxy6EP1Ut1TeVjBjY2fGcuSPLINz7762v8DxkMWWgBHfhdpExE/Qq3/gbU1okbKPYeCX3u6YhdRZbsW1UXhMiJuXAH0VyJWVJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d8tVVkBO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaOcuGzW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d8tVVkBO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaOcuGzW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C0EEEC0380;
	Tue, 28 Oct 2025 05:18:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 05:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643117; x=1761729517; bh=l8ae3boATk
	4Z946l09Pyw9JBL5f+UuCjgGS5eF/K39s=; b=d8tVVkBOMJfwP5lstnhHldjACE
	7lsChV8jukxCb7JDkOykYvPHETCN2VgzcdSHMiCUxOsUVJ16pQC4YBaPI9GPvGiO
	wHBPEFSk21CqdVcjs9PhlGlgb5nmYFm/9IBrM3PCYF2rbOTYyJjg/wH4H4bqVLeq
	ihHw8EHCNbLaGCuaOTmzTlxHwNXnFGGCdC1k75WSLkE0LgMAM1F8dACOVyZ85Rlb
	Ljzfu7AloQg3GQLPUM62yZSO25SYgF8/Da+2rluyTTCQgEGVORpuV8Kq8eRhFW2r
	1+jV7QWsxisFX0nXycMPH3XjBeFrKFlNTgemkcONG3U68entH/cWC/y0M9sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643117; x=1761729517; bh=l8ae3boATk4Z946l09Pyw9JBL5f+UuCjgGS
	5eF/K39s=; b=IaOcuGzWOucTFauvJP05ZHRfSgXNRB8vPvoB3Fr+y6J9oswh52t
	ctvoKxv0cG76+P8gozBw+ZhaX7ZXQKTq0TouGYwKkEbOTYcTvBse/Ki4LM4Exufj
	m/Oj8RXYyhuAgJzAXdo94NLpkBc13Zm/VSi1ihAnfkOIox4N+c20olu7tnF8Dr08
	xrgqfzXX4sydQrv/Zq6fd8UpaHJVRsI8Uj9NciTmQmBwc60j73YPQ7uVegKAmbNS
	QGFAXs7P0kU4nf2D509RemD3DV8MixLYqzTN2+1CgBBv7OivKk8FMbu7Ch47583J
	nwpMA5KjCWOfriMSSZRlEwdK40bvdTEPwFw==
X-ME-Sender: <xms:bIoAaV5OX623lHtW0qdDDejDhFNkzu469PF_wYY07yIvOFQtfbdXfA>
    <xme:bIoAaZ6S05fb4cudlReojdryjYwT-rkmq3XiIEMysKf2rHw2qJFtxdGHzJ_mi29qY
    ne-mCtpwGDwqBn5DVMnNIfgPtPeN6kKaUpT59zVX3zyN0PveLtm6-g>
X-ME-Received: <xmr:bIoAaRdvYVaOGORI_hGCYsWc3Bph2vB025_LCsmfK8TeIzSpqQCO7sKC2d7xwBpYYg-44vekazd31mBLKgY1y-KvX3fNVXjhgxZx1SngxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:bYoAadAEn4X4-JFKABzBCggXgu0ZGdMMHSapFpzZ65RusCQWtYwJBA>
    <xmx:bYoAaU8iCUDX8QmSIRcD9EOBwP5y-TxHMtRWjMNft-GlhLAV205Mrg>
    <xmx:bYoAaYLjIOqxz3lcu0dsxbhoy63ZzJypIj0FpB5kJmdx48zNXRwCdA>
    <xmx:bYoAadi9KjyvXIfJaX3mwrgzpQrQxoWRoqoaaPBxzZjk_PPQy_QWdg>
    <xmx:bYoAaZiShkf4gMY-YxA8zgzKjQxI_ZDowrNMs3cL675r0KG3UEF7ZpTj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:18:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83b3bfd2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:18:35 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:18:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 12/14] rust: add a new binary loose object map format
Message-ID: <aQCKaK6kTfwoj28O@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-13-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-13-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:44:02AM +0000, brian m. carlson wrote:
> Our current loose object format has a few problems.  First, it is not
> efficient: the list of object IDs is not sorted and even if it were,
> there would not be an efficient way to look up objects in both
> algorithms.
> 
> Second, we need to store mappings for things which are not technically
> loose objects but are not packed objects, either, and so cannot be
> stored in a pack index.  These kinds of things include shallows, their
> parents, and their trees, as well as submodules. Yet we also need to
> implement a sensible way to store the kind of object so that we can
> prune unneeded entries.  For instance, if the user has updated the
> shallows, we can remove the old values.

Doesn't this indicate that calling this "loose object map" is kind of a
misnomer? If we want to be able to store arbitrary objects regardless of
the way those are stored (or not stored) in the ODB then I think it's
overall quite confusing to have "loose" in the name.

This isn't something we can fix for the old loose object map. But
shouldn't we fix this now for the new format you're about to introduce?

> For these reasons, introduce a new binary loose object map format.  The
> careful reader will notice that it resembles very closely the pack index
> v3 format.  Add an in-memory loose object map as well, and allow
> enabling writing to a batched map, which can then be written later as
> one of the binary loose object maps.  Include several tests for round
> tripping and data lookup across algorithms.

s/enabling//

> diff --git a/Documentation/gitformat-loose.adoc b/Documentation/gitformat-loose.adoc
> index 947993663e..4850c91669 100644
> --- a/Documentation/gitformat-loose.adoc
> +++ b/Documentation/gitformat-loose.adoc
> @@ -48,6 +50,108 @@ stored under
>  Similarly, a blob containing the contents `abc` would have the uncompressed
>  data of `blob 3\0abc`.
>  
> +== Loose object mapping
> +
> +When the `compatObjectFormat` option is used, Git needs to store a mapping
> +between the repository's main algorithm and the compatibility algorithm. There
> +are two formats for this: the legacy mapping and the modern mapping.
> +
> +=== Legacy mapping
> +
> +The compatibility mapping is stored in a file called
> +`$GIT_DIR/objects/loose-object-idx`.  The format of this file looks like this:
> +
> +  # loose-object-idx
> +  (main-name SP compat-name LF)*
> +
> +`main-name` refers to hexadecimal object ID of the object in the main
> +repository format and `compat-name` refers to the same thing, but for the
> +compatibility format.
> +
> +This format is read if it exists but is not written.
> +
> +Note that carriage returns are not permitted in this file, regardless of the
> +host system or configuration.

As far as I understood, this legacy mapping wasn't really used anywhere
as it is basically nonfunctional in the first place. Can we get away
with dropping it altogether?

> +=== Modern mapping
> +
> +The modern mapping consists of a set of files under `$GIT_DIR/objects/loose`
> +ending in `.map`.  The portion of the filename before the extension is that of
> +the hash checksum in hex format.

Given that we're talking about multiple different hashes: which hash
function is used for this checksum? I assume it's the main hash, but it
might be sensible to document this.

> +`git pack-objects` will repack existing entries into one file, removing any
> +unnecessary objects, such as obsolete shallow entries or loose objects that
> +have been packed.

Curious that this is put into git-pack-objects(1), as it doesn't quite
feel related to the task. Sure, it generates packfiles, but it doesn't
really handle the logic to manage loose objects/packfiles in the repo.
This feels closer to what git-repack(1) is doing, so would that be a
better place to put it?

> +==== Mapping file format
> +
> +- A header appears at the beginning and consists of the following:
> +	* A 4-byte mapping signature: `LMAP`
> +	* 4-byte version number: 1
> +	* 4-byte length of the header section.
> +	* 4-byte number of objects declared in this map file.
> +	* 4-byte number of object formats declared in this map file.
> +  * For each object format:
> +    ** 4-byte format identifier (e.g., `sha1` for SHA-1)
> +    ** 4-byte length in bytes of shortened object names. This is the
> +      shortest possible length needed to make names in the shortened
> +      object name table unambiguous.
> +    ** 8-byte integer, recording where tables relating to this format
> +      are stored in this index file, as an offset from the beginning.

As far as I understand this allows us to even store multiple
compatibility hashes if we were ever to grow a third hash. We would
still be able to binary-search through the file as we can compute the
size of every record with this header.

> +  * 8-byte offset to the trailer from the beginning of this file.
> +	* Zero or more additional key/value pairs (4-byte key, 4-byte value), which
> +		may optionally declare one or more chunks.  No chunks are currently
> +		defined. Readers must ignore unrecognized keys.

How does the reader identify these key/value pairs and know how many of
those there are? Also, do you already have an idea what those should be
used for?

> +- Zero or more NUL bytes.  These are used to improve the alignment of the
> +	4-byte quantities below.

How does one figure out how many NUL bytes there's going to be? I guess
the reader doesn't need to know as it simply uses the length of the
header section to seek to the tables?

> +- Tables for the first object format:
> +	* A sorted table of shortened object names.  These are prefixes of the names
> +		of all objects in this file, packed together without offset values to
> +		reduce the cache footprint of the binary search for a specific object name.

Okay. The length of the shortened object names is encoded in the header,
so all of the objects have the same length.

Does the reader have a way to disambiguate the shortened object names?
They may be unambiguous at the point in time where the mapping is
written, but when they are being shortened it becomes plausible that the
object names becomes ambiguous at a later point in time. 

> +  * A sorted table of full object names.

Ah, I see! We have a second table further down that encodes full object
names, so yes, we can fully disambiguate.

> +	* A table of 4-byte metadata values.
> +	* Zero or more chunks.  A chunk starts with a four-byte chunk identifier and
> +		a four-byte parameter (which, if unneeded, is all zeros) and an eight-byte
> +		size (not including the identifier, parameter, or size), plus the chunk
> +		data.
> +- Zero or more NUL bytes.
> +- Tables for subsequent object formats:
> +	* A sorted table of shortened object names.  These are prefixes of the names
> +		of all objects in this file, packed together without offset values to
> +		reduce the cache footprint of the binary search for a specific object name.
> +  * A table of full object names in the order specified by the first object format.

Interesting, why are these sorted by the first object format again?
Doesn't that mean that I have to do a linear search now to locate the
entry for the second object format?

    Disclaimer: the following paragraphs go into how I would have
    designed this. This is _not_ meant as a "you have to do it this
    way", but as a discussion starter to figure out why you have picked
    the proposed format and for me to get a better understanding of it.

Stepping back a bit, my expectation is that we'd have one lookup table
per object format so that we can map into all directions: SHA1 -> SHA256
and in reverse. If we had more than two hash functions we'd also need to
have a table for e.g. Blake3 -> SHA1 and Blake3 -> SHA256 and reverse.

One way to do this is to have three tables, one for each object format.
The object formats would be ordered lexicographically by their own
object ID, so that one can perform a binary search for an object ID in
every format.

Each row could then either contain all compatibility hashes directly,
but this would explode quite fast in storage space. An optimization
would thus be to have one table per object format that contains the
shortened object ID plus an offset where the actual record can be found.
You know where to find the tables from the header, and you know the
exact size of each entry, so you can trivially perform a binary search
for the abbreviated object ID in that index.

Once you've found that index you take the stored offset to look up the
record in the "main" table. This main table contains the full object IDs
for all object hashes. So something like the following simplified
format:

        +---------------------------------+
        | header                          |
        | Format version                  |
        | Number of object IDs            |
        | SHA1: abbrev, offset            |
        | SHA256: abbrev, offset          |
        | Blake3: abbrev, offset          |
        | Main: offset                    |
        +---------------------------------+
        | table for SHA1                  |
        | 11111 -> 1                      |
        | 22222 -> 2                      |
        +---------------------------------+
        | table for SHA256                |
        | aaaaa -> 2                      |
        | bbbbb -> 1                      |
        +---------------------------------+
        | table for Blake3                |
        | 88888 -> 2                      |
        | 99999 -> 1                      |
        +---------------------------------+
        | main table                      |
        | 11111111 -> bbbbbbbb -> 9999999 |
        | 22222222 -> aaaaaaaa -> 8888888 |
        +---------------------------------+
        | trailer                         |
        | trailer hash                    |
        +---------------------------------+

Overall you only have to store the full object ID for each hash exactly
once, and the mappings also only have to be stored once. But you can
look up an ID by each of its formats via its indices.

With some slight adjustments one could also adapt this format to become
streamable:

  - The header only contains the format information as well as which
    hash functions are contained.

  - The header is followed by the main table. The order of these objects
    is basically the streaming order, we don't care about it. We also
    don't have to abbreviate any hashes here. Like this we can stream
    the mappings to disk one by one, and we only need to remember the
    specific offsets where each mapping was stored.

  - Once all mappings have been streamed we can then write the lookup
    tables. We remember the starting index for each lookup table.

  - The footer contains the number of records stored in the table as
    well as the individual abbreviated object ID lengths per hash. From
    that number it becomes trivial to compute the offsets of every
    single lookup table. The offset of the main table is static.

        +---------------------------------+
        | header                          |
        | Format version                  |
        | SHA1                            |
        | SHA256                          |
        | Blake3                          |
        +---------------------------------+
        | main table                      |
        | 11111111 -> bbbbbbbb -> 9999999 |
        | 22222222 -> aaaaaaaa -> 8888888 |
        +---------------------------------+
        | table for SHA1                  |
        | 11111 -> 1                      |
        | 22222 -> 2                      |
        +---------------------------------+
        | table for SHA256                |
        | aaaaa -> 2                      |
        | bbbbb -> 1                      |
        +---------------------------------+
        | table for Blake3                |
        | 88888 -> 2                      |
        | 99999 -> 1                      |
        +---------------------------------+
        | trailer                         |
        | number of objects               |
        | SHA1 abbrev                     |
        | SHA256 abbrev                   |
        | Blake3 abbrev                   |
        | hash                            |
        +---------------------------------+

Anyway, this is how I would have designed this format, and I think your
format works differently. As I said, my intent here is not to say that
you should take my format, but I mostly intend it as a discussion
starter to figure out why you have chosen the proposed design so that I
can get a better understanding for it.

Thanks!

Patrick
