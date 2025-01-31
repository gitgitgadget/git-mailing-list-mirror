Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCB1B6CE0
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336645; cv=none; b=Ett6HrcLn12KpxBY6pJnMya7jA+AkHRmcwcmyoK2TIb2yHiy4UX3txd4N1WbyzPtEecfGXVE26Q/rp51wpOpwnsqgzfMcxEabpuooX1+7RFig8DNAxa/+NQfqE/JS9cqXf6x4dYOPMy7iVJDO1KZIsarZ2Sz+R2/oE0JGeT39UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336645; c=relaxed/simple;
	bh=+Rwp4igr01rKIv1xWXICwf7DJcKW/T0m3ZF+sj4rcXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibZx2oNUtxBnOI27VpxV3H+yszwiVkVvJ6sNam2ybWWLcKe8ERbMp3odurbZOO1IAYqrMf+7Hmmvl4v9fyG5yrW50E6K3qpqxxB19HY0hlKbi3nJsce8WONPrlAoFG96CsuLcXFBj9/IoQSP9oAK0pi8PHINeytsOSfCrECcwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=Wr/9YvPP; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="Wr/9YvPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1738336630;
	bh=YrlcaHxvFMPB5s2ebD0HgA0273I1TGLLupcQT6p0ZW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wr/9YvPP+roRaIN/UqveVVgt/zf7S65osd5hR/Ak+hCqWEDtdtWKPTL0960qgEceM
	 vd8qakaqDMgdwa0kBpt74TlY9JLFvnvFXCh+5tilcZ0Alq3Sn6uzKTXcJtnF46zXXU
	 gtJNqxnIeSWmQBywo50ZQO61PcjeX/ZYyiNfuAYyMao6RVk3lPz2rYe5OEW68bS1ob
	 1qt9fKk4HtOFsky0SSpD4hVIZdXyBTYXmYHEPJGL4kfbkS/SM22rO531AYoiTwyclf
	 KzDGce6krGiGg23z0m5h2dhVH2IfT6mxKdUGV2xYqDbVuCNt2Y22X5iXLhpqjr1KMH
	 b4jAbpDGo5mdlXAI61HB7azNy6qu2YnwyTqNJ5ZJKJts9Ha/dKA7WqSpvK2kPtc0yg
	 9HU1hRh6wbvvQH9828rG868jg9vDGgM+3W2nmTQo7LSGWzptnGlFwJW6Xchnq+HLys
	 HqZCDpHrzSexbUrdzwyV1yLAXL97HkAPxCa27ivB8cqSCFh/PH97X9/Yh3Wlr8DP4E
	 6pmZfEscbJqc7B6HDtWUGMX1gr9m/6WIA7GtfhVV96xiwc2+yahBH5X/EES7wbPH3l
	 BZkhHT4Ai82qksH/XfkneDL7euviJRn+kqJyduXzYRVz4yoI7m/e66EoXKNDeIAmG3
	 94BRjVxGeCF9BoeM7EkA9c0k=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
 hanyang.tony@bytedance.com
Subject:
 Re: [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep when
 repacking promisor objects
Date: Fri, 31 Jan 2025 16:17:08 +0100
Message-ID: <7102402.jJDZkT8p0M@electra>
In-Reply-To: <xmqq34h0aq65.fsf@gitster.g>
References: <19759704.fSG56mABFh@electra> <xmqq34h0aq65.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 30 January 2025 23:32:34, CET Junio C Hamano wrote:
> I don't have a strong opinion about the technical aspects of this
> patch to be a reviewer.  I have no idea how you decided whom to Cc:,

I'm sorry again for spamming you unnecessarily and many thanks for suggesting 
more suitable reviewers.

Being a complete newcomer to Git development, I went by what the git-contacts 
tool suggested when I gave it my patch, since its output seemed to roughly 
agree with git log on builtin/repack.c, plus I also thought you might have a 
high-level opinion on where the test belongs. I didn't check the mailing list 
archives too thoroughly, so I was not aware of those discussion threads.

2T


