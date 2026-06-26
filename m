Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604CA3F23BB
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488610; cv=none; b=DLTVvKn3o2ACWrn2ImJyg3JnYry+Q9+B7qzPwfzuo9uuwfnjduBpLY9bMpt4zfvoO01ipe38ByryrSvNJEXQMun5B5rAz1c8DhpkV8PhwRDgfRnK+Z3sT5fnflL6SXGr5Uz9M99Q8OL/kFwOrTT2/m3tgZzQJhGnPvsHxlaQuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488610; c=relaxed/simple;
	bh=3+UFlvsA1wsHO+H4oMluXZHOEBum7NPFtL0cmIkIpmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L5+L2HDxxNF6pEWkCfqyKSDKZ7WSNOgglFs+hz7FRa6WbcjHrjTp4vY5QRd+2jDeivNXKIxLU+mMOHz0K6HkeLO6auUukCAy5vSUd9Grddn337pLBYB7POCV8MBRjPtvooXMqGKZbubj8+CrQb5g/1zOgkHhBtzuBlCmiL78hHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XZ1KdB12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kd6sgIMQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XZ1KdB12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kd6sgIMQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BDEB1D0015B;
	Fri, 26 Jun 2026 11:43:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 11:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782488607; x=1782575007; bh=rvrqOKbhc2
	lHMwAoW9iQvsAbhhnByGGDy+F+ZqbsQLs=; b=XZ1KdB12rIpZ8QSDGlt5dE0S1N
	V50gsyeEE7K5mtgY7J6hdErvJX5PM6YhbUMbkUf9t1cNPhsk3J4w3mKHZR6TwrUb
	bzrU5IZ5oQ4WNTyQKR5L9ogeh5AenRSZ1XMxnOBSSpHEIfbDle4+1FlnsDW6jUHj
	Hf+9dKpd1jjXYdGRleyt3kl0KdR5cfSOHCorvW7Dpht+JbxzYZOBWBD3H2w1BWC4
	P2BjOaYdakeIjgkAr5poEX1XcwIzF+z+TspkZCZwqB/8RTrEFQdplGgC3lkeMb6w
	nd9g1B6x+hCDPbfAimCo/vVSRt1knIyf9UeKTHygopkjcymO/0hRX0GtKC4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782488607; x=1782575007; bh=rvrqOKbhc2lHMwAoW9iQvsAbhhnByGGDy+F
	+ZqbsQLs=; b=kd6sgIMQyah0x21jzanQEmCwB3yG1jDFaMZepkDdrO05fcHlVdt
	9Q3jdGjP4TYCVgVujyWMXmm9hb8P6IERQMmT5y/BEHqpCiKGd9Vyr1jWp30jqt3T
	qIxj3BLE5fI2LBKBGg7AQ+5ILoh6AbzZ1jCFf5zKE1CsRbfyDo37C8Rs8ZLTp0ef
	vU8WmY+DtqOh+1l4B5I+rOZei5YhG/dQImVTqtSq7Iz6lZhsrheE5nR4UODiQtF6
	FLmoP7MtBa8rqCI60Uc5dmGxHe8pvvADLCnzIdWQcsZrQQkJwng8Fuq7oMYVSKnw
	bkEMarC9vfVnymoUzLOp0slBHPZf+yR6dJQ==
X-ME-Sender: <xms:H54-anW_L4PGMd6EdDj_SYI_oktu9T7rOjy4gC4aydOSmn5NWBq9Ag>
    <xme:H54-ah2nAbatfcrtm3I9_OaEMLuYQZfHERY_sNG5xm4Q6Wahgbg_rDmMxBj7E6GsF
    gvfuNMieRdZQalUyzV9ov3hjwNsixaybLHIjzsDjiexzaOl5L7XNg>
