Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E92D0C62
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364010; cv=none; b=BRxwFm4CvMG0CxTrNIRAiCzvQQjIL+rwEiDS7wAsWG11deWkgDD4KMn6HJZxyKH1NI7y8bHt3Psv5eJYE5I1Z3vTjIuBB9LdSqjvbEDDIUoB0iImSOlVuT2TZx/8cVyliPW6+sDj9zJs7uVsJTJ5yfCSwNDD2PfkICbA73vLVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364010; c=relaxed/simple;
	bh=MlR9gclcKaYxss6Uw+CgSTVhL85m7P6tzlKKLIl6nbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HwB4CKlsPz0YGcjKe2f9uRlfmjOZ8tGPz0oL4vm8T9TCx+wDA0kGR8sIW4igyR6LazUp3GsV1TMm0rFmeGdvMIYGQoVJKSttjxCmbELs8mdhRKhjuSS18La3mEMONexfgfDGUfeTm1Lk05tinew+zus9YI89ZcFbWCnQaG5v664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MiB1CnxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQp5U77y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MiB1CnxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQp5U77y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 055ADEC00F2;
	Sat, 13 Jun 2026 11:20:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 13 Jun 2026 11:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781364008; x=1781450408; bh=iBlvt97HQC
	CS1hkyFsWNq2B7+AnWxuPl7AJpUlIcE74=; b=MiB1CnxSvK6v0DMzhd9hmkLztR
	NmCj+Lf1rpmpW1/AXAwwXWTECqWQH9p6p+nfZf/grYxGe0qAnoJ12FtAOJltk7V+
	czMumtBligDjvxqUDeVV0GObDfRM1liHcQHLUzu3p3xGC+DGMTCynRKIL/oafv7I
	Jb1CRnr6q77JQp+2+82hSeur+RANuVPYhBfDxDX7Dqghmax9bM/senBEyk4bA/3r
	w4NszFZ8Hve7XkQOvNcTb7/TIAcc36/N+eMFjYMlhMjKke5sn24VUnWfK0n9yMnN
	7YPIz3etsdRDTgloonN5tBm5CEnfTkIx4nzSNeDDNEVwtEP6qwyXnlW7nrXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781364008; x=1781450408; bh=iBlvt97HQCCS1hkyFsWNq2B7+AnWxuPl7AJ
	pUlIcE74=; b=ZQp5U77ypnj/ETjcGiNpQ0O+iCJSFA53q5xsldWvhx3cTteRqLt
	QESpuyk5ypUr0zpG2aKekRAY0Z0KGErMow/mdCQxi1ias4HveANMlt2Hr0aUpdEN
	jok23o605PzW7NiZmYZer8BcV8o/TTGYJxeVELvVx+bvYwMnabvBhm3KEhsTaB8r
	9OFpBm9widLuPpmMn5VzW+k0FhmoGUDgzgaT7rDLhTCR7IlmlvLVfYuhwHQrQ+pV
	tZDKrltFKDBsDFOGUyLNd4cabfK6fG+wPYWMx3xkHlJktIgNVKfi5K8sFLS/Cjf8
	tvALeEtIHYcNd5Pp0K51S0HfYWxIJe9zajw==
X-ME-Sender: <xms:J3Utap50W_Hu-X4-_S6zIMKiSQ_vEqiHEH0J0nAQ7L6Z8ePb8ep0ZA>
    <xme:J3UtatyBi4_gV7xxd4wMwsfnfb_RlkPF5IzYCX0toP7ndgeATgnQlrEpAvMcHawIw
    EmVLP2KRaBryQDlr3KfNk-RUJz0rh67OJkt2suJRxeyHVtrxjDMnpA>
