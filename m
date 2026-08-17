Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834943AEF36
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006366; cv=none; b=bysmrtE3EwzgwttOZ8us/VFcoKL8YAymkPsQOWeKrniB0H4sh2u26/N95s8VXtxyIlz/VmULJZfJYirRRrEevc8rI4JdmPzdK6c2pwPM1lBBB+/VSyV5wVKAmo4Pd2z/cnd9X4LWy4IrB4+IEmBfyNmtMH8HF4QmdyDyNjVD61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006366; c=relaxed/simple;
	bh=rJ8vE7Bg7oHyOB7M+w7UicqoKRmEIQvNLqtV0hcBSOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dzm3Xn6zvfLbRViIayJW3pdWxBqSr4ozUClnpPQDrTKgJbhgQRKXXjfqInqyhiURkldPZjQeyQtmg/MbU2iZxhM7vkUzPeDLIkbEaw6reOvaLvypIJn8A/IaBXULcCf4sivPLHWf60t8LTABBvjgWqmUxBtLGPp/mQSomvxuVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HzQ9MnTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCRTWfJY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HzQ9MnTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCRTWfJY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C21D87A0147;
	Mon, 17 Aug 2026 18:39:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 17 Aug 2026 18:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787006363; x=1787092763; bh=nixq/ZgPx5
	1OwCbVmpuaYYpZ4KKW8cmt1PWxLaEjXRk=; b=HzQ9MnToHhrxXrh2tqiNEw57yH
	04ByHzust4y8MmRZ+3wlyJMCvhZLdfYfUcNFK7e6e1XgBeyT7jpnOTV7OsswZRTx
	DENPlhIKlsGksiDAdLVl2162+eVY12colD0bwV1GxKOlXx/RQLwmiw6jDSpMKNOs
	kMNDs9PZy8jGlet1XNpvKvQa6q6ZzwYXZlzYemVqzXbCCoAf6E9aRRppA7XpFhW0
	Ws5OzDQ+QLtBxSvL1uZn+Ke5BapsJsT1iTCta8CwoYcyHo0hLDGNL5N7X8wuWLQT
	UVjb3AdbV7JH4MpNOw9pHSUYibrHpVmWzerxXn4r4ey1KCIaNdZKjTIYLZ5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787006363; x=1787092763; bh=nixq/ZgPx51OwCbVmpuaYYpZ4KKW8cmt1PW
	xLaEjXRk=; b=fCRTWfJY5pcwhtCvP2bkB7tq9n72tGTO4FhISkHS5chf9V66Asg
	PzjMHe0pDOzD/DvufT8w9vSn0y1lUA9xHiKIUkTmJO+a2oYIiN+bgA8VWm+B7aHc
	N4SJVE1edBa4zPEohmf2q5qYjgKVTuJCC7lF8/jg1ydyLXFRMySYEzi4/7HStqAX
	LRM9gEuDoZZtwhu4LBHMXeiLMjmWaUBSgQURgKRRAIubP1t/SH5vGR1fTh/u/bO1
	oVgB53RgGjIAjlwsSD7Ge8kVtrHOVwYacglplHQBNIqn0M2LCch+IE0TTLRhvOUr
	yV7/YBAhAK1Ke5v8Dsh7liXgOCfRH2iTylQ==
X-ME-Sender: <xms:m42DaobLhwMzXeS6spoQJPv3Jd0OGNYs_XNcRAGDU51_zd2vEZ4ygQ>
    <xme:m42DaqTyYHACyja30s7ZeDGFoOsxuLUNe_cS0BEDCK-N3cgDP5h3RgyKJwQbFfT0Q
    yBFs0BZejsrFnTQdvE30kSwUMMDUFe3a9QPYSNYMIKhrahWcqULyg>
