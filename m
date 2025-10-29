Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9513C914
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762121; cv=none; b=o86KFLhMcI0NGpPfNCdh1jdnHfXNVCh8AsRI4M6M91jgeKsqQHmyzR+WHAsQwD6j0VqeciiR3H3qtYi1iUXK1HVFfeFwKUvRvsW8AOdnMrw6cmSnkW+LwQxlTdzHEvWLW4dvhHTixWORgFfziBWmqBIvuzdxZk5xyQuVDd+1NWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762121; c=relaxed/simple;
	bh=gGmISzrUiRs+L9C2PLBeIry88nHIOpvIxYlg2v9O2oY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USBoJ5Bt5zFl8osoRANckqvXPhaGdob9D7oyL57hkcfJsUXrA01FUBqyoWXtfBv1gQg80muLiznjnsgTdviyVP275vh5nF+wUaPxNp8qli/VFvG5RbLUrNGOK8ZGZHovCi4IiCWH6ASuPq1OlXhXumEu3nZXM+kQ3cA0YxZcCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zf+c/eDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlyCLWzv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zf+c/eDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlyCLWzv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE4C57A0084;
	Wed, 29 Oct 2025 14:21:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 14:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761762117; x=1761848517; bh=11pNGhvuk2
	KX67n5U/rvi9YJLWmCf+ZU2WxvnpspUwM=; b=Zf+c/eDGmMvTibQpC2hxZgKXOD
	Axz+8Fnl/UMIRROZ1c/UcIBXCKfjB0brtlefOKhyGF0chbIOwS78giaI6+U+pdCi
	c2PoY1JALt5rxcUtK72LTFXa7X/CqbT9tkhG0XqxEQ4EGK8HFYBP5ecMlIH12Uzr
	RbMiAgcm/LKbICr9Wr4kks6KDz2wT9bP4r0+mg+TD5nQNuPnd6dzAuhNbDKRvzoc
	j/QkGMMRhYign/V3ZlIrKf7oV3OPlQqjkauAxEwi6rTc9bxdTnP8HdxbdA2rbB4d
	TxJmdkq/LMlAcqk/clHsKqXYSfz5N93KdAQDRfUkv3mYL50VjS/vgUZbSuEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761762117; x=1761848517; bh=11pNGhvuk2KX67n5U/rvi9YJLWmCf+ZU2Wx
	vnpspUwM=; b=UlyCLWzvoAUy53LV1547l+NbG7V1EEyVbsu91tMD3S4o8z2i89n
	P6Sz2wctL5fqiWXT+LHpuv1rBCi/t5LwXIX12dLG9EDP9YvHR9sBHm3XtYbywR8A
	qGG4/FtaVGkx8JQlbccIbXMJ7cjzj95s768czJHZGeGmtnSKx0F0jrAutv3rVhXf
	QxUR09dlJnEEHYULitQMkEm65Nkke45u0GUCFb0hLkcfbmWa09/wt9WQn5Oaobmj
	DO3KzpHmfw06cgi6mUgxcruct6Lo/bbpjBuIzbGGEHu4pbaOmarfL5k+64v5f+y1
	uJYmicJY1dpydVPAta6TLk7iWtMwJQOvWgg==
X-ME-Sender: <xms:RVsCaY4FxKOgrtxlyP8ZE_w0dCodggONVClDdRfSo8T3M6GM7V-k9Q>
    <xme:RVsCaQzYiDXoiIAIZUD7rztAKZxh22dByZ2XBLMS2s6sshHIFu58svxOrThrBaAbb
    ANyhh3dJsusSTfpvRQ_v78-QfsCKrgY2PEGAvlf58rw99XjQ4og_OI>
X-ME-Received: <xmr:RVsCafxXgfO9KyXk6KNkrUvAJ9ak577rPPNbnt-awGpBifZQz48BDHSfL_oz9T69VyI7AcChvmzhOwOylb1msbC9s_cK0lJMCQDL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:RVsCaYwIEA1LDR5cVlhJyx2moZ_fO_szhU9rHwRPEgHYrDsAjfp0Fw>
    <xmx:RVsCaZYop3XlAtjmq-aHKQXJjoQ8ENjf6I5-JRqeXeC1O8dhlCtTlw>
    <xmx:RVsCaZVl58grWN1fWVSjz-AiIW9kaxcpHcUfO1f_payJ3IexSWmpkA>
    <xmx:RVsCaXhmX6EGFsXGmIBqNPLJmrfhHt1RifFMunBpYCAFm-5LAaIkAg>
    <xmx:RVsCacC6QOiewc7F_sTBfPJcS5LmjrxNjpBywl5Q6GRjjSJzp2toEJrN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 14:21:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 12/14] rust: add a new binary loose object map format
