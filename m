Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC393812FE
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896333; cv=none; b=bCPFAEKSwmj4b1rGGB+1GLWB/hCLTefIC8s1V4H5DZLTjoGVkV1302t8XEBuzCrL4hBpk6GgpmrN6IqNnTO/r0/EsT2O5z2uXbv3Ywg6D8ZSIkLecH//fI1PFeiQQnED3jlWD3q7WZoyyo5GrzowaRHKfAK1MDfxKPhgmeo/UyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896333; c=relaxed/simple;
	bh=tUjGnl06O4fiCY30eZRXdorgBjUaPIgD/ryuBsv/z7g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HVc1hsHX85jJwGN1EePDwhOiFEcIwC5fHDjEk4vyPQDfhg9n+ncuen5JLgrC1FR9oYcUBc/ldsbu0HZVKgn9sF4H1SGQfW5bKG12rIBKtzBBWoDjU0FigmlOfTTuw16soYDOSlwXGlXrRld67RTyHgjsnSLzIGPZNa7xHlh4W48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=H25unSwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DF+xjt+s; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="H25unSwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DF+xjt+s"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44AE37A0167;
	Tue,  8 Sep 2026 15:38:49 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 08 Sep 2026 15:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788896328;
	 x=1788982728; bh=+9ydDprnenCIcG6myqSbuWnIkAzmwVfrWTKrdPCWWjc=; b=
	H25unSwXhlWosP34tcTdpZG6VVGWQrBt25SvAgRuZGC248Qwc5flwMu2rV0gfBXj
	aF+0qGLzJbXC0aP2Ov+jgibgN0tZk6BiZeUWcK8MgKhVniAw4wX1oubNXkIfpvLl
	fmfvBDyY1sP8St26KzmpEWQQQszgleKcUHmvsHzlixkiDkOKczem0LjB+pkbvd6A
	Pvo2hE8J2PKxdzixEyJT2kcg5RbdyKG6uY8N4yf1AwqcozLgcCYmt7VEg6DKq4qb
	jIuyIDBR9u9tuTdj+Xv+ES+2Ue5urcLEWKcaWiumTwYd1MBI/bPL3SBeaQYwABHp
	1CpncZiAzy8PNoi4Svgnfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788896328; x=
	1788982728; bh=+9ydDprnenCIcG6myqSbuWnIkAzmwVfrWTKrdPCWWjc=; b=D
	F+xjt+s7YbU//H0dyouNFjqtEXuuKYP0rZDj7pt9fN9oa7O9mnyHUbG6prYl0h3x
	WYfjrwvHcimCyJYISJR5an7QiQJqNzhj3eZuGzHR2v8dp4SAZaoHBfHRIGTTaFeY
	YRnN6FBNULQ1BGbMpRcXZ8SyT7YHE9YOxrpFOmeKo5ko6RXP46uf7H001YWg29ys
	51hMo5Y/sfwDDj8IW0VzcIYgKrpXPX/LzDF5+6FxlPSCxJaoOvkXI8RUdAqS4AgM
	0dS00u1szb6zB3yqSZnbjry2Wo1/NtVOKD9br6O3S4tZ9rVu3km3LC5Sy9omqkwL
	2u8PqDgkfZ7lUn8y1Z+Ww==
X-ME-Sender: <xms:RGSgandExRqDlS6nQTo6BanCVh2wJ0VYU1ZKBbjwYxVaBYoQhOLq3es>
    <xme:RGSgaoDkw8x5aDzSZkHRVkXMVedBeD37oS8_5sDGoFtB8JjTfeAM9UnemVDFQ0Duo
    O2cRgyYKPAVKtH_-KeYzPWVE4SgJi8dSERSwLzDyE548tLuHJ6r4huZ>
