Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F6883F
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815712; cv=pass; b=RjfKKalWx6brCnZ/RrfrvjvzezIptUdreCg8oIScD8pClhYp2QEeAycNeXZIgkbz+SifStaLQ17hg2S/CAkhTfw3lrSHGQXFw2maxRwNo+pNLDGmBLH9Mz6OIU/8kZn971w9BsfCXJXVhyzXihezN6Rlw7PGwxDMIns+0QR99Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815712; c=relaxed/simple;
	bh=XJvpKxF5eS2dj1HJyFTyEtUQzu7K9TmbZkETah5EchU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YnNDmG5VYw4iPY+HhabQNE+/ozbkxxi0H/111kO6LtYTitnyeqZbxeFIMnlKMGMW1D7N5ss7Vwrom5fdozBaKfvzLyeMwTVi3kh7VPhbO8mk+dJjMwBXfIqpeyUSoB2pcqyvcCHCCt0ew13yB0PI3E1c4e0DDHS84rvh7k64rJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Rq/gOb1N; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Rq/gOb1N"
ARC-Seal: i=1; a=rsa-sha256; t=1762815694; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RjQa79wz8eWQOYCBVk8paaQp+lDXOfcp/TpRe9IxQPgOPtSPdoEXdlA/gdg1aX5XgmwEJUW2Ub8/FD0Rt+d1sJiqjnEBv1foOOXEzhbbDX88Q1pE3kbRYe1bUbjOpMVRpK87NI8N1yxEVCXCQLxlacuhmbhrlkWpo8yalSE0whM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762815694; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+P0Qqhuo53Z2t+CR7ae0ZrkHFZqUrk/NOOuLnlXXHjk=; 
	b=XlRWOmcf8iseYyR782tGoFZJA7vaRfy6QFXAtamwvMI/pi6YDPrpd1ndbgHqa/b3vTSH0l62eaQA84pEvZOT2rqh2ZAz56OLvZ2tQvzfCjQGS7e8iGAQMqjicwhrPnRCadDk3hpnpkfQF+Tk9FV1SFkA+s13TCi7FM//lT32nvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762815694;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=+P0Qqhuo53Z2t+CR7ae0ZrkHFZqUrk/NOOuLnlXXHjk=;
	b=Rq/gOb1NbrgEf6KzRFeyVOfgDTyMk7iII1Vhm5VjxsFuCEAlgeS/VXR/4n1f9Owh
	RIiyPv1Cc6g4sc5GClRa8TJO9l/OyPgb8CEOjo1QQMjzKyepjW4jZgqcSDT/st0LcoJ
	huHVJa0V8tJF9JcQCKUO8eUfkTC3ShTdoO8tfWB4=
Received: by mx.zohomail.com with SMTPS id 1762815692518765.2504809785039;
	Mon, 10 Nov 2025 15:01:32 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org, Emily Shaffer
 <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Jonathan Nieder
 <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <xmqqwm3xzots.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
 <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
 <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
 <xmqqwm3xzots.fsf@gitster.g>
Date: Tue, 11 Nov 2025 01:01:27 +0200
Message-ID: <878qgdjxvc.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi Junio,

On Mon, 10 Nov 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> On Sat, 08 Nov 2025, Aaron Schrab <aaron@schrab.com> wrote: 
>>> At 17:05 +0200 07 Nov 2025, Adrian Ratiu 
>>> <adrian.ratiu@collabora.com> wrote:  
>>>>Add a new check in validate_submodule_git_dir() to detect and 
>>>>prevent case-folding filesystem colisions. When this new check 
>>>>is triggered, a stricter casefolding aware URI encoding is 
>>>>used  to percent-encode uppercase characters, e.g. Foo becomes 
>>>>%46oo.  By using this check/retry mechanism the uppercase 
>>>>encoding is  only applied when necessary, so case-sensitive 
>>>>filesystems are  not affected.  
> 
> The .gitdir name munging is a local thing, so it makes sense to 
> do the casefold mitigation only the filesystem is case folding 
> one,

That is correct. Case-sensitive filesystems will stop before 
reaching the "Case 2.2" attempt, because their gitdirs will pass 
validation in the earlier steps.
 
