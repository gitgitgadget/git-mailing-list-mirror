Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361533123D
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310000; cv=none; b=BEGdutP/vhDuzImPwBWLbcysc6O08IV4YzEXu9g+9pe7MYCTut+4ZyfFmB5moJRKMmH3F18bO7GPclauy22mOrdrKHf/tAnDaTX64vjyzL1Bf39+TsEQoMXKtEjlZUYOL6rD4WyLrMgRsY0bQMTWShrxmvdEqqfAp1Ta7+MyTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310000; c=relaxed/simple;
	bh=/SID74dflLEBFVlfpJMdgGhvc++gsJiErJDrAhPzWvM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA3c5Mq+rUBHGFzUU6IFzrasUCkyXrHlc+/WxvZhKs15oQWIk8dzOcd+DW+YBEIWwbgF+KhmpBMc2e5HF0XOXdgNp5zW3SjEY8ssN3PY5VK2/AOgJA03k6Te6GEBoFl1o6p4V/i4mqgmeagoXygK6eGO8qnSXGpbOkw9v2Tqg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Jyuwia9b; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Jyuwia9b"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533797e72e8so19737761cf.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309998; x=1791914798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ewVTWcl9azdFjdOicrNl9QjcBY97Wv98ze7tYFSfv0=;
        b=Jyuwia9b61I305hW+yY7D7BUKHr+vxymm4RXh1S/1vgrtoOB1qExYRjh+zkta0/FA0
         l63kAQIwpmfVhYSSCk14iZ1mQrH4C/FyHvGggwzoAXUtgBeDaeQcUBLRWbkjzUm7lNN3
         nubw0jdm/GcNf1fslF0I4WlyWHyHyDP24894Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309998; x=1791914798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ewVTWcl9azdFjdOicrNl9QjcBY97Wv98ze7tYFSfv0=;
        b=qu9G7PxANzpxSAYQq9Z29MNI4VXdQ5H6dspP0bk98mCc0BYV5VhmupygJi6spncfjs
         Szy6bi4HlHdhCFVpNzhHAiI1braBtt47u8e4YnvBtSU7A3Iv1Wa++umi66P/uIZz4PyJ
         t68nD3MN1WqPheV/5NB6tztCjmqxzJRph8Nk5Geto/9j7uVhwhYL8zblP6ozPv72b5fu
         7XVNxWuJA79F/lEFtyk8dQ9rFp8eOxIdMvKVXzodeA39r9CqKC+IfNLU7DoD1IrYjsQ+
         DBDErlH2mlZayLzPWbepe1wPoqS61RCcwXamh37AqJINHIXbJuZpO9DXW43ZwE1qpy0a
         19Gg==
X-Gm-Message-State: AFuF++l8/8Y4NUm3Vsaxpzcx4L8a32TJXde2/i7uvi1nRK9375Ndd95T
	+RcVircG/EuKfOOze/qHOcQfwSWhhQFoh6hR7bqp3V4mZ/q9dls44ahVLhiddoNuN4qOoLt2ZkU
	/uzznPxk=
X-Gm-Gg: AYBFou0dyRxpchfWIOWzNTNyC09Ldl8fDtVVN6Ep5+g9Y5EOgmAiKpru8Lhh07UXZq0
	SAS4UJY7q4gwFtJEH3P5WKqAwSqNiR3NEidKNhwfOc+KdHEASaf1eUgWe7WoIzRDQiS7oFuXp92
	A4XO1HlJwY5qffJrOwL881jfT8SIIhPkWgUtv/O1Sftw6+iFnru4KaD4jIhY/eZNYEjhDoRlWst
	T8n8eLuqtv2BuIiYxf/HlU8E3XiaMeadi6Re0WyGA68PvgppB6oF/w93TBIX4OgPPwZmi7YFllw
	08VNtPK0tn5Y0KG4aza2oHcs9d5uVRDeSoTt5gNAZVrqbcHFDxodfAou0NN/eSjZ+26XvBEIpyh
	YUNdJvd8SPHIRZW8vPYqqxnPJ+tK+WPK2TBFOvs4ixZbvkhOoJyFmkubTRL6IR4V6PtQDSYMODG
	0nsEkdbJGZz0Ts/WyKoPd71m0fIT8s8xt4XB+XGzIMMH1J6+IhKHfqrozR7Q8Cl6e1WcKFPN+zy
	P5B3sSpQibKD6xibPa9ilH1Dky4TLHeBTJmajy//4FxMEkfax/hHJCBgS67J5zoC3fToSqXVb2L
	bejaahAKEOI=
