Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF63AC0FD
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164054; cv=none; b=TPgihHiwfkV0aU5/LtBSX/cBMAa10EzZA7Sxk5ctYtHJgfR2IWPKfQbgU7U5K1xTCh08QCtyfato3aniIMbJ4o7YC5yy7NShl0r3b3t3DQS4f4dpLzr0SvhCMDosVsIPdJh1GN11wEVw0G81MDyepJ2tZxQ68uIWsV3DJSXbBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164054; c=relaxed/simple;
	bh=ZLMaPuWkbtZro5l1CpQOLAgvwjFVm4qSIECFpZZ0nHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlDMJku3vKmDNJNMurDzAEZF79jyrPUltVkxZy0IQRBRzZxfPHIrsV1MAnKdCKno0dCgcUzRxJppFXEMKscFwmm65q0HVcWJTi0N+67X9n6MwPuoPKlaDm1MzHiggDrk9y7gwC6IpsgvtQ7eQaT0XCFJBHTk+rB3HyI4swzc8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G5FjIkWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJ1FCTnm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G5FjIkWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJ1FCTnm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D53C11D00125;
	Mon, 31 Aug 2026 04:14:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 04:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788164051; x=1788250451; bh=uMrXTqba2u
	FrwgsZVflsolnNvpSND83l/26B/9bZ52o=; b=G5FjIkWm376DF1vEnBDraEwKw+
	mCJPE8S1KfNABgQB1myV17zOHrDf7NErATMmWlJwo489Q1n2K4ydSOMnsfJFUCoo
	V1jksMhNwhUEPYBECGBafYIFHVHnmVrjOkNT4SXBFKjbVUpuvMSp0OK5+1MWj8BC
	P58PlbZRke39b+dfDiD1YCtJhcimrTMyH6MbHF+byhpSEMnSqJbm3/XD6/BsMSoi
	2sgy+jVHMWgnA0f5Jj+d9B1kOwEvTqs+vAp4XUoIKBmFjhWlZWUM1zdrsJHJLfjg
	LyosavKpIo954zqYStQ+aYa68K0RFdUUvgq/vnsjfYbfdYs/wkk6p+aYlCJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788164051; x=1788250451; bh=uMrXTqba2uFrwgsZVflsolnNvpSND83l/26
	B/9bZ52o=; b=AJ1FCTnmtH1RO9TqeDpKIAS66W/6ndViJtCKYpLFz8Vj13uEaPB
	ozlysrp33NHHJy4dAYH9gK5sgWFUQnvLnANBR0nWV2TLSRmowzRJ0QFkfvK+FISt
	5YThZ3s7Y6+Z40hYettZi0KtmEBLTuj3tpWx6hJWjvQwLQlkfxTeMT4Im3YZa2/W
	QkLrzky+VmIQ1BzbiFvQ7j0radyUKuW0j0ybVsTuq00SYHFceQ17R+jirzswOW95
	AVdzwVmAou1Koa1yUSepj1Kz/hf86byShwysIvLgy+WCNEecYXcX2/BbR0HAhs1W
	BDijwnzK+VZWudfIlIPfQREE+m+Hk5fYhPQ==
X-ME-Sender: <xms:0zeVav7mWkKVpDjEKdegPmvc9ZfbWrhZVgW46BupsbaXQWTJI2B--Q>
    <xme:0zeVaq4t-Pp3zMkPRG3JV7UOmU9dwQYCgoZBbfeqg2MSNEYARDXrM1Yp8jg8vb5AD
    b5G7DhZFz-iTWwAFMcLqakYhEhJgIzmLHXlqDyRTyn-Y7AeWP50MyM>
X-ME-Received: <xmr:0zeVakG9ZgnmeCqCUHoSEsUN7IaMDR2Qv_PivD522w0cN5BrSX-u7jkU8FO_eRY3XloQsQ>
X-ME-Proxy-Cause: dmFkZTFZXM4nlK7FuyZfh7KCinb1QyGk2t3KSS9yX5r1PCB1Xa5vcF8NfeAsZ67pSXj2ji
    fAT+1vdX3nk639xkgZMwzZT5pzCYuwKtrrf+X55yT+oZv2K9xDX23VMWH3hwqiWhBV8BwZ
    Wy1AB3wM7mVN+sc4Q2PZI0DpMgOEfkJBhrhHEEQCGbDsPXyNrDwh8Yxp3EKVJStka+0YV/
    cA7j1H4qwk/p45uS6WLyAy/hT4bB0VmK1lbYNulT9LAUcZxIyA4CjG5osStpowI+IyYttD
    w5TXW1cS6UZxtFPb/7gVJaYXUWCdvApbm08K6ecFPdWCI73cTqUzZU/ZpZik8DucGQjdc/
    jxjlp2hDTM7WEFp3r1LHAcnsqYs8KvcmNBH2PCndxkVOcj9URXNS+aix6VcfPhHMpCG2sO
    SmhNUR3cwl5K3hL7pp0Q1kYDh+pLaKuWiH86mEVUBRZFAM3kz6ttJ2Lb+sso1dZjUt+9U1
    2qKjrCjFH0oYi7vMXTbKwLC5fs9wihXUuIkK84CKDqo2xHAJ1yKT8GiC62g25QGtau4IzY
    6KRe79eca/7swt+895oJ2DGXSMO/RZBpPQ66pxObCAungs1FlwgPy/tTHGv2Tn26F2j2sA
    RIPir7ofg4tW2FoHMo0rb5ql4f+dxknAjYozt4rPdJoXxrvcsaGCN36di/aA
X-ME-Proxy: <xmx:0zeVarRDjUzEE36CTOdlZsreRaT7l5DoFWzZKxgtetrgJfW2c5Fg-A>
    <xmx:0zeValsJsO471cbDb2C9DFbFgs95Nz-fQdlH8kWdK-tv3nFar-wwEg>
    <xmx:0zeVaiyp1_AC7gYQTU_ZhQlqhJXCEifzNQx6xp7aGmxwWH4lS_lAyA>
    <xmx:0zeVan5C9UWAUgf4OUvGRjLWwXH0E9phE5Odj-Se2jPEgMoRXNFL1A>
    <xmx:0zeVajRMVXWF7OcLoBFntaDuM00OI-UeBQjtJlsljdRPp1CyvBpFROP2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:14:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d4bf579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 08:14:16 +0000 (UTC)
Date: Mon, 31 Aug 2026 10:14:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] odb/source: support writing alternates when creating
 the database
Message-ID: <apU3zShTb3W3rit9@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
 <8733vyuwid.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8733vyuwid.fsf@emacs.iotcl.com>

On Fri, Aug 28, 2026 at 04:53:30PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source.h b/odb/source.h
> > index ea8675247e..86b82fab3b 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -5,6 +5,7 @@
> >  #include "object.h"
> >  #include "odb.h"
> >  #include "odb/transaction.h"
> > +#include "strvec.h"
> 
> I see `struct strvec;` is already defined below
> odb_source_type_to_name(). Can we not include this and put the new
> struct below the strvec definition?

Good point, will do.

Patrick
