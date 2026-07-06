Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B2332604
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366656; cv=none; b=Oa+6saJpJ1ZxR/9b23MDGwCLaZGloVuFo9Y6s8uNmGRW/+K8ssc9ioSPD3Hermdf6Q7V5ziUuaKX0OHSYydnIL8XhGjVlMvLFdKCvWHr7cT1WWYRuitWRbxqQVGvnQq+B5P4hEd7ZoXlN9STo0xnmQJuXt0Mnkd/MEu3ceK94js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366656; c=relaxed/simple;
	bh=O64sjpQFr1+Grk6AERd5Bm64CTbLY1kBoSA1tqVTSI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1+IQkazIK67fEoJj46JTA7VSeP7q+tmai0IE/AV2ABD0b4D53gzLRVW1JD5xUGbkSSE4Ua4+OJcu/3bx3FzndAjwyQxY0m/hrJ2KINWo4WSZpZcpUZS7u8slVDHM79h9OTU3tP0QnZoQ/Oot5/C3LFDqNfZn6VvIKJdiMHuYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwGomZG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LC1xv2B1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwGomZG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LC1xv2B1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F5DFEC01C1;
	Mon,  6 Jul 2026 15:37:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 15:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783366653; x=1783453053; bh=GEmcQIEi10
	bfvro847e2mzN4IL/DwB57qI2FRBHF1zM=; b=bwGomZG2O6lS5qma5ggHqXTZf6
	NikZck6y/P6KIvmCvDPckK/J4Rb4KGMtg5gu+edFGDHpR6piqM4fcVD4MvzWG1wA
	bdRg0H/pZ+HYC8pwT+p5W/6x9m+q+mf+TBl2dPlTG6RUSZgJNqs4dAU+YUYfAuH0
	IBtdfv0YdJ4ZkriVc5EK7DbzIja4AbGY7cZTbIEkLuqUM1G+ZzJ1MMG9YHQzBJdV
	xS+SvXM6aekLM0eGmZ6GHEb5HEW/jcJTu+1vBEGnPqs5mfgIACLbCAXIE9niv2X5
	A85RGq02HC7QIh28trR1ejxyDITmqFMeHf6NJFRryh3EAwg91eQdUKEqmsYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783366653; x=1783453053; bh=GEmcQIEi10bfvro847e2mzN4IL/DwB57qI2
	FRBHF1zM=; b=LC1xv2B1EBuX5F8XnV7HkdgID5CXRE82ugHncvgQvJXi3Psl5r8
	HUWMD0M0NMNSJ1tQOXJzFlMNVN3bnJllkRbCrik3PLmRmsyJXQlBG/5nsmCqbf0+
	rgps4N+dSLuQzvhKJa2fmEuEZnKIuy+5TEiMD4SLyx76ifRlblm+8edHaU6UbSff
	fKtKHiVYcAg6W3X3bipCtOnXobdPgcKukCqi12IDyML2ruHWjrcBJBn4JukhHo7f
	Hs01jRKeSpWVDNMxPijRmw0ZozaXuCK/TWIVlCdjCYF+G5EMsTWhTrG2BZhXNWVX
	UNxW0OtqVXYKm+dSd0zcs/aAbZP1RPjeb9Q==
X-ME-Sender: <xms:_QNMaq9BuSRxf-1hRrsLjXGVQEgXWHi1NPozM_Msgo0qkHwbDYOm-A>
    <xme:_QNMaiIpChXgcUiNC0qnp2OvDlQl2csvX9sEp5mSW9j4yHYnYdizN37O1_a_JTuyv
    IviLiuS7aVXEkVMPEBiVv_e_6wRjPsWMq1qzN9KpqqQNON2C-IrQfM>
