Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D454281F
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200834; cv=none; b=b5A70pNsK6BVMxePVIrOXAwMNnkxS+IeRJsE3zezm/9zM6WKdt1W6ymRct1SJtNDzm5JF6W0okrqRG7TBntyZClMPd87hyQ4IXuXByeHXUhGISrx+nlwMPQdG/Hrtr3U9CmHDkGmH5v7nNsBwsl0J1P3lr6nnwCR29le+3cOnL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200834; c=relaxed/simple;
	bh=IRUY9g3fWrpQCAfxmehnnegrb2z28OYgynDn0uLTA0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCp217cU5oHUUyFTIOADbMAcgOtcM5CQvC2K5WlI+NKE7BqvRPxFo+CAsI3PMWRTwxXS9puI7MkTfo9GyyHqEwjp3k83a3K6mFBTNLzG50OvC/8038kCPmhmooHgyCBoE2l9WhAdiMQDnuMtD/j7Z41ztePaDUjvYqaQlsUwSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kbV1rqvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0OYRjXC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kbV1rqvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0OYRjXC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 24DF1EC01E0;
	Wed, 23 Sep 2026 18:00:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 18:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790200832; x=1790287232; bh=HSH+Y9BcEd
	81TIvZ/HcETZbpagzPSH+hGmxFIjPbz38=; b=kbV1rqvucNl6BF5P1SrCffuo9s
	ZnZCuqfJxq8wus79KlwkG9dsVe4xVEFBPlXx/JO/4F+h8PAUzDQAx6//6ApWB0r0
	vAi/AAokKpHillbLStcToCFeVrmfyilXnwhoGQePhmWydAa/sO11sGiAVQGq3dIU
	seTGENZssjU83Jhb26jWkl5IJWlB9R5n52R4yHu7QvTw4wzMZohYPBL9cYo29eko
	/pkHF5mZWeYHhYal8uy1a7Z8ZnornMwTfxKS3N6d0SOqD5bDKo4+WrK/HwI2WGjN
	ez7bwEpJcJIlq4dG1TjzkOklwSM8i6aZeWnXDvHLvJRFgEXWEVA2TCCKXwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790200832; x=1790287232; bh=HSH+Y9BcEd81TIvZ/HcETZbpagzPSH+hGmx
	FIjPbz38=; b=P0OYRjXCX9WNJHALpaavCzj+C2BS7bLb3MDUY2pAQmyYPqlphY7
	zums0roziVjfj2EWUnZ7CHdI6N5NueV5P52oepzl0jS5BfH32U5+M03JNZq6nWzS
	OZ1r0FeNr+P9CW18vczQGyb78+h7i+kI5tlrM4h99vazY2BvT++3F0VC15NYyvBz
	kTW50G0DEQ4zt9wloirQiRPG/0QKYl97LW83b3V54T7q9ebMLPaxdzy9ZVITJQmB
	rgyL11EBnO4ik/KOBm3zw3zrGDBAcWBwi/mZjFfbs+qpNOdaWMavcG2fIMXIc50d
	3P9kxgy+pPCvf+4bV6+/0+okw6NzfXxtZUA==
X-ME-Sender: <xms:AEy0apCC1F-eiNUyRH697PjDUPnmfToFR95xgEsTw77c9R7QF01W6Q>
    <xme:AEy0au_uWqnKlWbH9xWyfrZWg3s-psd7NltwflXvTh-BI3p1QxkIwhoyymgYA9_zw
    V9D-nj5Jn8YelqT9yBbtu-tqcNtJl6TJLEJw6v8FThxg1Bcy9IC2AU>
X-ME-Received: <xmr:AEy0ah9-NInMDmXG3e7iS_fzHYuqgXViNyHxpan2GtKrIY7T6fW7I6k40KyhpVGrOpJ4c1-oe0KDMcWt53OtAzaTqOpwRtSmiQM0>
X-ME-Proxy-Cause: dmFkZTF1FWiHTblUajC33KGQj3batX83EWzXt+ThdSFNvFk1AQ4fn2ZzKH+T0HLKuRi7Nq
    yKOc3XAEF3fBI6pQ2jTYOd/yaRuZ8uXcR+wxgcTATH/j57gvmOKTQMCJsp/x9F1QrS1boj
    blOP6CN4bzUENKZgiApa0VYsohBwLpJiPggOv4ePRmwF1ZMplahwKjOB5TwL2LHzsWKRDN
    hwLktVzOT6cLdPqfKyzJEup3Vo0e3PSWTvCpwpvjLZYf3vyYcoWrr1Q6UN7JMCK7YW5kxN
    1AhpAHjd3EWFIEZD1QsIZZZD3Q/fkbO/iflTj1y46egDTi/SEklWM1T9Nlnv9MMrmo9biF
    FkhwgXKQw/Bo3zobXof+1hHK2ANd6d3fu4+YHxbhdf0mWr08ku5ZIUYPlUkM6wG0lmbYC5
    Q/1ickVRNatGzfFGhtFmA8kAg9Nw4CoQDJgtVyLpoUGRL7bPdCaHuYOhvc0W8cnn7BwBXS
    FZglRm4/HUrgNZyNbdSeUY+vxXJTffbyl93VNbW/kljs0lx2Vn+pSTK7PCEK7tS3cZb5k8
    B+dkYGcgBC6m+2Bz7eBAwtWGQ5V5qEmaJSNv6Vmaw9+lI/rEJCdIWLAlAVMDwPTOnVlS8x
    ZGiNNREEWh6MVJIKyHvfUoeQv8Bv82A7hu37hErMWDYXYRYAAR8O5VedGYMA
X-ME-Proxy: <xmx:AEy0atcQCKQcxH6tZ0DrF6QjJDBjDFg-1KwnFG8cuIntKK8_gSeVqg>
    <xmx:AEy0aiHRJXlbk4JOnmhsuHd0TEKLrsE-4qTIHOH6Qi_MOHCuVGUFrw>
    <xmx:AEy0ajcy-wGjXAYp-GNEgCKMdHCvBAyzyf6-X8oVqj8v5mft2vTcqA>
    <xmx:AEy0akHVmPET6VfSnbjWsMfOaymPlvzi-CQKgSixJJX_QacqEB6oLw>
    <xmx:AEy0au_5n97W7N7u2Z2LANfd5yJQSC3WDmmBJf1vI4DJNH3ftIdt_wtE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 18:00:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: parovozik <kaliugov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: remove unnecessary comma in git-rm documentation
In-Reply-To: <20260923213125.1316-1-kaliugov@gmail.com> (parovozik's message
	of "Thu, 24 Sep 2026 01:31:25 +0400")
References: <20260923213125.1316-1-kaliugov@gmail.com>
Date: Wed, 23 Sep 2026 15:00:30 -0700
Message-ID: <xmqqo6dn6329.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

parovozik <kaliugov@gmail.com> writes:

> Signed-off-by: parovozik <kaliugov@gmail.com>

Documentation/SubmittingPatches::[[real-name]]

> ---
>  Documentation/git-rm.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

$ git grep -C1 'separate command-line' Documentation/

shows that ...

> diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
> index b5ead86796..67061e961f 100644
> --- a/Documentation/git-rm.adoc
> +++ b/Documentation/git-rm.adoc
> @@ -61,7 +61,7 @@ For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
>  
>  `--`::
>  	This option can be used to separate command-line options from
> -	the list of files, (useful when filenames might be mistaken
> +	the list of files (useful when filenames might be mistaken
>  	for command-line options).

... an identical text appears once more elsewhere.  It would be a
good idea to keep them in sync.

>  
>  `--cached`::
