Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8134751B
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075456; cv=none; b=nLxFTULwBXNu7B4zI3dz3Mc2G/vQOUL8jzTdQ4Cv1EBbEZdGCNisFqiynxnOcLUDO7UDg1iWj1UyJ3rcvk9QoQrqSzgS4wo9Qieix2h2/DRtjrlWRA6AiZdFcP6QTbR+3/w+QJbq1fcwui20kjflgXz5b6EyHy5Ukv3bc0QImDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075456; c=relaxed/simple;
	bh=t+w8khMlvjs59F1EMul0l3UfhLxZAqVF73sWi3SOtaA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jE5P9+hJqGcW7c/VKl7VwZBObWRWbN37ei5zr2MoN2sACHwX6509UBOKJHfSR3im+2Nxto6hStSCwnAb9igfNJ9Hi2SyabNxPd7TB1eilnR6PUFyBED5yPw3XxFpQgsBq1Fw1X1aidPTcZRDHeCyjC/X8rBoQME+QwD5FoY9VGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Y12NGgWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R44Uoy6k; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Y12NGgWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R44Uoy6k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 3727F13802AE
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:44:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792075454;
	 x=1792079054; bh=ic6Y/SPbu09cPRcjxqbzL8p4QOl1dbhRm2rl+658qSQ=; b=
	Y12NGgWPOIkSUvvQ1472uxihkTytkmDoDLm0mj1rqAdM/o86XEFbycvtAnq2NrWi
	TfmuBcqaRUG7CL0HG5vgJL/+rywBDiHG4FfGt5r6ocBL4vpuEEHqsCsVQ0AWmZQ1
	xyyQhfaEkB7eWIU7XAuKrYS6xLdYENomQqvOix0/VSOmwmYKD+CLrGg6g5K0G5BI
	yW12rSQTw2/bpyEr8BAajfp4Wu99yJonW+P9GkUcRwTwZs+f/E9a7IN2vXE17mhW
	WiFOIzsA3VqLerQQkTKjZ/7KcALAceBZDdosoSwXU9rT/j5lkUAXd6uXj/x/3qCk
	KLWVXO3mDNd6sOORXUF26w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792075454; x=
	1792079054; bh=ic6Y/SPbu09cPRcjxqbzL8p4QOl1dbhRm2rl+658qSQ=; b=R
	44Uoy6kOmRG6Qtf97HCnXC7KwXY5PjbsqpEZUePDcKl5NERCrQQR6xky38OX881l
	bWfaSL1Wjlgxx2VJNXMyzCod1SnFdbV2X6/uMl3Vx6hO1+EyFrm1Cvssy58B/qVZ
	DQWD/WMwc3lqJU/bu6pMrvhI15TaOgUGe8pZDx4XUiv+3oujSW0l0DEyN2jAmh8O
	iP59Mob7eJgEHlZma7n1r9C9TdLj0OYBc7+uEiD8nyK77Bs9+MpkeqVD9SE4tzyj
	IM2BfS5YglD31GXPS+G5So1cDgD94W5mK/evKY4iykb9LTGh5J845aeRT8D5/ZWU
	2hPuGOegYAOwZNqa7SewQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792075454; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tmqN6A3UuIKak599gqXE0nrewbKzR4f1zB72V+VvTufIvni
	9RK69K9xLJnkliWD2g6LianuTJniywUBchTFNM2ChoJIAVaYWnrM0aakkqNo5Y0Q
	UPcSeS9H3+Hih/SF8wAqDSYEVSvLSGZDaaElUN6wXXeJmvJ8qNrXQZn4glDp3+Av
	WjwYY335TY26jF2LDrELf8TEuVyrnhHpyTMWJYph1kJi9Um6Mhyfr8+65B8ZvofN
	ysriruaft57IHwJOQrsvcNaS6603QkSHTIi3csNQKIkFpahqByDV+KujjvR00+MG
	p8njYWby5GHGntuX8+YhN7yb+fIif+BZElh02sQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:buGzCezAiQd0uBbosXi9l8GmPAHZyE8W48+81YGHftY=:t+w8khMlvjs59F1EMul0l3UfhLxZAqVF73sWi3SOtaA=;
X-ME-Sender: <xms:vebQaqkBohlZz31ETZ0EJz0JYBg9OnSck-9LMiKF_APTTYu9g-agxw>
    <xme:vebQao1Lc_Bky32auZ5IPEzqA30w-wHyUzAKIOxDlwhrCsAUEZS212xIsBs2e7GUt
    Oqz3TmExdVbfBpW3iZhqDSeB064PDscRbCX3WO1M2LMKWIe1Z-gav2_>
