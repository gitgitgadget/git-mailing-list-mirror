Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CB3E1204
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162925; cv=none; b=Rc7hmpZj6+xATinGXeeoyXP+cfvqs9+IEr6n0XjIP2q2A4HhPVgJgm7EK6v588XgPHxggGfTma+LV3LW37yiYyaR1kuPH2fRiCo3TtL46mwDAEfmlSmlLpD9YOeiL5orF91DZijY8hTHiloabsPE9E2meF4yE4sSgFDmJzdfXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162925; c=relaxed/simple;
	bh=9YU9apIEtsg8roTcREk3Hv8UySDVaksnmOemuOx7iI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8IpD30rF6bjZNlvMyJTZN9hhL0NMPYqfu73vOX7szDnQp9rFtIAID1nJ4Yk+RjgBIPvZ7PdIbFJ55Iqbr8FvPzqD5DalAjGUO6/izOmjBrb2FcPn4vlJCHp5n//xVZK774wWXpT418vCxVMZQPPsvAVtTgRLTzin17dKsaQUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GGYwHMFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pTRQLc35; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGYwHMFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pTRQLc35"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A193EC00A6
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:02:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 11:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792162923; x=1792249323; bh=R3QO2bdHE6
	r0EfKy4+x4OmqrvjaV52EG7kpwE1INT6o=; b=GGYwHMFqXl34VnKCKJ0TcMea0L
	QTVqzkn9jOayzqUXwlZ26G6dybfOI5UK/VFA+kMt30anpd/vNQW2oN44PhdUdT8N
	1Y979d2OBQ/7GrPRjMRSHyB0D+AT82IcIjjByXYZMIxJcgpOm0Yc41zObwiaUIoE
	p/vI+Bt1Fv0sNncDYEaA/5I6N7CH8XzEyWP1quZclqZUhx6FHjmiH+4Sj3VTv3TW
	8XufgGZMhip+RxmHR/iYuYfOqe/luyy/avZUyerFmU6ma71097kuA+DYTjt1kMmM
	oDejt3Cp3xK4SAWEF017IBoxu2B0Y/7S3Uj3nmDDP7l83fbisYAe1LKNrhWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792162923; x=1792249323; bh=R3QO2bdHE6r0EfKy4+x4OmqrvjaV52EG7kp
	wE1INT6o=; b=pTRQLc35AjysL3i3zkgT/KpWSmtJgtoy5pylKrSMDJstGPdpFmp
	yQ456wCax/S1Yh4Oilu7AiFQ9kZXBt805lbGu9M2RphK9bf4uci/hhhZxoVT8K5p
	BPqdKsNeuyYWum2fCFTPl2R1cv73/wU9YNnHc/56AAA52/v6+Htro8Q7srGrY2IM
	oqPWH9dpjP7DcIo1SWF1PGZkofnouDUJFEW9ta8NXpOtaO4SeNb2snPjRe99hFTC
	z0Q8NZkfnXyecY0L4gAx0TreHatwWaIsdu1i6/SJPrTcPhVOxTUDFbcK38rCYKq/
	6+7LrK33n9vhttvyFz1W7hibSQWJnOayKlg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792162923; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DvgF86z17GEZrsZPE4pM39tFO0HIV1TuOmTujZCt7XhfPH/
	tR6iOdYd8lV1L0OY7Vo2jIouha9IacgtEspl23cZt6BhB8lAeN5Ozjwd2/94N1i5
	bpb/Bbg9nKc6N4/jR6m9Uuxeo9ktt8PJzNJR7ywG4+jndGcbTpqqdIb0ajJNsxHP
	NoMxp/aPj7MdYFiqZgtE7lo/ZbAwQEHXHaWBPHDTN57fyZkc/XylZwzS9yuMw3Yq
	VSTUI9JO1BpTFhH8R0exz4rt6uVfPZauFZdNJS1kF9IqH7frnQgmQPrMnR8alESQ
	JB3gtuJTyy3+DnLdJKz1JWdmCJiLruJBgui7DyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CMvQlvMH4V1tQY+tFI3e08plyuZrPehcw4CtXH5IU8E=:9YU9apIEtsg8roTcREk3Hv8UySDVaksnmOemuOx7iI8=;
