Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92157320380
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921888; cv=none; b=g7E86yOnB1cYsHlxpS9rIXme4pHDmS1o8rdjIFcUevFJir+G3vPJf1fC2ptMPfOEqTfwd0nnAlRgdidL1hh6mc+HFpNGtbVGzhzmhEgV1mub7fnqpEUQaxwcdskz7QhbkhvHQXnu4s98J21t8kQla9Zcj2X4RLpO95W39I1bQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921888; c=relaxed/simple;
	bh=wRx8oYFhBN3IjAYhXUoso0VSd0mslHS8Mve7SaYUciQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TssgBvZSME0PiU+ism0AG9WLqFptBB3/H5RtarN4JvKe7TjmM+2TgwMQZ2NassO33y09foshYxYgY6T8R7cfOfkPs9dhTGWOBKr0l7kv0TloPjsjMKtd6vhQPQNMh2070YhZAlp98kxFrH2ovAFmet2GRupMVNVdH5LWZyVKzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DYQ5Ya8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1OJq3nq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DYQ5Ya8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1OJq3nq"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BCE171D001E1;
	Fri, 31 Oct 2025 10:44:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 31 Oct 2025 10:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761921885; x=1762008285; bh=lcJE4aLd06
	zu6IY2W+dTCZSlflJ61wSSPg2DBEouYr0=; b=DYQ5Ya8oxgXb5+AB6sPHcxiHpa
	yEUYz1FxqERRE9tnnZBuDmnmvcuwzB3hno17C9/TbDQWom20HaDXoXL+il8BWl0f
	4hSgWxJRm+HFK2KlY0xTvr5OZMmPlm4gJgPXVRyXkQ1ipuWXvZRT1XJsHa0Fze33
	rVWJr6ct7BRMAJ105eVWfq8YBUXy32td/jpJh5Dfg6g7IeNO4S65LkZ9uDwePwi5
	NDKFxFGFqu4jBwodtill6an+BIwwKQKuFZjAd8gPts+mxtSZfLV5Dm2JqQY/Cjcr
	wtg+kZ7nWV+17wNvisrk66AmarxlSOUT/NHT83ZX6MQqQiP1r0Yl/G2OuQ2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761921885; x=1762008285; bh=lcJE4aLd06zu6IY2W+dTCZSlflJ61wSSPg2
	DBEouYr0=; b=j1OJq3nqPgielBhJBUfOQR3ECqxa+MK29r0EDGMsDvQbmgPNEgh
	ZilOLGt81Tj/akvmIxUw46vkmk23zg8ml/ATpkFImU3usSUHybNgzHiUBUjlNB0d
	n5ByhyiitcskBI3bndW4vLEVwMSTmwCsb/G6Qv6LKdl1JSKFal/WV6cezKuA9o3N
	YS09DqqXW3AHVK5oTEM87sQ75Y55tUCTV/z3Nsah0ahpFqjSy6EmmhLhOq4s1Fos
	5zDLAnShaIv5GeS64QkfUemGWWzbIsp4ioYnR7DPa5yVsJZDp4brO/AuWc0DYtg1
	hZkVHIUpwVqa7M/bCNrmTAIr3eWK8U7UdFQ==
X-ME-Sender: <xms:XcsEaeRi6_iEX2pTQqzTO5zMBkaoxUIyQMAQrrU6SGbu3ibBThroPw>
    <xme:XcsEaWD3D1jFC0_UIjIShQaBx9i3ouX_t6sXGU6gvR2dx8S1sHowGfqQRFTuKCz3w
    E3ElN8JyupUoyM4zLRo8v0H_P-SFMDRc-8UMFfXKIBY5KMYbnY9bA>
