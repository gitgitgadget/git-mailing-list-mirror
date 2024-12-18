Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D71E0DED
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534582; cv=none; b=JsU9QTK3vPlGPtYZBsfQ1wDLy9nJz3+gd56FLHcn+1WpgYPZveKfPrFWxlFbTVawXmKTVsUFFiOuW/jvLzei2UzhpP877HyvxLhIUdP2JfFspLjLlcb/HlduLIzPIXJphGNuVLSnaktExzXEm4riF4/Osa6ZcQ4fXKNrCro8Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534582; c=relaxed/simple;
	bh=eKxjAahbSX5SLTmufH2YPGTZIKUiC3IYUMy6ZVxyQk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHIvw/pyPZNUX17ySirQ39tWsadOCFQXt/ejdDa5fQTXjhS1C2R0BWYjITqEAr7Gi/J6BKlHh2imzPDKXZA/ZwWXWoMzfOhG8wDZshHDWEz0/H9wR5d9G+qulqLjDHEIDCaRFzn4RG+CP5gXRGXFP5R/MpvlASRY97Qx4XEMqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOOg2UsM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOOg2UsM"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eff4f0d627so59380627b3.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734534580; x=1735139380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+REf39VPiq9ogUM9ZqES86BsoOvKce8pM3dcdqYdlB8=;
        b=VOOg2UsMOWZ5D+CT/8K4NAe4o5cK2xpIZoxEPC1ihBMCmQ7AC5dQRARmSvAHK+9t+q
         f07TBhQoqgnAj9xlA3qlx5ILWYEPH3sgG1oLcV2oxgU9Dl6HZgGJN6A24S9EguN666YD
         Ko77P2HC33D9ZXluk7KROs1bLsJ8I1USgJX/O98b9Mib4FWLIpW8BLrRu5ktk14fkALS
         vQ9Gvlf9yFfiFSckhll1MlGZ9iS9lZQ2lSMEhmPeXQzCz4dL5bEhyGk0UToVBSkJhRHa
         oElGwkwHtt2OORVJdIww9G6/7n5EDQrMbA2RNCuyHy6+ZDTkrRrEjhY3ie5FEd1Z8jEJ
         v1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534580; x=1735139380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+REf39VPiq9ogUM9ZqES86BsoOvKce8pM3dcdqYdlB8=;
        b=BI9hafE0eo7UeJuRAj1TBzqbcnS2LVlcw3o4lQqGji3pDc0eVcJMSZ/HJWSmpVjnoJ
         Vang91baOM6p0q/dOz0Gol9M6ILR64VuBy3RjCmrUltWIL8lXHrObiQodONYxAdOhosv
         8Unno3YLDR6ATTw9jAQ6X+oztOAwMhH9/ODj9lRyJTsoyyLLhkDc3uXVP519/GOL1oC7
         CmqErK4dKy0chjI6AT1iCVNo6zNBA0//0oHoNUgj2ojO35pBWX7/OmZ4HiFPWr9q8vS7
         0rObuW8tHx+7oqEim4q7UGXZVQbJwje97a4dOF8OCP3EqBZbC8GfZ7dIJvoVXMEnF4+1
         esjQ==
X-Gm-Message-State: AOJu0YyDBXN4qaQM1u2WX4QZdd/kuWV/HrMUmg+V872+o6NgMbv5v2xp
	H37zMVeE1MW4rCCgy7FaXlOT/cnbMQExM37cISbfG1iJWTW4Qw/QTpm4fGEd
X-Gm-Gg: ASbGncuIUjcZhCq0/WoShpxlLVTdfM5UcxNfjBJw/x9NUnlAwZ/a5NIQzi5M0qbxjHo
	JtejTBP5GTpDZpxiwvFMuy6hXClWDvHNEXcyWG83KYNU2l8L5gv2ZrPz0jpByrnjGVlv9/gz+OZ
	aeyxwq+bE3tbxrCXuZq4sl909dgiDcz7h8wPPyfyzI8MBSRYpSx8lKq8qOwpR3s4IJoLF7RF0xB
	AxEFBQ6d0Llx5Hn+i0msgNzM8ixHn9HJwcQjBazeOEKNwKmBZMLO6wLat4RaL9Ys4C1LkW+U+Ak
	Ik1QGRSrZckUZfjbP6JIRJrVdMfEcDz4O4+r5iEUXw==
