Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017422;
	b=eDwn0bceZUNGt6OKv5HNyxn8R/TJLI/rY5H6gM+XtNZtjoDAciAaNppqbyCmmtdblpSA
	 Cc3/aq8dTpK3fAmKOjQjVWnx8Y559TEewdocmRXcX9ghOT+TT9AuXh+X7ck6S8+hUnHEw
	 OAVoBFmgQ0QLvnqS6mjwqfaeIecexABtUf07dJm42uOQPpwKNgWbrG/EZa97nV2N3g14+
	 P32GpBETnoEWSXMdjUqjkOKDCI9oKpkXzfPKgDYGyFmybbcY1Uv9IIZgMwC3Yl7YaRDpp
	 +I5CeghDfABL3zk2Pa9ba0OFR1SDmI/EivuZ9VG/ATx5FVvmxB9s+YKCh5GFi5Jg6ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017422;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U1JrWZ7PB85bgBs8HGuHW9qCRMhqXcuvFSj4YGnfjD8=;
	b=iJAL4h92LYnB2YAUFIqm5z6Tz+WqjfuCiMFAjm1mut2P5uERkcS5m7115Gi4MvvukW6E
	 SrBfZWqm63au5ichNLwouQ1CQMvhhD7byCXhJr9MsrTJ/aa651Ks8hw0298MoEXwq/kw6
	 c2krIveHb2hY0yCU54exzgt2tsWAh3QXJYGirvMyrLhk0oomciQiWoE2KusWy3JkDg27J
	 JhbzoE3aDRC5OfMwbiLiyZEGqaO/0P3eQpR8yPFwbfeTnP4RAPojXO04TeRIABLB315um
	 mn6b4N9QT4xbCNKPODo0E7LcDjHg9/eLlj/4k7eyKbw4Keqt4x53hJw56pySTDucn8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=St94RTUg;
	arc=none smtp.remote-ip=91.218.175.178
Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA98606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=St94RTUg
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f/oKkTeeKSsznhSUvnOdWTt+ggA8IVST0Nm7IK1eTco=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795017420; v=1; x=1795622220;
 b=St94RTUgV7QVG2spVhjcnEWWFrqiNzAViknprS44ytFHkr14ftgTX7zpMlfSSpMTMwihy8Gl
 sPIvRmEQKthYvlpeEjJBnMl8aG5Uyto9T+SpJeqvfUCqYxEvGvZE7EqERAv+PC3Adz16Aj6HFjO
 2iL1PRqZ2b9Pf4gKXyOx4sP4=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8593e1f5b292aedc;
	Wed, 18 Nov 2026 15:57:00 +0000
X-Mizu-Trace-ID: 8593e1f5b292aedc
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] Improve performance of reflog expiration
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
Date: Wed, 18 Nov 2026 16:56:57 +0100
Message-ID: <87bj7mjfp2.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I recently noticed that a bunch of commands started hanging for almost a
> second after they're essentially done already. As it turns out, this was
> caused by auto-maintenance, which was blocking in the foreground for
> ~800ms.
>
> The root cause of this is that the auto-condition of "reflog-expire"
> doesn't properly evaluate reachability of reflog entries, so it instead
> considered every single reflog entry to point to an unreachable commit.
> Hence, all entries were evaluated against "gc.reflogExpireUnreachable"
> instead of "gc.reflogExpire", and thus the auto-condition significantly
> overcounts the number of entries that we'd prune. So every single run of
> git-maintenance(1) ultimately ended up spawning `git reflog expire`.
>
> This is fixed by the last patch in this series.

Well, the last one is a doc change, but I get what you mean.

> But I was a bit
> surprised that a no-op `git reflog expire` took this long, so the first
> two patches optimize the reftable backend to be more efficient, too.
> In my copy of "git.git":
>
>   Benchmark 1: git maintenance run --auto (commit =3D master) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    853.2 ms  =C2=B1    99.9 ms     570.9 ms  =E2=80=A6   90=
1.9 ms
>     Memory       117.5 MiB =C2=B1     0.3 MiB    117.2 MiB =E2=80=A6   11=
8.2 MiB
>
>   Benchmark 2: git maintenance run --auto (commit =3D reftable-optimizati=
ons) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    392.3 ms  =C2=B1     2.3 ms     388.0 ms  =E2=80=A6   39=
6.6 ms           -54.0%  (2.2x faster)
>     Memory       117.2 MiB =C2=B1     0.2 MiB    116.8 MiB =E2=80=A6   11=
7.4 MiB           -0.2%
>
>   Benchmark 3: git maintenance run --auto (commit =3D auto-condition-opti=
mizations) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time     18.6 ms  =C2=B1     1.1 ms      17.4 ms  =E2=80=A6    2=
0.9 ms           -97.8%  (45.8x faster)
>     Memory        81.2 MiB =C2=B1     0.1 MiB     80.9 MiB =E2=80=A6    8=
1.4 MiB          -30.9%  (1.4x less)
>
> So yeah, it's a bit more efficient now. :)

Great work. I only had one remark on consistency, but not really worth a
reroll in itself if you ask me.

--=20
Laters,
Toon
