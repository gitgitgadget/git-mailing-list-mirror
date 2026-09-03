Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5726AF4
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471138; cv=none; b=ddI9uHcs5+FaJc9CoX6wFRztzVR5Wqzu2dif2mGs7qre8vlzLnBVWebm+FCSQ334wBzzHC+5rUM7B4Bn4Sd9RIkI/LKmAA9Yw2KxJk4JU11NbA1N16bD5LzlyNe5teM58fvz3GmLr9GlfpbWfhra3B3xcGHr29J6IeTEJWklSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471138; c=relaxed/simple;
	bh=2araMK0Q/k1Es67rRP8YrCByOXTdjFCepi/pQIy2Dx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEm/FYywxNVGFqTa7rfvcLrZNlJNjVWIAyxo4V7t4VI4qKUDK0FELYEZjU5tSYjsQAWJhOVRyEzTWf0PVJv7pAkamoEdThwe6KoK7F7n35kNLcxKDuR9U+3zO6ekXk6XZa8lt69xezOTs9xqjIBFudcN1NX1SYrgzPILXLm0phU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lTgG8BoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kk86jOK7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lTgG8BoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kk86jOK7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEB577A01BB;
	Thu,  3 Sep 2026 17:32:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 17:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788471136; x=1788557536; bh=5AoapbUuqL
	34191gIHBmXbm79hY0i5r+nAVLNAWGCu8=; b=lTgG8BoGuXtfUH8EseK+O1z7Z5
	zf6miIUs7m/0UakWAVoFK5/GsPafbCRM4i53hE45k1ispQXe1IWtzE38SUSN+XyZ
	Ap4Cwa9EZ0iT/+lafWBU9IB2ypiln6aNoRbvGfFbkkWL1q0VuC7cB882z3ktIyzW
	pyTjI7uW9yYdcQVKML3hlN7VxV6TOgy4b3wDtcsnslM/zM40dA/maqMxxRuocV5u
	3vjPKV9IA7glX7YfgiZb+fnFb6KilD6gAFjesRLj1K2wrc3AUyZRE7TWNeQ/AKCB
	Cv4RA6a6JFP0AfU2UZzRUSVMXm3RhYl3m5yvLi8X2biYnE980rYxdgysBCHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788471136; x=1788557536; bh=5AoapbUuqL34191gIHBmXbm79hY0i5r+nAV
	LNAWGCu8=; b=kk86jOK7QCi3gTedKZko2lKBHk2VQHgTODI2Yz2zi6Mkyr9JHsT
	mttMUxKD0uPVRB1Ws2OAxUJzzWqKTHJpfXRuTSjvKpM/v8H03phZ/dJp2705C6Pa
	gJtWFfqhJcrukzCq4jgBNf8KZiVNZE+YwiQmNDZ2HDcEe9W2TMZPporlU6mr/Z19
	sVDkLhvVJ9KtqcHIeeqnOPuKMuOqyYv5nCtf24Wy1d0iyxXbiiYDR6DK0l8ivFfc
	XwmCiKDEiyAL0nWG31yIeNxB6SEcylk4A1EVeFC5RdQcOy7JkyNbDF1RA4+LQHiJ
	pYPYyj31cD4kqrtksv09McXVmOK0R7rFcNQ==
X-ME-Sender: <xms:YOeZalBh3rHLdGblPw3P7Zvrd5_f5_jz2YfZDeG9237F5ECuik8Eaw>
    <xme:YOeZaq9Gr06HneFNqxcetNhat_pgJagWvKlEzVsvLOHyfeJ1zTG6hI8c4i5GXI3xl
    HHrSMo036THBEUETnd_hxBqP8xg-LCeqec3wOo7PJfwdeG0huVPy78>
