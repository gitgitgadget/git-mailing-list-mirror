Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1E2D5C7A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854692; cv=none; b=OywxwZn60dM6q2E50pmQoiNUNo5Sendzu53r79ffuLwUcIAiSRHnAOtW/gkBby+3XwIvN2RjAOmch5ivWUhllzVpZi/RjfXUHT8kgAsvV7fPNGBdoGp2vr2LNswqc8fHh7R2NDRTMV8xLfEdTuxGunpKciGUp2yg3hsK4dQSqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854692; c=relaxed/simple;
	bh=8LH01dZXNTk+eMWmtBKBcZrDMuyG3g1xj8jcKZAg3IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xnw/Ca61Sn/KkkwYq0DeVMwMpxI9oXsZwiNGJigjVTEAdfjQkmePUA/m0sREWCuzHKoOViYFO8ewSRCCtn+lzxVXyvuaFW2FUi/C/W37u2V6h9+nruQd4LiL4paCB9LKjZ2d/mNn3ldtQmFFfuJcUWA9uL2tgPjZiUHMqbBNT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fkhrTgrp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0DFE2CF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fkhrTgrp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0DFE2CF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 31D82EC011B;
	Tue, 30 Jun 2026 17:24:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 30 Jun 2026 17:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782854690; x=1782941090; bh=8LH01dZXNT
	k+eMWmtBKBcZrDMuyG3g1xj8jcKZAg3IE=; b=fkhrTgrp5CzVwS4mbzoQLkC+NJ
	LVL2Yf6I4Jufge/NEIu93E3UI4M6ILw4QEPjUAnjjikcbiPuNOR5GQs0P0c8R9mh
	euJbmsRbqALfEL3V8fR3O2q15w6X6ndQz8iAZykL/kIENdMc5CvAkp8wcPJM8f6u
	aRZQEahz3bleaYlYIO+lTeBsXnW+A3zmQbkrZLdGLAMYIAAeFGDrnoyeenEEngZK
	ZC2hUTugTaMv55lW/M09TU/wTVwggttlLHQnEUS+7U+vJ9ZezAihCHcrpZv7MzPk
	x+/xpkYYOCgFKtqRzbnJcWKftGcZdsKmOuO6U6Cd+txHatHGFJ8uf4NxDl5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782854690; x=1782941090; bh=8LH01dZXNTk+eMWmtBKBcZrDMuyG3g1xj8j
	cKZAg3IE=; b=a0DFE2CFktzPHH2tHybebrzWZptX7/vki5oQfY3q34M4ctl3Nmg
	BklVzyJdUxv7Eoae0XH/92veaduEl5rsWdMRVHhciHSJgXMV0HH7HvIPscErZ8GI
	NLEYI2RwtFgOr/0EmOH2M7LQe+BBALFobPtm4Oxk9ciKcyECGa/ON3HMG1PEgNFR
	L2QBVM3fXVVmbzr84+bQp2bjmssxwOMx/Alfr7fnBZJOSlx165LBm5fCktYTLjjP
	vmKJltiNOYId+7wqw2ke7nhZd1Y7ETjx9SLgfp4LBbBTkiCnW6vLG5ccraJitiAA
	EJ8KSmzsHxcBq8TMhSdVlJR3hSJ4B2QAB6w==
X-ME-Sender: <xms:IjREaq7m59DjfMguCgZhjHNIfPql1s62zixQB78AYrpbPg_NLnDCYg>
    <xme:IjREarWDN4pizFHLI_HDogp1q7i4hcphaSKp9mwCNyL33AQTz7cJzaNH5_lFjovAt
    -tFPE7mOwFZW_nu7v4yRdjir2IFq_c1Uhmyn9gowLAAHDdoc3gWaA>
