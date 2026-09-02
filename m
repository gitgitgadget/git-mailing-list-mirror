Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E249233954
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 03:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319532; cv=none; b=bbNG7bOKf5K5V8b+323ais74C5qQyUeT4oDKZGskXGzGwQOGQNX0Jyy0jrRKP2qVh1uLysemSISa/jOMRQMuQt+hd6Nv5Q4jTOcfLjvgVGTN9T1dgU6RVPzgrMQSOhVnSWE2/dP+567KA0h4ynBQM8+qkEDT7aNYhZLiQiflBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319532; c=relaxed/simple;
	bh=0rFpJRNUPbQdt+RbgBflGvx1NO1It6MOGbik8WRNq9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8Vk6C+A2VJ2Z/SsV3EW1tgxTwJagocuuyl1xBmYlDlqCCDhWVqLUMrXfoFWd0vcJN5QDSNfKhk6/g7YFbgl1PMcfkgK0TMaQ4ESaOko48PUh65e72dq1JJWs7QyRnwA6ytaSFVPXKiZHOqJzd6ucIHL87UcSfFFSKu6atWwwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LudWXa85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4NlEWvW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LudWXa85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4NlEWvW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2A69140015E;
	Tue,  1 Sep 2026 23:25:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 23:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788319527; x=1788405927; bh=e9XF179pC/
	lJCIGFd/FK144HIjV4IW+ct3R/opP6es8=; b=LudWXa859xh1GkFrKJW+a2Ytu0
	s5+WRLvz1NIVSc+aphTmkpRATmLDQI7AU0r/uYEd3iRqp/dnxEZpk1S0jWfX/Mz1
	soS5zxU+1BEdVHRmAez0xi2mXOnXTpMR6DCsFvG1NrXQyVmkqIS4e7JjjIBkPJ4H
	OxS+9dgFjpWy2UbaRc8PPtoDo0UKvYoNUN2EVGAFGpO/5YbJK7H8WX1spzLVDQgD
	9JIOwFFj4FoiDHR6jvX5iFMqN8HIBXmmM3lia8U7GBBKLA4UGzblRIoWbdZP+9iM
	JE3aJgBl0Ui3nccEOYToaUdt7mZXqa/oGUCTDSPNvTNRed3Rc2We8Dq+4k4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788319527; x=1788405927; bh=e9XF179pC/lJCIGFd/FK144HIjV4IW+ct3R
	/opP6es8=; b=W4NlEWvWP/q+Y/VemAzYgDae3dam+cXkXnjiz1Glb/UeqoaT81j
	uqMN3imKOTC6zzE8dFjMeekpkt619/RnTo8ZhQPAhXSGKS3sUSk+DgEiZnHs87bD
	mif5dq8WBSysCS1S4mmMphP3qGRDIuW5CQkMPF/ZPaCZDA6GPilYaE7O6Py/H0VE
	3auztDA11sy1Eb/zm7OE6tdK1SgVlxAtPIl845tGBh5ER91BvfpQKiOD2WGVVy3S
	Dnmh8aR2vS6hj626MhznFox4mYOaw5yqbGdEBf0ZEQyYzEmIkCXfMnxPvBtbJPoZ
	IuLEVi6cE2tnkHuhaNI6AIQ4zs1cnPoSIVw==
X-ME-Sender: <xms:J5eXakEWIypMaxrBsnrc1XGKf1Bgqr07n4JFL-OxkJmIo5Ctqjv1aQ>
    <xme:J5eXakWgCbznGRzvgbT0HIEHuUiGmN9HYYc9hbvLLPoApFHs9lLMFA5johmvyeOEM
    AfzfRlKgzNtWrl5Z2X26fUpHRxGqkSiP7Z0ewyxeP5feR2lZAne>
