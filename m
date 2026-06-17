Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954C37AA9F
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729555; cv=none; b=AwZrrJlghCoN44UjnUMMDHNs2gH9y7oyF/oSvlNH6K4SKfwzU/6LxEtEsDQitEGjr7ARwkMM/QK7JJyvjFXX3nfM9afE9RS25kiMZj042DQ/lUF7AiapxYTP2bu/opTgxhPt0dscs5V61iAlqsA6wLsBFJZnrcTnWmHB91K7//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729555; c=relaxed/simple;
	bh=gQqoi5B+VUBVoFDbUCzznGV+e0nbgz9LTuyV4iRVmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsrXpOIF/l3N6064GYDQ1qohildpbyi8xHxctpQktCDNizWnxZns35BLt9HT7lGVPgVukCXxhCWZaXNmOYGE5YKkjQcNNU2VIa6zT/9g+8Ewn4RQOtU3KxOSRpnBz/5MabG2QsCrbLHYT8ptcGYj+yfGAVEkRxXzOcac4rTs2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UvolgY3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evtJlWCd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UvolgY3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evtJlWCd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC5D97A009C;
	Wed, 17 Jun 2026 16:52:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 16:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781729551;
	 x=1781815951; bh=heXrjO//0ieDbh4wuucFHZoTGBKreMIPMWjutKUPfAE=; b=
	UvolgY3JAY4zgHmHJ7G4WyIz3pIyC33MiR0DB9e0zffM9XBDlPraxjxY7ybdC913
	PaFvAtmy9BNIyPp5dz5xU/0vV7i4cg5S0e9HDhw6YWoj//SWfxGdrEsxs9yN3lX5
	75T++bRPXDAtwnTPTqaZvn7OmeiVBdMfeIa+dMJ6lMnxZF9I/Fuu86/V2mJKO0YO
	eh+D4WsN4aflxCuWZC9gpzTgwW7F/zxoxJre6BGCSt5nl0utMU4EXtBG+YLaE+Co
	1IhMp7kl8Dp/oLA/IvJPZdaJzSEu8/SOqxnR9fHk2kBbrC3/JUjITqV1KRtuZLz7
	Qr1UjQEP1dGVUX+sbSW0RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781729551; x=
	1781815951; bh=heXrjO//0ieDbh4wuucFHZoTGBKreMIPMWjutKUPfAE=; b=e
	vtJlWCdY0tHbEke3YpkKDYVQHst0QPAgtlWskv2pjXkwnIXDtLSn1cEPlQWRmcba
	rgxiulaSy2ShjizkD0VojfVfJyfFlC3PC7VVERpshgS1B4t/npurMwp8m9kdtZTs
	f1RFUg76U2acsw4nA7jEiDsXlrEiaxU5L+aezG5SGkQBzavzxHn9xGDFbTf3KpzQ
	co7uknP2C41U0cZ4ND6kDdnVT77FPe9Xx2XYWedt5psxCa7ZmeVYK2DZfLNOMwdB
	UIrTgBaG67346ajiXFmCA+Lg+MsE6MkCD4LDcOIvjJoj4k34j5OJG3e9qQGkOBsD
	OlBYgbNLXJFP0jNrraArA==
X-ME-Sender: <xms:DwkzahtJPQl99LzaMg9ILWOVO-23qKh1G0r4CddkkfbFa2-7y6_oDVw>
    <xme:Dwkzah5afH9JfLRcPJofPQrWhSaCrf57V953l5r3O08mCMNGSR9LdDhbu22MhOup2
    6CaI86CJejAVu6gvXqfTjci52OSmUw3vhbVzdaG-G2OO2N32xSvVw>
X-ME-Received: <xmr:DwkzaiJbD01ws58DeWBdtE-wOBFHQASd6L05Qy0CCHQidVGqlR8QhLEUq755mGbQRQYImJ6XlTNY391uijX3cm1u0Yo8r9or0fL-5u02YwuynIEr_vVxTbs0ew>
X-ME-Proxy-Cause: dmFkZTEAjnDpsbzRqsIgqUIzTdGUdXEO+h9xpm0hY1dN4LwFENS4EJFVcwuriADNcp6bdK
    ReECXoThdiibEO4PfBlP4EZnXskCCGlFVljs+QWTGWdugrTxDeB0xglwngo+ifMTgYfarg
    dA8ezCyO/zUBY+ncNIiaTrvZsXuM+ybLIYaakNkHhC/Z+8BimpUvZkc83uOptf8kqduXAo
    zEHyViJ/quLL4Bz5PgqgYjvPd7TVfYmOWXM5XYT1NuQBsa70xgL3e1SfTupjlqKq4l895F
    w6XoysdE1Mac2nkUaozitwcXWPgBF6JBEm+nS22v5pUf890ittmxrHoz6cS54+jIjKWiTn
    y3Q6Hsg/iuw2gChOsVlSlT0qfAAiGXf9ecKuQkMbM8xPsz6gjEmHv0QmFuNlMpvQIjqu/1
    QugLmSzXbhyCf2ky/7WGLjVHqc5/LRJkzYTeBHzOc722+4+g6QBS/7bQrsaq2EhE45jIEG
    KXhxhJeFEpxTq0+iemDlH1okMQfU7+f6EUm1pi47j7n7tH71Ncdjn+X0Xm4Qz4lMRuRJvO
    RmNvVyf7m8YPKrv/UdI2IpuPBsaWqMtbCeULYH/Lcts5h/HmRvZGzAF7QQ5xpIzPJ6CfpM
    zziPJaPGluW5J0VKabPQLJvLtubofo9JThiwLITrhXLmVaH0CyVRwItwBAQA
