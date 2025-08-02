Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D9253F1A
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754164523; cv=none; b=nG/EmJYIVLwdGG6q+XC3NT+EfPkGbU2wjk7tit/LQBtcvwv8zKY8LRi+NxKZCppzT7NACS6HHX3TFB5ihc8ylZw4d3/mFrnMyCeYSNjAC5JIOHtn2D9mhq1ZqEN3gvKIe3BVqe7P7cruoif0F2e7ceG78y4PZY2wxbdLDhsPXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754164523; c=relaxed/simple;
	bh=Qw6aW9btRTabGIdexEC39z5NvVd0KEw+tz3SpgWgdUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGCOp7u6Qx5YMU63os/E130h429FmpB9g7msePx2oppbg84d+StJO3uuNyPawfwj5AsL2xOqL7K1xWy07v4ZC6R3xo1Ot5k1H0kfZmlb2ZjOFSKUMon7dlU6W/rqe3XIHozSQHDPcQ5tKyajhvmZgex7vtybght8VVx0rWfHliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IujiDpxw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IujiDpxw"
Received: (qmail 13917 invoked by uid 109); 2 Aug 2025 19:55:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Qw6aW9btRTabGIdexEC39z5NvVd0KEw+tz3SpgWgdUw=; b=IujiDpxw07gagffRc6+pzfgDR+ou5gq/LxhI9xJIsTdlZycKwf5bOTr7G+uO67/0Tlurect/QWeXX/TyGJlEsx8PPjb98ZsL9DQP2JkmCuENgjYcr2QinnuLU0tS+F/YD/PMO6n86SiDUuJhA1kMng6cRL0ec0giB8FStIgHqXwFFjz9faJIMyz2apfXQtGw8ubB7m3M+Bz50/D/x/BjjyhndaGpAR2HcQM8kGw6mxX56PXWqXZchyuagbtRfOwoq9CHMEWuSf2WZ0dCwAaqIEdllyPgTPWMGlrnBMOMBAJ6MIa7rrlDr4kWivWBeIRcFtUDcF0VKLTJlAw4MgbQlg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 19:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20214 invoked by uid 111); 2 Aug 2025 19:55:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 15:55:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 15:55:18 -0400
From: Jeff King <peff@peff.net>
To: Justin Su <injustsu@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching upstream remote fails if repo was a blobless clone
Message-ID: <20250802195518.GA1800293@coredump.intra.peff.net>
References: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>
 <20250802093226.GF3711639@coredump.intra.peff.net>
 <CAB=S_8JYbFHJ6WQSyzGO5ns8Fe-NPCdyKjWLmRrsZ1UiZJsReg@mail.gmail.com>
 <CAB=S_8+aDwMNQkawY-Mod35EDm20mi_=xmmwfngU6As799ppqw@mail.gmail.com>
 <20250802193110.GA1774743@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802193110.GA1774743@coredump.intra.peff.net>

On Sat, Aug 02, 2025 at 03:31:11PM -0400, Jeff King wrote:

> Doing this:
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 0a5c8a1ac8..e01cf7238b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -262,9 +262,14 @@ static unsigned check_object(struct object *obj)
>  		unsigned long size;
>  		int type = odb_read_object_info(the_repository->objects,
>  						&obj->oid, &size);
> -		if (type <= 0)
> +		if (type <= 0) {
> +			if (is_promisor_object(the_repository, &obj->oid)) {
> +				obj->flags |= FLAG_CHECKED;
> +				return 1;
> +			}
>  			die(_("did not receive expected object %s"),
>  			      oid_to_hex(&obj->oid));
> +		}
>  		if (type != obj->type)
>  			die(_("object %s: expected type %s, found %s"),
>  			    oid_to_hex(&obj->oid),
> 
> makes the problem go away. But I feel like I'm probably missing
> something (and that function is rather expensive to run, though maybe
> not so bad if the alternative is crashing).
> 
> +cc Jonathan Tan as the author of the code comment above for any wisdom.

And here is a minimal reproduction that doesn't depend on any other
repositories:

-- >8 --
# Server has two commits, with two blobs for file, old and new.
git init server
(
	cd server
	echo old >file
	git add .
	git commit -m old
	echo new >file
	git commit -am new

	git config uploadpack.allowfilter true
)

# The fork has built a new tree which mentions the old file.
git clone server fork
(
	cd fork
	git reset --hard HEAD^
	echo content >unrelated
	git add .
	git commit -m unrelated
)

# After our partial clone, we have the new blob (because we faulted it in to
# checkout), but not the old one (because it is buried in history).
git clone --no-local --filter=blob:none server repo
cd repo

# This will get the tree at the tip of the fork repo, which mentions old. When
# we fsck that tree, we'll see that it mentions the old blob, and expect to
# find it. But we won't due to the partial clone (though we could get it if we
# wanted from the server repo).
git -c transfer.fsckObjects=true fetch ../fork
-- >8 --

That fails with stock git now, like this:

  fatal: did not receive expected object 3367afdbbf91e638efe983616377c60477cc6612
  fatal: index-pack failed

but succeeds with the patch above.

-Peff
