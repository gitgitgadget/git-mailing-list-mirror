Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1143F08A
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328183; cv=none; b=FpaOhRrkbc+ePgLqENkuRLTNU6CkNELwFL34qbvT12uZFO2pNv9S2pVo1un+ei2yw2uoqS8hWQEazibpm3OtuqKDePrhtcCdbUAxXyAcjL3aLwDLGVRP9K/w8b7PL+uxKDjHywZ7cHH0KRlaHtYEEBm7UF9RgWD3CVG/cKvXrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328183; c=relaxed/simple;
	bh=Uf+iE1X+quVHMfWtwXIsaBccp+rk9YVFt5u7OpodKtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCm3Q87EYkV+H4awHugkrTHlwXVtCIT8G2wQQQAl1WnoC687kbcOjG0Ldf5clKYoBUVwggavkditI7d7INCW8yZUqA1QoahG52rdoVokB8i055khnU9cyNQmNNLl3j6o2p1pcDs+CPBKzbuN1bo4lFVJksw4W+5n/85eOMMsSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hESSac1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NuKraN2V; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hESSac1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NuKraN2V"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A81CEEC0179;
	Fri, 17 Jul 2026 18:43:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 18:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784328180; x=1784414580; bh=oumouM/kEo
	aR3dYOWLxVLCvYnk/NCkn5Qo5KeJieqGE=; b=hESSac1erL72s989yQOAEcxgow
	uGuMNr7XOi16XwdyFQDyU8kcCyFTGjlUKYLhPrLrGkKpmGMIFIxk5azIOE2keuI5
	pIFphRGjpZvg+LlUKUBeSfM8XgVcwv+mD1zAC4yxvn//od2DLL/a4+JDt7Jtw+xi
	KqzdcrxIuJQywAt/tZPMPeX/hjJamBmQQGCSFioV2Jc+DJudkPlRRmnXaBjP9fbE
	M1oQpzmslevuuAk5113/W1XIu28oqqtjrDpESeG/27ZlmZyf7+iHWItFvcbZWWtZ
	vAYOgicoFyyKGWt4YiFGVU01vgNzxtnCQzwEz2USBMlqOp93Rd35QUvj/AOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784328180; x=1784414580; bh=oumouM/kEoaR3dYOWLxVLCvYnk/NCkn5Qo5
	KeJieqGE=; b=NuKraN2V1L0j637AbW5i+p6nMgK2mErVaxCuYsPjdtaP5I0rJQO
	CqR/+QRhqoKGNI7wvaOKJEh3wzoq1obsZwahImMt7buY2GWHx9AxF5iNa4RdL57v
	kV7UpBpyzyfEaQHWHwaTGrumm1DnpvUEYpNQIbiqDf4s9IUPZoBZdDuiZx3h6csg
	aBo/90+2JDC5hc75UBNMfojcmP9J4GqomhIFEmq9dEu2OyS0HMBoPQyfFd1q31p6
	ybn7HkcM2mNXZS7/IsE6iaa/farW0t7rao8DnrVekCqEpC7FAya4M6ZaQZUuw1jZ
	4QI84tb0z7LtskYzgxdsrHOKZBd3gcH1wbw==
X-ME-Sender: <xms:9K9aaoT7wcOuLEjV6Fxkhnc8hxXllbU1udvLP4KidFYocjq7aJdPCg>
    <xme:9K9aasxvb1p7nlydzKubbncXPYRrjemKGlLaGGpFEcWEa8Kg3R59rzMIbTZ5mgrMQ
    uswwK5LHXY8-FbCtKdA8MtwF-uLZz6ykg6xaUyOlv6Pe0_WbHqD9sA>