X-ME-Received: <xmr:m42DarQ6iX0HKkAZbICHT383IK8xNvf4FhFQFoV2zNl65G8cn1N_vYLjjSLErNki1Cgq4_5Re6nreXAVVDvX6DjMOVqt7o3nCw>
X-ME-Proxy-Cause: dmFkZTF/SwtBfv60NzBX6HCYF1K8bj9p5vFKjGOTCE6ox8zLnmR1L6PDkWtThriLeU5JYK
    T7ls/Blr3DJym4IajDQ2q4OlX40AbZrNqLPYdeOMlF2nvui9GlEh2Tia4Jrp5FroqUl6I+
    PP1JDsXOcFZrU44qhkafRkPV6aGwAnZ+rN4JWuvn82ome2E7pNo6ehd4e6oB3dv999Qc7f
    1LYhMyowMQOoVxlpJPSMG8jSpbsvWE4tZsWjdY+nQkUHz1ZLwYI1yKLtgZ+N/j3c8McMQ+
    riuXOvEl4oPNXM6QlUKlCBdypHEaEq4wWs2j0Pt7R2sVKB6azqNunYkU4qbh0PJsGPtzUW
    b3CQ7RleO/VEQTjM5CMQx6Era1Ieuh4XdA5syC1yySEzP0heRJWjuhZA6Czo+eBKnEfQqG
    mZRJHazR+STJMNFkZjpIUsn9xG+slwW8x9Ndw0VgAb/k0tpvoVju4EpnimXnC4SuVRzBgo
    5oliATjAeQLDl2ZQEn9rJbTdoko1E21IhAMO2gxpNfOr6sliDichVA2UnzxlpTuB5Vwi3v
    XwR9HNjdhfh4vHIIvgr7mJ9/x6mbF+mSYHcCXs0cv5glS0dMoMHY9xwj1vBVSq5Q3qlCoE
    J2fB+WmDuRsq4f/ySydpurzkA31F6dtNWTj3xaIQ7EIB/Tb0YgWpj6IoZNHg
X-ME-Proxy: <xmx:m42DauTgvHm-GEUIiUaYr-NPAuLXAelu56MOqFLpn7e44G9HxBD2Ew>
    <xmx:m42Dag5WvsYUsvuqZ8Zxayd3CRJejCXUwUtw5_VLXY-FFYaakrO3Uw>
    <xmx:m42Daq2RPx3mzo-MsWLfFX3Mndt2_aYtGWS3WIaaGgBYJt4TQqK6Jw>
    <xmx:m42DarC8pzhZA7fgpFF5NLt4yJnSIGXOdbzbVFPyzFCXIkSOcV6-sQ>
    <xmx:m42DapuctWBkdGrNseu6Y6m8yj2xnG-QQ5XYZCT96dzTDzN5xzfEnWo0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 18:39:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kenneth Lorber <keni@his.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [RFC PATCH 0/1] config: surface editor failure in exit code
In-Reply-To: <20260817211936.2943278-1-keni@his.com> (Kenneth Lorber's message
	of "Mon, 17 Aug 2026 17:19:32 -0400")
References: <20260817211936.2943278-1-keni@his.com>
Date: Mon, 17 Aug 2026 15:39:21 -0700
Message-ID: <xmqqse4c2wyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kenneth Lorber <keni@his.com> writes:

> When the editor invoked by 'git config -e' fails (crashes or calls exit(3)
> with a non-zero value), git notices and give an error:
> 	editor.c:launch_specified_editor()
> 		return error("there was a problem with the editor '%s'", editor);
> which is then lost:
> 	builtin/config.c:show_editor()
> 		launch_editor(config_file, NULL, NULL);
> which results in git always calling exit(0).  Note that the value is
> not explicitly thrown away with "(void)", so this may not have been
> intentional.

I do not intentionally exit my editor with a non-zero status myself,
but what I hear from others who do is that they do so to affect the
invoking 'git' command, e.g., to stop 'git commit' from creating a
commit.  They somehow realize they botched the edit, and they want
to prevent 'git commit' from committing, signaling that by exiting
their editor.  A cleaner and more modern way to do so, by the way,
is to empty the editor buffer.  In either case, 'git commit' itself
exits with a non-zero status.

It might have been more consistent if 'git config -e' exited with a
non-zero status when it noticed that the editor exited with a
non-zero status, in that sense.  But we have never done so, and that
is probably because we did not care ;-)

In any case, I am not sure whether there is much value in making
'git config -e' start behaving that way.  Even if it can notice a
failed editor, the damage to the file is already done, and there is
not enough information to undo the damage even if you wanted to when
detecting such an error.  This is quite different from when an editor
edits the 'COMMIT_EDITMSG' file and fails.

So, I dunno.
