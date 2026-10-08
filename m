Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A991CDFCA
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487158; cv=none; b=siA8tEheT49+maVZVFADp30hKZXoozJl3F4NZ3u7MNGwxROGJE+5GNlVDiu1TyC3EADswutij323tTeLRFAyu6Ajm2fFoNf+Lo4bADElS3t0e13V/r4nAz4KQlPj75zRoUCGnGcYDM/3Ip5k/Vs+42WpLZpIM2vNLnGvOrsbSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487158; c=relaxed/simple;
	bh=9g+rt05aWlHLfuqFXymAPhkMNuvmeiSlU7kid8YDR1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGYqGmkZFuUIPkyEm7Dlbj6GGv1SsDr+2mV6KxDfS6o4EYq0k7nUqHVjJ1tTwNMdKKVgBMJkoI4tYNpcIaJKmcgwn8FrTAZORbhl3lOwHs+FmMYnSyO0OSIL4OlfHuBo/hf6tyZHxdKbwEUN1DWa+vSOiqEnErF9Ale5KdF6GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gzxFuDp1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lb52kYmR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gzxFuDp1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lb52kYmR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A57F61D0006C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:19:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 15:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791487155; x=1791573555; bh=FrO01sUzXt
	/jSFtmJezINUk0asdC+DE9XymsWzSGj3E=; b=gzxFuDp1Z4/dnhfzow8uTsplKo
	82wTMGvgwJA2RNR7/UCT6vJcaintA7E4AooBrIDnpO4Y3QTq/mvT5kB/Q7GHbqXH
	g92br2RGLGO/HDgeIhxUHZaZJJTFMoNo7n4xkdyNqKxcgrp+sT4bI9FX3upa9vL8
	F+rfb1EsdaFEpC4q6DuYiXaNz4XVSLHfbnloimXo+cdy8IuUIkE6yjPLGI2FIhNr
	M2aj4uA3onjbRUsOF1i6hjqFD5iw3eIiENNPIUOcsLTq8O388eUNaXWztTgNHj/c
	pgAr1TE3Tsm6SMwwuGsqoHMIdttW0yIia/dcL8KvNhswOMmUY6OORCteWEbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791487155; x=1791573555; bh=FrO01sUzXt/jSFtmJezINUk0asdC+DE9Xym
	sWzSGj3E=; b=lb52kYmRIZkwziKFEPRqoEJBGdTrSkwRqvtChkU7cfRfJmRaJ8R
	MEJJxgohPPKkgyc7KytrL0RwC5WNUxRyWmASSS7YYsmN4o9OIfV562+kaL4B4L3y
	SUzqB1gF6N3o+Mq3l4LaeGrlQ5goWgAh0Z8zAndMS0uT66DzkEfJMfx/HNpekZrw
	ZiI8aT7ou0IuHdvw/FWs403+EhQUjFcJic5UoBvHCvfUbOxlO35AO1VdyIsidK9K
	D4OmWSOMzX2AEVYeUYo1FIi3iz7af+f9r8ykjKExbLGzePgRLPltMFWnfQ5p10VF
	kYoi6yeaBcXTz/nY1qKLZfzm6VhFrn0K6lA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487155; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:J3P7d9cd/oUPIsVUtNjzNL50rmZgz0dHxcyfZIPxhMOQ7Ua
	6U5Gk6L4nDn7mSYQT5JtNCRdr5O9o6BpIldL8//tPG3I0oyIErj8ktJR0jk1slih
	3oGmxwtVESKbx2eufPAx5FMMiBWcYD9S/JW1uI+RgPaX8eQ3vYtC1gVM9HQAiONq
	zQ8Bqqn5qMo4yZvzYu5/+ljcD9WKsu44q7y+wcC2VslAi2E8CEqHY4c0COuZlQmD
	CsuIQUOkTnShOQm+Hiv0CoM7c1saDdHaY6oSSEYShlVeaNa7s/UolHRPYHGF6xuG
	t7GLY8AnU65VFqkekFJJx3FG/eFrrjct/SqJwOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Br+owB5Pe1j94N9tmZHmKHu31+yzg2G7QKu0giJY+Ao=:9g+rt05aWlHLfuqFXymAPhkMNuvmeiSlU7kid8YDR1E=;
X-ME-Sender: <xms:s-zHakHTc0_FViPp6YDl7Zt0u6wwwwML43mTqEveSY8thOE_fejATg>
    <xme:s-zHavlc1wDN7BrMZsI4ANL2RPVT0Q2Ty57VTmqalG0virzVEbiiLWng-oVvCqsBA
    xfE4irGTegh30Q28p_MICtN8Sc_SSb-pTq_RF02ZuJWFxJgLGO7QrA>