In-Reply-To: <20251027004404.2152927-13-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:44:02 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-13-sandals@crustytoothpaste.net>
Date: Wed, 29 Oct 2025 11:21:55 -0700
Message-ID: <xmqqqzul8t6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +=== Modern mapping
> +
> +The modern mapping consists of a set of files under `$GIT_DIR/objects/loose`
> +ending in `.map`.  The portion of the filename before the extension is that of
> +the hash checksum in hex format.
> +
> +`git pack-objects` will repack existing entries into one file, removing any
> +unnecessary objects, such as obsolete shallow entries or loose objects that
> +have been packed.
> +
> +==== Mapping file format

I know near the end of this document we talk about network-byte
order, but let's say that upfront here.

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

This number typically represents a small integer up to 32 or so,
right?  No objection to spend 4-byte for it, but initially I somehow
was confused into thinking that this is the number of bytes for
shortened object names of all the objects in this map file (i.e., (N
* 6) if the map describes N objects, and 6-byte is sufficient prefix
of the object names).  I wonder if there is a way to rephrase the
above to avoid such confusion?

Also I assume that "shorten" refers to "take the first N-byte
prefix".  How about calling them "unique prefix of object names" or
something?

> +    ** 8-byte integer, recording where tables relating to this format
> +      are stored in this index file, as an offset from the beginning.
> +  * 8-byte offset to the trailer from the beginning of this file.

OK.

> +	* Zero or more additional key/value pairs (4-byte key, 4-byte value), which
> +		may optionally declare one or more chunks.  No chunks are currently
> +		defined. Readers must ignore unrecognized keys.

Is this misindented?  In other words, shouldn't the "padding" sit
immediately after "offset of the trailer in the file" and at the
same level?

This uses the word "chunk", which risks implying some relationship
with what is described in Documentation/gitformat-chunk.adoc, but I
suspect this file format has nothing to do with "Chunk-based file
format" described there.  "4-byte key plus 4-byte value" gives an
impression that it is a dictionary to associate bunch of 4-byte
words with 4-byte values, and it is hard to guess where the word
"chunk" comes from.  4-byte keyword plus 4-byte offset into (a later
part of) the file where the chunk defined by that keyword is stored?

The length of the header part minus the size up to the 8-byte offset
to the trailer defines the size occupied by "additional key/value
pairs", so the reader is supposed to tell if the next 4-byte is a
key that it cannot recognise or beyond the end of the header part?

How about replacing this with

* The remainder of the header section is reserved for future use.
  Readers must ignore this section.

until we know what kind of "chunks" are needed?

> +- Zero or more NUL bytes.  These are used to improve the alignment of the
> +	4-byte quantities below.

Everything we saw so far, if the tail end of the header section that
is reserved for future use would hold zero or more <4-byte key,
4-byte value> pairs, are of size divisible by 4.

If anything, we may be better off saying 

 * all the sections described below are placed contiguously without
   gap in the file

 * all the sections are padded with zero or more NUL bytes to make
   their length a multiple of 4

upfront, even before we start talking about the "header" section.
Then the "Zero or more NUL bytes" here, and the padding between
tables do not have to be explicitly described.

> +- Tables for the first object format:
> +	* A sorted table of shortened object names.  These are prefixes of the names
> +		of all objects in this file, packed together without offset values to
> +		reduce the cache footprint of the binary search for a specific object name.

"packed together without offset values...", while understandable,
smells a bit out of place, especially since you haven't explained
what you are trying to let readers find out from this table when
they have one object name.  Presumably, you have them take the first
"length in bytes of shortened object names" bytes from the object
name they have, binary search in this unique-prefix table for an
entry that matches the prefix, to find out that their object may
appear as the N-th object in the table (but the document hasn't told
the readers that is how this table is designed to be used yet)?  And
using that offset, the reader would probably ensure that the N-th
entry that appears in the next "full object names" table does indeed
fully match the object they have?  If that is the case, it is
obvious that there is no "offset value" needed here, but when the
reader does not even know how this table is supposed to be used,
a sudden mention of "offset values" only confuses them.

> +  * A sorted table of full object names.

