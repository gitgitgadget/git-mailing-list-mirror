Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3A3D47B4
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294479; cv=none; b=nAQl94XtI7ar76ngQtI/CU3AgBM1CZlwk4srRYbMT1wC5LTnwWLL/V3+fGPKqe1U1WFtGPP2jRdTH2Tvo3ZwdphEOESMxrFsCnBOkva4SV3f6HhRT8Cr21k5N+yGUdCWgdnU/AdKrwMkM18gI92GrOBq78mHy6cpfhsHwB/5pDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294479; c=relaxed/simple;
	bh=+o/TxniwJAzpfMWQxAaMfuLvuJs4gHPoPhsc08M7EqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPftugcdmhcJ2vurOWxxhz69s38P1dm3l5zmWn5s8vQLIU+IfXTZgcezQSpXIy7ORBjLsdgATxKIvWLOo634yOUc4ZW0wU6YQrIafTozgie8a9ez38UDPLFQYKWtAcGw5QTaF7Sc97DBgGLv6J9gIhvotA9MjxD4cztbAHHwEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6a/aBw4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6a/aBw4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so321661a91.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788294476; x=1788899276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiwWUzmwFS7zEQSeAMlTnCJIAfx2tmrBM48L2/O79Xs=;
        b=Z6a/aBw4o9huHwpmXz0XJuGK0Mk0QdW2HRVwz7nOc5ksoLYJeMtbuWuzBO0ik2cgas
         SI+835fzqShg0UIthHmPwYLH5Gxsra+ouWUc3e8FaKtn7kVd9G7Rd4r0/HwQGBbuXtS2
         Ndx09vtU+CsfmxYgM02I0wjtsEqNtN58bwFipKXuuiQDawc031KIfbZceLTEAVGi91hV
         G1zqCy7pOpvd79voK/AuHFRoLbM0jxYQFWMrXgx27V2TbsI4e2oGhII2g7oyNBDIOlf9
         dV8a8b654tSTyhc68hm4mg9Su+7U8aHmgC/tsIYfi+/Ivxdibn7jhky8Ev9QJ27K/0Lo
         rdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788294476; x=1788899276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiwWUzmwFS7zEQSeAMlTnCJIAfx2tmrBM48L2/O79Xs=;
        b=pVJcDUMKzWIvGHTzCYuyacCSdCa0pPxJ2LPCuWyz0Wbex2rHGPLBRQ10XD3uBdQgpE
         ceBmH9nqJP2bsxg5etn4O2ktDqLKQaM8iEqBYT4glwoCRZIK+WCW0F6OLbh9i3plL2vs
         +khaofk6yP6IgLAuJQOT8Ny/CcCC9ucGdghAga+KIE6Yt8HHh3V9KOm8sQ/Ci8+Ej2a0
         8grOGlGu3UAfAuRlz1XjiKPbK8w5sp94D2GvmJGvSpTjfXDrI0DhMSE2NN9xQDvlA/33
         W/qf2h3DaKERvFbJqPwCf+M9myAxuNHAWg6Q9JFOU4yKoFdQIU7SoaojWQEqEZdQZlrZ
         y8xA==
X-Gm-Message-State: AFuF++kLg1JG5lcO8fDW8jdTwhLUSrn7FzX/0sEhmnKC78bSsHVho0n1
	NMd5tvprrC9q4Dw8xkicbcesbym0kr/drb96tOF2YEyvyE0BV7QWJtcm
