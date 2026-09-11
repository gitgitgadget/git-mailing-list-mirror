Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A8413786
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153325; cv=none; b=oEkzGtscJJGLUTj7RCaJ1LaqwLxrXTxJbJ4lLUkpIlrsUEOXNj2Hh19ptMC+3Cg+dVeR7hhVUTtSN7t5AoEY/ahFZtEag6iG3+FnIi92WwPfA0YiFyC+MYiiga/nOqGzAAIWRbWtx4qp9V18GWscRFtai9Gk6vBcifcgSpnJQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153325; c=relaxed/simple;
	bh=W5mqV4qn3lCVmCT6DKT+6R34kdiiFFFH9u5svizWuoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKug1us0y7PgsbXss+zVGIhy8lauJVUzSOeN8YmOR4q1Jd9WdyhkBAL/XvxSSJhA9HIYDPk+gWidUE0lfwsGP6rFvE/CkSKrMY68uOc+zEQSV7PU124kuCOTtQXWXfMYAi1c7x2UGtJbGVTDzIqmaprxKbguXutJE93KCZQMAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d8jV43la; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ia67hd0C; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d8jV43la";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ia67hd0C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7044B140003B;
	Fri, 11 Sep 2026 15:01:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 15:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789153305; x=1789239705; bh=+pZxOV7avn
	s9BrkuX8oY/LAPwikcSGmSt7vWw/QLCoc=; b=d8jV43laGsYy+OHMe3tu+aoNFF
	EFm0FTJEvZWjKmVi1eLJWo9UaxJ5neLOzaasi5vsHxZP4RQeyiPoZxubiFJIVbJA
	PUCy9MjdSYtPI7o1FTMY36WjwrLg4RbYm0atxsjTOn0ecAnTAdFPTTaWaIKQgTTM
	ZCtku8WfqZ+gC4LsJLwz5wSLjRMxWXkOCPrLUjSHTAka+KCMYeLIxjS50Vbjh39U
	KW5Srg0kIjxVLtEno8DrQUwXizB7LQ89b2LdTDnZJUxw+oe5sPFVVzDrRZI9nW/T
	TlpMNY4SiPs6oXb7k/7sHi/hQLZ0l7Lvp8LTCmncosq/6tBJJi6L7vs68Azw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789153305; x=1789239705; bh=+pZxOV7avns9BrkuX8oY/LAPwikcSGmSt7v
	Ww/QLCoc=; b=Ia67hd0Ck6B7R4p/My1NBvk9eMqaVZlqoXgJw7JdYe29ZWxvuIY
	YhLNbvSyh4OoHHEH0iH1V6mBA3XWclm85qdpSpK/d3pkNRS5MN+UWNAeHNVTEVAS
	x0zLLWCLuc4209I1c2J/wGHXGtHp4WBfCPJdSeEXPbaqCd6RKwEBs776Zo1fsPji
	RVD+KyZKT9y4yyz+C+lLGwz+67TA9WSD+vSQO+RWKLR/BVrSZEx7WDTtmcggDcgc
	oe2v5t0TSifzgJ/qaEIAOtmSgVtzMLEhIwzHXyPNPd4jNyli0Iz0rnaHwc3VcEJK
	hNFJmGfzb28jxDCGtBbJxFUUVGwswHvA8aQ==
X-ME-Sender: <xms:GVCkamWChWOfDrf62XtNchIjvdVkoByyFEF4nuCOFbrBQyv7syZnrQ>
    <xme:GVCkaonirvZjcHZjUemV_5iCrBAHw6cpjtctJCifWlAbvcbwRSkD0Cl8I5qbGlviu
    jcMqKW4iHL2emu14yNU4irpknNZg5NMsLUUd9QOVX9gFQ5GUs2-dDU>
