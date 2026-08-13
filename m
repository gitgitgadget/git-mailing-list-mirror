Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353738837D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786597232; cv=none; b=XphdD7DV3RTpDb+2+Svo8x1wHBBAT+u6y0jSjUA4/ApsjNFtmIC3wGxVvxG/LyFgoWCCDwjphTFcsmbt6O5tPRaEH5sittK1Asa3YJ9FgtRy8H9u9/8A4fxW7ju3xWQtwkuR1jTVPyTz0IQ7ybEPw3ARuo//ZHI6VAIatgccAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786597232; c=relaxed/simple;
	bh=1Wy760LfUxqcQPX1kI2pV40YsifJiiD/fBYnVwqAYPo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QV4XjTJh/U1TWt4Mz5BfNpQYNzwAK/aEvCJ6SJs+hn79PSKnFEIjj4boNTgOidhU0YIXF84u0kqQ1bduPnHCYA7MOPtJ4aPXmHC62YbL8SkToOVSlohntosNro98Bvfm2ZLCd52f4U5koLYwS+UwTi3Ty4Xjwy2RWL0VOvMwDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Hl/ePFWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iV8fV9DY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hl/ePFWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iV8fV9DY"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id AF3A41D001BA;
	Thu, 13 Aug 2026 01:00:21 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 13 Aug 2026 01:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786597220;
	 x=1786683620; bh=f4w4jW+T5xjgbREyyzLpvHNeYPAhKxxvbaZrUweXi4o=; b=
	Hl/ePFWRSitmLlNAWyz9dOrFzgSDmJu7hnAQqaqdxmGvFKkBppRPOXYRSBwrCVaX
	fuvMu327jgrWp2S/ypSLfKIZDpM6l/YiE51G9lANdW7VbEv6pBEwUf3YeGj3T75Q
	eNyXVxvxkWnMM+MD1Ptx9XOKNsLVoSzJfeTCzE1HQK6dy69YKHL6VucAtcAyE8r/
	V+gspLfK/DxHA8wIlFtVzwBjnDd6mQqm0BDZ5czbsQ2f/QgGAWBeNA47IxyReWpv
	E2MO1LY48JpeJvFG2rXey5Ytcw3uy/V3WMCWUxN1HJMDXx8PBweV7vLpCYHN+tJX
	6JK0pHFAYFLQi8V2t38/LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786597220; x=
	1786683620; bh=f4w4jW+T5xjgbREyyzLpvHNeYPAhKxxvbaZrUweXi4o=; b=i
	V8fV9DYljVmbXPsbSCoFpomUrli6wRPnC+jbpOtZq0xE9ezmuSUgFl4BojqwBf7t
	Djn+vPpCDSQOk5fYnT2Y+jwolFhThcAqgcSxl1iaE7344z2KZOhHmANUDEMfbgOx
	2bAgLxWoNC0jggjvrsFx6qsVMfJz5cYRM38fiU9Lf3OFOHtK2wjjA3CfPf54QBAj
	ZxQrSwjpXrVHMeOAXHIUv7TuKlPAkOxvD6AeDKAwgAYy9HUbPq0f3aVfmSrFOyNO
	8uUEN7csp//z9FFAgmGCcY5Eqh52D9d6+0Exf2A2aRAG0mvyhNaHmgeeIfcPgFS5
	rnjaSGsMCb6RD/JHsXBqg==
X-ME-Sender: <xms:Yk99amuMWSH0ypLacUKfATHA6JLXYy5otH4dgmaCKbyn9KiwVAuKiYQ>
    <xme:Yk99amS_e7-0GIbmcSdNwAqBqHt8qlpUX7yaT1kbbdL6AFD2-MmNheJfj4HVDFJdG
    HpPB0zDF077qrCcCbLLhtSgdX2-Gb-0XPePvP2EQNSccUi85IhNDSM>