X-ME-Received: <xmr:J5eXajJJnbngzuVI90aYEUbDsEWCf8cP9D4fBizGhPNfNZ6ZeZN5JcEmZjWJc05-C742pnotaH7btP4PRvybXaMGe_EVAer8_w>
X-ME-Proxy-Cause: dmFkZTGiG06Au7hMshpULuvc4Y7srmNJJsCmu3zD02or80+P8gIa/vasqjly3ZR1Hexy47
    dVGoe6wOkpxj2BcFdfnFtw8FNUBM5BPfik9nMDNanoJB76L3v5zd5FSByl0kOir01s5iAz
    CuS3vORJNLeE1ttiUND/eT7IyG8HFWJg2doUBHxJfS7YXlixTj82rGIBGihng/W97lmQVx
    4OCPFCG2t38yxTRuzj3JFw5NXBLZ6TvfkI4z1Cv5Ad2u4oYuESHFxeDZU8KAMnrlbJGSP/
    zYdvnG9cNXFpd3fvCZxu1/7wm4x2uranhSNvDDiaTJ/a/bioDGDWFxxs284T3voskfdSLY
    PfSgWH+qsAVNVoCF9u+MEBkq+/DuRDJJcfr/3TZj7uu5C2xUUxOPs965uyYBfKZoBDdJnv
    QvOhkt8MqWLC8LTjs0tJ7t4zwm2hR+iCNt7DrUD1eLBC6iek2Y1fWcV3hf+JBNzPrAzYF8
    B7LL9E7Cvq04v5OyuzVKMueqID2yqcWAUdNIx6U1zOGwsOCuB+ftxGfWtaZfcbNKGB04OA
    AgQKFNML2d0lpO68QFetfgv7FRpf1LPm9FPMOWMoNhVf068IOpvJIysFOHwkcSn1BsY4Io
    2yWkKYhIt+STDh/O2Kza/1H1Smp+6iLt6yVuHeyvxWoM4T8yHsXgtGSP7jcQ
X-ME-Proxy: <xmx:J5eXak8k8wa8uaZEuMdmB8LUzwoHbwtRZQUCu1mofejqvoXLLMh1Yw>
    <xmx:J5eXamKlOhAgtvEeUWqi4hpu0fTu1Im0yEVBeTdPxNccPHXc6VrlDw>
    <xmx:J5eXapnEfFoHaZesuaeat6jzaOWGXr8kqBS9OVEPczH3K6Bp6HOhyQ>
    <xmx:J5eXaqM-uBIb-GfswJmzf-H8tUnALSHLkLc4Or5-7pA81-xZ6wEh9g>
    <xmx:J5eXahy-ew5ohZzv53ddDH6bVvVZM6thyLy49QPVSrTHfT5_EZgeeUu7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 23:25:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
Cc: git@vger.kernel.org,  "Aditya Garg" <gargaditya08@live.com>
Subject: Re: [PATCH] imap-send: add --draft to set IMAP \Draft flag
In-Reply-To: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90> (Wolfgang
	Faust's message of "Tue, 01 Sep 2026 17:13:21 -0700")
References: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
Date: Tue, 01 Sep 2026 20:25:25 -0700
Message-ID: <xmqq8q5kl4gq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wolfgang Faust" <contrib-git@wolfgangfaust.com> writes:

> The documented purpose of imap-send is to upload draft emails for sending
> later, but it did not have any way to mark the messages as \Draft, so some
> email clients presented the result as an un-editable, un-sendable email
> even if it happened to be in a "Drafts" folder.

I agree that defaulting to '--no-draft' is a sensible design choice
to avoid breaking clients that have been working fine.

It would be helpful to know if e-mail clients that send messages
from the Drafts folder without the '\Draft' flag would misbehave if
they encounter messages marked as such.  Knowing this would help us
decide whether to flip the default to '--draft', while keeping
'--no-draft' as an escape hatch nobody is expected to use.

> +`--draft`::
> +`--no-draft`::
> +	Mark uploaded messages with the IMAP `\Draft` flag. The default is `--no-draft`.
> ++
> +With libcurl, `--draft` requires version 8.13.0 or later.
> +Older libcurl still uploads the message but cannot set the flag.

When compiled with older libcurl, would the command error out when
run with '--draft', or would it silently ignore the option?  I have
a mild preference for the former over the latter.  Issuing a warning
without erroring out is better than nothing, but people tend to
overlook warning messages.

Also you might want to consider adding a configuration variable,
perhaps?  I dunno.

Thanks.