X-ME-Received: <xmr:IjREam26UU_P7EtYRunRpieicr6RBSr7buQwFTEoT3kRYZ0MMY4_eYqEKFPrqQ3ihaGUmsGI6VkrPh7BeQay0WsTm85c0HSXIasoh3I>
X-ME-Proxy-Cause: dmFkZTERh6yvzNRbjYOss0z626cZd7i2vHWLjIzqKyH6Mjd6Vzs76I7NMrE5NF1q1e26yl
    FazEt1Q4a1VJdkHnNQMXXyOTq89XUn3aOHCWLmA8v+yapC2Mwytqd209AUmApszH9aOQ8x
    1p5Q/Znq7ynOBlreDgfwr7etTJNbltnGSSzcsFUymPGEGFMd9gAKWWcTQOofzJgNLeZl+0
    vdsAPjhb+T9MrAgEwBcUcmLfbp0SNljlkm5TfJT6GPO7QnIjfCi65O/fnyBBaDitH2SI+o
    qesC6OlBpNOBKagZynaJX2VX2oO8/IGPKfdGmAAzdG0Uq32n1ECFQYTDs13kvks6nxVbFa
    oP+2z4ZpVLdH/l0dNc0tljAGP+DwCYHcA0Q973Mjs+ke+WalffgISUS2+vMHbY2COL+0yL
    PYgqD0r51OoUd+6MNEz8xU7vTACTEw5GI5fBjGjzaLLNh4rmrAPIEhbyjHUJkyNm0ALsMQ
    0z7fDq22cMHJb8jtdOQfdkgq0lYb4U3zxS1qdPNuOTHyGGhP4sME2FcfE+gDeSVkO0tO73
    gbFEQEPcEpGC2Dhd8vdwQp49eYUwiM/kVzOvjpwBnlzUxYInaXFrZLkuyPfdqJZ9OnJ5Qx
    nU5kS5QVW47k76M34IXKJKGYWB0v1amay41QRbStYgrgiZkJI5BsPVP+W0Pw
X-ME-Proxy: <xmx:IjREag3SkH4LCH4WHGetBV3yRqrR_kxpcmNUVrGNY5iabZfTxWiopg>
    <xmx:IjREah-ZvlRgCIBE54duYbKRxcx8fLVZ3Ixt7MTEE7Fk7A2S3n7l2A>
    <xmx:IjREal2N3mduMOkDdVPCuPx7tUfB_HKqoc9qSQ9PbikdJKlah0Z2sw>
    <xmx:IjREam_IUpLvZoZtct5nhoj9CiqbzAEWCnsMBNPVCj37DTRxnwE_Rg>
    <xmx:IjREakHim_RT3lbcoKeIAXKnm8rjVQPTNFOacys96xYRm4HbU_wjC2rn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 17:24:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Laszlo Ersek <laszlo.ersek@posteo.net>
Cc: git@vger.kernel.org
Subject: Re: git-blame vs. abbrev
In-Reply-To: <7df1312b-c5d0-462a-a03f-9f07e7338de1@posteo.net> (Laszlo Ersek's
	message of "Tue, 30 Jun 2026 20:32:15 +0000")
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
	<xmqqy0fvreps.fsf@gitster.g>
	<7df1312b-c5d0-462a-a03f-9f07e7338de1@posteo.net>
Date: Tue, 30 Jun 2026 14:24:48 -0700
Message-ID: <xmqqcxx7raan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laszlo Ersek <laszlo.ersek@posteo.net> writes:

>> ... the same object, I suspect you wouldn't even notice that the
>> hexadecimal digits you see on the screen have one digit longer than
>> usual ;-).
>
> That's it precisely! :) I do *not* notice that the hash from git-blame
> has one more hexadecimal character than the central abbrev setting; so I
> just go ahead and blindly cut n' paste it, using the mouse, from the
> terminal, to the editor search box ...

Which means that there does not need any configuration variable to
trigger the new behaviour to protect your workflow from breaking, I
think, and instead we can just go ahead with the "-b then no extra
column for '^'" change, right? ;-)