X-ME-Proxy-Cause: dmFkZTGZE6JszziBa3u7oiPEPs/xRrqPZsjrNpMWZsgazX30WuYWTnQr8kuQWhawS9prdB
    mAiN/+a5KoP3WjQucQ3HgQXv4Z/q7vhrHM6BzzZJeJFmuyS9cGjgTWSE8HIeHjlai2cA9w
    4AUc5hRz+aO39HfO/OIF04zze4zaehbKELbCWLbxlzmCzp8ba+7cDKeIwhiP8AKGUH/+SU
    plaVrffq4wfid6dU/ovOsIc2haeAO8q5gmetEd6CmeEcWk3giZTpvZ/h+T8OU8EHPlrx97
    uvOCC9EiFBaB5P6yMOKWUDqBuG/rKYnjR5oTFYo10QbXEiaAvqWxTv+It9Qo/7fJtngDf1
    ybpskLUTvivHKI79wBFecyYi6OGTXJkE5TuBzHfd7N21C3NAZV9WgoLNZl7P+aMuct+wqm
    Z+X+V+OWHPQNbMKyZre9NkENe2d6QStFU2p6yZEQLKYwceGS5xG9pkvyz8X3Zn28q4Qr6D
    7/7orexeJEGB7P332zdxT70S1QfSyq7uFyM0tzbJgfc1OeSVDgsrs9lHcXARXusMbRFXLJ
    E3NU+GDNQ19xA+1s8IwIT2Oo00Egj+RuZ29grO6z89SDIliq5JlsyvQqEUK8rGCYC3kdh2
    qymDQXA1bAEM3UNv1hH4m2R8dhc6JD2wPU0Lw4sQwr7xNV+TjHsdisw3DzYw
X-ME-Proxy: <xmx:RmSgas_BoVF8rCbXS4M0maG2VPsb4Td4bc2d4_R4mTo5h-l0UY6NwQ>
    <xmx:RmSgagt9iyMotyDsO5SvQd9YrcyOz4c36EvzLtll7YuA_yXGOgittg>
    <xmx:RmSgakNwo8dckN-0OmdOzcSqzIlKYvPks94VmuCY7AUdupAai_c89Q>
    <xmx:RmSgatje6qEm3qhz_LdmWOE15L-6MYbAyQBuqBRBXsL-IQKfi0Bk8A>
    <xmx:SGSgannRN0Fx-w5FLsSXBNN0G-Oivw9NjJQ_kmYIzGxXGHJ901FZ7R7Q>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id ED34522C007F; Tue,  8 Sep 2026 15:38:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 21:38:23 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Patrick Steinhardt" <ps@pks.im>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Thomas Bachem" <mail@thomasbachem.com>
Message-Id: <48495cd8-c955-45c0-bcfd-ac32e4a11154@app.fastmail.com>
In-Reply-To: <xmqqse3jyc2m.fsf@gitster.g>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
 <xmqqse3jyc2m.fsf@gitster.g>
Subject: Re: [PATCH v3 0/3] sequencer: leave auto maintenance to the end of a sequence
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026, at 17:53, Junio C Hamano wrote:
> "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Changes since v2:
>>
>>  * Auto maintenance now runs from builtin/rebase.c and builtin/revert=
.c,
>>    once the command is done, instead of from three places inside the
>>    sequencer. That follows the apply backend, where "git am" leaves i=
t to
>>    rebase.c (Patrick, Phillip).
>>  * gc.auto=3D0 dropped, maintenance.auto=3Dfalse is enough (Patrick).
>>  * config_parameters is a char * built once with strbuf_detach() (Jun=
io).
>>  * Patch 3 extends the tests of patch 2 instead of adding its own. Th=
ey also
>>    assert that nothing runs before a stop, and cover a single pick wi=
th
>>    --edit and a sequence ending in --skip (Phillip).
>>  * Commit messages rewritten: what GIT_CONFIG_PARAMETERS is and looks=
 like
>>    (Patrick), what patch 2 changes for the user and why the call moved
>>    (Patrick, Phillip), and the comment on the helper (Phillip).
>>
>> Based on master. Independent of the rerere lock fix in [1].
>
> Will queue.
>
> By the way, is it just me or are proposed log messages getting
> longer and longer with more irrelevant detaild these days?

(sent from mobile)

Here is my impression. Six months ago, an on the
surface thorough commit message would

- describe the problem
- describe the solution conceptually
- maybe the concrete code solution...
- maybe the alternatives not followed
  through on...

(and this is still the case overall)

That can lead to verbose commit messages.
But note. There were also many things *not*
included.

- What tests have been added, what they test
- That the docs have been updated (accordingly)
  and howso
- Maybe even benchmarks when they are not
  relevant?

And only in the last six months have I seen
commit messages that look like they are=20
explicitly filling in an imagined form with
a dozen or so reminder/mandatory points.

(Note in the cmt msg, not after it)

The most noticable ones to me are the ones
with the implied checkmarks in the last paragraph.

Those old school commit messages took
all the conventions and business as usual
(like adding a regression test alongside
the bugfix) and didn't mention =E2=80=9Cand we are
still following the project guidelines by=E2=80=A6=E2=80=9D

Of course, for those commit messages which look
more like code-to-English descriptions, I can't even
keep up and judge whether they are correct
and coherent.

>[snip]
