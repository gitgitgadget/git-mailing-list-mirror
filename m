Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD9A1F8AD2
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247551; cv=none; b=Qcn/+yzFDfwmv8Aj5MYY6GVCmV0rPzbrVXxw39YreYgxAOxcMcFkIjg936BQv1e9ZDGFVLR1UZXNwC9IkCZp46yIiCN6Z/ALOikuqkPOEbMTqjE6DoygtMOpaiJFHJKqw68RNLf6uhrMMnSYlm3vPlLpF1T9isD4gGP7DObNsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247551; c=relaxed/simple;
	bh=VbjLzdY7nKK/PYUUMbAbgjs4fO5G3swzp/444gntdfM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sq1qr/YAYnNbswcLPgDysVD43hZk5WzxmekXe1jHED9r/kzmOX0CqeYwfHqO/qCfwOdISsSB8E5+LkhgSMLl0YO16Fn6EPOaxSdQqdO6yLepYPTo7dBDafhxOsdh+0J6MNU3kNuvytiaTVBUH+J61Qjo8wtawOHBOTjikxDDCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T9YXnPSa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3sHnwvPd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T9YXnPSa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3sHnwvPd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E26C11401B2;
	Tue,  3 Dec 2024 12:39:08 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 12:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733247548;
	 x=1733333948; bh=ysB/YnPq0RqZQjOOfvLT1395ue7P+504+kzfHZ9lH8E=; b=
	T9YXnPSantIHGq7+Iu2Hf17rpmprTwF8l7Nf3Qk2pYFxLV7RNpL1MkmUcxjQTezc
	Ktt6clK2uHIRWFLOV0wXfGRhfMZoOsgHNnG+ENRfcBOHcJeAlIDEz6ndxIpXckPO
	SurKJZxwez8eFo5G4VgIG/MQPlhfyDlehJiDJqK0Apc6ozoU6Yo3DeKfl8Ui2iR7
	DITo8xn4/Wv2flfqRdUM6cINFjZBVhLHe6bd8sV+yKynFlaLBcqYs00vJ31voR87
	X9dAF32Sa1QOzM5pgjBI5wbAnnVXmT69W7PaOvWJ74EgCTJc1I+vCW+eU3n+4iJk
	dT31rr6dmYvoEsFFEso3RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733247548; x=
	1733333948; bh=ysB/YnPq0RqZQjOOfvLT1395ue7P+504+kzfHZ9lH8E=; b=3
	sHnwvPdlSAwUAQLl0tJhNEWDeuJyfKsm71wMmoAhDIGO8z9DGslnBxeiuQvjXpOx
	fu0D0L+Yo6JgqSTw7Y+btic7Vgt6flJxLx4hqJc0y0dWlhUL+kS4Tke2K8OJFpYE
	rJxggdFp8lRMa+ZLkdQFzatMnLq0InxbqcZ/Zmx/J/5/qoLY4aeWB0//yITGlo/L
	NPgr4SaTLFuRtcEMZlAowzaK8gYapkp9FHhjqhY0OGn8nx9XFqUysCqoct7PoiK/
	W2vt6tzGGL/cG7Vlcr+gEdhyrpxiqO2ovZaeVj/+FTdMWclWhagm34ttODVOSkDf
	fn3I9N0iPbqhHy83q+JVA==
X-ME-Sender: <xms:O0JPZwZhOSsD4j1nL8TvFssa8XW1HOc3EIEyYCpKrYxGwgb0810X28w>
    <xme:O0JPZ7bPF-JNUSbkhzTu_kd825d3uhXUvV-cSLh9EqFCl_qSGMeSqop5_E1DVycLF
    -pkgifao3S-BxXSwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrihhkohhpohhnvghnsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O0JPZ69M6e9iq83YQEoMoPVdHb0mcoAvto0R5ZSMci3lFj4WKqdx-g>
    <xmx:O0JPZ6pMcnmvhj2VQtrCSaOlUi8FIg-1CLpkXJllDqjiAhyWmfAgOQ>
    <xmx:O0JPZ7okh7umPVlKBqHdPrYjZaQkZeMIGLzIe3GIcBkygLLBO_cG6Q>
    <xmx:O0JPZ4Rb6OuoiNOkTHId89V6-fkKEkqNWnbcHQ4hxzZKI8xO7X5BSA>
    <xmx:PEJPZ6Uth9XsrMtdXd322IfnVEykfEUpni0X43x7VKMd3FXpa7XAqBop>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D311A780068; Tue,  3 Dec 2024 12:39:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 18:38:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Kai Koponen" <kaikoponen@google.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com>
In-Reply-To: 
 <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
References: 
 <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
 <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
 <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
 <xmqqfrn5h8zj.fsf@gitster.g>
 <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Kai

On Tue, Dec 3, 2024, at 18:14, Kai Koponen wrote:
> The rev-list documentation doesn't mention that the given
> commit must be in the specified commit range, leading
> to unexpected results.
>
> Signed-off-by: Kai Koponen <kaikopone@google.com>
> ---
>  Documentation/rev-list-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I couldn=E2=80=99t apply this patch to `master` (cc01bad4a9f (The twelft=
h batch,
2024-11-27)). It looks like it is because..

>
> diff --git a/Documentation/rev-list-options.txt
> b/Documentation/rev-list-options.txt
> index 00ccf68744..f0a46f9da5 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -412,7 +412,7 @@ Default mode::
>
>  --ancestry-path[=3D<commit>]::
>   When given a range of commits to display (e.g. 'commit1..commit2'
> - or 'commit2 {caret}commit1'), only display commits in that range
> + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> only display commits in that range

This line got corrupted (linebreak).

I see that you used git-send-email(1).  Did you edit the patch file
manually in order to add the quotation from Junio below? I=E2=80=99m gue=
ssing
the editor then broke that line since it is 102 characters when
combined/joined.  I guess you could use cat(1) instead.  I like to use
Git Notes.  You can add a note to the commit and then use that default
namespace (commits) when making the patch.

    git notes edit
    git format-patch --notes=3Dcommits ...

Although in this case it might be better to add a linebreak since the
line gets so long. You can add one short line so that you don=E2=80=99t =
get the
reflow-paragraph problem from the previous version:

(these are with space indentation instead of tabs)

     --ancestry-path[=3D<commit>]::
            When given a range of commits to display (e.g. 'commit1..com=
mit2'
    -       or 'commit2 {caret}commit1'), only display commits in that r=
ange
    +       or 'commit2 {caret}commit1'), only display commits in that r=
ange,
    +       and a commit <commit> in that range,
            that are ancestors of <commit>, descendants of <commit>, or
            <commit> itself.  If no commit is specified, use 'commit1' (=
the
            excluded part of the range) as <commit>.  Can be passed mult=
iple