X-ME-Received: <xmr:vebQatrm3VBECehARJbA4aZxeiqCrPY-AmEvIDGPeLB6iHoHVLHUtlcb-JdUt3mi83XbCX8_6IW4LfRt-dtHFoA6_g>
X-ME-Proxy-Cause: dmFkZTFSpEPJSXEdWNeahbGkbgvY5DFKiWEUQ0koFam/FfCQtFIK+R8zDvFJoXA49BiZ3P
    +iaAqv1crgSGe/lb5yPl97D0dYA8G0UM0NKbFwboxNqEH2BroHiadanjbVLXsdqlxmxXX0
    svzwTr6g6w0Cb+K8jRDskT+UCb23KX8wELUtZPy6R5gnM7uKA+FdxaVkElp07fv+cJ73pn
    ycu/Nd7c+76vX+L5DbpwMpZt2ubvVDKvEazyAF6oJglgSx3pmDCImrU0IBPau+Y2RVXD07
    6Z9kEoqNLpacQx4b2sn7dFw8lzZ980NCri1es5hC57TZHk+3BGZ9yoA1xsxmAkmOtpAUON
    CKyDdn46suGcWuFIRilhltwQw+QmuSFMsRMc7zQ9/BMVF8lwmDHmuUFZjYQR14elZ6zBEp
    TnOX1AKyAnfEp7E7EZSp/kiZbCU1qlyZGhg7LO7WlqFMsuQQPAyEcY9EQUmEDvBReKQ6um
    ZMpa5V6EoFfD17fiQscnWRgOKbhi51Xh97OC0jL9vnSPrfE/PptwDDUQBtHUhoxf18VRel
    IpsHKvB6Tk8eOBD2jH3mplSWT4wU7EDdzleZ7mXzJGqo4qxNQFV0zuj43/1Vy6sAomrqoC
    07AKpopLEZJoq3G0bplkbjetElSTHL9CzeLS10cnPd6hF0KrBF6Tse5Akm6w
X-ME-Proxy: <xmx:vebQatc0-4FCo62c9F5KDEKO0x38t3MWbgnE4j7IshVxFBanAFlR2g>
    <xmx:vebQakrf495CNdm0y0UjHgsWW5PrEUk7tvCL6bTWHrmpLn3RpDpUcQ>
    <xmx:vebQamHccPR1qA77D5sxhzUr2yVGyPfensXdKuwpRySlqaKBw5EGfA>
    <xmx:vebQassOZEn7UZp1QftSayfPp8JyIb7eXZZCbiQK3QSHNClVQtXgPg>
    <xmx:vebQajOsGGTVxdBwdFAslsZqEZF7lQ7BVcWiJQkHLb2XQbuhTmvubFBi>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 10:44:13 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 10:44:13 -0400
Message-Id: <DM5HQ9U1JWFE.28OMPLQUD2E7P@fastmail.com>
Cc: <git@vger.kernel.org>, <jltobler@gmail.com>
Subject: Re: [PATCH v5 1/1] repo: add filtering options to "repo structure"
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-4-markchucarroll@fastmail.com>
 <as9yXVSdEh526Qi9@pks.im>
In-Reply-To: <as9yXVSdEh526Qi9@pks.im>

On Wed Oct 14, 2026 at 8:15 AM EDT, Patrick Steinhardt wrote:
> On Tue, Oct 13, 2026 at 01:28:51PM -0400, Mark C. Chu-Carroll wrote:
>> index 84e012f83f..f45dea06d5 100644
>> --- a/builtin/repo.c
>> +++ b/builtin/repo.c
>> @@ -947,16 +953,20 @@ static int cmd_repo_structure(int argc, const char=
 **argv, const char *prefix,
>>  		OPT_END()
>  	};
>> ...
>> +		if (argc > 1)
>> +			usage(_("too many arguments"));
>
> Nit: it's not "too many arguments", it's unrecognized arguments here as
> the number of arguments can theoretically be unlimited. Copying patterns
> from other builtins:
>
> 	argc =3D setup_revisions(argc, argv, &revs, NULL);
> 	if (argc > 1)
> 		return error(_("unrecognized argument: %s"), argv[1]);

Right. I was just keeping the original error message; but since we're now
taking a potentially unbounded list of rev args, that message no longer
makes sense.

>> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
>> index 02cc2b594a..1d25ee14e5 100755
>> --- a/t/t1901-repo-structure.sh
>> +++ b/t/t1901-repo-structure.sh
>> @@ -140,10 +140,208 @@ test_expect_success SHA1 'repository with referen=
ces and objects' '
> [snip]
> ...
>> +		test_must_be_empty err
>>  	)
>>  '
>> =20
>> +
>>  test_expect_success SHA1 'lines and nul format' '
>>  	test_when_finished "rm -rf repo" &&
>>  	git init repo &&
>
> There's a trailing newline being added here.

Sorry. I've got some vision issues, and as a result, it's difficult
for me to see whitespace - one space or one newline versus two is
pretty much invisible for me.=20


>> @@ -186,13 +384,13 @@ test_expect_success SHA1 'lines and nul format' '
>
> I'd drop these while-at-it changes. If you want to include them they
> should be part of a preparatory commit.

Will drop. My reflex is to change all instances of something after
a comment like this.

  -Mark


--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

