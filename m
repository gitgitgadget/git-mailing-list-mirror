Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7131960A
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270212; cv=none; b=Tjj6pOwmJ4cKaSoGrDV2MPmjtCekRF8xcfGK+/VHAaHYyHQFaInTkupetcO+tAJFYYITEuEzVpPdi4kRDobpZz/odt1jAUFwnL04d6NHuBMT6tuHg/kA46RtMz3ZUv1a7PepDd7nOKoQdZy5EqvmSKrxtUwf7gTAGDhiObFZni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270212; c=relaxed/simple;
	bh=PM9d4R+AzLD2uqCa+L8XAeYj5xUpBGoI5wTABK4nvnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8n2qgqb84nzeKPa58xDFXVt6WSlbuOlAidMwQJpttAPKp8Ix5JTMTsr/hWpPGKmGCyVxum+YP56Ovurt0/9SUVANO1WCq2DoFCi7zvabVdmr6gwqYHXH81B6HOa2A5r77KKZ+a9BeGN+7sPQvT8Ocbl3PO1fZsFrG9RfE0vRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KMMH/1S3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9RWGons; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KMMH/1S3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9RWGons"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D876D1D00215;
	Wed, 15 Apr 2026 12:23:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 12:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776270209;
	 x=1776356609; bh=QvdS4sXHZnsTlgX2+qSn1erpzSoOTnLGLc17WXbsSjw=; b=
	KMMH/1S3dQpH/I3vOd4c1up9pRXY9+N7UlV9kp6ZC2fFL3BiPLIw6cnZBiwBmzEl
	gGugAEn6u54HHcpLxaiPnuPqL8BbivY6W++czVfQI8NKtV1DlhBwcUTF6wb6kNc6
	FmVdPFaMWUd0RUyVCj/pN9qmZaUDD2L9PYsdWUoAWlCI4lOPpH9v63zONbm3h0pl
	LHKJfTKjeMHTDum7oPXdg1nXNEMgC0qFa+iigH/vcjYrJbLJU1hgYsfQxTrY+8i4
	B64h8ntzlUXoZ/xbr9bH+mMS9E73vMR+gdHTM+Fg19GuJh1P32Vu+ntqD8lu2nKg
	tSE5OGTFoURpzylUlakSSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776270209; x=
	1776356609; bh=QvdS4sXHZnsTlgX2+qSn1erpzSoOTnLGLc17WXbsSjw=; b=P
	9RWGonsufLCECilGzr363gwTHbHG5w7Y61K8FTnrhe454NnQ1qA3odspJmieeq3L
	q1f+J7yKAHuMUGf/jHhSClxw6oZLIwqO8Pzh1NuM3GUG22eGyQvf7XVo8ArrEPR5
	5Hc4yKcS5tTX0GSd5hz91ahpYG1c9fUMiTUDP6nNCep8MLlYwAmNUm7Pq6QCy8i/
	ibUFzQl29qOZmbVjYVlbymJRA5WhohPXdn0YRYVqFsL30mjAMlTotAqxZHaX7zVQ
	mYz9ogysWUDXh5cRpukAzO8XtMaGuHD4F8X5/gbu1Gzo/YEQCxQvZx+2Z8pz+hEs
	ZOlgOqiSfou4sJ/7FqDXA==
X-ME-Sender: <xms:gbvfaVn-Q0g7S3iEwsNXeY6olWcGkNxmD-XdLhgLDYI09XsTIsOr7Q>
    <xme:gbvfaX0CsuZGp-4yEZ9yVoYkxmQmm_GPHbZli9IYmTgN1U93UAtID-f1TIIG-u-ZP
    6F258COIicQ6NwC7bAOdn7Rlm4N5mwvNho0nJhBK5Bxtyh8iTwbmyQ>
X-ME-Received: <xmr:gbvfaQprLUcZdA0fkduzf-gPB0huWCNm-AZ8U8PT69iHld8iho0rClGGSNlP_ZhSzP_4ywH7tWDRC9kG_VB92QMruymhUfx9Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhgrthhssghinhhovhhishhhsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gbvfaUed2U4oDn3onnB5PhxX5ROIgIQCXrEQ0_PMc2D-iDzUSURaaA>
    <xmx:gbvfafr2qlIG88euFBkWOardquwvb68dnZ69d1UDNQ01SeCaGhp-kg>
    <xmx:gbvfaVESvpXmUVp2NVTAy9AvQDW2CwB67NUQquzwR4izcDdTMi8zTA>
    <xmx:gbvfaful-S73C06vAKtNjo6C9_I4m8wMw8sDvlyh6uS26-glsTesIg>
    <xmx:gbvfacIBVzOVDvTrH6ADEhabVNBcAF4zsKMVwqlwCQ3IJYceiuiKHevG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 12:23:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: JAM <kratsbinovish@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] worktree: add --recurse-submodules support to git
 worktree add
In-Reply-To: <823d30b3-b355-430b-b8af-c8421a87b0aa@gmail.com> (Phillip Wood's
	message of "Wed, 15 Apr 2026 15:05:07 +0100")
References: <CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com>
	<823d30b3-b355-430b-b8af-c8421a87b0aa@gmail.com>
Date: Wed, 15 Apr 2026 09:23:27 -0700
Message-ID: <xmqq1pgg8a68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 15/04/2026 01:14, JAM wrote:
>> Back in 2022, Glen Choo noted [1] that git worktree add leaves submodules
>> unhandled and suggested a --recurse-submodules flag to fix that. The thread
>> went quiet. The 2015–2016 discussions by Duy and Beller [2][3] had flagged a
>> deeper design concern: submodule existence (which worktrees have which
>> submodules checked out) is tangled up with submodule configuration (URL, 
>> path),
>> making per-worktree submodule support tricky to reason about.
>> 
>> This proposal sidesteps that concern entirely. Rather than touching 
>> submodule
>> configuration at all, the idea is to reuse the git object data that's 
>> already
>> present in the main repository — the same thing git worktree add already 
>> does
>> for the top-level object store, extended down to the submodule layer.
>
> I'm not really a submodule user so maybe I'm missing something. 
> Worktrees separate out per-worktree data such as refs like HEAD which 
> are stored under the worktree's gitdir in 
> "$GIT_COMMON_DIR/worktrees/$id" and per-repository data such as the 
> object store which is stored under "$GIT_COMMON_DIR". The proposal below 
> appears to use the same modules directory for each worktree so if I have 
> two worktrees A and B each with a submodule "sub" how can I checkout 
> commit C1 in "A/sub" and commit C2 in "B/sub" when they share the same 
> gitdir? It makes sense for "A/sub" and "B/sub" to share the same object 
> database, but they don't want to share the same HEAD.

True.  I am not a submodule user and do not have a strong interest
in submodules, but I agree that once the superproject wants to use
multiple worktrees, the submodules bound to it inevitably need to
use different worktrees that correspond to the worktrees used by the
superproject exactly because of the point you raise here.  They need
to be able to independently check out a suitable commit in the
context of the superproject's worktree that is checked out.