> 
> Your code seems to compare directory names textually, and 
> downcasing the proposed name for some reason, but I am not sure 
> why we need any of these complexity.  Wouldn't it be the matter 
> of actually trying to mkdir(2) the name presented (either "foo" 
> or "Foo") and see if that fails?  If it fails (most likely with 
> EEXIST if case folding is getting in the way, but for any 
> reason), the name is unusable and we need to "tweak" the name to 
> a usable one at that point by retrying.  Once we find a usable 
> name, we can remember the fact that we already created a 
> directory for it and reuse that empty directory in the code 
> where we used to do mkdir(2), no?

I tried the mkdir approach. Unfortunately it does not work because 
submodule_name_to_gitdir() is called on all submodule paths: both 
existing or new, valid or non-valid.

So if a dir already exists, we do not know if there is a 
conflict. It might just be a normal valid path verification of an 
existing module.

This is why I had to come up with the double-test using to_lower() 
to compute a common path, canonicalization and checking for 
existence when there is a difference via is_git_directory(). In 
this case there is always a conflict and is the only reliable way 
I colud think of.

I am very much in favor for finding a simpler check, however we 
need something at least as reliable as the current double-test, 
which passes all cases I could think of and all CI tests.
 
> 
>> Maybe we could derive a new path automatically (eg foo2 or 
>> foo_,  suggestions welcome) and use it if valid. This way, 
>> there is no  user intervention. 
>> 
>> Do you have any preference? 
> 
> If adding 'foo' and then an attempt to add 'Foo' will 
> automatically assign a name that does not conflict with 'foo' to 
> the newly added submodule, then the users would expect the same 
> to happen if the order to add them are swapped, wouldn't they?

Yes and it's a valid expectation. :)

I just missed this corner-case which Aaron brought up (many thanks 
again Aaron!).

It's a simple fix which I'll do in v5: if validation fails, we 
just need to come up with another name and retry.

The probability of conflicts decreases exponentially with each 
retry. By the 4-5 retry the probability is so small, at that 
point, if we're that desperate, we might just hash the name or use 
a random string.

> 
> IOW, I do not see why the code wants to treat uppercase and 
> lowercase letters any differently, and suspect that it might be 
> the source of additional complication.  Also, if there is an 
> existing module with a funny path "%46oo", you cannot just 
> encode "Foo" into "%46oo" to avoid crashes with 'foo' and be 
> done anyway, so it feels like we are inviting more bugs by 
> special casing certain paths (and not encoding or checking 
> others).  Don't we have an issue similar to "case folding" in 
> macOS wrt UTF-8 canonicalization, too?  An identical Unicode 
> string may be canonicalized in two ways, so in a presence of a 
> submodule named one way, the other submodule named in the other 
> canonicalization, while their names may be with different byte 
> sequences, cannot co-exist in the same directory next to each 
> other.  "Try to mkdir(2) the new name, and see if it succeeds, 
> and if so use the resulting empty directory" approach would 
> cover that case with the same mechanism as you need to use for 
> case folding filesystems, I would imagine. 

Foo and "%46oo" is another possible conflict, yes, but only when 
both "foo" and "%46oo" already exist. The deeper you go in the 
retry cycles, the more unlikely conflicts become.

We just need to detect this conflict, come up with another name 
and retry. Retry until one sticks.

Again, the probability of conflicts decreases exponentially with 
each retry. :) If we're desperate: hash the name or try a random 
string before giving up and throwing an error, which is "Case 3" 
in the current patch.

(I wrote above why mkdir cannot solve the detection problem, hope 
it makes sense).

I think it's also worth mentioning a key idea of this design: we 
don't need to detect & fix all corner cases. We can iterate and 
improve both the conflict detection and path generation over time, 
since they are opaque to users, who rely only on the resulting 
submodule.name.gitdir config we publish.

I know it seems like a game of "whack-a-mole", but even if we fix 
just half of the possible conflicts, the likeliest ones, we still 
are in a much better situation than before. At some point we're 
approaching diminishing returns, so extremely rare conflicts might 
not even be worth fixing.

I will add a test for this "Foo" + "foo" + "%46oo" in v5 as 
well. :)
