Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00F36F423
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826712; cv=none; b=ngXR/1r7iQTsbZ6tQK2iujAsEAqNI0wrkFqongOxxts0k28rlN0Er+7ju1HK0Nhqd6nITQx/fptTECoJ7XbcorfAfn0RmKQeYlj2wYLHpXvjABq14ZQmOzYk98HdX6zD62AKzbCsa1nUAWJf5kpGI0tHHai15HZ7w/JATaYY8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826712; c=relaxed/simple;
	bh=G//unsYftQp7i+29Cztp31uwSt1vbC2/dmDaHU3ofxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OB/vsYweqwfaa6SuVatlY0lrRm7GIdnIXY7DiXrZVyC7hbTnQW2tNnpIZOfhVpR5A93LQ+xPiU49baiiI0UH+YvzdjtcWbapRpN/r3u8KTWdJ7mHxVp46VGbe3hzv1XKB1HL4EMcAtX4QVmVNpu23dyx8/IUAoOqUI0JXjx7bFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fg7Qn3Fl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mg/MucCH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fg7Qn3Fl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mg/MucCH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8ABEAEC054C;
	Fri,  6 Mar 2026 14:51:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 14:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772826710; x=1772913110; bh=n+KyL436ci
	zx0qW5u7dD/4CjVkIQnIi9iTVl+H6q8Q0=; b=Fg7Qn3FldgeUOPDEziB1b0pY+c
	UkmWvNLRA8dlAAY9R4yOHLgQbMK0ZRmgURBDwiQwvlceNm5716tcgp1i7S6vbnfX
	zwdp1qFW3BEJ4xcGbsVNceZTrgzZr6vijAqwTx9qrOzZAMlzDrXsVDTanykFQhdz
	IE+QGH8hgE5DMGKRRYLIHl4rnAkGpKpbywfVqXz819VhGJCOx8yHAPKvluvhr6vv
	d9bepoqTDnv/rhW0OVSzgnlRzGdW3AuIDHjtOLwkvzogss+X6tDX/0J4OwlQQYKc
	H0JcinbCoajuKwx1rF/2qI9X+FXa0i3ILC6aOCONIRIET3aMywmyvMvcxyww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772826710; x=1772913110; bh=n+KyL436cizx0qW5u7dD/4CjVkIQnIi9iTV
	l+H6q8Q0=; b=Mg/MucCHczevStGuRqFHYIwInEBxETSnAR+UALHclXubvO0mF1n
	Qp2JLTvskhs8QoAJMWXSqjAQL4QBhLwmGv9V6obtvGIc4L4yLh2QpqEdzEdvOmWh
	z1CyzuiwNhUd2uchWaTBciTeI2j68NMmXnsa23IoL++jnToH26Im9S0fkEPsW4Iz
	oGOp06nXxDRcX6V7FU/NX4e1XmACooih9IK/HqhvRKwoHJL0cBRNJu6kkoV8g2je
	xSOAqdymlw+AwO43ThPlqJwzTL0zcNX10W7CPZLr3xuhGPFIqDvSYo8rPsGHshyk
	6tSqmd5vlwSu20uk7JgWMtjFxDXT9I4Dwew==
X-ME-Sender: <xms:VjCraUda-PhWSctOgUZEmWtoycz--h0acyZHqDHlblp3Am536l5a3A>
    <xme:VjCradoxIKAHE8REEMuf8H4I5vBUy2qpnCIoRi6u_1NryjcXYm1sjFmG-Grof_HNw
    u_uS9N6yYrUWlxFsbRCmSA8nGXD5flF37Agd18MyIU9hfi3aeh9Ng>
X-ME-Received: <xmr:VjCraS4e9U-xdOs90uo2086IukA600OpirCyOo-dmZQqm8NraCpKwM76sWcjsNvcImYq6V8vAwZA-AWG_6bDhyyMErXTVCLQmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheplefgkeffueeulefffffhueeguedvleeghfehjeelleekheeghfdtkefgjefg
    geffnecuffhomhgrihhnpegriihurhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurh
    hirghnrdhfrhhivggulhhisehmthdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VjCraTqxrePEKYSPEfEFUd8t51GVOfnZw_JbQg7qJzXyf5fOmki8nQ>
    <xmx:VjCraUgNCBaIbVxCk1QL8jRVTzJniMs1F4_56zCWZ-s4jTgXDgbUxw>
    <xmx:VjCradLYTVZnnQDbWRNNpW_Z5WbTjfr4ZbrvDGl52Byj57mkfDrksQ>
    <xmx:VjCraUAHXRsuJ0ryVk_mAQhvuCZkiNbzJGPZByHEu4uqrDEgOM6EWg>
    <xmx:VjCraY55tSD_qo6hjX0chotGXXBMcPYBVaO35JmllB1mQ1wQBzJ56Dya>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 14:51:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Friedli <adrian.friedli@mt.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/clone: fix segfault when using --revision on
 some servers
In-Reply-To: <20260306111001.261916-1-adrian.friedli@mt.com> (Adrian Friedli's
	message of "Fri, 6 Mar 2026 12:10:01 +0100")
References: <20260306111001.261916-1-adrian.friedli@mt.com>
Date: Fri, 06 Mar 2026 11:51:48 -0800
Message-ID: <xmqqwlzozqgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Friedli <adrian.friedli@mt.com> writes:

> In the bad case the server ignores
> `transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
> list `refs` returned by `transport_get_remote_refs()` contains many
> items, amongst others "HEAD". `remote_head` returned by
> `find_ref_by_name()` is not NULL and `remote_head_points_at` returned by
> `guess_remote_head()` is not NULL but its field `peer_ref` is NULL.
> Because `remote_head_points_at` is not NULL the guard in
> `update_remote_refs()` does not skip the affected code and
> `remote_head_points_at->peer_ref->name` is accessed, which causes a
> segfault later on.

The description makes it sound more like this code is perfectly
fine, and the problem is in guess_remote_head() that reads the refs
list and includes such a bogus thing with no peer_ref in the result
of its guessing.  There are 4 direct callers to guess_remote_head()
including this one---wouldn't they also obtain a list with such a
ref entry?

Or is guess_remote_head() correct in that some uses of its result do
not mind such a ref with no peer_ref, but only this code path wants
to see a ref with peer_ref?  If that is the case, then shouldn't the
code this patch touches be looping over remote_head_points_at to see
if there is one with a peer_ref and use that?  The original is
assuming that remote_head_points_at that is not NULL has a valid and
usable entry at the beginning of the list, but if that assumption
does not hold and we are getting multiple hits, wouldn't it be
possible that a good entry is hidden behind a bad one in the list of
refs?

Thanks.

> Extend the guard in `update_remote_refs()` to also skip the block of
> code if `remote_head_points_at->peer_ref` is NULL.
>
> Signed-off-by: Adrian Friedli <adrian.friedli@mt.com>
> ---
> The segfault can be reproduced by e.g.
>
> git clone --revision=refs/heads/main \
> https://dev.azure.com/public-git/sample/_git/sample
>
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index fba3c9c508..09219791da 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -557,7 +557,7 @@ static void update_remote_refs(const struct ref *refs,
>  			write_followtags(refs, msg);
>  	}
>  
> -	if (remote_head_points_at && !option_bare) {
> +	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
>  		struct strbuf head_ref = STRBUF_INIT;
>  		strbuf_addstr(&head_ref, branch_top);
>  		strbuf_addstr(&head_ref, "HEAD");
