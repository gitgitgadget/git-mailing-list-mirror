Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6F3C063
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521349; cv=none; b=imgx6UCKufu4QYJnBSKEFAeajPNTEcw/kHVptDB6n04UeUTsZCe7Qm81MCQaGv3FCVs42+CFmC0+yUM282FnFMtSDy00FzNBdx1WsALeMjFgjRKbUZxKnQmNcxuCGQVogLpJDO0cMbHvCa/f4TtgKelyLjKMPXKklC4njHkhSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521349; c=relaxed/simple;
	bh=VrRFG3Qsj1k6PrLTldfYR/wdQ7/3wyNSlzEdwwIP18U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNa9N3LNJeY1mCxELi1Ef/qkV02F99QbRMO4XMd92iQPQPFLLfMN1jbcyLI+vw9RBxMc7yJEmYMFBatDeAlwTyeBS4GFPr8IkOz3GSk5/UBLSr0TIMEPXtvmTNt8S0Dzfl0gVaQL1eAZ9EmDb5pwONuSr9SYacUgsaO/roLr+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=plpm0iyQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="plpm0iyQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91BA81E255A;
	Fri, 15 Mar 2024 12:49:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VrRFG3Qsj1k6PrLTldfYR/wdQ7/3wyNSlzEdww
	IP18U=; b=plpm0iyQIpjw5+1oLoJoRAslSXxPCG9vt/o2Wn1WYI1495gF09KXVk
	D+7bIpVBhjbScyUf9Ot9cQsgAVvPnmBq+xaih+qkGJlHOT77CgxFxxwqsfr4UoY4
	xo2vmx2Ld56lLHVCs8sLv+7ThHPeCdv8gwELVl1fhI82Kbgu7nr/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 887271E2559;
	Fri, 15 Mar 2024 12:49:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C48B91E2558;
	Fri, 15 Mar 2024 12:49:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
In-Reply-To: <SA1PR14MB469129D76D1C65832FC10EA58D282@SA1PR14MB4691.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Fri, 15 Mar 2024 06:47:28 +0000")
References: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	<xmqqttl94qxg.fsf@gitster.g>
	<SA1PR14MB46913A0B1CB3F3D39ADA6A5F8D282@SA1PR14MB4691.namprd14.prod.outlook.com>
	<SA1PR14MB469129D76D1C65832FC10EA58D282@SA1PR14MB4691.namprd14.prod.outlook.com>
Date: Fri, 15 Mar 2024 09:49:04 -0700
Message-ID: <xmqqbk7fsanz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF7E3EF8-E2EB-11EE-82B7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> It seems I just needed to look one function below to find precedent:
>
>   static int print_one_push_report(struct ref *ref, const char *dest, int count,
>                                    struct ref_push_report *report,
>                                    int porcelain, int summary_width)

It is "static int" meaning it is a file-local function.  You should
be able to find out how it is used without running around all over
the codebase but just the single file it appears in.

>   {       
>           ...
>           case REF_STATUS_UPTODATE:
>                   print_ref_status('=', "[up to date]", ref,
>                                    ref->peer_ref, NULL,
>                                    report, porcelain, summary_width);
>                   break;
>
> Is this a precedent we should follow, or is print_one_push_report()
> special in some way?

The code path this function is called is triggerd when you go
verbose:

    $ git push  ../victim-00 v2.43.0-rc0~56:master
    Everything up-to-date
    $ git push -v ../victim-00 v2.43.0-rc0~56:master
    Pushing to ../victim-00
    To ../victim-00
     = [up to date]		v2.43.0-rc0~56 -> master

Do we want to make it possible to differentiate between the forced
no-op and omitted no-op from "git push -v" output, or should users
refrain from using "-v" when they want to be able to tell?