I assume that the above two "*" bullet points are supposed to be
aligned (iow, sit at the same level under "Tables for the first
object format").

In any case, our reader with a single object name would have found
out that their object appears as the N-th entry of these two tables.

> +	* A table of 4-byte metadata values.

Again, is this (and the next) "*" bullet point at the same level as
the above two tables?

The number of entries in this table is not specified.  Is it one
4-byte metadata per object described in the table (i.e. our reader
recalls that the header has a 4-byte number of objects declared in
this file)?  IOW, would our reader, after finding out that the
object they have is found as the N-th entry in the previous "full
object names" table, look at the N-th entry of this metadata value
table to find the metadata for their object?

> +	* Zero or more chunks.  A chunk starts with a four-byte chunk identifier and
> +		a four-byte parameter (which, if unneeded, is all zeros) and an eight-byte
> +		size (not including the identifier, parameter, or size), plus the chunk
> +		data.

When the chunk data is not multiple of 4-byte, don't we pad?  If we
do, would the padding included in the 8-byte size?  Or if the first
chunk is of an odd size, would the second chunk be unaligned from
its identifier, parameter and size fields?

Presumably, you will allow older readers to safely skip chunks of
newer type they do not recognise, so a reader is expected to grab
the first 16 bytes for (id, param, size), and if it does not care
about the id, just skip the size bytes to reach the next chunk, so
if we were to pad (which I think would be reasonable, given that you
are padding sections to 4-byte boundaries), the eight-byte size
would also count the padding at the end of the chunk data (if the
chunk data needs padding at the end, that is).  If we make it clear
that these chunks are aligned at 4-byte (or 8-byte, I dunno)
boundaries, then ...

> +- Zero or more NUL bytes.

... we do not need to have this entry whose length is unspecified (I
can guess that you added it to allow the reader to skip to the next
4-byte boundary, but this document does not really specify it).

> +- Tables for subsequent object formats:
> +	* A sorted table of shortened object names.  These are prefixes of the names
> +		of all objects in this file, packed together without offset values to
> +		reduce the cache footprint of the binary search for a specific object name.
> +  * A table of full object names in the order specified by the first object format.
> +	* A table of 4-byte values mapping object name order to the order of the
> +		first object format. For an object in the table of sorted shortened object
> +		names, the value at the corresponding index in this table is the index in
> +		the previous table for that same object.
> +	* Zero or more NUL bytes.

The same comment as the section for the primary object format.  I
assume that the above four "*" bullet points are at the same level,
i.e. one unique-prefix table to let reader with a single object name
to find that their object may be the one at N-th location in the
table, followed by the full object name table to verify that the
N-th object indeed is their object, and then find from that N that
the correponding object name in the other hash is the M-th object
in the table in the first object format, and they go from this M to
the 4-byte metadata for that object?

> +- The trailer consists of the following:
> +  * Hash checksum of all of the above.
> +
> +The lower six bits of each metadata table contain a type field indicating the
> +reason that this object is stored:
> +
> +0::
> +	Reserved.
> +1::
> +	This object is stored as a loose object in the repository.
> +2::
> +	This object is a shallow entry.  The mapping refers to a shallow value
> +	returned by a remote server.
> +3::
> +	This object is a submodule entry.  The mapping refers to the commit stored
> +	representing a submodule.
> +
> +Other data may be stored in this field in the future.  Bits that are not used
> +must be zero.
> +
> +All 4-byte numbers are in network order and must be 4-byte aligned in the file,
> +so the NUL padding may be required in some cases.

The document needs to be clear if the "length" field for each
section counts these padding.

> +impl LooseObjectMemoryMap {
> +    /// Create a new `LooseObjectMemoryMap`.
> +    ///
> +    /// The storage and compatibility `HashAlgorithm` instances are used to store the object IDs in
> +    /// the correct map.
> +    fn new(storage: HashAlgorithm, compat: HashAlgorithm) -> LooseObjectMemoryMap {
> +        LooseObjectMemoryMap {
> +            to_compat: BTreeMap::new(),
> +            to_storage: BTreeMap::new(),
> +            compat,
> +            storage,
> +        }
> +    }
> +
> +    fn len(&self) -> usize {
> +        self.to_compat.len()
> +    }
> +
> +    /// Write this map to an interface implementing `std::io::Write`.
> +    fn write<W: Write>(&self, wrtr: W) -> io::Result<()> {
> +        const VERSION_NUMBER: u32 = 1;
> +        const NUM_OBJECT_FORMATS: u32 = 2;
> +        const PADDING: [u8; 4] = [0u8; 4];
> +
> +        let mut wrtr = wrtr;
> +        let header_size: u32 = 4 + 4 + 4 + 4 + 4 + (4 + 4 + 8) * 2 + 8;

Yikes.  Can this be written in a way that is easier to maintain?
Certainly the earlier run of 4's corresponds to what the code below
writes to wrtr, and I am wondering if we can ask wrtr how many bytes
we have asked it to write so far, or something, without having the
above hard-to-read numbers.

> +        wrtr.write_all(b"LMAP")?;
> +        wrtr.write_all(&VERSION_NUMBER.to_be_bytes())?;
> +        wrtr.write_all(&header_size.to_be_bytes())?;
> +        wrtr.write_all(&(self.to_compat.len() as u32).to_be_bytes())?;
> +        wrtr.write_all(&NUM_OBJECT_FORMATS.to_be_bytes())?;
> +
> +        let storage_short_len = self.find_short_name_len(&self.to_compat, self.storage);
> +        let compat_short_len = self.find_short_name_len(&self.to_storage, self.compat);
> +
> +        let storage_npadding = Self::required_nul_padding(self.to_compat.len(), storage_short_len);
> +        let compat_npadding = Self::required_nul_padding(self.to_compat.len(), compat_short_len);

I said 100-column limit is OK, but I am already hating myself saying
so.
