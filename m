Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566D214801
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078776; cv=none; b=j0AZdXPG5l7FYn575DhUMURJdN2Knv0g+hu+khDp+urSwYGsERjzdEigeRx+aWZRFkyqFCoRvNw7Mw4sLwR2t+/c03VeKmTyIzhhOHnXcEh2envTAosOFA1QZ6K62tbe3NQ3vWErt5Hmd4N3T7A2IvbByFStlV3VH8sNU6+tYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078776; c=relaxed/simple;
	bh=FOWeAMZb3ZpldfdgHGr7ajn2F9Q/rzA7kkgIbJQbN00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dvry31qT+hQUCtoT7rhepFJdOoTbyGQ2W+fPF2z0QCYV8/iRbNo2Jl1gkmK+SaFYaRnJgODJsMrXLMf5kqtcmk+Q9EKZLF99qDR6a/1mdb5d7eUb5SSkmoABAuiy+savYbF/684MMAgWKk5og3PtwSF6bTQLy1oQadkxv7u+zMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nUPUe25c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqDfI4dG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nUPUe25c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqDfI4dG"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D2C81140122;
	Thu, 20 Feb 2025 14:12:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 20 Feb 2025 14:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740078772; x=1740165172; bh=gifZKt2waC
	XgO6694aWbIN0OSMCnP3xHIbLCPZ+yqno=; b=nUPUe25cLBIf4yZnQZQy2dmUUR
	k6rVYXAgcI/WJdzIGxOcf6l4FVeVCQ8dtPkRKB2oTXT3kmxVOxj/NB8uoa97+CaY
	y8zdsHgQJvYTZSsItcz7J9J7XqE97i9/+2Ran3qP+20XAYOGhtOw4MhxqhHxoJTv
	SqOwEpPJ4s++lBbAj/1Y8qLaeXFZIU2RxMdEuzhq0bX6Rf29S2o0r8ZHqU8l2Nan
	332xr3g90Oywd+u84CiugAbmujC+9K+jC1q8nrBy8HnyxM6SO7/DZ0wkfOhwdep3
	zUTPxsClRnEoJorqzxb8w0EJEXRpJUHes7SQ6jZrOldZ7YJmCgakN6BGiZOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740078772; x=1740165172; bh=gifZKt2waCXgO6694aWbIN0OSMCnP3xHIbL
	CPZ+yqno=; b=gqDfI4dGTdbx52z/VI8qG3npo+Nrfrz7cyvMWC4WfZUfANGbwRa
	3ITI3eCKTw0pG93WKZUbaVt+C0ImBKFuN8cMipoJaqhTC/Ra5gjj/IshopU70Coh
	ihGqioDXrsSf9i7+Z4JK8rz2rLG39bUUvFPykMOfN4wPjjNWy/n7gOEP3MbuACh+
	mQGKbNiauQcbXBQ5Ch/N4aQTTMiIxe2moUsUSUZEID0IkxW8qoB3/EwBH36gPVGa
	yg1tqV/Jp76IBEKRlBdCtRZiYgZVP9j9vt4/7zI8s/G3HyBKSXJ6lU+3UJA2J9uj
	BHI+9BvgGKRueE4rIM3LfnfsNfJve4dj5hw==
X-ME-Sender: <xms:tH63Z71tT6b0LRRLD0PrDofebx2Puo75jy2qQl_lU4WEFWQYIdwAUA>
    <xme:tH63Z6Gjm4Tk4IMyzq0VVvbz8mGRJE6O-ALyL9Gn0vJ8pgVGFh1CeFh0SbmcCq18Q
    DumdFPay9TSiEVQRg>
X-ME-Received: <xmr:tH63Z76pE7kXniNkjIZ-9VyLIomDT1gyZgsqK5ahWSFI7AOy3TW_825ZkerrW0tpXJRBDI01gv2vCQcxBdbnUjyEQjo2mSIuFTI-qf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tH63Zw1m6_v5h_6GmwLEh8t5O05U35R_mub7D_1r-s6ZCE2EDaGFyA>
    <xmx:tH63Z-HlKVfY7k6EtHRvLGlu5I8mYAi4luUst19NL9yrtbFZ1al6pQ>
    <xmx:tH63Zx-jsUszPCGXHul5xNiGeIGmI9YRqCbJYGv5s0WZE7xqG72Sww>
    <xmx:tH63Z7nfYYjdmMhu1cPHLDRKIaoJKuEHYh2be9HFOc7-d-gmu4_4EA>
    <xmx:tH63Z6hMQPCQtf3UQz06dZwrHHSp_4CukP_Fb4fNzj3k4NVcMg7PT2se>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 14:12:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
In-Reply-To: <20250220151207.3248-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 20 Feb 2025 12:12:07 -0300")
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
Date: Thu, 20 Feb 2025 11:12:50 -0800
Message-ID: <xmqqmsegctvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases (introduced in 68d03e4a6e44) on handling the conflict before
> yielding it to the user. From the merge-ort and merge-recursive sources:
>
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
>
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
>
> Add a small paragraph on merge-strategies.adoc describing this behavior.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> This v2 changes the documentation text to a clearer explanation (as
> suggested in the v1 review), and changes its location to
> merge-strategies.adoc instead of git-merge.adoc.
>
> This content is duplicated as this works for both `ort` and `recursive`
> strategies.
>
>  Documentation/merge-strategies.adoc | 15 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
> index 5fc54ec060..a7fca249e2 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -21,6 +21,13 @@ ort::
>  	("Ostensibly Recursive's Twin") and came from the fact that it
>  	was written as a replacement for the previous default
>  	algorithm, `recursive`.
> +
> +        In the case where the path is a submodule, if the submodule commit
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this case
> +        as a conflict, suggesting as a resolution a submodule commit that
> +        is descendant of the conflicting ones, if one exists.
>  +
>  The 'ort' strategy can take the following options:

I am not going to comment on the text, but as to the formatting, I'd
point out that the existing

    +
    The 'ort' strategy can ...

construct, i.e. a line with only '+' on it, followed by left-aligned
block of text, is how AsciiDoc wants our second and subsequent
paragraphs for an enumerated list of explanations.  Here, the
existing "The 'ort' strategy can ..." is the second paragraph that
follows the paragraph that ends with "... previous default
algorithm, 'recursive'", which is the explanation for the item with
"ort::" heading.

So, you'd need to (1) change the empty line at the beginning of your
added text to have one '+' and nothing else on it, and (2) dedent
the rest of the text you added to abut the left edge of the page.
Ditto for the other hunk on "recursive::".

Thanks.
