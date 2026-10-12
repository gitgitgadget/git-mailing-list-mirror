Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD13AA507
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840325; cv=none; b=g3vGyZCyqxD2itR5Fk5B0J8RWWaQ/H5yIabMYrp1yf1m9HyDl9s61Wd0M5pgBqh5jPoBtmgEN4bo02FQEGrT89r/MXth9wpoJkU31MvwW/StyBVIhkU3d6ttq2e7vT0FUFaiC+tXUd46YqJPmkR8n65qqELxRJ+MJ8gZ4whVnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840325; c=relaxed/simple;
	bh=m7tzKPTAt6iN4V+92ZGTgoye1r8kxumUDdgqKOn8URQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDTZEKewJ6uHkQm0eDVW7owbA1p2alxmjcMIj7t8mlmL5zQqRAOgcf8faQ/zdshIdw9ak/z2VgpYxW1ORscchTqKlxiuL0H3jRTAKQfzTCjHijoGgVBvzRStnM3k9Y8ff+lTZAcvd9GEI0RKILl2ZKMZLvnj0qtceqiu1BsJnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SrRrPiVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MK18kFgS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SrRrPiVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MK18kFgS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A5E03EC0857
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:25:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 17:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791840322; x=1791926722; bh=EBhLFXoMOh
	odqsBkO4XQ87cf55WWyPRF+BUS+uOeTU4=; b=SrRrPiVeOVsm672F0acpbwD/Xn
	tGgCIzyOxI885Qtz1Bu0cXZaE53rFW7flGsaQOwdEROpVgn8+YYu6WoHtztaAdDk
	PlBTdSZ3+UcOey2a1DoSX7f6vXzuzJhaV6+kT/gIQ3g1TQAm0/23K+WO7XTODqGW
	Lnm+qDn0gPr3DfcP8COlgnNvmjaxgdLrgKdxBFehhQ7xC4g5GX4zNOBgxPYP1Y2t
	HSH7s7AeN9BclwF/8UW1QTLaVIltICT50ZMq6oj1i/Siep4HLeGarvsVRAm1AVvJ
	hgmg/hKYPS2RQGTWeVh1VhWC7osCfGfewyDHx8ZbDN0Us5MDXa7ULY7Srg+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791840322; x=1791926722; bh=EBhLFXoMOhodqsBkO4XQ87cf55WWyPRF+BU
	S+uOeTU4=; b=MK18kFgS1vdKrZV/UnlSWfHvexK6X4jCP/ty5o6GYTK3b/j+0MU
	VrXvjpui9M6PO/Srpt3pIJ5fHfZSn3DdR8wxG45iGi5zpZOvkBEiK/ALG2ScN0fa
	JhB+Ym/V2BIsSW0hqKo8O7xq579siuf3eKUa0Rsywn14mjV6PQIBbS4slxA3VHvt
	inaSeMT7ntGupcjrRiO6ieBHcSPNgysycLau6rXZtgYQ1FGatlMmYPWBg+htGzO6
	vvpa6vkLHU4Q02T+elxlL3N/P/r22AfaqsWPAUeuIb4QYr0sx+xcgLf7swNTGxpf
	B+iKlQ1AlC6IFF1GBNfZpG5F9qt8l/JTGAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791840322; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Q9jAQG7b5cCZMEq2/fVzBbUR9HgXttYfZeS1cYbFJSZL6P5
	Xvhfl6vJ9wTT2wrgxctd4N06r3iOn96htVxhAGbDArdv1bvyweQnrgaUDCi/SHIX
	0zyO6rNy6aF9FeBEtS+SXuGM+NuRaaqlNLGUVeV7YBrI1YTFgZtJm16ghleilHek
	uM16j28zk431GzVjAj4w8bRwYxg4XNsb1EGKMFfuH6sx3C5Enqc1FL9J9TIEqS1V
	pZXCgZJBKXkVyo0mycztByWMK+EbSHUMkjXZ0t+CAE8k/PVyq/1W/8qWsyXemFd8
	c8YRw+xAoGgzoT9f3ZhKMYlV2eetxpFxbWb8kDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kRxjisj0IeGcnxcrpI86QhmeFHEi7zqjf+w7MpTZVcE=:m7tzKPTAt6iN4V+92ZGTgoye1r8kxumUDdgqKOn8URQ=;
X-ME-Sender: <xms:QlDNalocsvu0pHIDV__Lam8O71pBVr-beBXu1fIkgSi0cQczeMqMhg>
    <xme:QlDNavHlGBEn1Q9aGgdzPsc7KyrLkoKYO3XETZFYErK8XgzYQ9xgmqNLPYl__382e
    DgDKGxT5gX68W6OmrJxGXc-RMArMuf6FzVc4XtdC0vE_iZb35gZXiM>
