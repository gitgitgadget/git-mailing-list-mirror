Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94031E0FD
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199044; cv=none; b=kl6j6V+5vWbEXzQn+2/3MwiA/eOSd2EWWgQzERJlrK6p/tGUzTKQmNRwETn6mYKAZTh+z9W0qdzHtlvNjh6kPSfo1C45W5rAsCA7vEmheTm33u5rMSVH1WmxxhtultM0+prFcf7Gx4Gnw6Xgc8ko4Qwclw3nwFrxqGA/jb9c13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199044; c=relaxed/simple;
	bh=dfKiV09F5S8lmSNowoBGLYCaANP30rGNAXkv72DpUmo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Osq14QChYrvWYAGo5sZfE0vceJmlBL+WyoJpvcOfdt7G7oCiYLPiAoWII9AL1eqcPeezPV/XghL2Gl7m1v8I8fcOq2WxjsDOpeTbsp3SryGfDjTkpVqG1R0AwDTJJb/8eOHGP2nRrOxlHHO57hfzG3mWi0e1rFuPmnCyb/m8UoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=bt8zRKeq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMBNT8YZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="bt8zRKeq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMBNT8YZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C61E11D00391;
	Mon,  3 Nov 2025 14:44:00 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 03 Nov 2025 14:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762199040;
	 x=1762285440; bh=TevTzhKUsORYySiVQ8VP34mYMPRcirfKhrwObPYkS5k=; b=
	bt8zRKeqSbava/X/Sycja7zG580NR+tG656wz3pOnwcPM2LvtfW4qGiIWpl25rlo
	0oh96nIxuzUbViWg6NaXQ7q8Cw3CgcYqvRvD68HRQcu8OgEMfUbMaLUXKfqXzF6B
	i1057ZJ0rhGgWqe30IRGB/GFM0FpjQE4g9aykNB/jYRfaVVTRqExR4/J9qHESvi/
	YzN0e2DSgrlgBEYVclV78N/PE5Crd7A21mLnDdrQCfsuiJpRjHCwEomq0/nloJe7
	JwIEVSz3dr2hEgBLgrlDWIMBSme/k/nFQHMuHPMHZjxEXFBCcadA6d+66xlO23jq
	JT7blZyO8EfpLdtrbgIVhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762199040; x=
	1762285440; bh=TevTzhKUsORYySiVQ8VP34mYMPRcirfKhrwObPYkS5k=; b=U
	MBNT8YZr0ZU3NgILBGjecvaZfePkbeLFI5Mi09gzIYf7RadKVvlHf5IpQqqWe6yP
	LYT55dEzu4ninmcqxNbswYKWx7u7c7yPzwXp5+/xadicwBBASQwMMG4/uSNmkvXs
	/LFWYn186arGhbLs0c8iwxxhCgFzX59dplkBJaEmTsq57c8vdDaIh0SAs3b4s8PA
	01WBSR1EShG3g3wSatSrVvGR8gCPQCE58xEm1IRhW02xByk/oWEe9t69FutS7pC8
	twdmvq/6NKPVRc8CPWHnjCrdI14lAYPrLJruzr7qmt65dguVP5kfvjofvqae9TnY
	KkcBIcmu8n6XNdr6cskkA==
X-ME-Sender: <xms:AAYJadKDpETc4UF5AxhbmIITVjHY8pinnHoneYmjBdrIcqFJdNQ5cw>
    <xme:AAYJaT-goYWjAX2hybNO5Me8of1u8b7SKK2rygWp1N-ENlesxSe0bMxnMN0xTsRin
    RQv-9LJ_NO5JWrX_iDdGuGzi31xgCBKP58XxiBmR3qJPrKykzAenA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AAYJac2B28p1I1H1oGBz5PJO53XVF6lEESJTfw2a9Bc7-DBG6QQogw>
    <xmx:AAYJaQbi_ehxYN1bjYHQvltpyBeUVOx53QqUmqQ0_29YuISY4r7Mtg>
    <xmx:AAYJacJvKEXtDCGRgaCidYxQ-NoQNwIYiCfZqfDzIHZAPf1br9Al_Q>
    <xmx:AAYJaXEAqJilOpau7rAJCQbrPRfadL6VcPgtcAxHduWRYf0ic62PZA>
    <xmx:AAYJadMZqHEAqqdiEYNPepnBVHroOR0rvI_ab6zj0eFxM0YG62b3ditf>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2743F780076; Mon,  3 Nov 2025 14:44:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Mon, 03 Nov 2025 14:43:39 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
