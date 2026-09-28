Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA672F8EAA
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599730; cv=none; b=LqVzsVqT7c6D2kq37fX4lQFR1tbhric+RxQNbOevMydoiKILNObolpjTglEcfMcvS0xcEw0ZPtkyC6n2qBKJUbsS1SORIdtEsTe0WUMq/8HHeU8zapbz1f9N2LXw86GVK+1rKfKWTAigANRN9rzeaX32mvMvyQoYgD88jyS2Brw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599730; c=relaxed/simple;
	bh=JREsiYQeNmVeOTlox2DPcf4w+McTgrYN/0y7Csw9d7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7hFsULBXoZ/lkHIoHFMyUox/hrC7Ja/wk3tjFVFXs9Ghq2tIbGsLcNNmPx8kSWCOcEvzXOAsm2vWE5FKCeUwNgfBQr71NCRQRWM9fshvbPk11JF71+uoFLckFizNlkmlqQmnwx0lUV0U4mViG4IrfZWjNUH7iqKbNetwSSMQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MaYdwzgO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2TFKoJb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MaYdwzgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2TFKoJb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FFE27A0141;
	Mon, 28 Sep 2026 08:48:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 08:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790599727;
	 x=1790686127; bh=xHElDEt1btVspYiPH11Ps/R8py2OkKoampOzlnm1JMc=; b=
	MaYdwzgO8KzliLYhNFxtmLvYBzNPta4hTy2tAhKrS3nCUzmgQ1GgKRwFXuSItRCH
	mRtVHNBW51aj5kRMkCOqVbjhOYyEqozoRTZn1tcwhCFZuXgtOOyUUBa+LskJtT4V
	LmQzE0rjbrIdpOHIltdJG3nNeX3QFq6CJ3qGNUWFalfdewaijiJTUNRQ6Qu5j/4f
	OUBqnzyKROeLpUN0WprNp7zV+zNBLs1eAnCuZwX89VS+Kz8Nabo9zD2hP87vEuzf
	Wgmq5+prB92W2SbEH6MOfXMNkuRBz5N5LQxGazLePk385mzQWm0MKsGySF8idWrE
	I2giiKd52Va1mNWb3aZhSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790599727; x=
	1790686127; bh=xHElDEt1btVspYiPH11Ps/R8py2OkKoampOzlnm1JMc=; b=Q
	2TFKoJb2dlPc6FxN+X8G1CD4CE0qPCx3/dYJrR0geV5/jr7GdGYMgyJlUnLsW7XV
	8Uttg0/UpJLfgf1YrPZVSuTz0M/RSE1r7HgUw/hmLTwz8rdPHp9H9UYNwkSw3XBe
	RwG9Jq4szfoajhDLk0Qgs6dU0eR1/JWPDVg2o3hbREIW7L+jHfVP+0ErKW6XBEWO
	rkxllmG5DOqniXYEAvGfkP44o6uAVmQafVHLOlmWPr27Ehx3fIet5LNPv81dcJWl
	JG7qMBTDUxp9u9a2DmzZzxBgm5waoGvazVo0OAjtfuP++nbI9srxIdIeakOrhBd4
	zp61EX6xucumZMKM0B9RQ==
X-ME-Sender: <xms:L2K6ap_cgDLu-HMBH8I98H8w5dJhwl--P4vNz5K1myaPo_gq5F8Usw>
    <xme:L2K6alLBej1-gCgjepiZXVnFOrwQ3IyS04jIpOr02h2FdJOt6QzoEaXzbULTJ32yE
    _H8-XjSpcJGWd7sEivgALR4Q8kK82vfgE_fJOW8Ga8CRLN7TTcoaQ>