X-ME-Received: <xmr:GVCkaoCAkgC9A_mknqxWES6Q4aepdzIbxul_hvU5lbtpzajZE7Hp9NOxEMHUPQ8CgjmFKA>
X-ME-Proxy-Cause: dmFkZTEo9Yixzx4GUgFkKt3yrZtLKwkoaPj9u406SOh7qcJPEbAynkjkIi7ADtGLiT09jF
    ur4+/FxQsftycLJf6LBsmllfBhyyyefK3uNfQ1+A7835e7K0CiaiNk1iPqa3ctWYQeilIJ
    E6DYJLzGvdpYi/AD687obXFRk0rSpKrSDsS0C9Z+c64ni8CpE92shK9cE9eCxYIrePKgOx
    6f6m66NcWxBoZo05KYOE96n0j4H5f/qOPg9G7lpaYi9Jde3mpakP7dldgKgU45Hqltp+hj
    aezd3pBPSisAALRIQ+4NIInpwoBJLK//2W1S90BDmE39YuTpQq9QHXZqZJaFJkvxf+0oQm
    Lnx7Hz4IDdDWlvOakYKRyRomxqpoEDw4J/TwaHDnsUpvnx5mt3TH2ORn8zfiLPuvxs63zd
    UXLxKp+S3Kl0ZWWsA+Vy8vzU3trJC4AQH6WjOm2LU9C3MekOjlckjyxNcJlYyJjAyZsW/u
    umtMECmvXvuZvw04SCgixQNBWMmdZkkb7dpbqQfmrjQI6XWh8XvGedzBaQrh5pIhXOyM9p
    y86HVGipdvyD3JGnqEtZ2lSzeEleioy22UkaTG9OkMADpzoMhvv3ZAgxYhgQH5mLqHYrpk
    v/nf6vIuegEV+CRzUSdykn8J0asNvLXmH9UuKQ1PCe+AFz+aeGi5zjw8ABYw
X-ME-Proxy: <xmx:GVCkaof_rXtp62IwRdxveh1W6k81uGQJyfPx7LBFuTf74a4DNLt6eg>
    <xmx:GVCkajKU44g_KxMURBeQSD_Y-AKufN_dz1pV_l_M5DGchFtBjgNXQw>
    <xmx:GVCkarfwuldBkOOmb5DwMkd9MgdtNtAJCGYsYPT5aosOsPVeXYiTmQ>
    <xmx:GVCkaq2aJcWlnogUHqU062cNkCEzxxzS5BFktu_-qrWdCWvUR-L_Dg>
    <xmx:GVCkahunTKRwuYfAuL2cvHv8ChkjFE64XmQ2XgW1pD2AeLtgJXCcQFKv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 15:01:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0bb5a7fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 19:01:42 +0000 (UTC)
Date: Fri, 11 Sep 2026 21:01:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #04)
Message-ID: <aqRQFQz_E0ZPzrfe@pks.im>
References: <xmqqa4ppf1l5.fsf@gitster.g>
 <aqOZLBeMLY6NdW2a@pks.im>
 <xmqqld97dbsa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqld97dbsa.fsf@gitster.g>

On Fri, Sep 11, 2026 at 08:53:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Thu, Sep 10, 2026 at 10:39:02AM -0700, Junio C Hamano wrote:
> >> * ps/libgit-in-subdir (2026-07-12) 2 commits
> >>  . Move libgit.a sources into separate "lib/" directory
> >>  . t/helper: prepare "test-example-tap.c" for introduction of "lib/"
> >>  . Merge branch 'ps/odb-source-packed' into ps/libgit-in-subdir
> >> 
> >>  The source files for 'libgit.a' have been moved into a new 'lib/'
> >>  directory to clean up the top-level directory and clearly separate
> >>  library code.  This topic has been ejected for now, as it causes too
> >>  many evil merges with other topics.
> >> ...
> > I didn't really have the feeling that I was gaining consensus on this
> > series. Maybe I'll be able to build consensus at the Contributor's
> > Summit, but until then we can probably just discard this series.
> 
> To be fair, I do not think anybody would unwelcome a change that
> makes the sources easier to navigate---otherwise we wouldn't have
> odb/ or even builtin/ hierarchies today.  It is just that different
> people views how easier to navigate a concrete change proposed makes
> the sources.

Yeah. Thing is, changes like this are always going to be subjective. I
expected lots of discussion around this particular one, so I knew that
it was quite likely that I won't be able to build consensus and that
there'd be lots of different opinions.

I personally still think that having library sources properly split out
into its own hierarchy is a sensible first step. But I also agree with
others that it makes sense to then further group files that belong to
specific subsystems into their own directories. I don't really see these
as mutually exclusive, we can have both.

Patrick