X-Google-Smtp-Source: AGHT+IF0lqu0t5wZRiFjVLYzoPfpA5JhRNC9qstiM1pqBsYWFdVE6MVld5r0hMiOKf0xo7590prsVA==
X-Received: by 2002:a05:690c:4881:b0:6ef:5ab8:2c53 with SMTP id 00721157ae682-6f3d0e3148bmr21204007b3.19.1734534579782;
        Wed, 18 Dec 2024 07:09:39 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:749d:17a4:27e:8972? ([2600:1700:60ba:9810:749d:17a4:27e:8972])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f289033fd9sm24080827b3.66.2024.12.18.07.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 07:09:39 -0800 (PST)
Message-ID: <d8e64f60-79c2-4c3d-9dc4-5e9842943de3@gmail.com>
Date: Wed, 18 Dec 2024 10:09:38 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] backfill: add --batch-size=<n> option
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik.188@gmail.com,
 Derrick Stolee <derrickstolee@github.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <3cfd23073a036ea426569769b3e31290076257a6.1733515638.git.gitgitgadget@gmail.com>
 <Z1_eTHk6IEJ0BEEg@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z1_eTHk6IEJ0BEEg@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 3:01 AM, Patrick Steinhardt wrote:
 > On Fri, Dec 06, 2024 at 08:07:16PM +0000, Derrick Stolee via GitGitGadget wrote:
 >> From: Derrick Stolee <derrickstolee@github.com>
 >>
 >> Users may want to specify a minimum batch size for their needs. This is only
 >> a minimum: the path-walk API provides a list of OIDs that correspond to the
 >> same path, and thus it is optimal to allow delta compression across those
 >> objects in a single server request.
 >
 > Okay, here you explicitly say that this is a minimum batch size, so this
 > is by design and with a proper reason. Good.
 >
 >> We could consider limiting the request to have a maximum batch size in the
 >> future. For now, we let the path-walk API batches determine the
 >> boundaries.
 >
 > Should we maybe rename `--batch-size` to `--min-batch-size` so that it
 > does not become awkward if we ever want to have a maximum batch size, as
 > well? Also helps to set expectations with the user.

Good idea. Will do.

 >> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
 >> index 0e10f066fef..9b0bae04e9d 100644
 >> --- a/Documentation/git-backfill.txt
 >> +++ b/Documentation/git-backfill.txt
 >> @@ -38,6 +38,14 @@ delta compression in the packfile sent by the server.
 >>   By default, `git backfill` downloads all blobs reachable from the `HEAD`
 >>   commit. This set can be restricted or expanded using various options.
 >>
 >> +OPTIONS
 >> +-------
 >> +
 >> +--batch-size=<n>::
 >> +	Specify a minimum size for a batch of missing objects to request
 >> +	from the server. This size may be exceeded by the last set of
 >> +	blobs seen at a given path. Default batch size is 16,000.
 >
 > This is stale: s/16,000/50,000/

Thanks!

 >> diff --git a/builtin/backfill.c b/builtin/backfill.c
 >> index e5f2000d5e0..127333daef8 100644
 >> --- a/builtin/backfill.c
 >> +++ b/builtin/backfill.c
 >> @@ -112,6 +112,8 @@ int cmd_backfill(int argc, const char **argv, const char 
*prefix,
 >> struct reposit
 >>                  .batch_size = 50000,
 >>          };
 >>          struct option options[] = {
 >> +               OPT_INTEGER(0, "batch-size", &ctx.batch_size,
 >> +                           N_("Minimun number of objects to request at a 
time")),
 >
 > s/Minimun/Minimum

Thanks for the careful eye for detail.

-Stolee
