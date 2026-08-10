Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94A220F2A
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 03:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786333100; cv=none; b=CU55mUMZsScdb34uJTrYyEut29v0qjW4VV4iCrtZnHkiK2ECw2bJgSvNmzJwqJV8MMUq8YlnYhHPoyf+6Km/AhJz/0uswhxGCPynSKqilUcmlnGTjJ/M+V9Pcu8v5XVH+UQgfOxOovFBPIgiShr14xhjJOzWMPQJr230YaPO/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786333100; c=relaxed/simple;
	bh=sg0KJU7UEsz/gGkRmjKPsYI0PB8ZIu3W+WABMm2IlxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pFnPnE+v4jBHTW5wMoe7YvB5GaGpPErebuM339VLpEBlCa4xLqDDceuRsa2oNamhnExNFTyAGTNILyh114iQwXNqj+aFtCgZMnOL6MGGI6mfUn/T5nbcTRack4vr0eGLeNIehfy6AJj3+8IjeOomhAURjZ/e7puF/2rex0BPiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nJSrU7ay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VHUhcJF5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJSrU7ay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VHUhcJF5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71519140004E;
	Sun,  9 Aug 2026 23:38:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 09 Aug 2026 23:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786333097; x=1786419497; bh=gLWGA0XdFr
	vyifCE7dvtiHzOL2TcABOGxr71lEW0+v0=; b=nJSrU7ayTEMv41kG8EbtNtJQJT
	lwfKAZpDq7SnUTz9/htzBv0OTBuVUIxVe1A93kKe8rBgQFinkzK2DZ8JkMmi8qLg
	YdRsq4TzD/0vspan5zoTN24NnPgQNdEtbd1thk8TEq5zMRCnfg1FHMG7IxVxEQTD
	RhMWRJaklPhBjpBVhQc8sEY15+iF5zgr7iuy9RKogoz5o1tdTa5hcs2afAmb8ejg
	ZMi3BVcQEmChekBWC5x/4YXUulkznFCGQeDI28jJ10ngxBVDIonP7W9PYpmzNahR
	aDzM27F7YB3FHgez2CdigYA/5ljPL7iILaRmoaYzlAbUN8irOZDhIXbDvnQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786333097; x=1786419497; bh=gLWGA0XdFrvyifCE7dvtiHzOL2TcABOGxr7
	1lEW0+v0=; b=VHUhcJF5qz3sIvm8M56BXjNrN4G/gpYor/k2DWJtJWfYrY3Aq8u
	+osuAn85lOVI2507ZC/94Y/plaXviGcrqlzLjLd4Pd1sM62gyXeAR35a/cS8nVt3
	XnLLf4HiO40BBvNxFH/3RAGgItElo4HAWbeQBspEtWzjnVM2mdySiPa5dQHyMypD
	g089qNTuDGh6Fy//OhC5qyxMhRItJvvRqQxcQ1TeBDDZIRvtG2gHTxFRymIJrl7O
	0pjA3GC9U04ND7yvcxzwlyrSQIy7YwgtYwrxSnwI75u7VU0YJ1ZsoKl0MWDfASgi
	EjlCdKQTSZN+fnmrxhDPXp8AZYtBVzduWcQ==
X-ME-Sender: <xms:qUd5as1tgJWbZ40FadZZVsm6mvq8WTjxXXR8yyGORXDWTEaxd5bugg>
    <xme:qUd5auGuf2zMRJNrWRca1LfW6VDiA5PxbWO_NBKHfA3PGy_zsQbtwiZbIUQrBd0Ol
    gz0PeGwJGAVPekTNoQOYPcqz8V_cm3IBPJIXEyWSigBHfbh8Ie64A>
