Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137930DD3B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591929; cv=pass; b=uBm4CvBgxNtgCIAS8H/YujDv2gg+r094gbfzPAl2IIHfSf5hclFSjVmkdFv28JfbBSDJRdNWGlnJM34jFkZ2ZvCmoqfXgUH/lIVtZK5cI6VILbaLgJJBAuR5i+1I660Yfa2s7yXzDRdYAV5wPXHj4ArGiatsF0HL9dhwe9Ofsi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591929; c=relaxed/simple;
	bh=/FdcYNFoClJ1D2h7tuo3di1VTSIHeXMkDWdNJdozCqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=surxuNlyHbCFoSxDT9vBmKV9ciSqd61+6zTVzuxBhdbQNbtnY7DZhvdwVXS3iBFOIZ6Mx+WFhXFcMG9qR+y5cjhwC//W1bWjX3Gm2yOzU99f+sIXw27KNN1JWfljeGU8JUek7iJjUJjsweiXIvSq2dISLqI+1lHRT1zsz02TQcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SBF6njNx; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SBF6njNx"
ARC-Seal: i=1; a=rsa-sha256; t=1771591915; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RaMETBKuLUT30Htw5cTLFWeiIcokm0SSFen/8nk0qdi236/drWPIVGbmKtaWm8elYo2D73yGu3YT3suBqdaYPlEkEZzw2RUWj1ltLkzNEUJ/RzD3xBIiPBXlugZGEryj6ewCqZ7PFysqN0yYa5aqQYg4nyU8qKrrcgYBwvhSRhE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771591915; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7fPnU45PYf0sedT9W/yXrv08uKXUHVZ7uLdHtgFlM78=; 
	b=XobxpZFkCLa0FDyVBUTNFqx0XhpmL/5F+TGVwv2R/OLSHFgdat4o0AARA+EfsgIjYpwd3vibi95HtHYnnHS7lBgbG9GLACYUXgC5BfpJ+SQH+nmRoBufj1tMeuWzkRncuCFnPHSedCAnWDI265mjOntAfeM2E6Mh8DDjtDdWg8s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771591915;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=7fPnU45PYf0sedT9W/yXrv08uKXUHVZ7uLdHtgFlM78=;
	b=SBF6njNxoJPzsIUGfvY1T/ubBg29OuLM0cgEbKkPxYTaw8b7HnKgDxgLA4PGCo84
	0tiGy0PC7315G7pBGJizEvRfT2Kvn1L5WUF18+j/ITabBYETw2d7GjI9Ghll96l/rt/
	qRiYoI+5P4dSubhAAg0uCZtrDtak7p0GChDdvNiA=
Received: by mx.zohomail.com with SMTPS id 1771591914225234.99978640239317;
	Fri, 20 Feb 2026 04:51:54 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
In-Reply-To: <xmqqcy202z9p.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <xmqqcy202z9p.fsf@gitster.g>
Date: Fri, 20 Feb 2026 14:51:51 +0200
Message-ID: <87fr6vy3vc.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 19 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> v2 addresses all feedback received in v1.
>>
>> This series adds a new feature: the ability to specify commands to run
>> for hook events via config entries (including shell commands).
>>
>> So instead of dropping a shell script or a custom program in .git/hooks
>> you can now tell git via config files to run a program or shell script
>> (can be specified directly in the config) when you run hook "foo".
>>
>> This also means you can setup global hooks to run in multiple repos via
>> global configs and there's an option to disable them if necessary.
>>
>> For simplicity, because this series is becoming rather big, hooks are
>> still executed sequentially (.jobs == 1). Parallel execution is added
>> in another patch series.
>>
>> This is based on the latest v8 hooks-conversion series [1] which has
>> not yet landed in next or master.
>
> Thanks for a reroll.  I was a bit concerned to allow configuration
> files to speicify hooks as it would reduce discoverability (i.e.,
> today, we can "ls .git/hooks/" to see everything that potentially
> will be triggered, but now we need to be aware of what your sysadmin
> dropped in /etc/gitconfig to get the whole picture.  "git hook list"
> would solve that issue nicely.
>
> By the way, the discussion thread for the base topic hasn't seen
> any activity in the latest round after it updated for the comments
> received in the previous round.  It appears that it is ready to move
> forward?  Let's mark it for 'next' in that case.

Yes, thank you, landing that series will make testing this one easier.

I'm also working on v2 of the parallel series, will send it very soon.

Both will benefit from landing the base preparatory "hook conversion"
series.
