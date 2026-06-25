Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F621638D
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366869; cv=none; b=L59dRZgbDW0oQ7TGKx/NxPg5YA4I1j78JukG+R9lzI9LI7bAL7A21y8TjPzj+D44+TeJirPzWny3X2GAL6eelU2ZhOvpP3Dy3lLSuAJECgZ7Jd6b+hlDK8hzSpcx7rtYdf94AUk+9mKUbZSDorIb3oiM/kBOpwveJFgNQQcN/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366869; c=relaxed/simple;
	bh=OHS8vC1tdto029rulz1kZ6CIU32pI9RZupSL652EJNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8tu8qvU2fa7XCaeR2O7Ek0UsCPzTB8qCy6SnbDxuiFQ5aVSWyX3lgkLcx0ZZvIYMxn8Zw89l4tB2cNIS/iCaVxx3MqP17a8zvska7IHmdrvqSvgFDGPkByn3yeVL/6sJhxLiwz7w+XhnSfptPkUpvq/WXKJ65JcB47fiMOYg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPcEOomj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWsk4AVh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPcEOomj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWsk4AVh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF536140019F;
	Thu, 25 Jun 2026 01:54:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 01:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782366866; x=1782453266; bh=YefgU9xGok
	ZoOQ39MgYdg6QExnqN2Nht482UWwnNLsQ=; b=WPcEOomj0heFaFUiLfgE57Up3K
	yAT6LfxC7GCYkVz4fgJfM2km9XEPANLDUNH4lkU8lmtfaKe0JgMN4HP7YkhAQ7ku
	gFBn2F+BcFMZDQM5n/v5RiF1GgeoQtbSgLJb6aO2lqSs3WDFM4UdaO/NX6mXPMYa
	JdNQxj7NjOcpJ7m/hMmRib6XOQddu7aTzMWaXlgePOF+96D4OFqYh2RghPmSrXBy
	iIHJnhI6zIcz/SllNqCQ0auNIwMbImE4wzCwpSJFS9Ltioatsg4c5TUxMbqPVnc7
	IRRWgbSAsIHBW7MCm2nfwXQcHm/1in216D5NE8KYr1Sbc14fzXyZZRPDz+lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782366866; x=1782453266; bh=YefgU9xGokZoOQ39MgYdg6QExnqN2Nht482
	UWwnNLsQ=; b=UWsk4AVhOAhpNNyqpQcplkjLSwBYg+PKdSQiisfRomBISGaUflu
	LkOyzsgcg1hhEjumHXca7JbajrikGojexlVIOk89j4ARLjmbU57kf1EBTTKG0izM
	JDdUeZutbiiQoo+NUkAlLz43e7NFVYkuwhlC1uLCsXbFa3K11QOS699bQ3pBLLlL
	D0bs8bZKxPfNEfj81jNNArVCIq4cZZGtZemhi+ldT6SAlfXgqLUkgdS6NnzqJV2L
	U2rGiwa1WnM6AFWyNAidNVWLaASmCxvYuBhS+go9kzBNnsdIfL2MTFwqOidjxS6a
	qTjto2tiv8Q1tWqj4fBDa3dyr4CZjVRkVaw==
X-ME-Sender: <xms:ksI8avTegJW2fL6733AaVJ74tsFTn93l-R72KltDxysnr4t4Pybfeg>
    <xme:ksI8aoMd8EIjNM6nqKprpaCspwSN3oeJed68Io6Aj8PxZnsXl4LgUz85o4MFKgHf9
    3kixCkz-FqyXfm6qWdR7aRG3gV_ueDz0lG1fEByZVKu2FjPTxFu_A>
