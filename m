Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16E19F432
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106501; cv=none; b=hULrAoNCSFvM7bjCSVfj6g/4rSqx1ur2BP868ytFlBQJRLXWoAROM39FtRhm5Tv0zt1kMauQACIz/WvoBWqKKnqHobAFWX8Li6rWrJOFDhlLe30rhQdWR7y6+Vfe8VFtuHvo+nM1bBGwwogqTzp+QVvRQ9UR4XtBDIeROElU2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106501; c=relaxed/simple;
	bh=t7kNbnm3x3CImU3lNnmPC7LMEklgZKKeCjwmOe+Bn/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+0oQ87JUT15uslGvNqybR/VkmEHfnkU1PvSVuqergit5dKFv4EchSJN3iCA/Ov0G2GCXHW4vFFeUqeUUUfh0WZFjK9ScJO38UtMBWkNFQaS9d2n/5OWqRL3AxaQZgyw9+MmsIxUT8158lreV9RCs5aEuvm/rBo5VWYqtgNoyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xfUcdnjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H416u5Q9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xfUcdnjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H416u5Q9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 33126138038E;
	Wed, 20 Nov 2024 07:41:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 07:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732106498; x=1732192898; bh=yspYhDlQ8x
	CgtH89Nt2jG3gUZ21yIr9NyVIbK4pc7kk=; b=xfUcdnjxQ3XR1vn8GrSZSp0lPX
	99JyinFac67YWxrUQIleFwLxxXtz//m7HA1ErlJdyvlpeIMTTnGZ1IausEnKnPt5
	eFSEUuPxncuLmYZ0PGZxiqg7L584c1kZwsbKR23swDlYpdFbQ1Ml7TNcRfwwXdAZ
	lfOWtnOaXUx+6R/GAKwRIg8BLJneWRZuGNseyOv/BVpxSrVKqHE6onywPinvwVYb
	Rxvixj5U9Rs1PuLXeAUi2WrssvJThGIfPdHTLQI2kfsrxn8bOC1rTzOAKJadqsVH
	9HJtMOA3iZghvCXdUNW1cgep1dILAL2nbmpyNnZf/P7uJMw9YMj0u9ZCa6Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732106498; x=1732192898; bh=yspYhDlQ8xCgtH89Nt2jG3gUZ21yIr9NyVI
	bK4pc7kk=; b=H416u5Q91ivP/4epa5z9NiP6Yd9PJ5F4kJul048WEIdKzCE/Ua4
	qZoj6q0uRvvy5OdmLuxh8pCrN0o9t+OMcreFtORfY82RzoTjLRtvyMsoxEpk//nF
	idkaIv5+MpZjYSzLMoJipvlF8E6TY/VO02eiUINCqYZU53gKoIj+zCyKpxZ8ff+l
	e8FKtD7WCeJOLwFybe3TK9oN0pgj5httFZmw+KYkCZ9eMhkzIIW3QgxUDJaqzSFn
	kjmSUmw0yoRMoZ6MQuLWdaElUC0T32drVgVPZzYXFQYZ0DqleiM/vGvuJmldzOAz
	6qg8vH3A4ueV3dubWhJv6RyXMyFdAGxwkJg==
X-ME-Sender: <xms:Adk9Z9tTD1FSmIZy2amY8lz-pWIOGzgQT-uNPAn-3KcLZnszrAnL-w>
    <xme:Adk9Z2eSt8hDej9p0iIFwbAMUKLAfKkjl7LvwCxwM1hLtwJO94d-ExIbs8Vz2OzWu
    l2qB3jD7I76mT-OvA>
X-ME-Received: <xmr:Adk9Zww4BqSYaqsJtVjdsnkQrLsoUg5zkGFIIL1uEYaIhf-bOxIyGtBizSgRy5L6gcc685iTMyN73kLL1J6CbSWdqkDLGSbjXK9KfLdf2VbwCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Adk9Z0MR9MQ5bPR5lklnzF1dLYWeqk5mfhikJSos7yn7w0mIUkT_zA>
    <xmx:Adk9Z99PdWMCYfFZqZaFu6Jq7qFN0xxmvyWJxgHT19fxES0xMQ-RZA>
    <xmx:Adk9Z0X4L0NusxB__J4Yl_HRGdMuOUc2mykZe56Et8GWoI07WYGv3g>
    <xmx:Adk9Z-dEtNxgXU6dGsfaPhpd3sAaP2GgYADAujfSBjd7JtvckD9B7Q>
    <xmx:Atk9Z4ZBAxej2nAAXoco0-tzh0a7mLRhK0VdVwa9IelUW-LIw-HmBfd0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:41:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59a40abb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 12:40:45 +0000 (UTC)
Date: Wed, 20 Nov 2024 13:41:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 07/27] bisect: fix various cases where we leak commit
 list items
Message-ID: <Zz3Y9xJ-xQvBNNdm@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-7-6154bf91f0b0@pks.im>
 <875xoitcu8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xoitcu8.fsf@iotcl.com>

On Wed, Nov 20, 2024 at 11:32:31AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There are various cases where we leak commit list items because we
> > evict items from the list, but don't free them. Plug those.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  bisect.c                    | 35 +++++++++++++++++++++++++++--------
> >  t/t6030-bisect-porcelain.sh |  1 +
> >  2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/bisect.c b/bisect.c
> > index 12efcff2e3c1836ab6e63d36e4d42269fbcaeaab..0e804086cbf6a02d42bda98b62fb86daf099b82d 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -440,11 +440,19 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
> >  			free_commit_list(list->next);
> >  			best = list;
> >  			best->next = NULL;
> > +		} else {
> > +			for (p = list; p != best; p = next) {
> > +				next = p->next;
> > +				free(p);
> > +			}
> 
> This makes the code do:
> 
>     if (!something) {
>         // ...
>     } else {
>         // ...
>     }
> 
> I find it odd reading code like that. Would you mind swapping them
> around? Or is there a reason we type it like this, because I see this
> also being done like this around line 393?

I mostly did it this way round to minimize the diff.

> More on the functional side of this code, I'd like to understand better
> what's happening here.
> It's clear to me when `best` is NULL we want to free the whole
> commit_list. And when `best` is set with FIND_BISECTION_ALL flag set, we
> want to free the commit_list up to `best`. But when the
> FIND_BISECTION_ALL flag is not set, we want to do the opposite, free
> from `best->next` till the end? But what has this to do with
> FIND_BISECTION_ALL? 

Good question.

Typically, `find_bisection()` will only return a single commit, which is
the next bisection point in the range of bisected commit. This is done
by approximation, where we want to find a commit that is roughly half
way between the current good and bad commits. So the result should be a
single commit, only, and thus we free all other commit items except for
the commit that we have determined to be the bisection point.

When `FIND_BISECTION_ALL` is set this changes: instead of returning a
single commit, we return all commits in the bisected range of commits,
but tag them with the distance to the included and excluded commits. So
the result is a list of commits, but that list may have been filtered
down from the list of commits passed into `do_find_bisection()`.

So when do we filter items? This happens in `best_bisection_sorted()`,
where we skip over commits which are treesame. But for all I can see we
never end up skipping over the head of the list, we may only exclude
times from its tail, and we do know to release the tail alright.

Which means... that the added code is effectively a no-op because `best`
will always be pointing to `list`. Removing the code and re-running with
the leak checker enabled confirms that there are no new leaks. I'll drop
it, no idea what I saw here.

Patrick
