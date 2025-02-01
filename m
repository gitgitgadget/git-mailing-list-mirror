Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1F17557
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738372631; cv=none; b=Y8xTlVpGAOmX0N6hA5cBbpgXFu7da8gQ+cKV63RsBQznixq0mW8r5vkuVm+uMf+02EOMovI29uqT/PDRuxU/X7+Eyhz9+uKfwddvcK3H/7egevszdN4cg5kTHj9e3DoatPCqkVP1EJLbk5lk51+FnTdZTIZBhoOvuGdqoAWuDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738372631; c=relaxed/simple;
	bh=OPxOoEt0wb8xrj261dKVizJ92fq1Jev+B+0Mk74Dgco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAX6Wjpd30el2toggsC+WPdGNZ1WsZ0XAEIzfgJV28VHUGsdeyFcRQLXn0u+LljxudwayJxuiy1hWjKMQ9lFVbXnQFxSarjdUIYPq1f143vjZC3HRp5Ps7IpGYfd3c/UnNfsUzFz5rZU4V2cFHsvZDlRQkHX5qozzqbn4sO+2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RcL5qvQl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNUOZdfF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RcL5qvQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNUOZdfF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AABAC2540122;
	Fri, 31 Jan 2025 20:17:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jan 2025 20:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738372627; x=1738459027; bh=Pb8fMMD+2H
	RWMSSuIsSA72Xg1ET1f3IDUuLw4gvPlSo=; b=RcL5qvQl3RLLw6mtYlptr99i7Z
	OdipwL/FbeDKp2zOmErS+MmMRyz7V9rBNqVmYcYF2H8FNRT0hJ8mRTChT8stkH7+
	Cut+K9zfBPGu7KgaQZfeAU7mG065ZoLVQGR6LrYK0DzD3JiRqKgG4ys8OFMvr2Jy
	/93UPAKJ0xINBXpxlAROIlGz0/a+McQU1m+aEAeNuiZmnGNhdk3iql4sSB7c6gtI
	6K6EzX4qyfgEcvMnevuk0xFFJYhXaISJXvCehkqOSvsk216Ipyg1tcjWt3FJCdX9
	t96sKLzWOiSbNzg0MnH1nU1B4lKR5auo0ksgBa/mZWZ15dEjrV/E/5oVkh6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738372627; x=1738459027; bh=Pb8fMMD+2HRWMSSuIsSA72Xg1ET1f3IDUuL
	w4gvPlSo=; b=SNUOZdfFlxhPRA66UcYJSLExfw8OpmByUnU0mcwH2EJWY5y7YGq
	mvTvfaDWk9BvuEw3C/bOkw0F5ljzMohvAWWuc8b1lNdPWN0OdIq0it1L+d0iQO75
	r0Fmz2hVSfsVUsgyDh6eUN4/iRTNYT5REiCVjE1O3QBjXJkv/gx+4s4SbcPEaSL9
	S+vOEsOlDkWybZ4n4AF5ddyVre7kM77V9eqqN0BofPJm9ctciDV/V/DANI572Lj5
	2PPDIw2WFarya3wMrVt3+uE88xrNw+bx+samikDvbIjFrmFngg6mtWTTjHQ95w8L
	38wcPBzlEVD4ZKGgaevZHlYNohW786y8MXQ==
X-ME-Sender: <xms:E3adZxb5_j_ixSB7Ijm-wWDe7laakUFGNFYAr3NOyzOnL8WATWY2ww>
    <xme:E3adZ4bul09EjzqRPtLpy3ucTcXYPO2wX2IORBB5Qvhum2nyW5Gryf-LpRVUdbziI
    YzajBxkGp3XNp-O6w>
X-ME-Received: <xmr:E3adZz9L5XJJprjS7G-zErlwWvK1JGWM5oiZ2F-WENh7kIp4z3Gaic5peetvKoK6EOrrcAAQ_7bUloKFaoD1CL_kNB1yV9ncIXZ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E3adZ_oPMzKVPfK0BxHHosGp5fxnygK23udrjyMOyG7LiU5ds0ZyqQ>
    <xmx:E3adZ8ot1AJn7_3ptwLUk7Q_n1p43Ji_ny0sUCQ0r9zZpPFQcZ9Uxw>
    <xmx:E3adZ1SXmbggw6AhB9wG3ONrPmunRfFNCbZcLYJjbj5-S00iTMA_zQ>
    <xmx:E3adZ0p4aGOVCA8Mvq8qONY5USWQM0DzaogEZWxyjBTn7h8tovyBMg>
    <xmx:E3adZ3UTliF3SmrRpomqy_fbBttizuOx9i7J35SLpErRUYWe1ZABkG87>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 20:17:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: ayu-ch <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC] [Newbie] Test Script t6423 Microproject
In-Reply-To: <20250201004556.930220-1-ayu.chandekar@gmail.com> (ayu-ch's
	message of "Sat, 1 Feb 2025 06:15:56 +0530")