X-ME-Received: <xmr:ksI8aiNLAj7wWGFs0J8d_w-FjaDwc5TJysXULORsfJ4199gnIeSA-7ChSeiIb0Hr2bhApGdFQWzG_qVvEATsi67S06mZlxtatDys2fvPBA>
X-ME-Proxy-Cause: dmFkZTGfD62e9bjpZ5564FLymBcM9Y612lKG//L43SxkspPLIrdP6CFgTNedbROsMZ4d1G
    0/FGYHJgdksfeseVR0pddOYOoU17aGA4/9p+aAScRv+t1gOoQkIjEm1VBUrtI28dAOLc/z
    PChpepRKZP366lRDOb+rIHZN4l4NWYMEQpyL93lxtwazJQO3UKV7v2wX5KxrukWz0sIinN
    2IvK/wxrjYJ4XDzJ/eiKBrWXUJ7/cUKlEMUAZhGLQPyNVA0CFkacejUT9lzDqRtzsnq9rm
    sAJiId6GbV+W2TsrDnDcLOcLkONvmFi4TWhfJhyShQV0Ec2sRV0Be3dJ+JbwpQ7HkocWgE
    4tOsgR6uSa+mHZsEkYay6yAOIMWYJIK+gt28SIiI3f67RMxDpYoBXLRuvJuQBDE5JmFklD
    ZkBALlJLYXTs7cXPEhUu+qZQO6UUvTkbT0BopX9zoP5Q9u1I1LZhTftS7saT+tg/zG52AC
    JkYIn3m8/xXkeoC/E4oddJ4j6Up1D/7Ym4wDi1J/+6DcIveF62T/iDlQLp3Num+WkiaaXP
    yThmHzhbrhPM4xNOHSmbV7RlARvMbT1THpy+ZqyGI+n4ZIF5UDsHUEUTjdAtpX+sNH5o6g
    L1AQL5hVI9FLUjnWTUIHSXLHsuR9P84boJTgFNeu+qeeS8v1ajTYED3B9E/A
X-ME-Proxy: <xmx:ksI8aovzif0nzezgSDU26u3nSQTyM17QQMzYVb3LAMAW7fIrK6HhoQ>
    <xmx:ksI8asUPEV0KA1rzHJVcMennxiPrJQwNPxoNbjfeQY9GF1Wm5RaNWg>
    <xmx:ksI8ags2nF6QGdqj1CeuMEJKVRBR-xU1H51QeEQn08Xz8FjTkE4zDg>
    <xmx:ksI8aoXuB2tN2gHOQsF89aTb_NFfIoPhPfuvCdPNWPutzmFxi36zOg>
    <xmx:ksI8am0BAX3Jc0PJYDee31Z-8Ql5efxttq6_s7rFTlG0GffC5lFBcT98>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 01:54:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4b66b39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 05:54:24 +0000 (UTC)
Date: Thu, 25 Jun 2026 07:54:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] connected: search promisor objects generically
Message-ID: <ajzCjgLJ5pzBph2Z@pks.im>
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
 <20260624-pks-connected-generic-promisor-checks-v2-4-132d73ee47b9@pks.im>
 <xmqqjyrnkinn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyrnkinn.fsf@gitster.g>

