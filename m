Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D3245005
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641230; cv=none; b=jK6G9IIsNmMU3sw0kvnYWFLhlmqyKNc8R4l0zI5/1E953q9/nimWhYAje3Z3PBoKyvxRqHZqju31PAFUma6dhStmZFBc2cvuwITRXG6u6qoGLwea17fkpy2NLNkySNxqSv8/YA1/Eh58zYv4Y2kciSEClROvxZsqJ2ppuuFWzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641230; c=relaxed/simple;
	bh=ZnNADNkWRfvUykgt5q4TR47spCLHa/XUV9LNW10n/7k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DxcTCfMcoASX+DDS+mLjR27sXAHSDbhvEYY0XzmipZfstmFCHO3ojUAlUeESpjiNL5d8l+gIYVcjoHfCICnJi9oNPYM8mestSvJXJzBFYTFazYGyPY238uFtx4nU28x3YehCRg3kpf2LnQY0KXlJ9mWgS24zMSQAdoDvBwxg0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=W5IX9ETj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=US2TTYGk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="W5IX9ETj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="US2TTYGk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D161EC018E;
	Thu, 16 Oct 2025 15:00:15 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 15:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760641215;
	 x=1760727615; bh=RYdkvUNNJgAZDiMLzhnFUS1A1HgWrfvIabvK8y015bI=; b=
	W5IX9ETjDArxBtLg5zUa7FHxhhgv1o3kLedIyg6RRcuGhDbkRh6u9EHTuzvkdUbi
	x9eihk7kOrwPlHTTRa/l2E/Ab6Z1juQHcjhkghECo37EMP4nEVP0EuhU0lDdeIpi
	bLv8NoPMTGueJdMp54DyypyENkbuIvQoYbyUnv/P+QZb9L6ktenBHphTKFQr1nk5
	yn+mHF5muNNbSsdA69/bCqrvb65+ZdYe2Z6c40jnOYSu1Gi4nlVrMernTooFLdaC
	JA7fLJgqrXfg/rpemWOjOOMZQpqYZybfCGQQnhfqDPNvIQat67Ei9ZSnRXD4ytxd
	KZMmlWiHWbcx20HCI6ADqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760641215; x=
	1760727615; bh=RYdkvUNNJgAZDiMLzhnFUS1A1HgWrfvIabvK8y015bI=; b=U
	S2TTYGkmWSq/JDW/+GQD4e8Yqny4ORPZvSbPiOc+Uu3UhvbfmMoRT+yJmb2njumM
	GKqMAbIL4jtW7ISd2WKc4AhfrSP2LqYziSy3Jhx3zVIXyKug6Wb0tbmpG1R+fGYE
	6gkklmXylTIeK7W4OalHR99aCStOPOivLkfImX3Yya4d2ZN8gjSxEdHMGSnrnUml
	jCijY+jfWVYyBbQZWt9QPoWAi+A7U3r54u6mFOfitcMsWNDyWtlL7YDw1zRWstxU
	rj47n1KXijx/iVUvoyNVphYFhNroo2PqYstaoQg72RKFmmBWy8m4u7LiJRcCWpDE
	rowRvc8nl6eVHOqbn5aAA==
