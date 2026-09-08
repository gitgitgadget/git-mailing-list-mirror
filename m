Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A055D86B
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882401; cv=none; b=MP0wE0npEuXqAOduLjKXbtScp0iQm7Nh50vYDn71xjMs/zYBZtsd5zdoNwvkiucNLxj94kjUgv8HYV7Uvcy4cHgKEliPj49oykjRCgL9Cn3aW5wAlUcVRz/RjvhUgDHV+IAK8TkZTjzDMwN8kS2GQ7Ah+J+E6eyCicRQeROSGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882401; c=relaxed/simple;
	bh=j5LWScRjw1x8CC3PJTsi/WqMLwni9fvkFJqqj2BWG5M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDYchMAll1L1wVEYpdF+vl6PXLxLeKm/sj2QdQnrvAE+sdFgYNBuBHCUAjQfzjFtIbT9rjMMcPraq9vKNyK4FKYQCH6WV4vGXdFFB9GN6odl2EVItpZNfbxP1hZPIx9LIiL8Wt30TRcsO+7anwiZbsZ/dWYGYcYDFWRM+Y1UI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-255-187-253.cpe.net.cable.rogers.com [99.255.187.253])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 688FkMGg1653475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Sep 2026 15:46:22 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <xmqqmrtu50av.fsf@gitster.g> <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
In-Reply-To: <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
Subject: RE: What will come after Git 2.56?
Date: Tue, 8 Sep 2026 11:46:16 -0400
Organization: Nexbridge Inc.
Message-ID: <010801dd3fa9$3277ae30$97670a90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJp64hHX77XhPwv59ItOxMkZ3lG/gHEpP6HtZ1Vt0A=
Content-Language: en-ca
X-Antivirus: Norton (VPS 260907-4, 9/7/2026), Outbound message
X-Antivirus-Status: Clean

On September 6, 2026 2:15 PM, brian m. carlson wrote:
>On 2026-09-06 at 07:03:20, Junio C Hamano wrote:
>> http://tinyurl.com/gitcal tells us that the current development cycle
>> for Git 2.56 will conclude around the end of this month.  As our
>> typical development cycle lasts between 8 and 12 weeks, we will have
>> exactly one more cycle after that before the end of the year.
>>
>> Now, the question is what that release should be called.  A few
>> thoughts.
>>
>>  (1) Git 3.0: it is tempting to conclude the year with a big
>>      version bump.  Splash!
>>
>>  (2) Git 2.99: by leaving no more room until 3.0, we will
>>      conclude the year with a version that is still in the 2.X
>>      series, but will hopefully force us to seriously prepare for
>>      a big version bump with the first release of the year 2027.
>>
>>  (3) Git 2.98 (or 2.97): we admit that we are not ready for even
>>      (2) and chicken out, leaving us breathing room for a few
>>      more preparatory releases before the big one.
>>
>>  (4) Git 2.57: doing business as usual.
>>
>> Needless to say, this is not a popularity contest, nor is it even a
>> democracy.  Regardless, we should review what we have in the
>> 'BreakingChanges' document and ask ourselves how ready we are.
>
>There are a few remaining things I think we should consider in regards =
to this:
>
>* forge support for SHA-256 on the remaining major forges (I have an
>  update to provide about this at Git Merge);
>* any updates on libgit2 and its support for SHA-256 and reftable; and
>* the lowercase-only object IDs series, which I will be sending out a
>  re-roll for today or tomorrow and which is a breaking change that we
>  may want to soak for a release or two.
>
>I think anyone else who is not already extremely far along on SHA-256 =
(and
>reftable, for software working with local repositories) is likely not =
worth considering.
>JGit and Gitoxide were both informed that
>SHA-256 was coming in Git 3.0 at least a year ago, for instance.  (I =
know because I
>did the informing.)
>
>Similarly, I am not aware of anyone who is seriously undertaking Rust =
support for
>platforms that do not already support it, so I don't think that should =
be a blocker,
>either.

Actually, I may have some news on that score. While it is unlikely to =
make 3.0, it
could be soon after. Unfortunately, all info is NDA, so I cannot really =
publicise it
at this point. I remain very hopeful.

>So my gut reaction would be that maybe 3 is the best choice.  2.97 =
might be nice, or
>we could be more careful and go with 2.95 and then skip ahead to 3.0 =
whenever
>we're ready.

Randall