X-ME-Proxy: <xmx:Dwkzah7djAOwAaBm0wIcO_XzclQYoXcD92pU4vjaW69WFNPQZf5tYA>
    <xmx:DwkzalyVrFc3L1OEGx1Tp9o5EZEjj1Nms_q--msAFs5_tlWq7IL3cQ>
    <xmx:DwkzalbBDebHPeF-pInrcxKQjfx9XGR9S0Aev0dEA8KnysCuLKp55A>
    <xmx:DwkzanSfqYwTursNFrOUB7SSstgsbtqQMi3wYphhxUwx9EjnF7Nc6A>
    <xmx:DwkzaiAvtbLaoVWYE-GWRE15wskceMpMWoQaJpFICFrFqDRIBWaM67h0>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:52:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] SubmittingPatches: update and flesh out trailer sections
Date: Wed, 17 Jun 2026 22:52:14 +0200
Message-ID: <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied) kh/submittingpatches-trailers

Topic summary: Flesh out and update the trailer sections.

All of these points have come up on the mailing list. At least for me.
And `Based-on-patch-by` is a nice-to-have documented kind of thing.

[elide “since January” from v1...]

Link to v1: https://lore.kernel.org/git/CV_SubPatches_trailers.8f3@msgid.xyz/

§ Changes in v2

See the patch Notes for details.

• Improve commit messages
• Drop patch “discuss non-ident trailers”
  • https://lore.kernel.org/git/CV_SubPatches_trailers.8f3@msgid.xyz/T/#m53305dbb8c1f19b06be781ee720fc3be875a326d
• Rewrite “note that trailer order matters” to emphasize chronological
  order and to also mention it in the DCO section
    • See https://lore.kernel.org/git/xmqq8q8mt4eo.fsf@gitster.g/

[1/5] SubmittingPatches: encourage trailer use for substantial help
[2/5] SubmittingPatches: discourage common Linux trailers
[3/5] SubmittingPatches: document Based-on-patch-by trailer
[4/5] SubmittingPatches: be consistent with trailer markup
[5/5] SubmittingPatches: note that trailer order matters

 Documentation/SubmittingPatches | 46 ++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

Interdiff against v1:
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 89542263444..dceeb5a1817 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -427,6 +427,10 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+Place this `Signed-off-by:` trailer at the end, after trailers added by
+others and after other trailers added by you; see
+<<commit-trailers,Commit trailers>> below ("chronological order").
+
 This procedure originally came from the Linux kernel project, so our
 rule is quite similar to theirs, but what exactly it means to sign-off
 your patch differs from project to project, so it may be different
@@ -467,8 +471,8 @@ These are the common trailers in use:
    of a patch before submitting it.
 . `Based-on-patch-by:` is used when someone else authored parts of the
   patch that you are submitting. This might be relevant if someone sent
-  a patch to the mailing list without a commit message or a
-  `Signed-off-by:` and you have picked it up.
+  a patch to the mailing list with their sign-off. (Be mindful and ask
+  them to sign off on it if they did not.)
 . `Helped-by:` is used to credit someone who suggested ideas for
   changes without providing the precise changes in patch form.
 . `Mentored-by:` is used to credit someone with helping develop a
@@ -478,10 +482,7 @@ These are the common trailers in use:
 
 While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
-highlighted above. A trailer that credits someone might be more likely
-to be accepted since these are the most common ones. But another kind of
-trailer might be relevant, for example to link to an issue tracker
-belonging to a downstream project that is affected by a bug in Git.
+highlighted above.
 
 Other projects might regularly refer to other kinds of data, like
 `Fixes:` and `Link:` in the Linux Kernel project, but these ones in