X-ME-Received: <xmr:J3UtaoyF9JY5ZeIoJpIptDqG_LZ158wJSbm9Rk_IOoF3UMBCt6jWbzc0WyjfXfnVn6DvJKxtTXjQnCD5LvzgpGYzKgcHuct8YbXh>
X-ME-Proxy-Cause: dmFkZTGOrvgbYTvJnHSM6821PcauCZSfRoyLVp+CYk09LYu9xQJyw/KIsSL5YgDhosiZpu
    1j+vTie3OHY0OylCCBAaryc6fSQ/TS4mw9oFArzJRCz/zOTGTeoT6P02w+ovvk7hFV20Lq
    cJ3zzX6EcGpZFxsfEVPPzsvAg40zDF5HnwLkGw9/jYibzcKw/k754y7sfwgfhPTBjOVOI3
    EbtcolYD8xRMJBCbmCvg6fMyGEF93MgavrtsfsyGT2jMffsRNIwA6jevFD0PSggobC3G6S
    HKBghEIYmpzNY9Hyac5fhAPgzaPhqKu8Vn1NAIs5bK9ho9eWw+27r223x6wML/SeuyBimy
    /q9m7kc4DrsdDEsR/xLcDHaisl15xn2EAbiS0frvELch+litXM9ntoL4cOAbU2SeqjcrJm
    tzSrbrbIGf+boG2MstRRMk42LZPwh+zq5yn9P5E7RfVaQb8QwlXlKhDWdnNOtbJjhDf8M/
    MsgAsaDO23Pzb9piV59z6kbcVfPzzY1k9DvIdkoI7RbJq9ncvAhA93BvuOiBbBZ35zgTin
    vc1042jlp8ja7+nOGlukWzp10LkI/IIbFNkBRENwVAcrhqLSERYCNLFHv5GiLHusBWT2io
    E6LROp4gxhJPfGPoyB4ruULYua2qZWnOYLIOv1n59QXYEkFYKltciyE9EeSA
X-ME-Proxy: <xmx:J3UtatzOyQCzGI-PX0p6MLPbv8Z6oKelEqzFxN3smPxh5SvtYWBxqA>
    <xmx:J3UtaqZ4rFViQhHxDx4ykxtQFIgP98ctpgA9T4Quygg8gmewWq_LGw>
    <xmx:J3UtamXc2J9_2GfMEzPVDWwVZUyUOhpwtkzhiuzL9Q4SSRLvZZ5dzw>
    <xmx:J3Utagjdrf4sd1mAgb3S5jEDEzpmwoKDxjro045csvu2StcbMdkkxg>
    <xmx:KHUtavIIh_q77T9C_RsF24oogASIA4ApmGKg8Si9A2yK2sda2B0wtCAf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jun 2026 11:20:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "h8d13 via GitGitGadget" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  "h8d13" <hadean-eon-dev@proton.me>
Subject: Re: [PATCH] clone: accept DEPTH env var as fallback for --depth
In-Reply-To: <DJ7MJMIFZR5N.2SG1RWB46WPQB@lfurio.us> (Matt Hunter's message of
	"Sat, 13 Jun 2026 00:08:02 -0400")
References: <pull.2333.git.git.1781314780645.gitgitgadget@gmail.com>
	<DJ7MJMIFZR5N.2SG1RWB46WPQB@lfurio.us>
Date: Sat, 13 Jun 2026 08:20:05 -0700
Message-ID: <xmqqeciafowq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matt Hunter" <m@lfurio.us> writes:

> On Fri Jun 12, 2026 at 9:39 PM EDT, h8d13 via GitGitGadget wrote:
>> @@ -1022,6 +1022,12 @@ int cmd_clone(int argc,
>>  		usage_msg_opt(_("You must specify a repository to clone."),
>>  			builtin_clone_usage, builtin_clone_options);
>>  
>> +	if (!option_depth) {
>> +		const char *env_depth = getenv("DEPTH");
>
> Nearly all of the non-standard environment variables used by git start
> with "GIT_".  "GIT_CLONE_DEPTH" may be a better choice.

Isn't it sufficient to add a new configuration variable in the
clone.* namespace?  Unless there is a reason why it does not work, I
won't accept a patch that adds a random environment support like
this.  We do not want to end up having to add other random
environment variables like GIT_CLONE_DEFAULTREMOTENAME,
CLONE_REJECTSHALLOW, CLONE_FILTERSUBMODULES for consistency.