X-ME-Received: <xmr:qUd5ap6p0azs4refQgl6UjgPsYBISlBBOia5-l13Qnbm01ixPIvmeS7GNfYt_ZMwFvY4ImUrMcLZYy6whtMX8tchfFJq_lxXPg>
X-ME-Proxy-Cause: dmFkZTEvVM0FvUz6NQhe5pa9EeBnkq4BheeQRPGL6BO98fwMIr8bJNLX3IrHsBeVyebiKu
    ugodUA1MAql8PTTqn8jE2ubeTmMrxsFszUI5dVVLLTwpdcduwBKyXR3461X0zN+4VDlbna
    LgTjYQqKBUMe5dakpWh/2OqDJHEL3NVJupwveHSowOfwc4QqQf5njY7Ll8SzDNWgJfgoO8
    PI2SmZkuuRSFGj/WG+F8gDghOBZz18cjn8H51Ds1oy+oWPPNJlDdik1G3Kzk8VMRm10xUv
    hQ4Rb3MfjL0pjLQJzJZnrAJ2nVMwxzmW8Qq2zsb82Sk42qgCuNzRFp6jrVo3BQ2eReHJAQ
    u09WYuy++cmHzWfNvr9ylkMNaOpPe7zDc/fcKPJimJWq2P+YQ4DKc5kYFusuC4hlWG2zut
    mPwZiNt68pQMfkjkMgusGObXzhQCB/agUi7/odlyz54cy+Z7IkJpxou6v89AdPCpqeHtxL
    T9dY/NGtT3yPiUTfPnm0xKVT94hEWOTyiVuyvrUFoLUx8Je+vbKWpHvvJ8kz4uH/ENfqgv
    IfovFs7L9YClmQQh0k8DPwXk7Fu4j3CBi9JoFTocV5T2fmX2o58m+h4DceaEVqqkBVTHWN
    N8ITdy0obIWeDDsLVIlPVv6Ft0NPXnLprcwK9+IOYV1cvSZupW/INp8eR+jg
X-ME-Proxy: <xmx:qUd5aks6cS6vjM7-QggV_loHVmyf1RfT1HUvtmwAV5ju-yAMGPv68g>
    <xmx:qUd5aq5p-vTF2VlLeutlzbDNiC5pYRhU_wRrE-g0ZK8HFG4YEEkJ3g>
    <xmx:qUd5avWgj-i0UvsCze8Ll5xUhyn_N_uReoOAqHYHIQN0VQTOnTkIww>
    <xmx:qUd5as-5im8FPUhAYfBHbScCpRZnyxmi2_5cyGxUL80lNKFKGG_Xeg>
    <xmx:qUd5albBL3Zpy3Cmn5PWZcI8SyfpkJzyg2S2xwC-uMFu8PtrPIf54rOq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 23:38:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 1/7] odb/transaction: add transaction finalize interface
In-Reply-To: <20260809190106.1565882-2-jltobler@gmail.com> (Justin Tobler's
	message of "Sun, 9 Aug 2026 14:01:00 -0500")
References: <20260806213859.816157-1-jltobler@gmail.com>
	<20260809190106.1565882-1-jltobler@gmail.com>
	<20260809190106.1565882-2-jltobler@gmail.com>
Date: Sun, 09 Aug 2026 20:38:15 -0700
Message-ID: <xmqq33wm8x20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/builtin/add.c b/builtin/add.c
> index 60ffbede2b..501e114ed5 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -393,7 +393,7 @@ int cmd_add(int argc,
>  	char *seen = NULL;
>  	char *ps_matched = NULL;
>  	struct lock_file lock_file = LOCK_INIT;
> -	struct odb_transaction *transaction;
> +	struct odb_transaction *transaction = NULL;
>  
>  	repo_config(repo, add_config, NULL);
>  
> @@ -610,5 +610,6 @@ int cmd_add(int argc,
>  	free(ps_matched);
>  	dir_clear(&dir);
>  	clear_pathspec(&pathspec);
> +	odb_transaction_finalize(transaction);
>  	return exit_status;
>  }

There is only one non-local exit between transation-begin and
transaction-finalize, which is a call ot report_path_error()
followed by exit(128).  Will _finalize() stay to be just freeing
memory and nothing else?  It may be conceptually cleaner to jump to
the bottom to make sure the clean-up sequence will always happen.

The same comment applies to other codepaths to which this patch adds
_finalize() calls.

> diff --git a/odb/transaction.c b/odb/transaction.c
> index dab7da6a9a..9e9a982778 100644
> --- a/odb/transaction.c
> +++ b/odb/transaction.c
> @@ -33,6 +33,20 @@ int odb_transaction_commit(struct odb_transaction *transaction)
>  
>  	ret = transaction->commit(transaction);
>  	transaction->source->odb->transaction = NULL;
> +
> +	return ret;
> +}
> +
> +int odb_transaction_finalize(struct odb_transaction *transaction)
> +{

Curiously no callers added by this patch checks the return value
of this function.  Intended or just sloppy?  If the former, perhaps
this wants to return void instead?

The same can be said for _commit(), by the way.