X-ME-Received: <xmr:YOeZat9a9BnJ8GLVhsHuH5Jh7f4ae6R_d3ME0iOeqiS8GCRqN67dUV5GdWo1y6w7rbbszVDyXZOcvSAhTyB4jiNRALHFkEvhQQ>
X-ME-Proxy-Cause: dmFkZTFeSJaIjS746fETfxahg54gk5R0edMykewTNSVWysPTVyAQDuW74O36/i0UtDZCWf
    owpWWQFMkOF09DKw+QKqoBfkfdKZ+zUP3DvuAyBaTsq18kM8oMxkKvYZ3+vuyHAZf0UHgP
    2ULthkdg9HV2VwhbpxYsfW3588q75jdG4pHs2LWe8KntGx+7/id5KldfTnfOdvDO5g/0jO
    r07hzicgmf5etCKo0E0WQNWyzNX95RBWclI6YFS9bQBCDlaoByvrcGJ0BozebF8kfQR6p3
    vVsZOSyL427AHku7nDGN7ChWRGdFaKqyOOcNO1PhEP+APXX9NUj1uarKmwFF+gpVeo9SSQ
    uLx5iVVl211XemM/cjdMGQ7h7M3q5+OhlRxu0Hr4EOcwR1AaBHpMzOHuAjF/opDR6FkHoc
    SbTrhHSB6I0TG5ZwNJUYuIn5vZLLFNZY9JUgJ2l6lPpId8ARI7G44PdEpbofR/YIAKY0DQ
    reDh3bS+b6deYJ5Ek/2BzrWt/mrrwHTXvwU+ojElt53XJ5egsktiOYs5lelPSTs7OFdtkc
    nxrp3MwmzTYNpUVSFt5Jqo+cn1eUS3X9XFcP8cDLmRuRNWZdPLLDgYhEtco33q7rsClVyb
    ZnhLiHbmGDD82cglsuRxZFxBrhsPWEqZq4ENpigyz+fDBEjuPihE8S1Qjc2w
X-ME-Proxy: <xmx:YOeZapeODaemTQ7SW-vo_qx_nVDESTAWrpCYiExgKb1dwx3146IUwg>
    <xmx:YOeZauHbdh597xsQ-ktVLNdZ1PCPCSmuvLrpkgWLMiy_P_K_v1u4Wg>
    <xmx:YOeZavdFJZ6vmvkLMet-XMYlEmS1bopNQLMJBWyWrR_NsMUjxim1AQ>
    <xmx:YOeZagG-QfLt6B0UWJKMWR6E-csFQrILaFMHxBY1BbFIGtzojcJ6fQ>
    <xmx:YOeZaq-BJyh6BRmb6zcTjhm0D--2LUOtuxxM_HH9NdrmjlrAtsoBRUHV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 17:32:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a
 conflicting --no-commit
In-Reply-To: <20260903125524.67889-1-f@lex.la> (Aleksei Sviridkin's message of
	"Thu, 3 Sep 2026 15:55:23 +0300")
References: <20260903125524.67889-1-f@lex.la>
Date: Thu, 03 Sep 2026 14:32:14 -0700
Message-ID: <xmqq7bl29g2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> The tests here check the ref after a conflicting pick, after a clean
> pick and after a clean pick under --no-commit, but not after a
> conflicting one under --no-commit.  That is the combination a user
> runs into by accident: the pick stops with conflicts, and the ref
> "git commit" would take the authorship from is not there.
>
> Pin it next to its siblings.  Letting the ref be written under
> --no-commit when the pick conflicts leaves the rest of the cherry-pick
> tests green, so nothing else guards that path.

It is not apparent what problem, if any, the description
above claims the commit addresses.  Nor is it clear why
checking these combinations is relevant.

I also fail to parse what the second paragraph intends to say.
What does "it" refer to in "Pin it next to its siblings"?  A new
test?  Any test inserted into a sequence will naturally sit
adjacent to its neighbors, so calling them "its siblings" offers
little clue to help the reader understand the change.

Can you help me understand the above two paragraphs a bit better?

Thanks.

P.S.

I shamelessly asked an AI agent I had nearby to guess what your log
message might have meant and got the following.  I am not sure if
that matches what you wanted to say, or if it is totally off the
mark, but at least I can follow what it is trying to say, even
though I do not think if that matches reality (for example, when
"--no-commit" is in effect, we probably do not want CHERRY_PICK_HEAD,
even though the version of the text given by Gemini below claims it
is needed).

    When a cherry-pick is run with the --no-commit option and halts
    due to conflicts, Git must still write the CHERRY_PICK_HEAD ref.
    This ref is necessary because a subsequent "git commit" relies
    on it to preserve the authorship metadata of the original
    commit.

    Add a new test alongside the existing cherry-pick tests to
    verify this behavior.  The test suite currently checks for
    CHERRY_PICK_HEAD after a conflicting pick, after a clean pick,
    and after a clean pick with --no-commit.  However, it lacks
    coverage for a conflicting pick with --no-commit.  Indeed, if
    Git is modified to stop writing the ref in this specific
    scenario, all existing tests still pass.  This new test closes
    the coverage gap.





>
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>  t/t3507-cherry-pick-conflict.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 44596cb1e8..2ce2e88184 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -100,6 +100,12 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
>  	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>  '
>  
> +test_expect_success 'failed cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick --no-commit picked &&
> +	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
> +'
> +
>  test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
>  	pristine_detach initial &&
>  	echo foo >foo &&
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
