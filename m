Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36671198A34
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856772; cv=none; b=R0uOLZqG0VNr7NTHCoCCI+v0iuVR/JgbTVQawiYR/azIRA+XoSyF+IaaE6Fao9q+QRGfxB0xVUblpEeG0S3YrbmSxFmsVz0xKlt+Ncua2NdTXcVmDaweob61yqJFz5uuoHdREDVnBer4H3gwWzQd7gY9H1dUVVjZlFDmzRWR+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856772; c=relaxed/simple;
	bh=zNw7MBG1boSGpyZcTdCyJu6sCro1BKr0gTRjVEE07jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJjHt3mnNpp1EG2OZNErckbfVi96duzepVHPw3AeAeta/RQYcPHHTVa140RIFyvNosr9Ob8BZnZvc3M5Uj/ZEN0/AXQIaAXnriRUZrcsJQumMgQjOTUET5B2AhOsKb7IuCPNR385oKh9W6DW6/CWNrMH6b+F6OSj9ntDKA5ijkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=nm+w3D9i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqJIoyws; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="nm+w3D9i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqJIoyws"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFAB125401F0;
	Mon, 24 Mar 2025 18:52:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 24 Mar 2025 18:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742856768;
	 x=1742943168; bh=yz6cZzqNCYJXqm0rqtIo6Nok5F+yTZO22nAmRVlniUU=; b=
	nm+w3D9iav7f9Q6NCuegaZKjf1SuI7WEvh7FU+OPAdQvvWLWzQ0HVpB58Rox2HLS
	JmHtFBE32Bk+ZZ6HhHc9Q1FRpPpuBP9StiEhjVYKYso27amwDyDSRdYXk221CBEd
	NUN1TsFJuNSAJVkf752XZP/f6NxN8VfHbZZIUZ42HSz1WNvqkE6XbxIbb3RY3Bty
	fCyDrgwPonDa2M49fUmO4kYFucxI+bNwx5YJWO8NfI2lHXIHf6yuDuqmXTzS0N6o
	RUcCq+e4ZBPRRNx4ldGmYWKy0Qc+k50CMECs2hGz5oDta6BTUYEWDy1xE334swYK
	wgQEOQk3yAV3F8gMA+0MOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742856768; x=
	1742943168; bh=yz6cZzqNCYJXqm0rqtIo6Nok5F+yTZO22nAmRVlniUU=; b=d
	qJIoywsObMaspqCmGVnkHSXvG64L27Y5Lvvq7ThF54Rz03/ZW/QuDntsBXPreVnL
	1MfGgSWRyxDSRgMIeQEcqsnm9Uo4OkXd8pWKS/G0yCJHjgzqEStyFQsfQxwMRg5Y
	3BGBCDvMnVvgaswRAhfSgXzJNjKhoc2JSn38gdkgEKefx2JI0OAI3QPprihdgQBy
	uutUOUjFV/eHGUCsy7I00uNZNm3vIIGut8ecJGPcpPE+aeIhJHyylBq1YQRkM4Lk
	VMAbqszLxPOEsWh7hn2lbLd1UkFsLziktm3++9lScFobpkXg2bB2krDQSJgH/exP
	m5GIC1t1gTg4e1PdJXgaQ==
X-ME-Sender: <xms:QOLhZzL628nz7mv1JY1l6EXFx6YhIwOEsLea4ZsQ-E8y3E_GjmPnBQ>
    <xme:QOLhZ3KPgN8Wr8uDXvNE5YsAcn4uBllMAomxsQdUcqkMFEkgloOlujiu1jEAt3lxP
    AKElgMl_j1BttVheg>
X-ME-Received: <xmr:QOLhZ7vXFbutTKLjAT-JelhAxWbZcsdELdyNbnRk_xZ_HQsDvhaWTLugknFFC26PE44g0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuh
    elvddrvghuqeenucggtffrrghtthgvrhhnpeevjefgvddtieelfeejheeuhfeuffdvgedu
    udejhffghfehgeejleefjeejhfetjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghupdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrgifrghrihhmihguohhllhdoghhithes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfhgvlhhiphgvrdgtohhnthhrvghrrghssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QOLhZ8ZIZpczb8-OPrCyA1PVQImX7CbRqMqwkX5Sm50BIu8DCgg4vg>
    <xmx:QOLhZ6akumLveTzdTcS_KqUf-GC2kTGoGO3wuiwy0dvyrGvZxc0DWA>
    <xmx:QOLhZwDbU_e-j09eKl24tdouPivhv8Po4532J0toR-ZQILip95SGJA>
    <xmx:QOLhZ4bQE_xUnTvj0nl1Lwg926mxOLrd36ZFS0pN870_G5QBll8d8A>
    <xmx:QOLhZxWqYH9xEfTdmyF3s65foPaTuF0gKrCpvO-Z7TQCjSGsF6rOR4Ew>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 18:52:47 -0400 (EDT)
Date: Mon, 24 Mar 2025 23:51:56 +0100
From: Fernando Ramos <greenfoo@u92.eu>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: kawarimidoll <kawarimidoll+git@gmail.com>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: mergetool.vimdiff.layout behavior differs from documentation
Message-ID: <Z-HiDODocZftrtgL@x395.localdomain>
References: <CAC6paJg19ue7W0VxTnGH-1ra3Zkk+pRnj6McEC755RD54xDzCA@mail.gmail.com>
 <CALnO6CD=ghMyWm6s8u3=iH4neRMWnTTAQWUAokcgM1HOBqNC6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CD=ghMyWm6s8u3=iH4neRMWnTTAQWUAokcgM1HOBqNC6A@mail.gmail.com>

On 25/03/24 04:35PM, D. Ben Knoble wrote:
> I've CC'd the author of most of that mergetool for some help, but the
> issue is likely here (lines 298–310 of the script mergetools/vimdiff
> on 683c54c999 (Git 2.49, 2025-03-14)):
> 
> # Search for a "@" in one of the files identifiers ("LOCAL", "BASE",
> # "REMOTE", "MERGED"). If not found, use "MERGE" as the default file
> # where changes will be saved.
> 
> if echo "$LAYOUT" | grep @LOCAL >/dev/null
> then
> FINAL_TARGET="LOCAL"
> elif echo "$LAYOUT" | grep @BASE >/dev/null
> then
> FINAL_TARGET="BASE"
> else
> FINAL_TARGET="MERGED"
> fi

You are completely right. This is a bug which can probably be fixed by simply
adding one extra "elif":

   if echo "$LAYOUT" | grep @LOCAL >/dev/null
   then
   FINAL_TARGET="LOCAL"
   elif echo "$LAYOUT" | grep @BASE >/dev/null
   then
   FINAL_TARGET="BASE"
  +elif echo "$LAYOUT" | grep @REMOTE >/dev/null
  +then
  +FINAL_TARGET="REMOTE"
   else
   FINAL_TARGET="MERGED"
   fi
    
If you can test it and prepare a patch, that would be great. Otherwise I will
try to do it myself in a few days.

Thanks!
