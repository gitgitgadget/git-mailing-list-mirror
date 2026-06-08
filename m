Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226F35C19D
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926818; cv=none; b=sZBXRggjQ2F44SyMZTqYMpcYnWhsBQHqi/8pLWU/sLOrdAxkwObD/hQU4nprNuzMacZ/Ju0rpQXaabii0vWxzL9zNlyfgCWj5HEOBtWUGLIT9riaN13Wq1NoMRYPyAlKhB++4sTLpKhmH0VGxf7YV9KbwQUdV6KfCySaFPCdVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926818; c=relaxed/simple;
	bh=4O87XM50x5ZR/QWeaDV1EijVMPC97ywmFRMDTqjjCBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQSsUW/nT1APQRjnOBm694WzDsq6Stvfahmwv7wOhf4I20zJYLVEjai1Uw6cBGV/BhnEeHo98ixvTxjq2bQUCHd6PSsW7gKnMi1bTNnWcV+w2a9YeE4lROHqW1sevIp0sjSOtM747tHKy0lbRTm4bchrcWezhvGwke3s4u16qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iCv+kmgY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9csgIVB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iCv+kmgY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9csgIVB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DB3D5EC0244;
	Mon,  8 Jun 2026 09:53:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 09:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780926816; x=1781013216; bh=FXCMoIT6KO
	bn71Cl+mpqFIYpHd5VYxwki6qccHrch6M=; b=iCv+kmgY99e6F6iZJo21kd9U+w
	60C/On13JrZTMUn8svQyshnmh+JFWkwKyOquOUedI/D/ZULsYeiz6Iovo+2nzuOF
	AeLOyVKCy+JKd9ip3dGFI8BykAz874nElQivnLt2OAO9Ex+lAGYksEHrNvuZxzDL
	jUFkPuz7WS4jhigFNCmzwsfjhfZiTEK25lWp9ZsSsIUbiGTVO04UrIgEM1F+h8or
	+81q3lUrDGgVtjaOk+KzHHVzvxj6lWsX7mykNCNot9mcOJFS3HyJKOMJ+3Fhvt4E
	6nBNc7QhE+ucbBspUpWBMSn4b3UKwUc+Ny3vbadahI3PhUMkoH2koodNkTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780926816; x=1781013216; bh=FXCMoIT6KObn71Cl+mpqFIYpHd5VYxwki6q
	ccHrch6M=; b=c9csgIVBht5///rQkAoeUliRJBQ2K5G5y9cdb/SWHQP4WUVsZ6U
	6UGQP7z8+ZiEBun03OIs4fR03UAW8pobAWt9CzkaQzoEayVWTd5HX/5jfUA3FdzH
	gHIHICH1hdeV6//UQFiLb1Q8gXy0ERUxRIyjVY3+qd1qwoH7/PiwSxy8GiO5+Tsu
	//zJKz/ZeqXFxRFkM5GDmHi7pjtRjrs2VQvjVaO1TfWUKYrbnFIidZW4Kq1dtrlJ
	cGKyHUx/bKv5QW9yvQMwwERo9bkdCODY6sCKeIF5h612GMB5EuTaUxgg3Kuv9+DH
	P+VzvSJbQdiqulikY44L9erRy29jpogaQRw==
X-ME-Sender: <xms:YMkmarcID9vZI-CAMpx7GLHhgREKQUhC517dl6oJWhFOQ9yb5sdM8Q>
    <xme:YMkmaoPgHeVmYO5pQgiQ34V5LGAevuxtQ6xmTeu_4OaAwh22hOoZ182_Or0srei6c
    tPDyd78mTnB5pLD8iViINJjlP7NLpUgMJJCIjgBtb5PRQ6MjSI>