X-ME-Received: <xmr:QlDNavl12tIXKZBTXx9nAUJUKrjq78awBxlR8ry70NLE_HaVF0K2ICKVxOkKm5imFpMWHIEXYRB4EkhKDfmde2Niqit0kT996QHw>
X-ME-Proxy-Cause: dmFkZTFDSQxTu95KKsit4BSr4TABTXGuZveNYzrNLuT5kB/xW2oURPa+xr2jUU3n1KU7od
    awG2ubqCiBDn7fq9X5972JkNzqMoWlKKoakO1BSijW2bHKdckXtu+kWjQAvGWrTLRvqRdo
    icriX3geczucnudrFNR+0A/LdlWL2lcwvJ47KRIGNLiPTeQcyICYomryjJO7go8fNPWLs1
    hPR6Pk4TbLT7Rw8lDBxUCP1yoYXqfbzqc8vn7iwnUFDRZnRr9CK4p9OShpjmOMC9aVjebR
    40e4KrQvPnqbwkfeTdroXHHSpKYMV38TNJTEAZ8AtCezOhwRQ9LTlw4TwmvXlLJ+yhswQH
    8HCLKo2k4AMxdQgot+SD9w5kWvfzjzVVzBma0j1ZdUcn1Oy6KudUDvKyXdgSgR/Ulk9BhD
    FTVquxyu6O7serqSEeoVWpYIgrELO/OXRT1D3XqKxhgm10AJaVhGkkn7KJt4iYktv1t7ym
    1WHtcPr+qNhfuxOIqK0DANxVHx+ORbop/BEo8zRmRDU7rguFnte9842yU1Bzx0JwaxtsVn
    haIDLYMJ4JZuKN5n7O3/UgbgoHW72DYqMasQ2TH2vCon0UQDck7Ccz06OT9J0a8HsoBV2+
    q6MJi/cjkyMjEdjfVKnEv9wTp24c6wWHx4ZJqYIy1pteUKoubKdXz4rPJdlA
X-ME-Proxy: <xmx:QlDNaql0WKWqhMaiKRORejVbI7FCuez1e8gPFuX6rvG3x4foNjYLQw>
    <xmx:QlDNaov9pmNvads8QKllhkC7yVeXu7xYV1_aje7gBXh00p0R6n65Ng>
    <xmx:QlDNallXmsZSpwiwxYMVXRBNMh22qfXe1QgQPKpl6MlLlqZDHy1fNQ>
    <xmx:QlDNarswEFw5uQpGXpl3KkbhPzhsRtoVJIX_uutJSxUV0tlbxO8Lpw>
    <xmx:QlDNaqSWqUJRWELjGmlyDGnAx02fMSzWargOa_Qbr32wqvVpBJAYTzp9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 17:25:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] unicode: update the width tables to Unicode 18
In-Reply-To: <20261012210450.994951-1-dev+git@drbeat.li> (Beat Bolli's message
	of "Mon, 12 Oct 2026 23:04:50 +0200")
References: <20261012210450.994951-1-dev+git@drbeat.li>
Date: Mon, 12 Oct 2026 14:25:21 -0700
Message-ID: <xmqqpkxe4nni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beat Bolli <dev+git@drbeat.li> writes:

> Unicode 18 has been announced on 2026-09-16 [0], so update the character
> width tables to the new version.
>
> [0] https://blog.unicode.org/2026/09/announcing-unicode-standard-version-180.html
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  unicode-width.h | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)

Obviously correct, according to update_unicode.h in
tools/update-unicode/ directory ;-).

Thanks.  Will queue.


