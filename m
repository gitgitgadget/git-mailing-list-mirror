Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48024CEE65
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226353; cv=none; b=PzYW4tZ/Y89h9rAxUPqQeEirifCfl7S9j9pXRgggqztGyECE5cy2WqKBNGPNGiVGQeiRipvyZajIsCzM89vZI1BezYBWJEosswPL1B3D0G+aGgLMLg9G+49slXAv03qLMemv/VdQbnrRKChITKN4VcpCXF1U54VE59T1aRcgcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226353; c=relaxed/simple;
	bh=V8qSNvcCHohBJJEIP/Ooj8giPWrOoQsJjeW4z5LIJ0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EwikBA9ArhfkHI1BJgh+3DgnVAF2SD9wCIx1n4yzYX9h2OrekW3h5P0JK3siKocZjwOsU8BuTmkbgWpInLu0Xhq9tofWA0QK/8oKbSSnqyU7OF7qAWVN7P5Mummn8nfMBytYKw2eYDM+sfVtRSs5lFPtYKVjg58EKPR09b/KSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ab1zOg79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtE+Hlli; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ab1zOg79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtE+Hlli"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 87BEA1380213
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 14:52:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 05 Oct 2026 14:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791226348;
	 x=1791229948; bh=/Qkki0VTM4a5u/Qk/ZzqFFb5W/NKrknoqMdBjECFszA=; b=
	Ab1zOg79klVRRegbfIfVab5Ec5KABckjTEnXpcEZj1TuKdJmu1xQmlHC1Sn4OLaB
	NOTvIJ/DLygxBoK3+j0g10l73kuDDIFcR/nBTSGgwRnFW8WRIl25ZzL7um25kmyl
	qLkfyD2NGJW++PXrfDReWEWPX1s40GFpr1EV3UkwJsrwZl9ew4o7pOgAFIt++Zpf
	BC74JMKazr36R1yokIanl/0mPnq+WMo64PR6mvCrBsUtfX4fe1KVRjCnLtg3jh8K
	VGl3jkQJukz06hR+GocuihlTWZFEalaMS/pNmdzqIRMqv0Vicpe1Z7j1+FTrvnNJ
	3Qc0CSFdUK/MQoQmkjvzRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791226348; x=
	1791229948; bh=/Qkki0VTM4a5u/Qk/ZzqFFb5W/NKrknoqMdBjECFszA=; b=F
	tE+HlliMTTEgaEfFKcKheoa8TcqcdHUmwMqBula26ScYbND3apksL5GSVzYkSEGu
	goqQJM35WBP1rErYl/ZxP0M53HQKhIIFgVhqk76e3m9Ly3CjQrFFmdoopTvtOuYp
	xinRjKMw6AN4lLVH+AWuB/NG28V+POAVBn58yCPH9eJY1diQX+Ftd55cIiKMKluh
	qEzyG0k9aEukDc2Vryqr58+2EZKzkXMEoFIeOFh1j4OzTgqvlztbdHOvGsPcGhZx
	T4MWwKmDjA1ChOXuy6KzIyqdFUgpdoIPoTafVIP5joM4aia35A3aksl1q4zXet9S
	TCiFkneo4lz1D1ReL35uA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791226348; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d8gnjDpCzzHjncrPXPKUwnd5K/Lla77clk2mWU3djjegijO
	m/vJxDPEtd8oWme1l+1qHNtWcMdaQlcVzmLNhbROz7+yW+E5h4ZdCYWZgdccXgLO
	1Wqus53uyrJ3yKkZ6F4jR1ELY7KmBaYDCvQ4/L6Ek8H8PC8E+zFZ+QVR1P24RotN
	oS3jkuu0ZrOnK5d2Y8EEarL5W8+UUZ1rtpSNZUlmw11yNTlZzTKF2I6vPOwZhIXi
	7QZoXW+3fQCXT82wZowjlcp6STqno4yqmHjiC63z1fCf+VOs2isFxRU6lPzauzZL
	yhdsGHGKn+KtcKJ2UiJWaQtuXwBBAgPznqwEiMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yFSLXp4DmjDQdSJPP764wEBPkzR58uCSxXltRC7uRRM=:V8qSNvcCHohBJJEIP/Ooj8giPWrOoQsJjeW4z5LIJ0k=;
X-ME-Sender: <xms:7PHDagSvfHlPoK3uxpHQl4sdAeeoj6QsZzB8kVgaOKLr4TCjctSeaQ>
    <xme:7PHDakzdMvJWoCm1Kosh7SqXeLPzxd4OBeWjkdjKQkE9HdFiLoRTldSMEg3RAbXJ9
    FnWcGdx2Wutux-Zidj8ZnR7znh1iBPqMLOKTbD5Ygi1pOjWvyAMU8U>