References: <20250201004556.930220-1-ayu.chandekar@gmail.com>
Date: Fri, 31 Jan 2025 17:17:05 -0800
Message-ID: <xmqqjzaa4g6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ayu-ch <ayu.chandekar@gmail.com> writes:

> Hello everyone,  
> I am Ayush Chandekar, a second-year undergraduate student at IIT Roorkee.  
> I've been using Git ever since I started learning about development. When I  
> started out, I used to solve some problems/exercises related to git. It was  
> very crucial for getting better and now as I'm looking forward to start my  
> contribution to open source, I find Git! I read almost all the docs on the website, blogs  
> and tried to understand as much code as I can. I just want to take a moment  
> to appreciate how great all the documentation is. It's honestly the best  
> I've ever seen out of any org. It developed an urge of giving back to git  
> after I'd spent so much time developing things. I even started a small  
> project of making my own git (obviously mini version).  
>
> Coming to the topic, I saw that we need to submit a microproject, and I  
> started to find my microproject. I stumbled upon the thread which mentioned  
> skip bitmap traversal for --left-right in git rev-list. I tried to  
> understand the issue, which I pretty much understood why it's happening,  
> but I figured I still need to discuss it with someone. This is also my  
> first post/patch on the mailing list, so I would love if someone can discuss  
> about that issue with me :)  
>
> The docs also said that only one microproject should be done, and for now  
> I've selected the one mentioned in them, which is Avoid suppressing git's  
> exit code in test scripts. But I feel that the ones mentioned are pretty  
> small. Can I still contribute more by not calling them as microprojects? I  
> can do it for more files, but first I would like to have some feedback about  
> my initial patch. I know there might be a lot of mistakes as this is my  
> first patch. Thanks for taking out your time for going through this :)  
>
> Best regards,  
> Ayush  

Welcome.

The why our "microprojects" are designed to be technically too
trivial is because we want to get the formality and the process
behind as early as possible.  If you look at the output of "git log
--no-merges -200" (and the equivalent "git shortlog") from our
recent past, you may notice that a contributor must adopt certain
discipline in writing commits for this project, including but not
limited to:

 - to be familiar with and adhere to the coding guidelines;

 - to choose the right granularity to make commits;

 - to write the proposed commit log message clearly and in the same
   style as existing commits;

 - other formalities like signing off your patches.

It is expected that a microproject submission would never be perfect
in the first attempt.  Do not let it discourage you if you received
review comments that point out the differences between what you did
in your microproject submission and what we expect to see in our
patches.  During the "send patches -> get review comments -> send
updated patches -> ..." cycle, you'll learn the proper interaction
with the reviewers to get your patches accepted.  For that, as an
exercise material, microprojects are designed to be technically not
too challenging.

The idea behind "only one microproject per student" is that you do
not have to do (and we do not want you to deplete our stash of)
microprojects in order to call yourself prepared for one of our
mentorship programs, like GSoC or Outreachy.

Now, a patch critique.

 * Everything you wrote in the body of the message so far are *not*
   suitable for a proposed commit log message.  Making introduction
   and stuff is a very good thing to do but that is not something
   you want the "git am", which gets run on the receiving end, to
   make it a part of our history (and by the way, you should try
   sending your patch message to yourself and then try to apply it
   with "git am" as a practice).  Studying "git log --no-merges" and
   "git shortlog --no-merges" of our history would have taught that
   already.

 * The Subject: line which is the patch title needs to be carefully
   written, too.  Again, "git shortlog --no-merges" would be a good
   guide.  We want to make it possible to remind ourselves what each
   commit was about only by looking at the single-line entry in
   "shortlog".  Your title tells us the commit touches t6423, was
   done by a Newbie, for a GSoC application, as a microproject.
   Among these, the _ONLY_ relevant information in the longer span
   for the project is that it touched t6423.  What kind of thing the
   commit did to t6423 is a lot more important than who did that or
   it was done in preparation for GSoC, but the title does not tell
   us that.

 * Be familiar with Documentation/SubmittingPatches, as it should
   tell everything I said above, and more, I think.  Pay attention
   to the [[real-name]] section, too.

> Signed-off-by: ayu-ch <ayu.chandekar@gmail.com>
> ---

Here, between "---" line and the diffstat, is a space you can use to
give your "greetings", and other things you do not want "git am" to
make a part of the resulting commit log message.  We often use the
space to describe what changed since the initial revision when
sending an updated patch.

>  t/t6423-merge-rename-directories.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> index 88d1cf2cde..bdd19de3aa 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -5071,7 +5071,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
>  		test_path_is_file source/bar &&
>  		test_path_is_file source/baz &&
>  
> -		git ls-files | uniq >tracked &&
> +		git ls-files >actual && uniq <actual >tracked &&
>  		test_line_count = 3 tracked &&

We tend to write one command invocation per line in our shell
scripts (cf. Documentation/CodingGuidelines), so this should be
written more like:

		git ls-files >actual &&
		uniq <actual >tracked &&

The same comment applies to all other hunks.

Otherwise, the patch looks good.