X-ME-Sender: <xms:vkDxaIhO0-J2_Flfw4Q_g8UUC8hnPuJo-66x2Kk2mK8YWkx2HLFfEQ>
    <xme:vkDxaL1zdZ05xEg0R9hsKGRSQUdRDSte6QJmGDDBxXLVWKkwpl3qNfYRL_I8sXHiK
    gcTsoqCKopey9Wi8MRo2P9vbHYuEZTX5D8_pdi2fe1mMg4DPlYh0f8W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    eplefgveevvedtvdehfeejhefhjeekieejvdeikedugeevudevveegledthedtgfelnecu
    ffhomhgrihhnpehjvhhnshdrtggrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:v0DxaEOgUdOs-L18g5gINN1JCOoQaDPizpI211F-LGEo1T6nmW1Irg>
    <xmx:v0DxaETebguO1315Ci1Z6c6BwIHa7b7ESoXWE618NdFoayIx4S32mA>
    <xmx:v0DxaCiKC78uLQcXvcCAbEHPOV27bj9EfU76loaZMSp4CMShSwa9rA>
    <xmx:v0DxaN_hGVKVB0icameojTgAG69K0gvEhIDr8VHl0SVIoMLe_4YOag>
    <xmx:v0DxaJGPmU29DSLlO_UqpgXlk9ynR8gp0aNonxF9DqCclGTphp8-DCM7>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E40A1780076; Thu, 16 Oct 2025 15:00:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Thu, 16 Oct 2025 14:59:01 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <03db91a6-148b-436f-8afa-0273a1f5d508@app.fastmail.com>
In-Reply-To: <xmqq347i948a.fsf@gitster.g>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
 <xmqqv7kgszr1.fsf@gitster.g>
 <0eb276ef-7b1a-4e79-93da-13a83226aa01@app.fastmail.com>
 <xmqq347i948a.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 16, 2025, at 12:54 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>>> +[[tree]]
>>>> +trees::
>>>> +    A tree is how Git represents a directory. It lists, for each item in
>>>> +    the tree:
>>>> ++
>>>> +[[file-mode]]
>>>> +1. The *file mode*, for example `100644`. The format is inspired by Unix
>>>> +   permissions, but Git's modes are much more limited. Git only supports these file modes:
>>>> ++
>>>> +  - `100644`: regular file (with type `blob`)
>>>> +  - `100755`: executable file (with type `blob`)
>>>> +  - `120000`: symbolic link (with type `blob`)
>>>> +  - `040000`: directory (with type `tree`)
>>>> +  - `160000`: gitlink, for use with submodules (with type `commit`)
>>>
>>> It is not really "supporting" file modes.  Rather, Git only records
>>> 5 kinds of entities associated with each path in a tree object, and
>>> uses numbers taht remotely resemble POSIX file modes to represent
>>> these 5 kinds.
>>>
>>> Perhaps "supports" -> "uses"?
>>
>> "Uses" sounds good to me.
>
> Also "much more limited" is misleading.  We only represent 5 kinds
> of things, so we use only 5 mode-bits-looking numbers.

What does it mislead the reader to think? My goal is to communicate that
if you want to tell Git to remember that a file's Unix permissions were
700, that's not possible.

>>>> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
>>>> +  or <<commit,`commit`>> (a Git submodule, which is a
>>>> +  commit from a different Git repository)
>>>> +3. The <<object-id,*object ID*>>
>>>> +4. The *filename*
>>>
>>> Here it may be worth noting that this "filename" is a single
>>> pathname component (roughly, what you would see in non-recursive
>>> "ls").  In other words, it may be a directory name.
>
> Comments?

Oops, missed this in my first pass.

I looked at them man pages for a couple of commands ("mv", "cp")
and it looks like it's normal to refer to files and directories jointly
as "files", or refer to them as having a "file name". So I think it's okay
to call it a "file name" even if the "file" may be a directory.

>>>> +[[blob]]
>>>> +blobs::
>>>> +    A blob is how Git represents a file. A blob object contains the
>>>> +    file's contents.
>>>
>>> "represents a file" hints as if the thing may know its name, but
>>> that is not the case (its name is given only by surrounding tree).
>>>
>>> "A blob is how Git represents uninterpreted series of bytes, and
>>> most commonly used to store file's contents." or something, perhaps?
>>
>> I'll say "A blob is how Git represents a file's contents", unless Git has
>> another use for blobs that I don't know about (I think it's not
>> that much of a stretch to say that a symbolic link is a special kind
>> of file where the "contents" are the the link destination).
>
> A few configuration variables like mailmap.blob name a blob object,
> for which _only_ its contents, i.e., the sequence of bytes, matter
> and where they originally were stored does not matter.
>
> But we are falling into the area of tautology, as any sequence of
> bytes can be stored in a file so they can be called "contents of a
> file".  But the point is that these bytes do not have to be stored
> to become a blob (think: "git cat-file -t blob -w --stdin").