@@ -490,10 +491,11 @@ particular are not used in this project.
 Only capitalize the very first letter of the trailer, i.e. favor
 `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
-Note that these trailers should come before your `Signed-off-by:`
-trailer. You are signing off to the patch as well as the message. This
-also makes it clear who added trailers when multiple people have signed
-off on a patch.
+As mentioned under <<dco,DCO>> above, trailers are added in
+chronological order; one person might sign-off on a patch and send it to
+someone else, who then in turn adds her own sign-off. Further, any
+trailers that you add beyond your sign-off should come before that
+sign-off. That makes it clear what trailers which person added.
 
 [[ai]]
 === Use of Artificial Intelligence (AI)
Range-diff against v1:
1:  366c0f43b71 ! 1:  835eb736f39 SubmittingPatches: encourage trailer use for substantial help
    @@ Commit message
         contribution”.[2]
     
         Adding trailers is already encouraged, but in the section `send-patches`.
    -    Let’s replace “If you like” with outright encouragment in this section
    +    Let’s replace “If you like” with outright encouragement in this section
         so that all trailer discussion (except s-o-b; see `sign-off` section) is
         contained in this section; a link to from `send-patches` makes this
         information equally visible.
    @@ Commit message
         Now we need to make a heading for `commit-trailers` in order for the
         HTML output to make sense.
     
    -    At the same, it is important to temper this recommendation to a sign-
    -    ificant enough contribution; in my experience beginners can be eager
    +    At the same time, it is important to temper this recommendation to a
    +    significant enough contribution; in my experience beginners can be eager
         to add a trailer for everyone who replies with an action point that is
         followed up on.
     
2:  c78fb49c245 < -:  ----------- SubmittingPatches: discuss non-ident trailers
3:  cff069ced4e ! 2:  5a652b8e14d SubmittingPatches: discourage common Linux trailers
    @@ Commit message
         git.git `master` from time to time.
     
         This project does regularly mention what commits a patch/commit fixes,
    -    but that is done inline in the commit message proper (c.f. the trailer
    +    but that is done inline in the commit message proper (cf. the trailer
         block of the message).
     
         For `Link`: These are used both to link back to the patch submission as
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/SubmittingPatches ##
    -@@ Documentation/SubmittingPatches: to be accepted since these are the most common ones. But another kind of
    - trailer might be relevant, for example to link to an issue tracker
    - belonging to a downstream project that is affected by a bug in Git.
    +@@ Documentation/SubmittingPatches: While you can also create your own trailer if the situation warrants it, we
    + encourage you to instead use one of the common trailers in this project
    + highlighted above.
      
     +Other projects might regularly refer to other kinds of data, like
     +`Fixes:` and `Link:` in the Linux Kernel project, but these ones in
4:  278eb2c5d21 ! 3:  5e53999b2e9 SubmittingPatches: document Based-on-patch-by trailer
    @@ Documentation/SubmittingPatches: These are the common trailers in use:
         of a patch before submitting it.
     +. `Based-on-patch-by:` is used when someone else authored parts of the
     +  patch that you are submitting. This might be relevant if someone sent
    -+  a patch to the mailing list without a commit message or a
    -+  `Signed-off-by:` and you have picked it up.
    ++  a patch to the mailing list with their sign-off. (Be mindful and ask
    ++  them to sign off on it if they did not.)
      . `Helped-by:` is used to credit someone who suggested ideas for
        changes without providing the precise changes in patch form.
      . `Mentored-by:` is used to credit someone with helping develop a
5:  347c72e4e08 = 4:  dd47fabe917 SubmittingPatches: be consistent with trailer markup
6:  1c7e9ad8e69 ! 5:  20f04e18cee SubmittingPatches: note that trailer order matters
    @@ Metadata
      ## Commit message ##
         SubmittingPatches: note that trailer order matters
     
    -    It matters where you put the s-o-b; it should be last. You are signing
    -    off on the patch as well as the whole message up to that point.
    +    It matters where you put new trailers: they should be added in
    +    chronological order, and each person who passes on a patch should add
    +    their s-o-b last. You are signing off on the patch as well as the whole
    +    message up to that point.
     
         This also makes it clear who added what:
     
    @@ Commit message
             Acked-by: The (Late) Reviewer <late@example.org>
             Signed-off-by: The Maintainer <m@example.org>
     
    -    The the first ack was added by the contributor and the second one was
    -    added by the maintainer.
    +    The first ack was added by the contributor and the second one was added
    +    by the maintainer.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/SubmittingPatches ##
    +@@ Documentation/SubmittingPatches: D-C-O.  Indeed you are encouraged to do so.  Do not forget to
    + place an in-body "From: " line at the beginning to properly attribute
    + the change to its true author (see (2) above).
    + 
    ++Place this `Signed-off-by:` trailer at the end, after trailers added by
    ++others and after other trailers added by you; see
    ++<<commit-trailers,Commit trailers>> below ("chronological order").
    ++
    + This procedure originally came from the Linux kernel project, so our
    + rule is quite similar to theirs, but what exactly it means to sign-off
    + your patch differs from project to project, so it may be different
     @@ Documentation/SubmittingPatches: particular are not used in this project.
      Only capitalize the very first letter of the trailer, i.e. favor
      `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
      
    -+Note that these trailers should come before your `Signed-off-by:`
    -+trailer. You are signing off to the patch as well as the message. This
    -+also makes it clear who added trailers when multiple people have signed
    -+off on a patch.
    ++As mentioned under <<dco,DCO>> above, trailers are added in
    ++chronological order; one person might sign-off on a patch and send it to
    ++someone else, who then in turn adds her own sign-off. Further, any
    ++trailers that you add beyond your sign-off should come before that
    ++sign-off. That makes it clear what trailers which person added.
     +
      [[ai]]
      === Use of Artificial Intelligence (AI)

base-commit: 1ff279f3404a482a83fb04c7457e41ab26884aea
-- 
2.54.0.22.g9e26862b904