X-ME-Sender: <xms:ajzSap4S0CVYFdi8a-ETl2JQVZCJP8ibvyuoMxZIo0Mx6RswsCQBuw>
    <xme:ajzSat6hKJvSkGUQE8ph_ygY9c6FFoi3ZM-MxyNbyB7ASiANTQgiz6VwgvDxmVL_I
    kewHoiISffcphazqXsqgqX88rFB13rZlri2IFR7XkBVT7tZA_AUiTU>
X-ME-Received: <xmr:ajzSaldtTLwCYTx0mv79UGpSvtte3FuAtNPTCnQYSVpJ_hkjJuv4alUelnCPeXxbxGqKPx3L_e_hwmuY1B74KQ6-wqjBFcuRofth>
X-ME-Proxy-Cause: dmFkZTFAdNc3vHZ009qQR5lxL3D3KxqK9y8P6DiRaqD3qII1yE8DyiHuHEAeLNVL162+7T
    5xQqGZwM2/F8nYEVpxHEmH0JruDk0fPsrqLRAtUvyKQHrRoQTYmUJ3EivhL5IXMBU34ypG
    ju58rIoOJsiuzInoiRHk52aBHXAG8CxSjmsTDS7DCmhP3O1iSNhxOpMvgzblbCztqkixv+
    RlpAKsp1H7Ytx+HmhQtHqYX7+8dcg5YhbA70zatx3lGAWU0J67doZDyDKFt/tZvORPI5qC
    yyEunsecKxEKQunwCWc69gCPIR/u6b51pHrxRuWuWFWCws7hhXnREJdrP2HovS9MK0/9QC
    hZgqGjoNGHFE5HiwCBxs1sXcScQ0lcHBa2iqqXkd3g9YLfNZGsEAqd6nuWRFpjTudxCo4R
    wLh0BUMbWcB5V3lJ1cBV+Rdoq5qz6VmLAJDX274r2wDcUV53gQ8r6udsxztitHtYIiDB+x
    1v8IU+Bx6MnpwmzPax149SgFyHVHBdWXZ2D1GGVbpRi39laj6sneRWlhqoViNFZc/Ix43F
    lfZEJ7cwHoP8PwPweeHbKTAUNIMj8BQqOlqmdWs6tIzEkmUjYzPqkzAVb894l+Se7tbr8j
    q8Ln1j9g0MZeQ6dvDHi1ic7G3+FwPCJoh0+HpLTCZmirjMft4ThFy0On35wA
X-ME-Proxy: <xmx:ajzSahDGGu72bvggagyRXsOhkJSJY3xlPEsl3L9zN7i8rcb3HqeoKQ>
    <xmx:ajzSao_qWZO0kmojSUCw2CsSCNYJmOk-xEhtlDnOZJZuXLtkqZXdDw>
    <xmx:ajzSasKmbxKlrd0COYKFmW-MdhAWnDwcq_5vAwH96YETs-bhocRrnA>
    <xmx:ajzSahhgH6hMUUayQIUWgy52uCnLB2Qq2JRdQzc4HrQpvyEuMzArNw>
    <xmx:azzSak8GBrh1w0Z3q4kjQaHrE_1Ik153hkipbVvvAObg9sqIKYs9s-nT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 11:02:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: jyotish kumar <jyotishkumar725015@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] pull: custom fetch refspecs and fork-point lookup
In-Reply-To: <CAGjZMyR7-_T+maSibej8cHn3wdWcYzbuQ94pmHj=MAdp9g-2OQ@mail.gmail.com>
	(jyotish kumar's message of "Fri, 16 Oct 2026 15:47:33 +0530")
References: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
	<xmqq5wz4rthd.fsf@gitster.g>
	<CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
	<xmqq4iemq4gy.fsf@gitster.g>
	<CAGjZMyR7-_T+maSibej8cHn3wdWcYzbuQ94pmHj=MAdp9g-2OQ@mail.gmail.com>
Date: Fri, 16 Oct 2026 08:02:00 -0700
Message-ID: <xmqqv771it93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jyotish kumar <jyotishkumar725015@gmail.com> writes:

> Hi Junio,
>
> Thanks for the follow-up.
>
> I followed the link, but it appears to open this same RFC thread.

What you are missing is the recipient of the message you are looking
at.  It was answering question by Harald, who asked if the issue
(which I asked him to take a look to see if earlier discussion with
him was relevant) is a topic you are working on or something else,
and the URL was part of answering that it is the former.  Of course,
it would link back to this thread ;-).