In-Reply-To: <xmqqtszf2kro.fsf@gitster.g>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <xmqqtszf2kro.fsf@gitster.g>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 31, 2025, at 10:44 AM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
>> new file mode 100644
>> index 0000000000..1cefbb4833
>> --- /dev/null
>> +++ b/Documentation/gitdatamodel.adoc
>> @@ -0,0 +1,296 @@
>> +gitdatamodel(7)
>> +===============
>> +
>> +NAME
>> +----
>> +gitdatamodel - Git's core data model
>> +
>> +SYNOPSIS
>> +--------
>> +gitdatamodel
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +It's not necessary to understand Git's data model to use Git, but it's
>> +very helpful when reading Git's documentation so that you know what it
>> +means when the documentation says "object", "reference" or "index".
>> +
>> +Git's core operations use 4 kinds of data:
>> +
>> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
>> +2. <<references,References>>: branches, tags,
>> +   remote-tracking branches, etc
>> +3. <<index,The index>>, also known as the staging area
>> +4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
>> +
>> +[[objects]]
>> +OBJECTS
>> +-------
>> +
>> +All of the commits and files in a Git repository are stored as "Git objects".
>> +Git objects never change after they're created, and every object has an ID,
>> +like `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
>> +
>> +This means that if you have an object's ID, you can always recover its
>> +exact contents as long as the object hasn't been deleted.
>> +
>> +Every object has:
>> +
>> +[[object-id]]
>> +1. an *ID* (aka "object name"), which is a cryptographic hash of its
>> +  type and contents.
>> +  It's fast to look up a Git object using its ID.
>> +  This is usually represented in hexadecimal, like
>> +  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
>> +2. a *type*. There are 4 types of objects:
>> +   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
>> +   and <<tag-object,tag objects>>.
>> +3. *contents*. The structure of the contents depends on the type.
>> +
>> +Here's how each type of object is structured:
>> +
>> +[[commit]]
>> +commit::
>> +    A commit contains these required fields
>> +    (though there are other optional fields):
>> ++
>> +1. The full directory structure of all the files in that version of the
>> +   repository and each file's contents, stored as the *<<tree,tree>>* ID
>> +   of the commit's base directory.
>
> "base directory" is a new term; I think we most often use
> "top-level" directory (in various spellings).
>
> $ git grep -e 'base directory' -e 'level directory' Documentation/
>
>> +[[tree]]
>> +tree::
>> +    A tree is how Git represents a directory.
>> +    It can contain files or other trees (which are subdirectories).
>> +    It lists, for each item in the tree:
>> ++
>> +1. The *filename*, for example `hello.py`
>> +2. The *file mode*. Git has these file modes. which are only
>
> "has these" -> "uses only these" to clarify that this is an
> exhaustive enumeration and users cannot invent 100664 and others,
> which is a mistake Git itself used to make/allow.

I like the idea to make it more explicit that this is an exhaustive
enumeration. I'll try changing it to this instead: "These are all of the file
modes in Git (which are only spiritually related to Unix file modes):"

>> +[[tag-object]]
>> +tag object::
>> +    Tag objects contain these required fields
>> +    (though there are other optional fields):
>> ++
>> +1. The object *ID* it references
>> +2. The object *type*
>
> I would rephrase these to
>
>     1. The *ID* of the object it references
>     2. The *type* of the object it references
>
> because (1) a tag object references another object, not ID.  To name
> the object it reference, it uses the object name of it, but just
> like your name is not you, object name is not the object (it merely
> is *one* way to refer to it). (2) unless it is very clear to readers
> that "The object" in 1. and 2. refer to the same object, 2. invites
> a question "type of which object?".

That makes sense to me, will change it to that.

>> +[[branch]]
>> +branches: `refs/heads/<name>`::
>> +    A branch refers to a commit ID.
>
> A branch refers to a commit object (by its ID).  Ditto for tags.

What's the goal of this? I can't tell what misconception you're
trying to avoid here.

>> +NOTE: Git may delete objects that aren't "reachable" from any reference.
>> +An object is "reachable" if we can find it by following tags to whatever
>> +they tag, commits to their parents or trees, and trees to the trees or
>> +blobs that they contain.
>> +For example, if you amend a commit, with `git commit --amend`,
>> +the old commit will usually not be reachable, so it may be deleted eventually.
>> +Reachable objects will never be deleted.
>
> Very good write-up.  As we would touch upon reflog later in the same
> document, we may want to extend the "amend" example a bit, perhaps
> like
>
>     Note: Git never deletes objects that are "reachable".  An object
>     is "reachable" if ....  An unreachable object may be deleted.
>
>     For example, ... a newly created commit will replace the old
>     commit and the current branch ref points at the new commit.  The
>     old commit is recorded in the <<reflogs,reflog>> of the current
>     branch, so it is still "reachable", but sufficiently old reflog
>     entries are expired away, the old commit may become unreachable
>     at that point, and would get deleted.

I like that, will include something similar, lightly reworded.

> Other than the above, I found everything very nicely written.
>
> Thanks.
