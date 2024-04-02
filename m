Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68215AAA1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089363; cv=none; b=HgGlgLkA0cPTpUJ8GXNUzJnBWCoRY8CrPGJj1+7VZuFJmmfSheShFUx9MfZsRwrCnsS0HEzSd/9VR91URUM5Ue1wQdWc6AN05N5CYoE/cP1wKVktrBqz4BQp+6ZNbd9C3w/iU3v3lWOfWMaS8n2ml/2rA79HTOgNWgJS00oyg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089363; c=relaxed/simple;
	bh=GQNYcaRqYPmgLCez2pTkY+bKIlMgUxuMjdp/XSTnK/w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Txp16Swl5cvYP3RrC8QBm4ZJ/HOYZMHkQvCs1jix1w+v12w00wkVIn29TvAV8+XJ+pKwG6IUSctN/DOiRoMVRLo6RE8PPGcsDN575/j6HIbld8wluVMhUJjKYq0dOWGMQqUGGeyVQ1bxe1fKq4GlWDQxSX1Y9XSrcZs7EpZFB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 432KM1Ir2355598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 20:22:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
Cc: "'Daniel Stenberg'" <daniel@haxx.se>
References: <20240330000212.GA1261238@coredump.intra.peff.net> <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr> <20240402200254.GA874754@coredump.intra.peff.net>
In-Reply-To: <20240402200254.GA874754@coredump.intra.peff.net>
Subject: RE: [PATCH 0/2] git+curl 8.7.0 workaround
Date: Tue, 2 Apr 2024 16:21:56 -0400
Organization: Nexbridge Inc.
Message-ID: <08c401da853b$6c0b8570$44229050$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJws1Xu3+P+oB7hpoOMcV1t4cbufAIz/uswAuOIiiuwAFOYoA==
Content-Language: en-ca

On Tuesday, April 2, 2024 4:03 PM, Peff wrote:
>To: git@vger.kernel.org
>Cc: Daniel Stenberg <daniel@haxx.se>
>Subject: [PATCH 0/2] git+curl 8.7.0 workaround
>
>On Sat, Mar 30, 2024 at 09:54:02AM +0100, Daniel Stenberg wrote:
>
>> On Fri, 29 Mar 2024, Jeff King wrote:
>>
>> > I noticed some http-related failures in the test suite on my Debian
>> > unstable system, which recently got an upgraded curl package. It
>> > looks like it's related to cases where we use the remote-curl =
helper
>> > in "connect" mode (i.e., protocol v2) and the http buffer is small
>> > (requiring us to stream the data to curl). Besides just running
>> > t5551, an easy reproduction is:
>>
>> This smells like a libcurl regression to me. I "imported" this into
>> our issue tracker here: https://github.com/curl/curl/issues/13229
>
>This was all resolved in that issue, but just to summarize for the list
>here: it was a regression in curl and there's a fix already. Thanks =
Daniel for your (as
>usual) prompt digging into the problem (and likewise to Stefan for the =
actual fix).
>
>Ultimately the issue will be fixed by moving to a different version of =
libcurl, but
>here's an easy workaround in the meantime, with a small doc cleanup I =
found along
>the way.
>
>  [1/2]: http: reset POSTFIELDSIZE when clearing curl handle
>  [2/2]: INSTALL: bump libcurl version to 7.21.3
>
> INSTALL | 2 +-
> http.c  | 1 +
> 2 files changed, 2 insertions(+), 1 deletion(-)

Do we have an ETA for this fix? That or do we know when curl is planning =
on resolving this?

Thanks,
Randall

