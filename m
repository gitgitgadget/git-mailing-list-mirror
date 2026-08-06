Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F133750AC
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037503; cv=none; b=qlaSHk+FTq3WiGKNJkCScfJdTZD2qMxMFlH78aF7k9hL9XVzuu3JbUO/80LG8JhyG28pb5wbByEMiPg2tTRbJLHbX3/V8tbDduHiR1BMmouh1My6H4NXjzJ2F117gC1vX5Ilf0ez3KvCcLytLI0pOUGuZTvwh2Xh07XEgZBkyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037503; c=relaxed/simple;
	bh=JGsrndGVZ2ZiEpX67y2jNttxhA0swiSrFLrf2KUapkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lyll8jJHZGdyD4Iu/kAGn46Gpg4agXM85Q/rxqwJO8oIMLuOtipGKXXKn41ni6hS16Jwf7lf62SxQcyTh4gOS9zL52fV/PC21G5nhfoPUyLmrfbk2hvnJEriKFW10Xds2LAmeTLQMgFPEPE5B2YgrcEqQoKfipYm+yBQDN+y070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DUGiVcOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ae4qZ/ZU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DUGiVcOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ae4qZ/ZU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BC2BD1D00051;
	Thu,  6 Aug 2026 13:31:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 13:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786037501; x=1786123901; bh=FgzP6+CLPu
	AlCjdkL9h9WWzIrF6TuTYf5IMEFoI9fsQ=; b=DUGiVcOp4vi4wnrRH0OAihzIl+
	9pDd+0VepE4bWcTvRvHuIGlC+3N3+q/S4M2sTwrLvz6atYoYJNUYhOECPO9hPiWY
	Qj2GK0sT/Q7dvhdBn3vd9plpvxyYR9NXBuRaamM1L2pTS+z5LIlbFMHQZ8a2rGUR
	R50bIfrZyOOiTm+q6/hC+XUxd9IsguKs5+rNFMTB94FMx3TzBdR6I8RrIOv4ONV2
	cDjRcSVrXxC2/k6A5anz5etmeupzn6rcg1szRMlbxg84PuTYBaXwtdM7U9/qoKxP
	IrY99awKGcAuwkKskeXPyKNXN2hJkC2I38hEK1HTBrSt8f+5v9bUWVovCuAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786037501; x=1786123901; bh=FgzP6+CLPuAlCjdkL9h9WWzIrF6TuTYf5IM
	EFoI9fsQ=; b=Ae4qZ/ZUT5DXGhkxKZRlaMe8jufHnStCRXLAC6LNCEmHb3cTvj7
	taVyBOAC6zbMf5AQx6hLhdR3M8IxwjE8bAwiZ7HdmYfvcrBEWYC7VD3Se0On3PQw
	CcMikwiU5A2mLyipKQJIe2nr7OTgm4ybzV8sWnRdPdnVixmmPspg7+vouWYR0YF1
	h8QlYc5Qp3kGri8jE8diiDKyEGCINWyZkeeOhZAzTQeQU0a6C71vsYmHZue4tfdq
	75b0nqrVEVs1TiR3nsvSPH1T2JPX7LS+91FxgaeFdoGBJqXwNpayPT2DJYeQ0wym
	5Cvf4l1Qr1YvvIfybEM6dC6cpW+nJJtEWCw==
X-ME-Sender: <xms:_cR0alotjJOSpECuoVxhJU_mZpnJ-WycW4MZcdWJtVw25p_kNI1Omw>
    <xme:_cR0arVs15WcUQynmg5BvDSRvhFOZZYbPY2LzMrvbzS9lzj66pC44DDxzcgX4_PTZ
    zTQ4olcyX7pP6s9grrj3lLRGnNAUxYAt-a1DtrPCR3tNdwkIdzEKAA>
