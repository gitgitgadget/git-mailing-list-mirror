Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903C26461F
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492499; cv=none; b=Mu8RzVehSqw3QGsBr5RY73JeJ/ToQqgZg+hDktORcb0gptfM7iA2p3eu18kOZ3kJ4/5PtmGTJ99J1VSRdHEk6MfXQGUGLCqosJIIvm9qPNd5Ewj9UaWfijInF5tMwCqseORIXCCiinGjsvLsGgJe0MuZStM5sDBn6Ck2CrHjRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492499; c=relaxed/simple;
	bh=c/E32jDlvoqXxKYTyiOi494fnXOMEDUSCCdJ8/mlO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STzZniUOzgS9Q7iHj4Wpa52g08mr+00cBUxqRQo9UZtlTifDxelT9teaxrpt8qVLtZ6Uo/k85OgBXki00Brz9tIKLgmNElz057LDvfFlz6pkxBlFW1VhQJOosSFn5OWmjRR1KEtcil9TJXw1kZusZWdZzm/o9sxcY+3g+KtwdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CVy3FE+G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CVy3FE+G"
Received: (qmail 16499 invoked by uid 109); 18 Aug 2025 04:48:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=c/E32jDlvoqXxKYTyiOi494fnXOMEDUSCCdJ8/mlO+8=; b=CVy3FE+GrjbNkO34No678Nue442x8EcUQlp1h9/4Zt24MY+V5QMx5PONdhYSYaT+zhoxH0PSIFl7NqGv/7rzibBiSGdA1i6nvgt3YCQczEwAu/lZi8b+irVbV6dVbTStFeFTL6jg1J6IOmOn9cTKd/wPPZFxyGL2S3pz/aQyKS1IrenhlTKaUx/a+36MtWgIzuw9u091YFSjUViHiSJG9bxOEnSF88g/oanAeGdJsQSxmpXwKc4hEzRgajZJ/g56Y2j9xLpdWSe5pqSGztbiHj3EaDN6tzxHf1nlFIuIpy90naAIBGsweh3CdzvgqdcatIpN5k5iPF1TyJv2QW87Tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 04:48:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19397 invoked by uid 111); 18 Aug 2025 04:48:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 00:48:07 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 00:48:07 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
Message-ID: <20250818044807.GA51803@coredump.intra.peff.net>
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
 <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>

On Sun, Aug 17, 2025 at 11:27:12AM +0200, René Scharfe wrote:

> > @@ -546,7 +544,7 @@ static void process_object(struct object *obj, const char *path, void *data)
> >  
> >  	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
> >  		reset_revision_walk();
> > -		describe_commit(&pcd->current_commit, pcd->dst);
> > +		describe_commit(pcd->current_commit, pcd->dst);
> 
> pcd->current_commit is initialized to NULL below, but
> traverse_commit_list() without a filter must have set it via our
> process_commit() callback before we get to the describe_commit() call.
> 
> Or are there weird repositories (e.g., just a blob, just a tag) that can
> cause traverse_commit_list() to call its show_object() callback without
> ever calling its show_commit() callback?  I don't see how, but may be
> missing some way.

If there are, then I think the current code would segfault, too. It
initializes &pcd->current_commit to the null oid, and then
describe_commit() resolves that via lookup_commit_reference(). That
would return NULL, and the next line dereferencing the result would
segfault.

And it would be a counter-example to the claim that the call to
lookup_commit_reference() in describe_commit() never fails. ;)

I think your intuition is right that we could get the traversal code to
call show_object() without show_commit() in general. E.g. just:

  git init
  git tag foo $(echo bar | git hash-object -w --stdin)
  git rev-list --all --objects

would do so. But in this code our traversal always starts from HEAD,
which must be a commit (and this is enforced by the refs code). So you'd
have to corrupt your repository like:

  # do this in two steps since redirecting to .git/HEAD breaks the
  # repository for a moment!
  tag=$(git rev-parse foo)
  echo $tag >.git/HEAD

And indeed, the current code does then segfault on "git describe foo" at
the spot I mentioned. Even though the repository state here is
unexpected and corrupt, I do think we should probably be more defensive
and avoid the segfault.

I also find it a bit funny that describing a blob only walks from HEAD
(and not say, all refs or ones matching --match/--exclude, etc).  It is
documented that way, though. Actually, I find the whole feature a bit
pointless now that we have the diff "--find-object" option. Reading
15af58c1ad (diffcore: add a pickaxe option to find a specific blob,
2018-01-04), I think the git-describe behavior is mostly considered a
mistake (which we have to keep around for historical reasons). I guess
another possible candidate for removing in Git 3.0. :)

-Peff