On Wed, Jun 24, 2026 at 09:27:56AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/connected.c b/connected.c
> > index d2b334173f..b557ff5db9 100644
> > --- a/connected.c
> > +++ b/connected.c
> > @@ -11,6 +11,13 @@
> >  #include "packfile.h"
> >  #include "promisor-remote.h"
> >  
> > +static int promised_object_cb(const struct object_id *oid UNUSED,
> > +			      struct object_info *oi UNUSED,
> > +			      void *payload UNUSED)
> > +{
> > +	return 1;
> > +}
> > +
> >  /*
> >   * For partial clones, we don't want to have to do a regular connectivity check
> >   * because we have to enumerate and exclude all promisor objects (slow), and
> > @@ -30,25 +37,28 @@ static int check_connected_promisor(oid_iterate_fn fn,
> >  				    void *cb_data,
> >  				    const struct object_id **oid)
> >  {
> > +	struct odb_for_each_object_options opts = {
> > +		.flags = ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
> > +		.prefix_hex_len = the_repository->hash_algo->hexsz,
> > +	};
> > +	int err;
> > +
> >  	odb_reprepare(the_repository->objects);
> >  	do {
> > -		struct packed_git *p;
> > +		opts.prefix = *oid;
> >  
> > -		repo_for_each_pack(the_repository, p) {
> > -			if (!p->pack_promisor)
> > -				continue;
> > -			if (find_pack_entry_one(*oid, p))
> > -				goto promisor_pack_found;
> > -		}
> > +		err = odb_for_each_object_ext(the_repository->objects,
> > +					      NULL, promised_object_cb,
> > +					      NULL, &opts);
> 
> promised_object_cb() returns 1 without any computation since we are
> only interested in learning ODB_FOR_EACH_OBJECT_PROMISOR_ONLY finds
> any such object.
> 
> odb_for_each_object_ext() returns 0 (if it iterates all the sources
> to the end), but if its call to odb_source_for_each_object() yields
> non-zero value, the returned value comes back as "err" here,
> terminating the for-each iteration immediately.
> 
> odb_source_for_each_object() is implemented differently per the
> source backend, but taking an example of "packfile" backend,
> packfile_loose_for_each_object() ends up calling cb (wrapped in
> packfile_store_for_each_object_wrapper_data) via
> for_each_object_in_pack(), which stops immediately when cb returns
> non-zero and the value returned from there is the value given by cb,
> i.e., 1.  So we will have err==1 when we find any object.
> 
> > +		if (err < 0)
> > +			return err;
> 
> And err presumably is 1 in such a case, so this does not trigger.
> 
> >  		/*
> >  		 * We have found an object that is not part of a promisor pack,
> >  		 * and thus we cannot skip the full connectivity check.
> >  		 */
> > -		return 0;
> > -
> > -promisor_pack_found:
> > -		;
> > +		if (err > 0)
> > +			return 0;
> 
> And this does.
> 
> I may be misreading the patch, but as we return 0 from here, do we
> cause the caller to fall back to full connectivity check?  The
> caller, check_connected(), sees a zero returned from here.

You're right, this is a result of the refactor. Previously we had it
like this:

    err = odb_for_each_object_ext(the_repository->objects,
                              NULL, promised_object_cb,
                              NULL, &opts);
    if (err < 0)
            break;
    if (err > 0) {
            err = 0;
            continue;
    }

But that made us correctly skip to the next object. Now though we have
to check for `if (!err) return 0;` in the refactored code. Makes me
wonder whether the logic would be easier to follow like this:

diff --git a/connected.c b/connected.c
index b557ff5db9..b5a9b0543d 100644
--- a/connected.c
+++ b/connected.c
@@ -13,8 +13,10 @@
 
 static int promised_object_cb(const struct object_id *oid UNUSED,
 			      struct object_info *oi UNUSED,
-			      void *payload UNUSED)
+			      void *payload)
 {
+	bool *found = payload;
+	*found = true;
 	return 1;
 }
 
@@ -45,11 +47,13 @@ static int check_connected_promisor(oid_iterate_fn fn,
 
 	odb_reprepare(the_repository->objects);
 	do {
+		bool found = false;
+
 		opts.prefix = *oid;
 
 		err = odb_for_each_object_ext(the_repository->objects,
 					      NULL, promised_object_cb,
-					      NULL, &opts);
+					      &found, &opts);
 		if (err < 0)
 			return err;
 
@@ -57,7 +61,7 @@ static int check_connected_promisor(oid_iterate_fn fn,
 		 * We have found an object that is not part of a promisor pack,
 		 * and thus we cannot skip the full connectivity check.
 		 */
-		if (err > 0)
+		if (!found)
 			return 0;
 	} while ((*oid = fn(cb_data)) != NULL);
 

It's also a bit concerning that this doesn't cause any tests to fail.
I'll try to figure out whether I can add one.

Thanks!

Patrick