X-Gm-Gg: AYBFou0EM0BafipNYSfvJIGwfCCywFtoVvKccsXpSZfSgClrzIATv5nWJETfkcyAPAl
	bjX6w30Uswz5+YvfbIMI9uBUQZsOolL+FeTf0v+nxKusoowDhW9DJmUrp9Te28lubPG7F0CG5Ir
	jk+agKEFxBpn71pZTjGo83PCEI7aHIfyd9lRUv3OhDUTt7rX8/a5V/gW6PwO9EUvJ9Ke7oSxR3z
	py9D7LeJBpvRbR/gxTOcP5p9QIu351sVi+WCp9O+M2ZX8h/USVO51WTeDjga4KY1bQvZxBWRVuC
	5DB+UhuetaYCqG/2v4sowQ5ftROLuB7ymjI81+LX76tKjJqs69jsSqkFVgwgzX21jVQCqoLgbGD
	8hhEmE4/gvrvUjKMWbxU/bYdnxQes7Fjq8vpJQBeejGXSyK3O4YgQb9FEq1IsXHvjuj/6EfQIbw
	ykk8U40Ro6TLBqcbsJFKUN7qkTPdJHmVhf8+o0G46LJ7M9Jwj/Hp97nN30KMJaV4U5EogAFoURi
	vZUkuJG4t8JDzufEf8hV8Efvy2oXkEQG6GW/VEgvMDJGetmbE2LyaBU0u0tOumH9oWlG322KjKw
	zWUoTJje7ts4QGytEOUSdWAm3CCEhp6MsL5E68A12veO7y2/EnOK55oIUqTzbhlKC9PKHpeG5N1
	TOwnB+JcbSqa3e0Sx
X-Received: by 2002:a17:90a:d44b:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-399074b6df0mr17132687a91.0.1788294476497;
        Tue, 01 Sep 2026 13:27:56 -0700 (PDT)
Received: from ?IPV6:2409:40e3:179:3f2e:d589:805a:9631:7949? ([2409:40e3:179:3f2e:d589:805a:9631:7949])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfcd65sm1286556a91.3.2026.09.01.13.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 13:27:56 -0700 (PDT)
Message-ID: <29b5003e-48b3-490b-a4ec-c57088acc441@gmail.com>
Date: Wed, 2 Sep 2026 01:57:51 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] rev-list: add --missing-only option to filter
 output
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, toon@iotcl.com, ps@pks.im,
 karthik.188@gmail.com, justin@parity.io, peff@peff.net,
 phillip.wood123@gmail.com
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260901185100.33948-1-siddharthasthana31@gmail.com>
 <xmqq1pbcsq1h.fsf@gitster.g>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq1pbcsq1h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/09/26 01:27, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> At GitLab, Gitaly uses rev-list --missing=print on partial clones to
>> find missing objects. The output mixes present and missing objects and
>> prefixes missing ones with '?', so we post-process it. --missing-only
>> avoids that.
> 
> Not an objection to the feature (as it can already be done with
> post-processing), but stepping back a bit, how is this list of
> missing objects used?

Thanks for asking

> 
> You know what objects you currently have.  They refer to other
> objects, some of which you may lack.  You can get a list of them,
> and then what?  After fetching them from 'origin', you will have
> a new set of missing objects (e.g., after fetching a missing
> commit, its parents become known and missing; after fetching a
> missing tree, the blobs and trees contained in it become known
> and missing).
> 
> Fetching missing objects a batch at a time sounds like too much
> back-and-forth to peel the onion, if the process using
> '--missing-only' is trying to find out what it wants to fetch,
> and would be a rather inefficient way to backfill a shallow
> clone.  So I wonder how this fits into the larger picture.

Agreed, we are not using it that way, and I would not want people to use 
it as a multi-round fetch loop either.

In Gitaly the main caller is transaction packing. When we commit a 
transaction we walk only the quarantine (plus the new ref tips) with
something like:

	git rev-list --objects --missing=print --stdin

- Objects that exist in the quarantine get packed and logged with the 
transaction.

- Objects that show up as missing (the '?' lines) are recorded as the 
transaction's dependencies. At apply time we check those OIDs already 
exit in the main repo and abort if they do not. We do not fetch them; 
they are expected to already be outside the quarantine.

So the missing list is a one-shot dependency set from a single walk, not 
iterative discovery / onion peeling. Today we parse the mixed output and 
strip the leading '?'. --missing-only is only so that path (and the old 
"count missing" demo) can get bare OIDs without post-processing.

Happy to clarify this in the commit message / docs in a v3 if useful.

Thanks,
Siddharth


> 
> Thanks.

