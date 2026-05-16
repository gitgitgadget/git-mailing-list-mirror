Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFC15665C
	for <git@vger.kernel.org>; Sat, 16 May 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942011; cv=none; b=OiHbjhrCHZMfmxXC+aMhuWF39yf6qcuxJc8uwISp9QzG3EsCMzG3CiTxF3JQj140nQhKvLWhGZI0ngVZPPvuVa5O15TOKJdsgTvg9qEhYSdCC2mnk7ViM0T+MGdP8+o2K0yu8W2b0RWNDGol62kSMY4nBfJfY827464hRPJi61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942011; c=relaxed/simple;
	bh=158pCZml55y269xmEeYeLRYx9cehnvjvPIuhumcOqpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=depBAVWU2Kl4mAXiVxJ3Kkgatsc9PbQGR/VTDHrkVCVDZ5xW2G6FzbCH7f6i3uesnNQqqWPdkDjW6Dvmk7c7C0yNOJg/xAAWg4ZFzO2shjtggCN8dFdWgw/uzF/QEqOEeXqQW77SAM6RS1/Gn6myhNe2gQLJRSq9nS0XIc0eoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTJtC/Bb; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTJtC/Bb"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so9484156d6.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778942009; x=1779546809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbaM6tOH/7+b+nCqqoLJONnrtLDPYL6+USC6O6NgGKU=;
        b=eTJtC/BbQP2s+wnISuJnuT7Hb0gURTTtbp+e5HptrNlkUpjp5OHYxXsUfIyZTCO2TH
         cGdMFIjHdZ3Lraet1XeuYsvayjV2ZckFl7Tr4M+jIJ1BgXUWKFk+GTL/cK7444NXiR2C
         8jGjhrhwAHv62kHmy+nof0EhITo5T7Tm0UBMGFfUJY9zFnEHIzT2AxEkc11DGkmp46LE
         NF75bfzvilivxClYNXWovzZudM7YqaI1uju4tQT2C7Ak9yy0Xt7nISwqv818YAbfj2W4
         gUD4dR/Itch5cPE0IGcIzCt4/aV2Pe/Q/JymTMAX+NmK8rAIAZlhDMeUueVbd4Rq2MT+
         vsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778942009; x=1779546809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbaM6tOH/7+b+nCqqoLJONnrtLDPYL6+USC6O6NgGKU=;
        b=TJb1+FMtqSg3vfgo6fEmHSNP0LxqZytRA8zxv5M3aowaZ/jXxVhs3NE6G9vpyShv/3
         FWeLMBuGXnBElFm67jrsi92R6qq6cAs83fdXHPcMUuZW/RfFL5ROsdpOiUjN/WIyZxZz
         xzUEizMn9CLpe1NIt2qoNypMKQMmMDcOVeCcV490TAe47jeOmfqgGgPk/R/nf5IqoATV
         aa7PvctSz4HGMdB3QpLJ+LqGmOYWmwjf1THR3SzpUf1fbPv1zSZeIQgfU/nULYIjJP0a
         wj3LJNsd7wUbIpul1Cvo6yin9xTI/rI0b5xV8N2yiA4r5WAyHJG9NkscoV5dyPtgPvu8
         273g==
X-Forwarded-Encrypted: i=1; AFNElJ9un0dZjYmldWA+5hIRlsxcZNem0knG9YCOiQMomNaXUEUgXt6rT0VIOt0bQ0uKB+N08qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqzHumfiXwetUoycY4H0iCR3a3DgNFCnxhVmL82V72HQs1OSI
	Nu4/nj8AVliOT18VEVK8P1I3ubc+XMiy9W2128rlnP7qUCLQWXsyOdUQ
X-Gm-Gg: Acq92OFbKoXCTKdZLH+OSnZhcv+bsBEpBAOTUu6QDX7toJivD1ope5bosTBHEZFCbUR
	xA2t9PiMOH/2RJVC+GzZ5QkMJsFYnrQA7vgSk5iBfUWenmZwJT1q+dHOC0nj7tOVrA/XhIS7zlB
	lOLGiScU6CTq23EQcb1YlSkLRoz0sV4DFcnYDS0D0VRIu9TiA6aqZsXjXuzRzTjGlb6EK8toL7V
	lyTdOL3qtl9budA34rMpd/PXEyzwXK0hRLfLodrUUQngNmiHeFo8AYTkxgt0S4xw3iG/1c6psAi
	YD/Sgjuw9jVWPc+bkZhL5AqwcxV27sccDNuef5lPlc/b4no/qxbXn+zOhBwgkFK04yFBQ3u9tMd
	bT0Bi2UI2MtTDzpPJ3DLB/6G+xWspsBq8oihe+g8svgPYNf5CYjpAOYSPlLty4XmParDRLOrA/o
	KsIgxMsANOTBIubyVRu85MKbBN7BRsuFnqsIh1hOmMnlRrTesXDxqa2svoPsBTpx+czzgXC6g=
X-Received: by 2002:a05:6214:ca2:b0:8ae:5fcc:ebc1 with SMTP id 6a1803df08f44-8ca0f6f9c9fmr146698116d6.37.1778942008712;
        Sat, 16 May 2026 07:33:28 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c374469sm82240026d6.49.2026.05.16.07.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:33:28 -0700 (PDT)
Message-ID: <e5eb5105-6e6d-4e68-afc5-107e4b4a8472@gmail.com>
Date: Sat, 16 May 2026 10:33:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] git-gui: use --absolute-git-dir
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-6-mlevedahl@gmail.com>
 <948f9f9f-8225-4bfe-be7d-e9b03c912aeb@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <948f9f9f-8225-4bfe-be7d-e9b03c912aeb@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 12:00 PM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git-gui uses git rev-parse --git-dir to get the pathname of the
>> discovered git repository. The returned value can be relative, and is
>> '.' if the current directory is the top of the repository directory
>> itself.  git-gui has code to change '.' to [pwd] in this case so that
>> subsequent logic runs.
>>
>> But, git rev-parse supports --absolute-git-dir from fac60b8925
>> ("rev-parse: add option for absolute or relative path formatting",
>> 2020-12-13), and included in git 2.31. git-gui requires git >= 2.36, so
>> this more useful form is always available. Use --absolute-git-dir to
>> always get an absolute path, avoiding the need for other checks.
> Nice!
>
> However, the patch is incomplete. We set _gitdir also from
> lib/choose_repository.tcl. I think it would be best to swap this patch
> with patch 4/11, remove the _gitdir setters from the picker
> implementation, and call `rev-parse --absolute-git-dir` like you did in
> 4/11. This depends on that the picker sets the current directory to the
> top-level of the working tree with the embeded .git directory.
>
> BTW, missing sign-off.
I will change the interface to the picker so that success / failure is a returned value
rather than _gitdir being non-empty, then rework order and content of these patches.

Mark
