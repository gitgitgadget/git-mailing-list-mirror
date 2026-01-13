Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA532D5C7A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318701; cv=pass; b=A7AjsdJc00eLFSpDI8eRDmSM7giDe9iCPyjCK1HjLr0pLEpw/w1ZVww+R9XOIULGDT6SMZnTzAxcFVTRYKVa/OuObMlx6wCiOZmvnNxuWyrv4L9KqNzsCM1bnPT8Arx/hb4YZXys3dbDR2BpUaeLJsGWVlA5yRN4TbG+U/1pc5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318701; c=relaxed/simple;
	bh=cssNM3UqoXxEJWGH8Wf6Xcxt6+fdwLvbvDEBc3KjpbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M19ao7fhI/K/+WnQ96pMsLFZXXXaRJJLcrLwCafPa+mzS5t4koOoofTgQWYOrYV+pgaWoWon8FNAw15QJH3H9mReQJRhX298oP0cPS7j4LX3X7Y35BXF82pWIQIVFNISmK9XujyTGfFnihg+jCvH6frwvGK4dkWw2Wss4Eo3E8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kvyCg4FB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kvyCg4FB"
ARC-Seal: i=1; a=rsa-sha256; t=1768318685; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vo4mRjF2QUMsMTPnPW3fJlinI2igRKZglkoY2HBS/+Lw8DVg+khIo/sIWElucJ2Wp0gJyBAQzuqmK3aOXrTRweOPgkv1uM39J2nlrxAsXh4E3GtMxPtAm7MzTaX0oedbzk2x3ZFXiXUsnfEvvLODWQ7JLNG7LjMpZhQblUPbjPM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768318685; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xRVp4Ey711mIubjMo9aqvhg0NeK1A7J2ZGo3b3dhuTE=; 
	b=ZerfQpskDT4PIa7ZgJwLyjqsHaISxeGkDu4+Zim9sFzdM5upaXoeDyrnoz6n1K16+ZKdA27YHU8AZdyxETjqEycxdPPfmO1LKOUwGfc01JkgY4z3D9IgHcfqbBKJL5dHIYPX/fvSW8qjwiAinxo1gwGm5MS1Lf7m/4g/hKntMD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768318685;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=xRVp4Ey711mIubjMo9aqvhg0NeK1A7J2ZGo3b3dhuTE=;
	b=kvyCg4FB/EaKevjCjRNryIf2HYrw6p+Ury2VChW+5xemB19emrPbsUeux6Kikg8a
	GaEtrP4ePET4Rj84fwYyrd+KYRrabBhOmYUiJIZ7uubeRIo0pSovnYA2a739IES71ZT
	mqdlgBBKo4a90YJuGNqjYCXNBAtlbl43AuOACnD8=
Received: by mx.zohomail.com with SMTPS id 1768318682442344.9630956333299;
	Tue, 13 Jan 2026 07:38:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Chris Darroch <chrisd@apache.org>, "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <xmqqv7h5k05v.fsf@gitster.g>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <xmqq7btlliip.fsf@gitster.g> <xmqqzf6hk3ox.fsf@gitster.g>
 <87h5spimno.fsf@collabora.com> <xmqqv7h5k05v.fsf@gitster.g>
Date: Tue, 13 Jan 2026 17:37:59 +0200
Message-ID: <87ecntikvc.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> On Tue, 13 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> What was the previous behaviour of code paths that ran other hooks?
>>>> Was pre-push the only one that didn't divert standard output to
>>>> standard error?  This patch does look like a proper regression fix
>>>> in that case.  I browsed "git log -p 1627809eef..c65f26fca4" (i.e.,
>>>> the change for "Merge branch 'ar/run-command-hook'") and random
>>>> sampling (like run_receive_hook() that used run_and_feed_hook(),
>>>> which set stdout_to_stderr to 1) seems to indicate that it is the
>>>> case.
>>>
>>> By the way, if stdout_to_stderr is by default set to true, but tnis
>>> regression fix allows specific callers to opt out of it, then the
>>> title "make stdout_to_stderr optional" is a bit misleaing.  It makes
>>> it sound as if it is false by default and optionally turned on.
>>>
>>> Perhaps like "hook: allow stdout_to_stderr optionally off" or
>>> something?
>>
>> Ack. Will rename in v2.
>>
>> Please wait for v2 because, while writing the tests, I noticed pre-push
>> needs 1 additional line (ungroup output) to function as before.
>
> Understood.  Thanks.
>
> Writing these tests would take particular care, I imagine.  Apply
> the test to the tip of the 'master' before ar/run-commmand-hook was
> merged, to verify that the tests expect the behaviour before these
> series, and then merge the result up in more recent 'master' to see
> that the changes in ar/run-commmand-hook did not negatively change
> the behaviour, or something like that?

Yes, that is an excellent idea. The tests should work the same before
and after the conversion. Will do.
