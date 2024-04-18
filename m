Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051216D32C
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470702; cv=none; b=sUfiHk6dhdV0B5mkOuK8VDycl6v4LvSnt6+RiOrz4xsuX5cOPEBF5VvUyY9f4kGxLruJaZ8NhrP8Vlel1SmYfPPBUBiR3aC14306dJnucBZzxjVR+EEtOqCN6k8Xf0s+Oaf9tEd57tELRQu/a5LFCNQEy6KDge/bxT444cXJqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470702; c=relaxed/simple;
	bh=l3umERYbRBQE4760lrTBZSbpTCcTPimlJlPCj5V57W4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uZQL7ZhQ7N6oix8QzZy8HyTydCwGecIgTG6iXYjfAT023TKmBTO7nnTGs+9EepiJKiqpwKyzf+yX2taT8MzpewsxbDJkRn4f5CGWI4JxfH+jTPdwsPkOr7kcZIS40IGe2kYT0do5u6k5+HqS4SkbEXAOI0p90Ss4Iyd21Y8VQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Y5yqe6o5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Y5yqe6o5"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713470697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNovI5Iy4vT37IDr9WgwOVfbRCN/dJPgX59HdAVNH54=;
	b=Y5yqe6o5OQdmML0EkcGkH/aACNsnJQnf/59nYWIGMUKYRWuqc2g9phurKtV9NQnspL27G1
	7MD57PBf0MPNA0ezGUHTgw8AGwkzXzzkCt4nHH4WjPIfSNi3HrAeeFqsCUipMyvQzU/uX/
	hFzWaAN0VlXGMyCZ+zYALR/X+b4hxsD8xnzu0Oc5Jp4Fg1JymWEWKIVMTE/gRzA62Y+8kR
	lJG2KMZIiYWzj3LFZaHu132bTtg3w4yzP+0rGi/AdVwMl5jT5flVden7XJr4c4WwZG2DbE
	gMuRQBtPiNpKG/XXHVZSCX3sg2pXydpQwRrgFB/FhDywWnz5Xh9MiwzuAplT4w==
Date: Thu, 18 Apr 2024 22:04:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <a0b93341380c2157f6b87e19129abb49@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRzOHROK0VpkLR9fk7Gr0NRH9VKcH4dGXOuoaO5Ky2c2A@mail.gmail.com>
 <a0b93341380c2157f6b87e19129abb49@manjaro.org>
Message-ID: <cb2d20938cc9b11e621103575b1bb379@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-04-17 09:05, Dragan Simic wrote:
> On 2024-04-17 08:35, Eric Sunshine wrote:
>> On Tue, Apr 16, 2024 at 11:33 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> diff --git a/builtin/log.c b/builtin/log.c
>>> @@ -2111,7 +2116,9 @@ int cmd_format_patch(int argc, const char 
>>> **argv, const char *prefix)
>>>         if (keep_subject && subject_prefix)
>>> -               die(_("options '%s' and '%s' cannot be used 
>>> together"), "--subject-prefix/--rfc", "-k");
>>> +               die(_("options '%s' and '%s' cannot be used 
>>> together"), "--subject-prefix/--rfc/--resend", "-k");
>> 
>> You probably want to be using die_for_incompatible_opt4() from
>> parse-options.h here.
> 
> Thanks for the suggestion.  Frankly, I haven't researched the
> available options, assuming that the current code uses the right
> option.  Of course, I'll have a detailed look into it.

Unfortunately, die_for_incompatible_opt3() cannot be used because
it also prevents the --subject-prefix and --rfc options from being
used together, which is expected to be possible.

>> (And you may want a preparatory patch which fixes the preimage to use
>> die_for_incompatible_opt3() for --subject-prefix, --rfc, and -k
>> exclusivity, though that may be overkill.)
> 
> I'm not really sure what to do.  Maybe the other reviewers would
> prefer an orthogonal approach instead?  Maybe that would be better
> for bisecting later, if need arises for that?
