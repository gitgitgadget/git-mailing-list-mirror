Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA201BC30
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257444; cv=none; b=q977/F+3HAEMR/W9dudssqEujYcqWooa76UrkuExu96S1D1z1q3LzjIbTA4FDJLOYXqZpJsf7V8NnX9rJibI4JHuGn4dEovrGCDbkT3RhzmQggXUuuTLu0G5Btd+w0+7D7hty74mj2fzlhNOG5fQAhTQq9aQFBv0iOvDx9zVOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257444; c=relaxed/simple;
	bh=huZeZX1NPdMzdkcnxZfcEeMddwXcm/LAWyT18wNvM1w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLmrmQaQdcVl91eQLeVUKrJvHo9IMlJT0ls7je94u2DoiB16I3UgsYRSUYa9hbSSUWAn0GGs9DjmV4jitZPkvYa68Z2pJitHTcMWQ4s/g74M/FFSMZ6k89mWSHrc9om4vMYYrlgOjg7FG479J1oqf7SKV044d1UpdYE8VrIm3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCqEbWYC; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCqEbWYC"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so21329fac.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 14:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257442; x=1707862242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldbho56gLnwk9CIfV9RLia/I1hrFa+3u2FUygR6A2GM=;
        b=JCqEbWYCFhlbDUuXr0ncz4ldpHL2V3805epyUVN3cLt5PuQzRZnjPzgoLAarDLPiN2
         IlbGopDBxeKI5TdqLByse6lIvFdnvwcEO7Ip2Zw+Jnhpx0villH0JZTxHPk4iUnsp6bF
         l0pH1hgVK4iKZc5NVny88FwYOKS5BVfol+cVsWASWjkTbfajLG9qvwRtrGRlZETunyS6
         ONaB1ZWMTf5jVv3FDPHmWAXtLJqlE3tHAgI7xeIJ4Z13xK+VxjjX9HKmuSt09DiX+na9
         zi/+kEI6UqH7N4tQrtEH/AX64zK07i9IeOTAmOCI8HpkkwbkY4T06JCeKrAOVorcM0Fw
         feDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257442; x=1707862242;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldbho56gLnwk9CIfV9RLia/I1hrFa+3u2FUygR6A2GM=;
        b=ZmZNRu63bm6QzOJNrPSEFLb3Oy0roy8eOkbBl3P464AIlACV9dY5NvREqkxhRwoVlr
         E/0qC8hL3SMk9fMkbxTwegkXOHNZ5YBGCss2ARITtsClfU+CB0nEMORjaYMKVyQhRFpE
         RKJLlIZBIUnhxtmP2eNT6qBXqHJlyKIPRxedi953yu5h8CsY6NdGBbRcBK14VAjkGUct
         gkLvYnjJ70PD5J+Nmaa2/0Finu4S1Tm7HwYjGs7++rYRMMZzVT3lGGCoBo14Jp+hWRHC
         CsLjj5n07StMpv8xPMFE1+7/VIlYM/r4mVmMsDevXtrL7i4k8ojcYpEEf9N+/SUw9GK+
         nLIg==
X-Gm-Message-State: AOJu0Yzq5M/7aIJUcbHX4yeMB/ivmtwKcZaUTwv9MUUUF/OgpYamLbez
	MALpxVpYA5b3KyRsqoJkcsElOT/EQPkE7hh7AaWNAr6KXZjY/MinmqWkfZybDIM3OiBzQghrj+X
	+BFkJ1EQ/+nv0SAp7BERs96xJ1ATcutn2
X-Google-Smtp-Source: AGHT+IEbwQiStvRYF3m0pNbWWUUneYH6Yy3SHZ88nH3wAxXiCmSY5SpjDEQHJ6W9Vcr6vM1tdKrZgQvR/EtTPj2zuEE=
X-Received: by 2002:a05:6870:46ab:b0:218:d374:9b7b with SMTP id
 a43-20020a05687046ab00b00218d3749b7bmr4517012oap.38.1707257442268; Tue, 06
 Feb 2024 14:10:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Feb 2024 14:10:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqr0hph1ku.fsf@gitster.g>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com> <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com> <xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Feb 2024 14:10:41 -0800