I'm trying to think through what the goal of explaining the nature of
a "blob" is.

To me describing blobs primarily as "bytes" makes it sound a bit like
"Git will treat this as opaque binary data, Git will not attempt to
interpret the contents of a blob in any way" (which is certainly true
for many blob storage systems!).

But it's not true that Git treats blobs as opaque binary data, unlike
other blob storage systems, Git has diff and merge algorithms to
interpret the contents of the file to some extent and try to do useful
things with them.

Another goal we could have is to be clear that there are no limits to
what kind of files you can store in Git: you can equally well store text
files and binary files.

>> I think it's always clearer to be more specific when possible, if there's only
>> one purpose for blobs it's unnecessary (and IMO a bit misleading, because
>> it makes the reader wonder if there are other purposes that they should
>> know about) to say that blobs can be used to store any arbitrary bytes for
>> any purpose.
>
> I do not think describing other use cases is unnecessary.  Even if
> we limit ourselves to discuss a single purpose for blob, i.e. to
> represent the contents of a file, we should stress that blob is to
> store _only_ contents, and not other aspects of the file (e.g., in
> what paths with what mode), and that is where my reaction to "how
> Git reprsents a file" comes from.

I think it does make sense to say the blob stores only the contents,
though IMO that's fairly clear already since we've already explained
where the other parts of the file are stored by the time we get to
explaining "blob".

>>>> +[[branch]]
>>>> +branches: `refs/heads/<name>`::
>>>> +    A branch is a name for a commit ID.
>>>
>>> Well a commit ID is an alternative way to refer to a commit object
>>> *name*, so it is a bit strange to say "a name for a commit ID".
>>>
>>> Perhaps "A branch ref stores a commit ID." is better?
>>
>> I think I'll leave this alone, none of the many test readers reported
>> being confused by it.
>
> Would a confused person report that they are confused? ;-)

Everyone leaving feedback gets a prompt something like this
asking them to categorize their feedback,
and "I'm confused" is one of the options.
https://jvns.ca/images/feedback-categories.png

I definitely got many "I'm confused" and "I have a question"
comments about other things that were confusing to readers.

>> I see that you don't like the "name for a commit ID" phrasing :)
>> Maybe there's another way to say it, though again none of the test
>> readers said they were confused by this or disagreed with the phrasing.
>
> Yes, I get that given "refs/heads/main", you want to say "main" is
> one of the ways to have repo_get_oid() to yield the commit object,
> and you are using "name" in that sense, but it is more like a ref
> can be used to name an object.  It is *not* the name of the object,
> because the object can have other names, and more importantly, it
> (i.e., to give a name for an object) is not the only thing that a
> ref can do.  

That's interesting,  what else can a ref do other than to give a name to
an object?

> And that is why I do not like that phrasing, combined
> with the target of giving that name is spelled "a commit ID".  The
> commit ID is already another way to name the thing the refname can
> be also used to name: a commit object.  A commit object and a commit
> object name are different things.  The latter is a name that can
> refer to the former.

I'm curious about why it's important to you to make this distinction
between a commit ID and a commit object. To me the commit ID and the
commit object come as a package, since the commit ID is calculated from
the commit object.

>  And a ref can be used just like the latter to
> refer to the former (i.e. "commit object").

> By the way, I do like the way many of your responses are "will think
> about it more", not "I'll take your version".
>
> Very much appreciated.

I'm glad to hear that! It's a fun puzzle to figure out how to express
things clearly and accurately and concisely.

- Julia