X-ME-Received: <xmr:L2K6akYECv8QcoQePRU7dnaK1AQ39I66zFYsn9o7U1NwbGVZhl6dBw>
X-ME-Proxy-Cause: dmFkZTEeun5GshX8+MifCCcH2REfJEiDtZ0smtk7++Di9auHjR+6jjar4So24ah/PUF0+2
    OWo5Feah9ZzW0LggCBsv5ZUbBSDY8tZ1UP9yarBbf2SvpaFVCz55tS+IBQoZl/5vDLBNi7
    ewzKNrmKGWjkFe7QYaemrV8Ake5woPyHQVTjmzx4WI1l02DztdddVv3AjRyWmZpjKYNzBw
    XyyALADguQeRSWkzC8PU7tZfi2+LXiYCQtQhxb4uSmmGyOBZ0H01ubm/zsRSGXKqgDI4zJ
    a9l3FmFcyFOneOVQkleuETPb7I3yf5mEi/RV1GkUmxk04BgGa80/1Vm6qWKVyb4HPrJbqF
    +dH09OF2p2+v+aVHouq6P899Vnx0s0GNNZuARQdTVPxSeS1FIE5qP79+n8MDKWlZzlZ642
    JljtMoEiSS+dIcH9bHbD4jGE/FHTcPW7IMOmKTpfTSsclIoBBvtJPDMY1gBfT/zi4j/mOa
    Gi03P0IDAqhGvX+Tim5fdqLUgEXjn6iU0DJEn2MvsBcBM1APVLFT5NPMFoE9/Hcxsn4PEw
    V7jmgIG8sWgf3p5fLZn7MMBmFKjBN7isx2Q42HjropSd/362SkjcgbzUUfQurfRj7Uk+0Y
    kyp1/ixcLcFKIQINfj9f6DAKQDKA6Tca6YKjNqaVoiciwkgi/YNuArwGZdUA
X-ME-Proxy: <xmx:L2K6anI5bSRtpVBwPIkY9QANOc_yR0DStHfSo2wpPU7Lg3LUbod62Q>
    <xmx:L2K6aiBdl9-hV7-YilfZqJlLDhZA1OWAe-usR7zRP04S9bHtTl9Yyw>
    <xmx:L2K6asrnLtWd04WFEPQgLUA352Jsh01uPDY1fXu7bORBp44O0U-Qng>
    <xmx:L2K6atg2QzGDbHZLeup43a8pGyTeAzYioIclMMsfqJhSEiIDDIYjpA>
    <xmx:L2K6arneOuIKANs3LjcQ56z2GVWvsXOT9fKd4ruRk42VDTVM2g45ub_l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 08:48:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf40fc9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 12:48:46 +0000 (UTC)
Date: Mon, 28 Sep 2026 14:48:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] setup: enforce repo passed to
 `create_repository()` has no state
Message-ID: <arpiK4chGRDnHXrW@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
 <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
 <886d145f-ac38-4079-8a96-f09904fc3b10@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <886d145f-ac38-4079-8a96-f09904fc3b10@gmail.com>

On Mon, Sep 28, 2026 at 05:49:20PM +0530, Kaartic Sivaraam wrote:
> On 9/28/26 17:45, Kaartic Sivaraam wrote:
> > On 9/28/26 15:21, Patrick Steinhardt wrote:
> > > 
> > > [... snip ...]
> >  >
> > > 3:  3a7c197f1b = 3:  8dd89f144a builtin/init: refactor messy
> > > creation of leading directories
> > > 4:  c3ced666bd = 4:  f37db1b17d builtin/init: move handling of
> > > "core.sharedRepository" into "setup.c"
> > > 5:  25918a4ff6 = 5:  db76d32f2c builtin/clone: don't apply
> > > "core.sharedRepository" to leading dirs
> > > 6:  a742852675 ! 6:  19388a188c repository: adapt `repo_clear()` to
> > > fully reset the repository
> > >      @@ Commit message
> > >           some state because we don't make sure to clear the whole
> > > structure.
> > >           Refactor the function to set the whole repository to all-
> > > zeroes to avoid
> > >      -    any kind of leaking state. While at it, make it a bit more
> > > robust when
> > >      -    called on an already-blank repository.
> > >      +    any kind of leaking state. Replace calls of
> > > `FREE_AND_NULL()` to instead
> > >      +    use free(3p) to avoid zeroing out the data twice.
> > > 
> > 
> > s/free(3p)/free/
> 
> Oops. I meant s/free(3p)/free(3)/

Ah. 3p is correct though and refers to the POSIX man pages.

Patrick