X-ME-Received: <xmr:7PHDai2PdCp5ukloXkuZecTfG03LZ8twWm9vyuExOU3SeB7Ejtm4GdcaeeutKqqIcGjBdJqE54S7VYiOOwKFpcmyarwKVy9vmal0ukBSZlBVIw4D3AtvTxpfSw>
X-ME-Proxy-Cause: dmFkZTE3/12xZX0gXRO+ZuIzE9M6d0gHBF3+BjkwjkkOovH4iPxUWAsHZBCqZPQolAyKSu
    zd3w5RI2GOrMx8PVq/AcAjX0yy4ILD0ZRcmg3YDGJjM7D70R18+KhZhNJVUkvruuEnZRXe
    S+QdiGy4msSSP7CmQMpkqAVTQhPnjIRXfc7QUKbxnyrjqSvK9g7smoMpmF7O7NzT4t0R8s
    TtOf6retK2jVgxcswiiHWm1SkZwGem5P/wMzYEHhbTpEvp11R+7ddeDcvdqlIV+8BE1yhy
    QrOG9Ptn/lholZlAerEsTay7YW08nrNctyPdpkO2rRwFtGhyxbPfZPBDZUyIRDjL7czKfN
    eMUg2zgdv0QgcdU9vzSaUqP1i6SLYAEn/KgMaY2z3J1cxMw58acDclAxK2GuqdnKcpnyO9
    WqIKn9TLOsjNqv8MHrVVTF0hZyYoh6P+NkJccVjaOLLlBZV6h73Dmujw9CFugBg5iJ3Zmn
    2S8/tY1ZRjcG12WTiIzUj6gQYr1Zv1iU+Ibgfq7xc5R1wiSpiiXih/UVsXX7aq9z42siZ+
    lo5pMTp3uwvqMwWMlV/OGHuMj5rxiF9ZYa0tKv74nABgbRzndlMgpvalGjsVkOvka/yElC
    DKbiywIc2IOx2769CBMKqp9bmo2MKGs6xyYSkysH6TLyAbitqYRv8gS0EhVw
X-ME-Proxy: <xmx:7PHDai5y36hYDk5FQYCk2F1-dtoRXS0yjzisaU00opSYNzRfuMAQ7w>
    <xmx:7PHDalUnYntMHDeCLdDkyl0IhVghBxAudGDSu1L6grseQTyguhxx2w>
    <xmx:7PHDahBrE_9jNvr5opCVwVYfLBMB9imHf_w7SWzbQAkF6soRRyL6Fw>
    <xmx:7PHDak4JICjPTD9XC_d6hWhskP838FsfinuEmFGxWOCuqp90oswbGA>
    <xmx:7PHDarJCOXPiAVvHX3iWHsC7bV-ZM5d04-papid_INN3y8Ke0gwd-X6e>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 14:52:27 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 14:52:27 -0400
Message-Id: <DLX4QVXQJTQ4.24JR7ES0P3H@fastmail.com>
Subject: Re: [PATCH 1/1] repo: add filtering options to "repo structure"
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
Cc: <git@vger.kernel.org>, <jltobler@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260924164503.119506-1-markchucarroll@fastmail.com>
 <20260924164503.119506-2-markchucarroll@fastmail.com>
 <ar04uStCZ4pnEJ38@pks.im>
In-Reply-To: <ar04uStCZ4pnEJ38@pks.im>

On Wed Sep 30, 2026 at 12:28 PM EDT, Patrick Steinhardt wrote:
> On Thu, Sep 24, 2026 at 12:45:03PM -0400, Mark C. Chu-Carroll wrote:
>> "git repo structure" provides a collection of useful information
>> about the information stored in a repo. In particular, it's
>> valuable for diagnosing performance issues caused by large objects
>> stored in a repo.
>>=20
>> The current implementation of "git repo stucture" provides summary
>> information about everything in the repository - all of the
>> branches, remotes, tags, stashes, and notes. But sometimes
>> to properly diagnose a problem, it's useful to be able to exclude
>> refs that are known to not be relevant to the issue at hand.
>
> Yes, indeed. Sometimes you may for example want to figure out where
> exactly the storage size of a particular repository is going. Or in the
> case of GitLab for example, we may have bookkeeping references that are
> not controllable by customers. So we may only want to get the structure
> for all the customer-controllable branches there.
>
>> Add a set of flags that allow a user to selective exclude
>> reference types from the report generated by "git repo structure".
>> When a ref type is excluded by the filter, it no longer appears
>> in the report (ie, if "--no-tags" is passed, the report line
>> for "Branches" will no longer appear under "* References").
>> Following the pattern of flags that are only used to
>> disable functionality (eg, "--no-verify" in "builtins/push.c"),
>> only the "--no-<reftype>" syntax is listed in the updated
>> documentation.
>
> Hmm, okay. I would have expected that the user can essentially pass
> arbitrary revisions as understood by git-log(1) et al. And if they pass
> any such revisions, we should not enumerate anything but what they have
> passed, so the flags shouldn't only be used to exclude.
>
> So, for example:
>
>     $ git repo structure --branches
>     $ git repo structure master
>     $ git repo structure --all --not --branches
>
> I would hope that git-repo(1) can achieve that rather easily because I
> expect that it uses `struct rev_info`, but let's read on.

That makes sense. My initial understanding was that most of what=20
"git repo structure" does is internalize the functionality of git-sizer
into the core of git. The only filters offered by git-sizer are=20
type-based. But I agree that a commit list based filter is a lot=20
more useful, so I've updated the patch set to implement it.

   -Mark



--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