X-ME-Received: <xmr:YMkmaphXHGau4Ir0dLzx12z5kAhdWecqvhrKMM96R-IFTFuj2jBoq99lBL4RPGI94qtRjE5INo07ApLEsN80xr43zyyq0Owbx4mOxN0PGg>
X-ME-Proxy-Cause: dmFkZTEGNy6bVM09haIyqX2KIYn/ergfrMZA2n/ttSf9FJ8t6Qlu0XEMZqRnf0UkauDWNb
    kV5MFqeyA8BnyPx4AOKlpz8Y8eIpyCpmcnUa7/1TyJ1Ixb2kHotdY7k9AhGOzBLmWudNH/
    Q8HnzyNK9OaSEJsaBt72oqAV24+e09kd9sHDdkn9CKb48m+tNtvAevZ+75p7c2SnYMkfoa
    C4X8N98/KsKhLLix+k9BuGmr1a3zsZ2uZE+wKT4MGM4780tYIEqtZaPXTAb3oe2PwVn3s3
    FdyIi1olLDbzdYRViV6istwz/PrMTPgmLX3e1o24pTO4MHN+ArWHUd4iC07bIqKSiz/gPB
    JpojUO9PjK445o+ouM1YWcpth5sVxnHKi6A+EEuEQtRSJ++vYoz32t/e/goOuNzaZbyw5a
    98HxsuB1r6Z8D8qDaavSlulG7obrAH2/8J886dSDPDktElrwG9+8FcrX0bVnXJASMYfVm0
    YJVWGdU/cXSYKVexn7qa1EQTXkz97NI9Nm8ZvSzQGF8r4M/9YfgFcmL44clZsGik2ths/1
    DRsJ3b+tX0x5w3LwoybuZNzCokNxw4nFzWOzvXGkLlDw2fUHXEWAV5G09FuCelzWEtrvm0
    G5pTJsVpoKbEcMQYLqxOy6XGKfHJyQu4gdXSdXrLn7msRV6XAVNC2sKkPDNw
X-ME-Proxy: <xmx:YMkmar3pA1ohbh09yYSIRnC548_eKhRwMKjITyIugf6vhP_NHFa8wQ>
    <xmx:YMkmajiJJ-UIVzFXT5kdkRTXqpddiAqnmwP4K4eyehoneANteyH1XA>
    <xmx:YMkmarcKVHXD_A_t7hK3u1Hcg5NcXUTKyUMWyxTWLLML2YAWjVwlzw>
    <xmx:YMkmamkNCJHE0EcvABBOF_RJI01-KQY7KIj2p4Iqcux3awJrfF6P7w>
    <xmx:YMkmalTHRQo8498AGVcPrmNW5oXIn9yivoEIdisB2WG9CnxdTl3EagXy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:53:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81829935 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 13:53:28 +0000 (UTC)
Date: Mon, 8 Jun 2026 15:53:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/7] pack-objects(check_pack_inflate()): use size_t
 instead of unsigned long
Message-ID: <aibJVSrKPCfDVXw7@pks.im>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
 <ddb75326cde9695f1eb7bbbe77175424e6b77004.1780570273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb75326cde9695f1eb7bbbe77175424e6b77004.1780570273.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 10:51:08AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> `write_reuse_object()` learned to track its packed-object size as
> `size_t` in 606c192380 (odb, packfile: use size_t for streaming
> object sizes, 2026-05-08), but the comparison sink it feeds,
> `check_pack_inflate()`, still takes the expected decompressed size
> as `unsigned long`. The call site bridges the mismatch with
> `cast_size_t_to_ulong()`, which on Windows turns a >4 GiB object
> into an immediate die().
> 
> That function only uses `expect` once: as the right-hand side of a
> `stream.total_out == expect` equality test against zlib's counter.
> zlib's own `total_out` counter is `uLong` and is therefore still
> 32-bit-bound on Windows. Widening `expect` to `size_t` cannot fix that,
> but it is a strict improvement nonetheless: instead of dying outright,
> an oversized object now simply makes the equality fail and lets
> `write_reuse_object()` fall back to `write_no_reuse_object()`, which
> decompresses and re-deflates the content (and which the larger
> pack-objects widening series targets separately).

Hm. I wonder whether it's possible to reset `stream.total_out` on every
iteration and instead have a local `size_t` variable that we use to
track the total number of inflated bytes?

Patrick