X-Received: by 2002:ac8:7fcc:0:b0:532:d176:5d55 with SMTP id d75a77b69052e-53511d19626mr216051431cf.17.1791309997940;
        Tue, 06 Oct 2026 11:06:37 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53572163ceesm1417191cf.20.2026.10.06.11.06.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:37 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:35 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 06/07] AI contribution policy
Message-ID: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: AI contribution policy

* Josh: What is the current AI policy?

* Elijah: [Reading from SubmittingPatches.] The DCO requires
  contributors to certify their contributions, and it is not clear
  whether they can do that for AI-generated output.

* Taylor: If we take AI out of the picture, is any of that inconsistent
  with how we already treat patches?

* brian: It often has a distinct character. It may get better, but
  currently it can be noticeable and awkward to read.

* Elijah: It is often useful for proofreading and improving writing.

* Emily: One thing missing from the policy is attribution. Johannes sent
  something with an Assisted-by trailer, which helps us understand
  whether and how a tool was used.

* Taylor: Would I review Johannes's patches differently if I knew AI was
  used?

* Emily: It is different for new contributors and people with whom we
  have established trust.

* Patrick: Sometimes knowing helps us avoid reading complete garbage.

* Emily: Having the policy in SubmittingPatches helps because people and
  agents will read it.

* brian: Many people do not read SubmittingPatches often, but honesty
  about where code came from is useful. Using AI for language cleanup is
  useful too.

* Taylor: The policy effectively says we cannot do anything significant
  with these tools.

* Peff: We are seeing more contributions where an agent makes the
  changes and a person acts as a "meat proxy".

* Emily: Those proxies are getting thinner.

* brian: The Linux kernel requires people to state that they have
  authority to submit the code.

* Peff: What is the rest of the open-source world doing? Are we missing
  useful tools by being conservative?

* brian: Some people will no longer trust us if we accept AI-generated
  code.

* Taylor: The Linux kernel is much more permissive than we are.

* Peff: We imagine that we will be sued, while the rest of the world
  does not seem to.

* Patrick: Opening the policy further would open the door to an even
  greater influx of contributions.

* Emily: That is why I want more attribution.

* brian: When I contribute to open source, I am attributed as the
  author. With AI-written code, I am implicitly using other people's
  code.

* Taylor: When I read code from a project with a license incompatible
  with Git's, I learn from it, and that knowledge may implicitly
  influence my work on Git.

* brian: That is a coherent position, but not everybody agrees. The
  project has to decide.

* Emily: Have we used a voting process for something like this before?

* Patrick: We need proposals and a vote. Who would be allowed to vote?

* Peff: Active developers with a track record; perhaps a threshold such
  as 50 merged patches.

* Taylor: We asked the SFC lawyers, and the result is what is in
  SubmittingPatches.

* brian: SFC is very American in its legal approach.

* Peff: We should give SFC more credit; it is more worldwide than that.

* Emily: This was a problem with GSoC. There was a record amount of
  contributions, but the quality was poor.

* Peff: We need to agree on a policy. Do we accept AI at all, and to
  what degree?

* Taylor: One possibility is a process similar to Debian's, with
  proposals and voting.

* Patrick: We need to follow legal counsel, and we do not need to use
  the same proposals as Debian.

* Peff: We got legal advice on the current text. We should work out the
  voting options, take them through SFC counsel, communicate the risks
  and concerns, and then hold the vote.

* Emily: I am happy to set this up. I have been doing something similar
  with Jujutsu.

* Peff: We depend on Junio. If people disagree with the policy, they
  could fork into Git-AI.

* Josh: Let a few key people put forward their opinions and see how much
  they differ.

* Patrick: Let us do that on the mailing list.

* Peff: brian, would you champion one position?

* brian: Sure. I will take some things from the Debian project.

* Peff: Taylor, would you put forward another position?

* Taylor: Sure, though I am not yet sure what it would be.

* Patrick: Then we need to decide what the vote would be.

* Martin: If there is a vote, how would the result be enforced?

* Peff: Junio is the source of authority, and usually follows the crowd.

* Peff: Emily, are you leading the voting procedure?

* Emily: Yes.