X-ME-Received: <xmr:s-zHagYoCmi89wNmOYmA0r1NNxep13OnU5X9HstMTY-DnxsxOwmigLD8M8iNmOS3jEYxLnZocYkGiEBagRa0Ph9Ux_5vxGGkHWEC>
X-ME-Proxy-Cause: dmFkZTFUf9phGKYaPXJJqQjSDEXsGOWV5cO5hnJFtL2ZEKZP+fruX38vFopB+n7TfPHmt4
    ceuvkQkvYLy1EwjcESchqLSD8HBbuoA3y3emfKugQcZcuQ40SsPy22GwE0kBoov++m0pJy
    1FYnhjEsykJ1jL2b2Xa/rq6bNVla15TVPm0dMhF3DyPUNgJxPSBLde85C+LVuDMuXB57UI
    OWpkTpY5u0b7Sexk2zyjqyz/O8fVQjqgr6Ucwbww2+Y31W25bXijMPnwechYTdQHx2iVSB
    FG3wz95gnEyVLBEcdpucbgUX5qqvE8aAyz87Gbba85LKI7vQ2ArRDo8Ki3Q4FVnv2Hm1g7
    IwFyU2Ze0uz+SD4KfwPNnR/9eq1+wQM0BXisNoEOYd4QQ+3XpPNOQOdbuidbZrMr+RJF/v
    QSWe2uME2sljAtyu9vD0B6mNctFtzcjudOATLtPgvcPkVLmx1SYxCynqmuReNuVy3JPm/s
    Ei1ycLt9J/bxgCGSHvAi8GT5+Zf8yV+ZzhGVR7D8ayK93klPa6GgT8O4FFYM9qL/5AMME1
    wMCuvTLIoaxrGtka1wqttQjZ6buGdaJuKV60ZTk3hQdqnycsqvugyvIH9YzIMezKzD4oOv
    g+Z9yJ0qOi2KA++WagxJ8hrFEyxP7hOB+AkS5tTaUwuYDtMLi/UEblUEUBhQ
X-ME-Proxy: <xmx:s-zHasHcfxQZpDby4l_Cq9wCwmAMi_wm_Alvpzl5b7ttsdSSubL76A>
    <xmx:s-zHapI4Z8LsrbkkOShG11qPbL6gocWDZonYd3a_O7X-X2-RJ6SFpg>
    <xmx:s-zHavOhq5fEG3iq3Ke5o-jtjMKIAlThZiqFDtC9ec1eFKJ299zTpQ>
    <xmx:s-zHahmickHNZQJ0Q3eAK9HxB25moVo-YsO8E8HEn-svYSJqT9oCuA>
    <xmx:s-zHanlnllQQ9G4UWL7CxtNpA1wyqxp07DIKJI2T13K1Nnxqgu1jrWwI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:19:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "qeesung via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <ttaylorr@openai.com>,  Justin Tobler <jltobler@gmail.com>,  qeesung
 <qeesung@live.com>
Subject: Re: [PATCH v3 0/5] repack: don't lose objects to a ".keep" that
 appears mid-run
In-Reply-To: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com> (qeesung via
	GitGitGadget's message of "Thu, 08 Oct 2026 09:52:16 +0000")
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 12:19:13 -0700
Message-ID: <xmqqv77cyp8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"qeesung via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Interaction with topics in seen:
>
>  * ps/odb-files-alternates turns the list of object sources into a single
>    files source with a list of object directories, so
>    repo_invalidate_kept_pack_caches() from 2/5 needs to walk those instead.
>    The textual merge is clean, but the build breaks; this resolution follows
>    has_object_kept_pack() on that topic:
>    
>    void repo_invalidate_kept_pack_caches(struct repository *r) { struct
>    odb_source_files *files = odb_source_files_downcast(r->objects->source);
>    for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
>    invalidate_kept_pack_cache(dir->packed); }

I do not know if you meant to cram a function on four lines this
way, but I suspect that it may be easier for everybody to stop and
wait until the other topic solidifies a bit more, and then create a
synthetic base that merges the other topic into the tip of 'master'
and rebase these five patches on top of the resulting merge.

I wonder how close ps/odb-files-alternates topic is to the finish
line?  Karthik did read through the initial round and then gave a
thumbs up on the current iteration.  We would benefit from a
different set of eyes on the series [*].

Thanks.

[Reference]

* <CAOLa=ZTjrzNbuvZ-kr6k5TZSMyGGMFTb4iar6DZwdnCDvUrH9Q@mail.gmail.com>