X-ME-Received: <xmr:H54-aloR2BpfBWl6rLi-vMa6Q_tL0wb7rVWM7BiqPuJoccjD09exvKC3MwC3KBK_kqUkCX6GVwnchoRsgrXUbjm1Qy5-mZqbnR5mFY4>
X-ME-Proxy-Cause: dmFkZTFMsdBzL6FzoYN0Zd8ziGOnArzn2xlpTsvpFeNe4LU6v5O8d8ARpZyC67HT0/QwvD
    OQLNCG0WPv7L6hD8BZ+OfBCRxrC6mpQWkO2UGxrZ8wY61lFfs4jzrzDG9hQk/8cP3jnQ1G
    h1RRDtRP99zNE866q5yKtGJpTQUlNIy6b7DlqP9ZNN29dZikGKD1qfdUoNH4erwO+Ni5iU
    MZ5prQGhzY9tllsP3xK+vyg9yHUdhKvJCA70UpGGXKPQwfuYButYZO6PiNsXfWBXHptCfp
    BExx1VLK8SUzwuPtDkR37cx0YSuaMGob/MQYCFBi7xA9PpKllTt8Gs3wRRPKzvcwxSXVL3
    s7lXqT0wkVw2ogBdBSXOwGmvQp2AT8IcgCStHjG/IPxMiJp8S6ZOO41H6peSDOuhVadjTB
    Yxu3owSZbrCJUooP2V87O7sVu7//yka9lxQ1A39droT0oX4mDCqhYNjQwzzrjK9b2mJbE/
    Uv0Qko+uiwPV1FUJ6uelXsF2X0/eRRJfOKSlULS/AcufOE3hAbmiJV5D6A8F4jX6btYldy
    WvqNI4tlPIIKKhbBnaJHxqFL25diezCH6Q7FF3Jupba98YY0OVQKKb5FohNvsIQQUv59UD
    sNUftgjxNAEeWZejc9TEkAHO1w9/LKATV37xBKnnw/IRSByGO3c7a/KrAFTw
X-ME-Proxy: <xmx:H54-aoWtPScYuacYG-q41WhCa-Ftq08B2pIzfEijlQddjvkRqokeMg>
    <xmx:H54-agY0ebNhscJR7JdTlyZbC6--_9myoXInhiNe-tfNkH5XzfW_uA>
    <xmx:H54-alfqLctpFpOY9h6joSnh-FhwYlTABbuh-A39qzcRlpTf8S-GAg>
    <xmx:H54-aq1MJbE-BVPNsmj131xL-SCE8fiaXoOe4Xky7swk0f0ZyMYlIw>
    <xmx:H54-aiAxur4Le5KJaSW5EM45HmPNaNQ5ZIpW4MRTBz6cLus9PNW9H5qg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 11:43:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2 2/2] environment: move excludes_file into
 repo_config_values
In-Reply-To: <20260626075037.532164-3-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 26 Jun 2026 15:50:37 +0800")
References: <20260626075037.532164-1-cat@malon.dev>
	<20260626075037.532164-3-cat@malon.dev>
Date: Fri, 26 Jun 2026 08:43:25 -0700
Message-ID: <xmqqbjcx9ujm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Continue the libification effort by moving the 'excludes_file' global
> variable into 'struct repo_config_values'.
>
> Since 'excludes_file' is a dynamically allocated string (char *), it
> requires proper memory management. Introduce repo_config_values_clear()
> to safely free the heap memory when repository instance is destroyed.
>
> Note:
>
>  - 'if (repo != the_repository)' fallback logic is temporarily added
> in both the getter and the clear function. This prevents calling
> repo_config_values() on uninitialized submodules, which triggers BUG().
>
>  - 'attribute_file' is another string variable that was migrated
>  earlier. Its FREE_AND_NULL() call is also added to
>  repo_config_values_clear().

OK.  I think the placement of the new member in repo_config_values
in this round, moving to the spot next to existing attributes_file,
makes more sense than the previous round, too.

Looking good.  Shall we mark it as ready for 'next' now?