> diff --git a/unicode-width.h b/unicode-width.h
> index b701129515..c8fcf68668 100644
> --- a/unicode-width.h
> +++ b/unicode-width.h
> @@ -5,7 +5,7 @@ static const struct interval zero_width[] = {
>  { 0x05BF, 0x05BF },
>  { 0x05C1, 0x05C2 },
>  { 0x05C4, 0x05C5 },
> -{ 0x05C7, 0x05C7 },
> +{ 0x05C7, 0x05C9 },
>  { 0x0600, 0x0605 },
>  { 0x0610, 0x061A },
>  { 0x061C, 0x061C },
> @@ -61,7 +61,7 @@ static const struct interval zero_width[] = {
>  { 0x0B3F, 0x0B3F },
>  { 0x0B41, 0x0B44 },
>  { 0x0B4D, 0x0B4D },
> -{ 0x0B55, 0x0B56 },
> +{ 0x0B53, 0x0B56 },
>  { 0x0B62, 0x0B63 },
>  { 0x0B82, 0x0B82 },
>  { 0x0BC0, 0x0BC0 },
> @@ -143,8 +143,7 @@ static const struct interval zero_width[] = {
>  { 0x1A65, 0x1A6C },
>  { 0x1A73, 0x1A7C },
>  { 0x1A7F, 0x1A7F },
> -{ 0x1AB0, 0x1ADD },
> -{ 0x1AE0, 0x1AEB },
> +{ 0x1AB0, 0x1AF0 },
>  { 0x1B00, 0x1B03 },
>  { 0x1B34, 0x1B34 },
>  { 0x1B36, 0x1B3A },
> @@ -230,7 +229,8 @@ static const struct interval zero_width[] = {
>  { 0x10D24, 0x10D27 },
>  { 0x10D69, 0x10D6D },
>  { 0x10EAB, 0x10EAC },
> -{ 0x10EFA, 0x10EFF },
> +{ 0x10ECB, 0x10ECF },
> +{ 0x10EF0, 0x10EFF },
>  { 0x10F46, 0x10F50 },
>  { 0x10F82, 0x10F85 },
>  { 0x11001, 0x11001 },
> @@ -325,6 +325,7 @@ static const struct interval zero_width[] = {
>  { 0x11D90, 0x11D91 },
>  { 0x11D95, 0x11D95 },
>  { 0x11D97, 0x11D97 },
> +{ 0x11DF0, 0x11DF0 },
>  { 0x11EF3, 0x11EF4 },
>  { 0x11F00, 0x11F01 },
>  { 0x11F36, 0x11F3A },
> @@ -344,11 +345,13 @@ static const struct interval zero_width[] = {
>  { 0x1BCA0, 0x1BCA3 },
>  { 0x1CF00, 0x1CF2D },
>  { 0x1CF30, 0x1CF46 },
> +{ 0x1D127, 0x1D128 },
>  { 0x1D167, 0x1D169 },
>  { 0x1D173, 0x1D182 },
>  { 0x1D185, 0x1D18B },
>  { 0x1D1AA, 0x1D1AD },
>  { 0x1D242, 0x1D244 },
> +{ 0x1D25B, 0x1D25C },
>  { 0x1DA00, 0x1DA36 },
>  { 0x1DA3B, 0x1DA6C },
>  { 0x1DA75, 0x1DA75 },
> @@ -438,17 +441,19 @@ static const struct interval double_width[] = {
>  { 0xFFE0, 0xFFE6 },
>  { 0x16FE0, 0x16FE4 },
>  { 0x16FF0, 0x16FF6 },
> -{ 0x17000, 0x18CD5 },
> -{ 0x18CFF, 0x18D1E },
> +{ 0x17000, 0x18CDA },
> +{ 0x18CFF, 0x18D20 },
>  { 0x18D80, 0x18DF2 },
> +{ 0x18E00, 0x19191 },
> +{ 0x191A0, 0x191D2 },
>  { 0x1AFF0, 0x1AFF3 },
>  { 0x1AFF5, 0x1AFFB },
>  { 0x1AFFD, 0x1AFFE },
> -{ 0x1B000, 0x1B122 },
> +{ 0x1B000, 0x1B128 },
>  { 0x1B132, 0x1B132 },
>  { 0x1B150, 0x1B152 },
>  { 0x1B155, 0x1B155 },
> -{ 0x1B164, 0x1B167 },
> +{ 0x1B164, 0x1B168 },
>  { 0x1B170, 0x1B2FB },
>  { 0x1D300, 0x1D356 },
>  { 0x1D360, 0x1D376 },
> @@ -456,6 +461,7 @@ static const struct interval double_width[] = {
>  { 0x1F0CF, 0x1F0CF },
>  { 0x1F18E, 0x1F18E },
>  { 0x1F191, 0x1F19A },
> +{ 0x1F1AE, 0x1F1AE },
>  { 0x1F200, 0x1F202 },
>  { 0x1F210, 0x1F23B },
>  { 0x1F240, 0x1F248 },
> @@ -482,22 +488,22 @@ static const struct interval double_width[] = {
>  { 0x1F680, 0x1F6C5 },
>  { 0x1F6CC, 0x1F6CC },
>  { 0x1F6D0, 0x1F6D2 },
> -{ 0x1F6D5, 0x1F6D8 },
> +{ 0x1F6D5, 0x1F6D9 },
>  { 0x1F6DC, 0x1F6DF },
>  { 0x1F6EB, 0x1F6EC },
>  { 0x1F6F4, 0x1F6FC },
> +{ 0x1F7DA, 0x1F7DA },
>  { 0x1F7E0, 0x1F7EB },
>  { 0x1F7F0, 0x1F7F0 },
>  { 0x1F90C, 0x1F93A },
>  { 0x1F93C, 0x1F945 },
>  { 0x1F947, 0x1F9FF },
>  { 0x1FA70, 0x1FA7C },
> -{ 0x1FA80, 0x1FA8A },
> -{ 0x1FA8E, 0x1FAC6 },
> +{ 0x1FA80, 0x1FAC6 },
>  { 0x1FAC8, 0x1FAC8 },
> -{ 0x1FACD, 0x1FADC },
> -{ 0x1FADF, 0x1FAEA },
> -{ 0x1FAEF, 0x1FAF8 },
> +{ 0x1FACC, 0x1FADD },
> +{ 0x1FADF, 0x1FAEB },
> +{ 0x1FAEF, 0x1FAFA },
>  { 0x20000, 0x2FFFD },
>  { 0x30000, 0x3FFFD }
>  };