X-ME-Received: <xmr:XcsEaeFv0A7fckw1fPblkJqqOayCtCcR6MKliAqoBJPV117aktR-vvRUX73efPaFP4YOOnp4qt6xVFGSjIBp7kKZRurwgGpeFlRV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeljeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XcsEaQA3X2O3wJmEzVpsFWPudM7GJ9789HYCz8G8Ud-H1xf0M7X4Fg>
    <xmx:XcsEaWU_qdbuFyFHafLWhECdjmQVAh2RQyN_Tb4cI3FEzieEXwzpqw>
    <xmx:XcsEacobbs6iNGzT1K3XVGtjf6GPpiIPT7BmWmhce5xyh9uczFta5A>
    <xmx:XcsEaaSs6w-lM1WkwHxQYKDHZVwrSNA_dRc3EwZVB82hRZoQSugWbA>
    <xmx:XcsEaY2w-yj5XJyvtAZhv5O3TtTOrWWSrSbe-1jFH-XHF20m-iV3G5MD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 10:44:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Thu, 30 Oct 2025 20:32:16 +0000")
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 07:44:43 -0700
Message-ID: <xmqqtszf2kro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> new file mode 100644
> index 0000000000..1cefbb4833
> --- /dev/null
> +++ b/Documentation/gitdatamodel.adoc
> @@ -0,0 +1,296 @@
> +gitdatamodel(7)
> +===============
> +
> +NAME
> +----
> +gitdatamodel - Git's core data model
> +
> +SYNOPSIS
> +--------
> +gitdatamodel
> +
> +DESCRIPTION
> +-----------
> +
> +It's not necessary to understand Git's data model to use Git, but it's
> +very helpful when reading Git's documentation so that you know what it
> +means when the documentation says "object", "reference" or "index".
> +
> +Git's core operations use 4 kinds of data:
> +
> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
> +2. <<references,References>>: branches, tags,
> +   remote-tracking branches, etc
> +3. <<index,The index>>, also known as the staging area
> +4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
> +
> +[[objects]]
> +OBJECTS
> +-------
> +
> +All of the commits and files in a Git repository are stored as "Git objects".
> +Git objects never change after they're created, and every object has an ID,
> +like `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
> +
> +This means that if you have an object's ID, you can always recover its
> +exact contents as long as the object hasn't been deleted.
> +
> +Every object has:
> +
> +[[object-id]]
> +1. an *ID* (aka "object name"), which is a cryptographic hash of its
> +  type and contents.
> +  It's fast to look up a Git object using its ID.
> +  This is usually represented in hexadecimal, like
> +  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
> +2. a *type*. There are 4 types of objects:
> +   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
> +   and <<tag-object,tag objects>>.
> +3. *contents*. The structure of the contents depends on the type.
> +
> +Here's how each type of object is structured:
> +
> +[[commit]]
> +commit::
> +    A commit contains these required fields
> +    (though there are other optional fields):
> ++
> +1. The full directory structure of all the files in that version of the
> +   repository and each file's contents, stored as the *<<tree,tree>>* ID
> +   of the commit's base directory.

"base directory" is a new term; I think we most often use
"top-level" directory (in various spellings).

$ git grep -e 'base directory' -e 'level directory' Documentation/

> +[[tree]]
> +tree::
> +    A tree is how Git represents a directory.
> +    It can contain files or other trees (which are subdirectories).
> +    It lists, for each item in the tree:
> ++
> +1. The *filename*, for example `hello.py`
> +2. The *file mode*. Git has these file modes. which are only

"has these" -> "uses only these" to clarify that this is an
exhaustive enumeration and users cannot invent 100664 and others,
which is a mistake Git itself used to make/allow.

> +[[tag-object]]
> +tag object::
> +    Tag objects contain these required fields
> +    (though there are other optional fields):
> ++
> +1. The object *ID* it references
> +2. The object *type*

I would rephrase these to

    1. The *ID* of the object it references
    2. The *type* of the object it references

because (1) a tag object references another object, not ID.  To name
the object it reference, it uses the object name of it, but just
like your name is not you, object name is not the object (it merely
is *one* way to refer to it). (2) unless it is very clear to readers
that "The object" in 1. and 2. refer to the same object, 2. invites
a question "type of which object?".

> +[[branch]]
> +branches: `refs/heads/<name>`::
> +    A branch refers to a commit ID.

A branch refers to a commit object (by its ID).  Ditto for tags.

> +NOTE: Git may delete objects that aren't "reachable" from any reference.
> +An object is "reachable" if we can find it by following tags to whatever
> +they tag, commits to their parents or trees, and trees to the trees or
> +blobs that they contain.
> +For example, if you amend a commit, with `git commit --amend`,
> +the old commit will usually not be reachable, so it may be deleted eventually.
> +Reachable objects will never be deleted.

Very good write-up.  As we would touch upon reflog later in the same
document, we may want to extend the "amend" example a bit, perhaps
like

    Note: Git never deletes objects that are "reachable".  An object
    is "reachable" if ....  An unreachable object may be deleted.

    For example, ... a newly created commit will replace the old
    commit and the current branch ref points at the new commit.  The
    old commit is recorded in the <<reflogs,reflog>> of the current
    branch, so it is still "reachable", but sufficiently old reflog
    entries are expired away, the old commit may become unreachable
    at that point, and would get deleted.

Other than the above, I found everything very nicely written.

Thanks.
