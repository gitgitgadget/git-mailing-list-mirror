Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8961BF20
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713730712; cv=none; b=SqqBsSrItjKYO6D8WjSHLLvyDnUyMUvSjg+HegvQ6t8/KBAYquekGGyxF/rmNcW+rQT6YxGZ4RrfkPmEQ4Fm5aMRUElQaWY2FTf4JubcAvSZOWMBU7XS+EADnd6s4bJVVliyN9794HEQaZ7hfsYW4a+dAokP1ZTEAUh6SxDQcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713730712; c=relaxed/simple;
	bh=z118HE8ZlMuhhrJcmm4J/jb8JzyR1SdgJAT3jIoptYY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=U2U0ZvuTAjDnpw9qzNapiwK21rmJjIgDm+Ndk+KfZHZUE43R4swjG3tEWttrVB35jiFvs4cRaGtrFd66N6HiSfDvknIPA5ADwSo4F2KYBT4DTAWw2sx3aMd+NyLPPVEmvVVcHgEz5Dkf4j0qaycKN9+mlhieMLHGufv+PRQaw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43LKIP5B2910832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Apr 2024 20:18:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'German Lashevich'" <german.lashevich@gmail.com>,
        <git@vger.kernel.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>	<xmqqy1961sxf.fsf@gitster.g>	<03b501da941a$4896bdb0$d9c43910$@nexbridge.com> <xmqqh6fu1qk3.fsf@gitster.g>
In-Reply-To: <xmqqh6fu1qk3.fsf@gitster.g>
Subject: RE: Possible git-diff bug when using exit-code with diff filters
Date: Sun, 21 Apr 2024 16:18:19 -0400
Organization: Nexbridge Inc.
Message-ID: <03bf01da9429$10b55460$321ffd20$@nexbridge.com>
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
Thread-Index: AQD6IN/EEUg+Pj6GO/QRv1Zk76ONSAGHpshHAXuYprsCy9gy0QJaDip7svLHBVA=
Content-Language: en-ca

On Sunday, April 21, 2024 3:09 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On Sunday, April 21, 2024 2:18 PM, Junio C Hamano wrote:
>>>Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> You can more easily reproduce it by setting the environment =
variable
>>>> GIT_EXTERNAL_DIFF or the configuration setting diff.external -- no
>>>> attributes needed.
>>>
>>>Indeed.
>>>
>>>A much simpler fix may be to declare that these two features are
>>>imcompatible and fail the execution upfront, instead of just silently =
ignoring one
>of the two options.
>>>
>>>As a person who is very much used to the external diff not
>>>contributing to the exit status (who also invented the external diff
>>>driver interface), I would be a wrong person to judge if such a
>>>simplified approach is desirable, of course, but just throwing it out =
as a food for
>thought.
>>
>> My suggestion would be to keep with a priority approach, where
>> GIT_EXTERNAL_DIFF overrides diff.external, assuming they set hold to
>> the same specification (the git-config page implies they do) and
>> GIT_EXTERNAL_DIFF overrides diff.external as I would expect.
>
>Nobody in this discussion thread is hinting to change that, so I am a =
bit confused
>where the above suggestion comes from...

I must have misinterpreted. Please ignore my suggestion.

