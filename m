Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883622F4A05
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418377; cv=none; b=LmLmjYestvYUF4dnpse/ieRop7DmwTNvLYZLVrZMS/XV7RNsqm/f6Yx79zivSzF670OxfpSpCZPruvuWV/Q0ud2X0RuxXXo8pFARWXvYMrlKWvR+iplnfA/73E3hrs/rQhk7K+2kF7zOMC3dXg6lJkbwuhOAQ81aTWq3EaLE2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418377; c=relaxed/simple;
	bh=Oy+iS39aRqLBNdlKByvbFoAl0XVVEs9oAtNoF5i1STo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lal00WdwHbKpGfVJW+90F0Jwwa8VSQd4xd3lpMoWzVwC31XPMPXoNnmhESXP2ka+50gv5M49vHxRPpDrfInkb73QCyfqVy+5n63djfgbtrVOxZGuqL456JYlCN5AfCM5Bqy4hqnXd/ycV3STda8PqJ6CkjHy3GNeZgdKNazrvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WTRTDHOv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dx8X9wPG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WTRTDHOv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dx8X9wPG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 84311EC01BD;
	Mon, 10 Aug 2026 23:19:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 10 Aug 2026 23:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1786418374; x=1786504774; bh=ZmVpnggvLRgm0sUgznxLzI/aCiEbUwJB
	H/kWiXv2yXc=; b=WTRTDHOvoj4RHIKdjfY8pLwwRqAXVRJ7LEyr+BA9xECZm485
	mdMBcrruVzYqROiy5aCq1dYIHGTnpMnv6FmeJ1zxX/lsPFIkVM3zNzO2B+x9L6L1
	Fw2clvVDGixp5ufL+xNLWzLpzNnxJ7+1r9m2VnaScpsg2VP5K1uKL2VhIsHA5SSs
	VqzyCo9kvoDsC/eI4aGReyDQwrwvuqh8fpRcTkVWQt0KZD+qqkZPnem+8mFoiI80
	ggs9ylrtcFgAA9EIS0lT3hx+nEfLEdYP+VDv54ledNrD+jmsOVacPdR5zZJmVVyv
	YoyROA5TzXXTKJHBTDh182vQFp3tzFMsWAlhqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786418374; x=
	1786504774; bh=ZmVpnggvLRgm0sUgznxLzI/aCiEbUwJBH/kWiXv2yXc=; b=D
	x8X9wPGfJc0YLkqz5Jh2p+tJ+FUbxw6W2pUx8rACMcqMyr50lDD1rAv90Xdt+6mO
	KV8y43smxry/A49SYbQjS9m9GDHAd7DiMnrPCCjqdfT88Ea6QehjqFWSwHk62llU
	3FlM/kcpfZLwaScWmASqUhMSk+cV6PaoG75cEj+pm07Hs6ZMezPULSaSJokbcabd
	eFruTHiCxmSuna/8OIsf4Sw5+KEQL8Wn35iuwD9Xd+XYtI+JIhwoiMAKSCpkv1PI
	oX1w9DXzPFY9nwga2TrGoC4+L/iZnbELc0/dKvqgeDhT+zqU/1h3AcBtwIdgAbF1
	S/V4O3J0iAiRzS7pqEXeg==
X-ME-Sender: <xms:xpR6aqxjxwOAZ5cin8FbyOcpM-GT0U2Z9yBICmx6N9T_pbDpQIpZJg>
    <xme:xpR6ao3YtfyJ9p9shNEILsvK0cTkFZVW0gzUMrizQaBt-GL5SLplGYNUw8IZOFBVg
    0dvDnW11icxelH15c6ph25baCsbofKa6d17d8F9rTe8vmZKHDGb>
X-ME-Received: <xmr:xpR6av-2FWlM0CaHyPdoaf0W2PXwL-ybXRRLyl6Y1Ws-yvE7vgNcTGGLV6EdF42Zj7RA52SJ5bQRc9BWLxxYX-RuxDPxkXVaxQ>
X-ME-Proxy-Cause: dmFkZTFASVdjMhz2zyr/UXQFlMR42dEY+eTMMZLiQqyrDSpK8vjKhuPhK6oZu5OlUDJtAV
    so3NUHU6RdibU572GlMq0tyXngICLWF3cUpXQsii2TO/FGksOOZ57swn5k9MG424k8WPfX
    2/orATW8PH9cHi7snrWY835TmNr3Hpf8jV9utNb7qv5jhDjAwZK063yx4HmHjIL9ESiL6N
    LggluepT4vOerY9ZaV3dhwAzbpt2/6mDXph9wGvzMDUsLFoA3mpunA+4qbiZG9aKmvRQbX
    Rjg3Guj8kuzoReWTeUS+/Tj3u0EUuMBLPkbODRQ7BriqVHXVZBpzrYhL7rm+caH6RfCxsO
    E5rJw5Pq6KbQJ+YxGsxupGW2wO26i/shJe3N4QWoS0OFcMc/60kMVJIXf/EUCinpwTQTwX
    pNDImQhp7Haf+rdK/rF/WEv3tuLuEUyXL/CmdmSWQEWlY6dtkp9Tc3iDQEVss7+i65Zpr/
    BeBZVq+il2wOYamCf51a6MHXntkZFpeQu/ucxZFreHNi3k4HJHIdLw8oUpYfLxyeQnAdSj
    2zZRarCXtV/1ANn1VF8E35OHAj5rRu+3YSCAx13xKwO1PEldmBkd9dOwP0LtZM4ACueXgo
    N/P9grrdsQ2DlMwZ/ZDkzPiLZUNlZ7tgWzMDDAcj0Ag+YOSrsPgvOUOvf67Q
X-ME-Proxy: <xmx:xpR6agq6SCMEACdLPhBr9iiuyFsLY7TmtgrnVMUUyMM-Fg4Y5e93xg>
    <xmx:xpR6ahRi1AuGgXSXBYA8Ykx_-A234jN-KYDVSLzxzHRYppmMZ_1k5Q>
    <xmx:xpR6arNwna1eVCf57FJBb3-D6tWc7AAm4vIwz7jBqr1U8iUT7GuiJA>
    <xmx:xpR6anjKVEdrshbVxWyDjmtmL5x-HtHQe26Qs_KO_KNQ7KqnweY3Mw>
    <xmx:xpR6aveP4yYpCHV4JkpOHywCCL9L5j5i5DxrKaAzRO13oTsM9C8l9SMe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 23:19:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>, Britton Leo Kerin
 <britton.kerin@gmail.com>, Elijah Newren <newren@gmail.com>, =?utf-8?Q?Ru?=
 =?utf-8?Q?b=C3=A9n?= Justo
 <rjusto@gmail.com>, Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com> 
Subject: [PATCH 0/2] completion of 'git [-C <dir>] checkout'
Date: Mon, 10 Aug 2026 20:19:32 -0700
Message-ID: <xmqq7blx5oor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Continuing from the previous 'git [-C <dir>] diff' series, these two
patches correct completion for 'git checkout [-C <dir>] path<TAB>',
but without falling back to untracked paths, as "checkout paths out
of the index" is by definition about paths that appear in the index.

 1/2: completion: no-op refactoring of checkout completion
 2/2: completion: complete tracked paths for "git checkout"

 contrib/completion/git-completion.bash | 86 ++++++++++++++------------
 t/t9902-completion.sh                  | 27 ++++++++
 2 files changed, 73 insertions(+), 40 deletions(-)
