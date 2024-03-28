Received: from mail-108-mta28.mxroute.com (mail-108-mta28.mxroute.com [136.175.108.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162051BF58
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711599442; cv=none; b=kY1PEJQSJpdpStd5oMCkqj0Au8oBKC7f/WslxoMCDtlG45fgA1aWOGiMGvo7y9rXs9n52ctnt8SXXA73fLF33ZyYxEVcgujck8gW6vXf+1qpzQXBgoj+LN5z6ieRysIvfhiBJKskcMz2HIS8CEO90nI/A0b888NAQMdEKErK7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711599442; c=relaxed/simple;
	bh=RWIJDi9fstj8fkgjn9gF2DLvGv9D1BK+x573Mb8PdRc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uEQvG6vCVAUQuAO+j1s6+xw4xAnb6xNuna1X/NhySNi4/h2+v/DNZLAMz90Q4BBOtfgLTqYb+zl10ejPSUVI34U2K7XZeytvDdyUuJ9TwFtGZ+tiI2EWPsjRObWMqDT+8PMMO8eUOA2bzrVXbJ8Y0p4m3CDOHarsOpkLF/Id8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me; spf=pass smtp.mailfrom=vkabc.me; dkim=fail (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b=kTcAYdZa reason="signature verification failed"; arc=none smtp.client-ip=136.175.108.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vkabc.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b="kTcAYdZa"
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta28.mxroute.com (ZoneMTA) with ESMTPSA id 18e83420d800003bea.002
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 04:12:07 +0000
X-Zone-Loop: ebfbe4d30c5c17b5534cbe35a7fd7b3bf407e1a776f8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=vkabc.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+MD1LbbudYl24nzBIuVUGWIbZs/P5yEpXdzwbqqJ53A=; b=kTcAYdZaVOhTdXpLkuUWuQmMJA
	lZ1M1akhsvrSuijYXf6ELFKPfgxClDalIC7Ua3xsnMdmVZ9FoqXbPK6/T0cZRBxB6PJzLdNFWPdq/
	8g2Gdrf/K86vBkjxwWrPIub2+TadRAMrhZtcjThowi/gKVCQZLHFIXudAKdV7TRxAHQDQOx7dtgXB
	YtMxzgYUzpTC9SxYjVJktwfeU4bs4297lJv0mzSZrSoek6SItr+ZJaa93PZweh1Th8UdyvmwjuPQA
	QRKoA+nZcn6cUFEzuA/QpdyEXAXIJvM9zkBBaNzSITu3iMoGLgPfa8OvSsg+VKSDLUVqmzU35zScc
	TeYyLXrg==;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Mar 2024 12:12:06 +0800
From: vk <g@vkabc.me>
To: git@vger.kernel.org
Cc: ps@pks.im
Subject: Re: [GSoC] [PATCH] builtin/gc: Replace run_command with C function
 refs_pack_refs
In-Reply-To: <20240328040010.40230-1-g@vkabc.me>
References: <20240328040010.40230-1-g@vkabc.me>
Message-ID: <0a149be978e68271c251e80f8eb571f4@vkabc.me>
X-Sender: g@vkabc.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: g@vkabc.me

On 2024-03-28 12:00, vk wrote:
> Replace "git pack-refs" with C function refs_pack_refs
> for maintenance_task_pack_refs(). C function refs_pack_refs
> can be called directly, hence saving an external process.
> ---
>  builtin/gc.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 3c874b248b..b55c5f5225 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -42,6 +42,8 @@
>  #include "setup.h"
>  #include "trace2.h"
> 
> +#include <revision.h>
> +
>  #define FAILED_RUN "failed to run %s"
> 
>  static const char * const builtin_gc_usage[] = {
> @@ -218,14 +220,29 @@ static int pack_refs_condition(void)
> 
>  static int maintenance_task_pack_refs(MAYBE_UNUSED struct 
> maintenance_run_opts *opts)
>  {
> -	struct child_process cmd = CHILD_PROCESS_INIT;
> 
> -	cmd.git_cmd = 1;
> -	strvec_pushl(&cmd.args, "pack-refs", "--all", "--prune", NULL);
> -	if (opts->auto_flag)
> -		strvec_push(&cmd.args, "--auto");

I forgot to add this --auto optional logic. Will add it in the following 
patch.

Thanks