X-ME-Received: <xmr:_cR0asBBA84RWxtw8IJ2BySJFWf-VGKd5jB_dKvtt-d6Q6aEs0vQ-j4_bzIMVP8Whob8lnzo3QkJwVuvugFvDE4wkwsFzQEiiA>
X-ME-Proxy-Cause: dmFkZTEeJmjsz8KrGE5S83hfWOuPwxtbXNaNyZ/+ibpbJczfMqiWc4OdC5PAUkIZfuWBgP
    3N6hCtB2ovDdHVSszRG4X/1BbUMFGcg+cGBJJsZO+Z16PaY89Y1NaZnZT7sjcDjA98lQDQ
    RjIgMbzYQkg0ZqGX2wFplD3uQ3dt2Fu6a/oTacTLVDMH/Y5uDbTlglWqdXg1fQK4XRfYU/
    txRAFUTDaIka7hl7R4f2jEuCFm4ZGdCs6+Gi5vyspWTfR5sQzhlYidlmOs+WiohCB/1TT+
    bx2734gO3ZP562E5E69ZQDL0bhMxOpoySs4dhI7vrPinioJSvGJQu6kkd4I5PjoARPQCqY
    HOy30j1a4p/EH7ytRUvix85rbUVndZed1QRlvhehUuFUY89PRWEi+d55KmYQW7KwdwY33H
    EISf2B04+7uR85midcTDWS+TrbBQ6PV507pTiUuL5cQqYhO+A9pqh+YRHG62hB5d8RQcMB
    TTUJvsiVm1YehN0xRAMw6iVrNgSHrml8BXPX3CmWl78iP6IFt3KxOTXpVmubQUCcw9aPll
    88p0PIUodjddKsZsT4U/JcTaqgEeJaTFPtItGtUpd6+HyHtg+vODeJkWRutrwT/KCNxvIX
    RAB/fk7HnP4DTptiPVdWzpFFxONXvIaF+AfP4nqkBJpp754gpr9407afufDg
X-ME-Proxy: <xmx:_cR0an3uYqUc7yOjIrtK8blLnSjx-tS2q1KtFS_DykU6Ie74SACA0w>
    <xmx:_cR0am2oFfXT5DtIhdcaRFivbI6OmwFousTCXUJcHMgxAPuQIQyHVw>
    <xmx:_cR0akDDNim-3zNlpsvxlkmCR9kaTLFlpgMwKPBgzHDkZu8xLLKNNg>
    <xmx:_cR0at4YxUxGM7qCcfT53V-XHJHUjzj7FOx5XstIk5uKQQdd59yJMA>
    <xmx:_cR0ary26eaBD8yoxTwlNiQXsMX9nJ5E1wQDtab9hCC79AWJ4HxZ6Hsr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:31:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/11] bisect: handle dup() failure when redirecting
 stdout
In-Reply-To: <20260806154103.GA1625706@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Aug 2026 11:41:03 -0400")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
	<829cd82177a8e72e450d42db2af3166123c5b7c6.1785954661.git.gitgitgadget@gmail.com>
	<20260806154103.GA1625706@coredump.intra.peff.net>
Date: Thu, 06 Aug 2026 10:31:39 -0700
Message-ID: <xmqqtsp7jguc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Aug 05, 2026 at 06:31:00PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> diff --git a/builtin/bisect.c b/builtin/bisect.c
>> index ceb60b0626..733d28d377 100644
>> --- a/builtin/bisect.c
>> +++ b/builtin/bisect.c
>> @@ -1308,7 +1308,12 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>>  
>>  		fflush(stdout);
>>  		saved_stdout = dup(1);
>> -		dup2(temporary_stdout_fd, 1);
>> +		if (saved_stdout < 0 ||
>> +		    dup2(temporary_stdout_fd, 1) < 0) {
>> +			res = error_errno(_("could not duplicate stdout"));
>> +			close(temporary_stdout_fd);
>> +			break;
>> +		}
>
> Ironically this produces a new Coverity complaint. ;)
>
> If dup2() fails, then we break out of the loop, leaking saved_stdout.

I didn't notice it while I was looking at this part, and wondering
if we can (and should) do anything if close() failed there.