X-ME-Received: <xmr:_QNMatYXHrLEf-D-GWlPPnknq9XUY6ABbLzlmd6XEK5I4MJd76Op2mT-P37NArBwKLEJ3L3Bn1WW5ASXX6LIIqSiM-ool5LQHCKrDic>
X-ME-Proxy-Cause: dmFkZTGFASyzLVblDpgWlX/ZAaYMt2AkzGkEzlKxWHRjWtvZMKj1fvzh2nCW0OODRGrODg
    SIKORbT59rGEQx3OkE4zmNCilavai364m0ArJmCq+om0aq+cogeu6+4OV28bmtl/QW9ls6
    Ay54BpMwBFl+nszG1iLMMBNBzCH1NgzFCJq1936HQ9e0EOCYY2LmU4srUxkgJHP/lUpVKb
    6/buOmhbs1AEtPuvNY/bmLV30AK5swAgMia5AGwIVxqg1a9R+jT6j4fgkUnTokha2Hy9Wr
    2yxJ/usLRBb3qF62N/m6a2TdwQa665jtKu5jH89YU43RRbXMA6eY3zjXkq9ZN3vaaibJq6
    h+M3Z/BnnbzNrScfEtpHlLBbCuDCMVeoaej/w/m7Pr6I3DNmgoMQsUZHQm2ZhUTC/ymzVk
    7w9lh1SG4ycp9gsB2DA3CKA4w8a21Il6jHU2MIC8+GUQd1IfhD2WZfesmTCOvPMZlv3kyA
    cXxCR1VESt368SL5PQSeEnYYavu08VPQAVYxqthbFhPrXlLbOtLKI3O7eXY8ACM14KDIr9
    xpX2CC0moD4pOxhrHof57/09+F+BfMgOp6p+2EmihPTJ9FG/1Gzhb9BRgubE4/6vrAq3Bg
    akDe4WY77gxKJ6zZsnMcCUbQlr8ZLrMv/x14LzAo6Q1mkk86sdE+bqyQIheg
X-ME-Proxy: <xmx:_QNMasLtTFYY7Lyxk0X76DDM8SI5UafCRs-_YxZmPnVfHZDDVC6J6g>
    <xmx:_QNMajADl7HCRejm8dtyzqWbWpOhW_-_g1DDx7SHSSQDhrxGDV1huQ>
    <xmx:_QNMapr8-uTYEGQeT25dX8Bl6Ntmpa78lbTbGsdVRW6T645cmsAzAw>
    <xmx:_QNMamjzmtUV7aBD7hoRgCEmkZRDRiH864FpgtfelQncaiq8VZ8gwg>
    <xmx:_QNMauLRt-eDHHL--PopBK7W-o3q7dZg4yGbbmb67-tPsGlwwcipeBtm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 15:37:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] setup.c: use die_errno() when chdir() system call fails
In-Reply-To: <20260706191421.94453-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Tue, 7 Jul 2026 00:44:21 +0530")
References: <20260706191421.94453-1-gatlavishweshwarreddy26@gmail.com>
Date: Mon, 06 Jul 2026 12:37:32 -0700
Message-ID: <xmqq4iibc3k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

Make sure that v(N+1) patch is sent as a reply to vN patch, so that
people who look at vN immediately notice there is a newer iteration
and they should spend their time on it rather than the stale one.

> When chdir() fails, the errno value contains the reason for the
> failure. Using die() instead of die_errno() loses this information,
> making it harder to diagnose failures. Switch to die_errno() to
> include the system error message in the output.
>
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>

Perfect.

> ---
>  setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> diff --git a/setup.c b/setup.c
> index b4652651df..e2e98d1126 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1954,13 +1954,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  		break;
>  	case GIT_DIR_DISCOVERED:
>  		if (dir.len < cwd.len && chdir(dir.buf))
> -			die(_("cannot change to '%s'"), dir.buf);
> +			die_errno(_("cannot change to '%s'"), dir.buf);
>  		prefix = setup_discovered_git_dir(repo, gitdir.buf, &cwd, dir.len,
>  						  &repo_fmt, nongit_ok);
>  		break;
>  	case GIT_DIR_BARE:
>  		if (dir.len < cwd.len && chdir(dir.buf))
> -			die(_("cannot change to '%s'"), dir.buf);
> +			die_errno(_("cannot change to '%s'"), dir.buf);
>  		prefix = setup_bare_git_dir(repo, &cwd, dir.len, &repo_fmt, nongit_ok);
>  		break;
>  	case GIT_DIR_HIT_CEILING:

Will queue.  Thanks.