Message-ID: <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000006317360610bdd9ff"

--0000000000006317360610bdd9ff
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Thanks I'd missed that discussion. I see that at the end of that
>>> discussion Junio was concerned that the proposed "" did not account
>>> for "refs/worktrees/$worktree/*" [1] - how has that been resolved?
>>
>> Ah, that is an excellent point.
>> ...
>> The use of dashed-options to include hierachies that are by default
>> excluded (e.g. "--include-root-refs" and "--include-worktree-refs")
>> feels limiting, but should be sufficient for our needs, both current
>> (i.e. I want to see HEAD and FETCH_HEAD) and in the immediate future
>> (i.e. I want to see worktree refs from that worktree), and I can buy
>> that as a good alternative solution, at least in the shorter term.
>>
>> I still worry that it may make introducing the negative ref patterns
>> harder, though.  How does --include-worktree-refs=another to include
>> the worktree refs from another worktree in refs/worktrees/another
>> interact with a negative pattern that was given from the command
>> line that overlaps with it?  Whatever interaction rules we define,
>> can we easily explain it in the documentation?
>>
>> Just like "an empty string tells Git to include everything" is a
>> perfectly reasonable approach if we plan to never allow
>> refs/worktrees/ hierarchy, "dashed-options for selected hierarchies"
>> is a perfectly reasonable approach if we plan to never allow
>> negative limit patterns, I suspect.  We should stop complexity at
>> some point, and the decision to never support negative limit
>> patterns might be the place to draw that line.  I dunno.
>
> For now, let's block the kn/for-all-refs topic until we figure out
> the UI issue.  Which means this (and the reftable integration that
> started to depend on it) will not be in the upcoming release.
>

I think it makes sense to remove the kn/for-all-refs topic for now.

I also think that the reftable integration branch can go forward though,
since the difference between v2 and v3 of that series was simply that
v3 was rebased on top of kn/for-all-refs. So we can continue using v2.

> FWIW, I am leaning towards "a set of narrowly targetted command line
> options (like "--include-root-refs")" approach over "a empty string
> defeats the built-in default of 'refs/' limit".

I think this was what the earlier discussion in the RFC series was too,
but Phillip definitely helped consolidate the point.

I'll send a new version of this patch series with `--include-root-refs`
option and we can discuss on top of that.

Thanks all!

--0000000000006317360610bdd9ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8520020b39bbefea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQ3JsOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1ROREFDZjBEa2ZpNlJzTWNFbG0zWkVjeHdpSHcwNwpxNldRbThtc3Jx
NmkwcHhGdC9sRmVYRjkyK0JrQzhUT05lOTdkT3hFZk15ZzAvalR1blJveVN5ZXlJQWU4Y1ovCk90
cUJPQ1c2bkJQNENZRHRBZFhibDk0bnBXU3hTb0pMcCtyalpyakwweEcwVzJpU3NVNHpuMkZqeXp5
TlFHdmQKVzlTU0U0ZU9iRUlEdVpqTDM1RFI3RHczMnhIaFE2TG9YVTV1MUNNeEVMSHB5eHg1VG5l
MjNUMUl1a2RhS1ZCUAo0YUErMkZhZm9UUUVuNTdiaVc2bXJ4UFQrYnBjT281akpLS0poMmgyU3Mv
ZkdXUm5RK3I0N1lwN2lyc0VpeWFRCmg3dHkwd3BjVCtzazE0T3p1Z3ZZamdKWnhOK29Ha0NCK3g5
RzZaRENqR2JaTEhTV0ZuSDliSkU3UEVUYmpDK1IKVEdMQlZZVGoxU2VGb0dHUTdpVzRVVnJvVm4y
bzdEamJpY25leE5OVElEUXg2T2dUYVFZL0pwMmZpVmZOZFhsVQpRSzdpOXhqRzV1RkZnWG5yV2Y0
VjJiY0pVZVFGMVJFN0NiSHNsZkczMDJMcUVScGFrWk9Gc2NsSEJ5VFpweVd1CjRCRkw1am5ZUTlR
Wkx2VmE1ZHlvZktPdHorei82UHpkQnJ5aS96Yz0KPW9DUW0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006317360610bdd9ff--