X-ME-Proxy-Cause: dmFkZTEDMn2c0zQBvkuKwb6TQ7izf7s+cD22L3xumo7Yw8eRe214q0sfMbMydM0nIlAgsk
    MhW6wFITS04Mcg63WzZWaReDgXQzM2MhCD1kVN+JRkjnVE50DwPQl/e13zvr/UhUah75g5
    /QdTIyoQcRcOHaCUfzqyuplrcb5c0F613MTXfIuClOyM9gLtLnVgEpm73r/P15dvEkegs0
    v3v3EBFv4SmkwZ93oD1nc951olKrNFPln1zoh2EgpL4Eb3Jk7KURLpppyn8q6aAcabbDB/
    la5nvEWC5/vvHKanGSWBgOVtlaVPG12CptC1aeMLNRS0PmnO/O/Dydo1G57K79mMFOUIUW
    4LZQq9S6IrFhFvA5nv+gpsO1eUs14sLnSPA/ujQ/wenZtUYkOlyEeqONxBxCqNZeg9DKbu
    xZ4KhhYf3YbTHl0FEMA55ClN3+tvos584RfXHBNvA38GVMHhaMeDPAnFTC3mQCCaFoDrnP
    MLF3bBJXQqNkK9cHF8kybyIKGBWkQbRce/zI9El1ET84jcwChN/jQPaKbbuc5ToNpzXt93
    CWsTkvrMa7bSVz/Xwq7sIXL/Nn5by/FQIVBf5JWE/RKVPGgQ2DXwtIexP2+mcl+BP4/XIJ
    GSErYOTEWgXu1S6tBGTjhcdK0Ds3wKlGUR84emRJuZv5SIWJEP0J7D6a3YIQ
X-ME-Proxy: <xmx:Y099aio5kQILExjpDhDXonqZuKYtOrLaUIz33DGC8fLCvSl-6GRm3w>
    <xmx:Y099aoaWs5ifgKKv_mxHdthz5jTEuIleIAF9ivJEcMg_a0emWa6EFQ>
    <xmx:Y099aqT2nL8afKirvPTMx9EN8DhdUjNi1FMrs-Jw_qpQIc1FOopQqQ>
    <xmx:Y099av7cLT3q0N5GcaEOBhih6Ifd1SjQz_BYGR13NBmysBHzbljHlA>
    <xmx:ZE99atnjtAo92Cwbn7mWZhkTDem_dWckA3o2_rzBl1sEJUfHdVjZt4Us>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0A41B22C0072; Thu, 13 Aug 2026 01:00:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2-b0hDR4pQ7
Date: Thu, 13 Aug 2026 06:59:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>,
 git@vger.kernel.org
Message-Id: <25c18566-134b-49af-86e8-494634fe51f5@app.fastmail.com>
In-Reply-To: <xmqqmrurxodi.fsf@gitster.g>
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
 <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
 <xmqqmrurxodi.fsf@gitster.g>
Subject: Re: Bugreport
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026, at 19:03, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>[snip]
>>
>> They are Git notes. They form their own connected graph. That=E2=80=99=
s why they
>> are not connected with the =E2=80=9Cactual commits=E2=80=9D like from=
 some branch.
>>
>> The `--all` will include all refs, including Git notes like
>> `refs/notes/commits`.
>>
>> This doesn=E2=80=99t look like a bug.
>
> Wow, I 100% agree with your conclusions, but it was unexpected even
> to me that "git log --all" crawled anything outside branches,
> remote-tracking branches, and tags.  I can sort-of understand why
> the "rev-list" command at the plumbing layer may want to include
> everything under refs/ hierarchy, but it is unexpected for the
> end-user facing "git log".

Maybe `--all` was added before Git notes and that was the intent? Well,
they would known that it would include whatever custom refs that people
wanted. But then maybe they thought of it as:

=E2=80=A2 branches, remote-tracking branches, tags (from git(1))
=E2=80=A2 (git-stash(1) is an old command; I think it might have been an
  oversight to include it with `--all`? (see end of this message))
=E2=80=A2 whatever custom refs the repo uses; these you should know (?) =
and
  shouldn=E2=80=99t get surprised by

The custom refs would have been added by third-party programs, but
someone would have thought that it was worth going through the effort of
pushing out these refs to other people. Although, people could still be
surprised by mere bookkeeping data showing up with `--all`.[1]

***

Note for others: One doesn=E2=80=99t end up with Git notes added by git(=
1)[1]
*by others* that easily. ;) Branches and tags can be pushed out easily,
but you need an explicit refspec to push Git notes. And I don=E2=80=99t =
think
git-notes(1) mentions this. I would venture to bet that most people who
have learned to push out Git notes have learned it from StackOverflow or
some other not-Git project site.

And after someone has gone through the trouble of pushing them, other
people also need to fetch them with an explicit refspec.

=E2=80=A0 1: By other programs is a different matter. Git notes are a gr=
eat way
     to attach metadata to commits, so many third-party tools use
     that. And it might not matter to the end-user whether data about
     which commit messages have typos in them is stored in Git notes or
     in some Sqlite database, but `--all` will reveal that
     implementation detail if Notes are used.

>
> Not that we want to or we can change it this late in the game,
> though.  I wonder if "git log --all -p" also goes through the stash
> refs as well as notes.

It does show the commits from `refs/stash`.