X-ME-Received: <xmr:9K9aaq3v3QWIsjPbli7lFyqI8pgyXbcAeZcL6GmbqhyvXP6wk2BywVXfv2sJ2qal_8OYUyyzRfzGl-GSl6sIIFtaUJ1MreKQo4IHrqk>
X-ME-Proxy-Cause: dmFkZTGLi04/ZRNghBVC6dosIrNSwFUWQEgv4bugPOuX0BD1PXQzR/UrW2bIHymDOGY9u1
    Cv2S4rc02pdAUcuxgtaivOnxX3sAa45tONqHcbqtutcvJ8nKMU4+c/1D9F2fP6PWEoofRo
    fORxUA8i4dF3cmulORom9vfTP6qXGiJqJ6BtRwXPz9xl2B2uuaIxpuJTEgtewGmCYUUwkU
    l5UlOcMEl7KiZI9ikYfpuyN6gZSLDipnI9GYxIE/gBPfQODTl9dGFZyFjebSDni/aayJq/
    AIYW6bcyWTcgVIFEz3xfzGDCxLjEvxyWt4lzQw8CvYf8XN8PqXH/f7OdYFP9xm5svCh7fH
    fHO6wHJyhm9wtVpzW86hIqkcFDhu7XUsUu/k2RwbltJksKwOE67es9t5n6GpQjJ6mnYEUv
    GiwAihTx/bgO5jimAChkVj1Zclxkln32U/jjJH+tJgdvleKStsJzYw2WtFfszE/srrH8BV
    vTOFc/ObqGrepLY0+TfOyK9SQhFuTqJAID4QUngA4aU7p0Bvn1svt+RSC9zu4P3bq/z4y4
    odTQ/PbjDF1+3edb0KdVISAs4+s4axoOKsfdW4zBd3s0F5W/uvicYcXXlYLB5w6Tvm5LxA
    U/XPyKJwrYA/rS1smA3P/jijei1f2pHusbS3WcdEwp1N7UDTjAgaAqkarhtg
X-ME-Proxy: <xmx:9K9aaq6IcLftvtQy5PiMhygu4Y57Y_eMDhTImzmE04BKIsZTFbZRXQ>
    <xmx:9K9aatW7X8cvf0D6ftTOl2_DlC03QaBNh5gRhsVP1MkqfJNdia7NTg>
    <xmx:9K9aapCldhMFJdsZ3STjG0ELLU65eSZhTFx3JtpcXHhG5h7H_lO1sw>
    <xmx:9K9aas7x7up32iAT8ils3QTwiNCEodocJGcnCo4iJxFnIAgtqQifWQ>
    <xmx:9K9aaiWQmzGGOjqKmSveX4kM8GX2tk1xnVo4b4pvDdKY25YG2RKG6KT_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 18:43:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/3] bisect: read run output from the open descriptor
In-Reply-To: <0de8b12f65530497320b6a4bca395dfd0556c959.1784312854.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 17 Jul 2026
	18:27:32 +0000")
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
	<0de8b12f65530497320b6a4bca395dfd0556c959.1784312854.git.gitgitgadget@gmail.com>
Date: Fri, 17 Jul 2026 15:42:58 -0700
Message-ID: <xmqqpl0l1bm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git bisect run" redirects each step's output into BISECT_RUN, then
> prints it back by reopening the file by name. Read it from the already
> open descriptor instead; this behaves the same and no longer needs the
> file to be reachable by name.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/bisect.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 798e28f501..69ea14b1b6 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -178,17 +178,13 @@ static int append_to_file(const char *path, const char *format, ...)
>  	return res;
>  }
>  
> -static int print_file_to_stdout(const char *path)
> +static int print_fd_to_stdout(int fd)
>  {
> -	int fd = open(path, O_RDONLY);
> -	int ret = 0;
> -
> -	if (fd < 0)
> -		return error_errno(_("cannot open file '%s' for reading"), path);
> +	if (lseek(fd, 0, SEEK_SET) < 0)
> +		return error_errno(_("failed to rewind BISECT_RUN output"));

OK.  So, instead of the usual 'O_CREAT | O_WRONLY', you use 'O_RDWR'
instead, so that we can switch from writing to reading at this
point.  That makes sense.

I wonder if there are cases where we somehow fail to seek, and
yet are still able to open the path for reading and copy the
data successfully.  If such a case is common, this change
would be a regression, but I cannot offhand think of a
scenario where that would occur.

Will queue.

Thanks.

