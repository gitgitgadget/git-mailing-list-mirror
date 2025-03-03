Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C51E5213
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038964; cv=none; b=Ggn2KxR44hz10HbD+ZwamyCTlDiip/C04P9+Bh1R7rTlRhd9jpn0ysGmOEkthtU7icFnkHhrheAterBT4Xm155bRUyVoLIWiO0ZwhiKceXr9UzkZDV2HYPIBZw0n7z2tYbai0pn7nSKryOtJ4CefjOn3k28ZAbdWlnJ0vokrsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038964; c=relaxed/simple;
	bh=TbfQKyoQZRPseejjNqy3TN6nUhluP4Df4dwiP4Frq3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AqrqXYxHzzyAoy85UrWwW2k8p/bxFOihvFA9Jul10O5jWG8KoKWNximtONRQ5pNXyEkfzLrgsI+REvM51mPiWsPKt8r3MPI+x7sNjc3j7Qi8qx3TqpTh1ydKDHLfYDuYL3/LWdKdnFvrel3+XMyCR3oeuaeonCCNqxVdD7x+Kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2lxXPPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DdN/Ursp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2lxXPPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdN/Ursp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C9BA11401CF;
	Mon,  3 Mar 2025 16:56:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 03 Mar 2025 16:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741038959; x=1741125359; bh=8V+94ERz7w
	Zniba4/aYWUVpDa5gOnbuJ7Yd6bl1UiHA=; b=J2lxXPPHFeNVPCV97o03S6sRxc
	chWnrcp2vr/C9sMEiJi5FhvbQvrzGBr0hZpEecGAyt0uKRgz2cVH/jxTUO8PnWu2
	DSDRDoVJ234Oy3Ryj5bsNr55h9c+diQP657p30VMDYeZueJCEcgQIcJcIqwmSTnK
	TLlQNVPgt2fK+lal+/jDCrHx0fX84Im/6ZktOA/w+eaeJrUG0dEyfVkQ000ggmfB
	MuHKvTyNEjXuFuE7JF+1tINjkeMLMV7oEito2emJJUGcrp4BDAhMqP1YpsHfPAsT
	XWlRtDqNC5F4uVQD03l9mpGJ4ug/b4vKPPsKhLgk36hBEdVTKy7/wYjN9g5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741038959; x=1741125359; bh=8V+94ERz7wZniba4/aYWUVpDa5gOnbuJ7Yd
	6bl1UiHA=; b=DdN/UrspMoVI1lkV4Ahg5MDdnxFIbIiODi4lIC70V8v65+5tGW1
	pcEOjoN/Mz0GI7pjd0pEXWt6mF1pLGLpVms5WYRKwo0+7VQKFoJEhOO1+/XGS+Cz
	myYoIGp1qg3MEpbF5p4uraqeyvP/przPVQP/GGCd3Hvo06DUyOlPbWHQKC5cXhZJ
	7uhsRsPM/xnMUih0VnbD/bdZi1EAT1HtQoUkOWWo4ck7xtET/jF1c/omKpJ00WZY
	X3H9AxAaffpqN4i1D+7Z4relOozEYxzqRtzfVKJr/VCLDnrg7gp9o+ez5BbDMS3B
	Dkr6XyPkvAwvbR4210G3UydpbfhHBMo5d6A==
X-ME-Sender: <xms:byXGZ-zT8CC--n0ec0N5cxIY0iCsO9Hk4SAymzntWRytVcM-sN8FjA>
    <xme:byXGZ6RfdrJip8-g1iml-R07_bxolXc5iBZLCbgPuYWioV3E07JyCy3bktJqXBRxp
    bAFB3zYRahnNjIIIw>
X-ME-Received: <xmr:byXGZwVp5LCOz1btSxHGa7s-TcHpPfBisZOvFxrszTHG4oCXorh22Xa9sW3MMUzLJdJ1FG3frjpz_nM4uXXPeVbwaOIJYtg0V8Py>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:byXGZ0ihGvOqaUoVXWLH3mFoXMZujHRqIF1e2qyvjYqWY_ODC4dWgw>
    <xmx:byXGZwAg4cla5qIESnmn1HrJR_PkE7k6mO5TnHRpSSxP5Gf7H3GEjQ>
    <xmx:byXGZ1I8gTizMEPBYOnoKjou9u1xTatwdAxtNbE2K1wxK6Uj9sUVRg>
    <xmx:byXGZ3DsbVX50eXuq8m3rQJ8S44QhUe8hfXveXdpoQ_i12Vv40QopQ>
    <xmx:byXGZz-ZJlqni_kXGLVGej4enW3Ic1KhKSOk0h7Dx0PvZTpePBA5mFuf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 16:55:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 03/34] doc: remove unneeded .gitattributes
In-Reply-To: <20250303204443.360595-4-tmz@pobox.com> (Todd Zullinger's message
	of "Mon, 3 Mar 2025 15:44:01 -0500")
References: <20250303204443.360595-1-tmz@pobox.com>
	<20250303204443.360595-4-tmz@pobox.com>
Date: Mon, 03 Mar 2025 13:55:57 -0800
Message-ID: <xmqqjz95vkwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> The top-level .gitattributes file contains entries for the Documentation
> tree.  Documentation/.gitattributes has not been touched since it was
> added in 14f9e128d3 (Define the project whitespace policy, 2008-02-10).

I'd explain this change a bit differently, but the end result I
agree with.  These days we no longer have any .txt file under the
Documentation/ hierarchy, so no matter what the other gitattributes
files at the upper level(s) do, this attribute definition for .txt
file would not do anything, so it makes perfect sense to lose it.

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/.gitattributes | 1 -
>  1 file changed, 1 deletion(-)
>  delete mode 100644 Documentation/.gitattributes
>
> diff --git a/Documentation/.gitattributes b/Documentation/.gitattributes
> deleted file mode 100644
> index ddb030137d..0000000000
> --- a/Documentation/.gitattributes
> +++ /dev/null
> @@ -1 +0,0 @@
> -*.txt whitespace
