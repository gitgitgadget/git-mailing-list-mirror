Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C734750D
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349594; cv=none; b=cjmwY1vAMaVR2ssHSwjXXqHlXVa9v07ji014yWjG3RJPz7+deFHVkCQ0QCQCc+N/0pYhgni4BssxHPzq9nG1BgCQn6/mdJxiu1vPlhT+Ojlar6fako9mOKuXlir1Z3H57mJnLXxTjnyaw5Mb8zEAkKz1lcEXoz9FNPdpOMNnxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349594; c=relaxed/simple;
	bh=WwZJF72BwKS1F0jCiKNNem2yokqConMU6LFOZAvQOW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCz3j/zaXDCAphFWl2sbypKiSHh/kbyFihB+GQejpdL46g0h3y8XkSkRY8U51aEdPC3IunOfQ25X47hH9IP1qrFy6qi/3zkDIKfFz8iFhO3rCI4dy02STwS4FVRrBleE9FeNtSf92/NvKPKdzkqzxHpAGD8tYENO2CVEngkEQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kHptQ8BJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWupg//4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kHptQ8BJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWupg//4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C7D07A0013;
	Mon,  1 Jun 2026 17:33:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 17:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780349592; x=1780435992; bh=s92qHQ0Yf2
	ivhv6a7ouZFVPcHi5SRdf8gpqJkOiCBcc=; b=kHptQ8BJRv5XW6z2ayWTDxlbvo
	msS54fGnApWMT04w6iPk22szZo6ANfcOfVomQi+/TlulRuOIAYMWUKjvcQb0uH5/
	2CDexUSaj/rnSBEHSP/u0GdRnql5o/Jq/jTZZZ6SuqKSbuTLYAaw6ZWC5GnWjqj/
	5jYSxqZGRcC5H7VyYpnCBs17AgjbHZYXjLs8aOVgtya14a26noObTG5rQFuUi5eB
	k3aRxrpnV8Uk4b0/MNf8hNJ/OMR5mNT93QBrXxjjS64aaxoSfSokBDsebkMeKdwe
	n5wnIX4w2hyj1ZUoe2Y39I5SNcntfE89m7b1NBWet4EtR/oaChwO1TSBnxPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780349592; x=1780435992; bh=s92qHQ0Yf2ivhv6a7ouZFVPcHi5SRdf8gpq
	JkOiCBcc=; b=BWupg//4spPIJHqpCd9oeKBclTWWKSSS4Hif69A2ydKuimnD65Q
	Xb+r7ss8rwNoDHb7r5i/36REzYmIlB77g9fIKpzUDQdhi+UU/12FGvdx6J2FbZGU
	dVVzdqUBtWoIRbxaw+uvKI1cYjySQXzINwI0UFUlJn4t3sfsbIj9hnbyu+5185dQ
	TXpVO/rQumZ6Iqdx/9abND1/Ui0tbomhd/tRPt7XfmmAlrYidqtHNG/oMAtuHSEv
	pxM3JyOrx/WaqPFFP2Dc+9mvScfrHG9pyBgKnbUfbM9Ue449BLvOTMgnDgI2R2Pr
	K8OrkNE5WghkmiUURU1eBypwDt4tnIHgI6w==
X-ME-Sender: <xms:mPodav-R2J_xOoxEfkbwlDURm7thpa1-n6lGWT0mOQFuYEWDMUOi9w>
    <xme:mPodajI7Rw0TJPzuyxMrFcGYPS_pkU2jdM2oFtB9LFMMfFazS-diVhs5rf85tlzTZ
    UOg93BYXZOq4-ulJDy1Ef_R2rR3WiTbJCFooYVAgXn-2pNCguI9hw>
X-ME-Received: <xmr:mPodaqYoGcmMhCT1mw8kAgrDebPOVjR8v5NteRbMM0odxyWYzRkiy_iKEqYWVzrD5u0vvouUoVNkcTi4MYfSnPtqGMTbjoSOLRik>
X-ME-Proxy-Cause: dmFkZTFF2CTRkMT5ZJH6lUdwVNXf/UUOiY95rm5mYrhNNCXosvqUQ7SzShdWTADcuf+l3f
    P/5qeamJi5f4E/MBowxTOnbx+J/ug2+9CK9uDbey464VmAGO/nZRfQYZ6awGPpGD+Rb0Ha
    +ieac44Idk6YBDCdXDEAmcVnHJgs1vPZZhA0at2JWFmP1WCmuLRJ/oyc/1Y6IJKqRsFHKm
    MfAB4eE5/mh+JYdKKsnkH+4X/T5qkfLlginDZj97hsIYN+rBu+PRl8jlNrX1RBKeZEdfeQ
    kvqPwxmuEtdaEnJP4rR+/EjIH6lzfb/Ac7lJDIh7KQLSxPGij2KFo25yPV2kaXCH+3muVe
    RLb7drJsTw6vAHXhBr2NvBbN4qGBLGU2fpW3N1O/dr8a89xpyLDWUrxwuBBDdMpsu9BztU
    xbWG5J1isnsQ2x8zME4EyPokgj9sCdOh9vU0hET3JcyuOQseIhOcDkSYk+rla65l1/hace
    D/UUfgeSCptql7R/vUXeai9kPd6ymOIobf9ntTcrt1O9r8D3jCfoi5m5fnaY4ycg4R+oMb
    NDP/ikjh76y32MNveQiuW8VZxX+YjMAvj8wkU7ZpxoIxVgBud5KU9k6KbuWWn3hgXDCa9w
    VNhesx+counD0o6BYNNOR3CFCqIF3aRGyNcHx2fQOB+maN+QH0Dpc1ipD6iA
X-ME-Proxy: <xmx:mPodalL2DZDtqqHMmvDSvbtNQBYzXVe03folZ0NGsQpsaHrPdV9sKQ>
    <xmx:mPodaoAIOXvaaCXLrQfLDARY4C86w14dqfIhlQ6vlRc0ZukzQqCJdw>
    <xmx:mPodaqoffZVpxqqRJEnig6r2wY82h09oqeIRrwKLu40w7R8JOpOAnQ>
    <xmx:mPodajhBRBujZb4e8xOHGq0n8zmL252DLm57P7BqQtuYAzf6kUMHGg>
    <xmx:mPodajQqCifLwzYtTDM5bAwv_NBjkTxT1IVx_vXvRLX0SciLfRVWCHCi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 17:33:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/18] odb: make loose object source a proper `struct
 odb_source`
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 May 2026 10:22:20 +0200")
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
Date: Tue, 02 Jun 2026 06:33:10 +0900
Message-ID: <xmqqh5nm3q09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series converts the loose object source into a proper `struct
> odb_source` so that it can be used via our generic interfaces.
>
> The patch series is relatively straight-forward, as the source basically
> already exists as such and the interfaces already match. So for most of
> the part we are just moving around some code and converting functions
> that were previously called directly into callbacks.
>
> I guess the only part that needs some attention is that there is some
> confusion at first with the `struct odb_source_loose::source` parent
> pointer that initially points at the owning `struct odb_source_files`.
> This relationship doesn't make much sense, as a loose source can totally
> exist standalone without the files source.

No significant comments came in the past week or so on these
patches.  Should we declare victory, and mark it for 'next'?  I can
locally amend a typo in [3/18] (<xmqqh5o0zrsr.fsf@gitster.g>).
