Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD32BD0B
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780356794; cv=none; b=dhqtN1RsEvMROF44vAdbiIuTAFBF426uo7yvzjxq5wkbNAhHnN5aEm0PU/6COif650wOilEXS1mH68Og7rvTKllLf+VJqFjVOAviilgycx7CCsS5AQ844Ybno0Uw0CKgbSc9J1hZv11VgdcgMfphTyU5wfhXtArN/zw5C2f+qMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780356794; c=relaxed/simple;
	bh=1zLtIPChsAZPVAYFruZjVWyRe70vO6NeRmczOH01qrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lAnRrQrU68sDBWN0JOXXMLv0XFl0jQGlhV8wcV9K0vusen/KjwClyjbcsd6K+Qd2H4QqSfrheS5CGyM4IFDFBEgO6F6R2xSqfb+r5YiTvW3mz4nMR4QmZTm9aPRrDM5ETb7tgjsICNhr5nOH3KcaJWKx5p4FBg8powjSoT3frng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MwOHhBS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5hh9IyT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MwOHhBS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5hh9IyT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B73C1D00038;
	Mon,  1 Jun 2026 19:33:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 19:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780356792; x=1780443192; bh=8cJbZuTCwe
	gp5FOZX1XvCikJ+1dCxrfrqcMGCtsvunc=; b=MwOHhBS3MLvc/6oScPZlrflxz9
	JEAQjL0R5YhZvImbsQssuITA7JV3BypL/bOvN9IQ2pOzhG/3QwEzVlugAtfT+pIq
	e+yRrP6zDolB+1aifKzdlJ9S70XCI6EdNPdz+U28nQGEkbYHZKmHc3yd1c9AdTN8
	v3a5a4S1l7Zb87/+vfp2SJbGUgx7Ej5uCnrjT+uqFWZijvNMFh9VHpPcQcL5Oper
	P3WroZS5QLIFtKubSZbaYI/dCbvMIx2JCAGD6yX7LiHj2CU77EuJDcscIooHPlAl
	cpEn3ooM9axskF8ZXT0fOkDPgUInig4GTvuq/dvJ299pwl7ZaCEUyDgGHIFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780356792; x=1780443192; bh=8cJbZuTCwegp5FOZX1XvCikJ+1dCxrfrqcM
	GCtsvunc=; b=d5hh9IyToKtdRDtg1bI8rlh3L7ZnzozT1uztGO5/85Z6rKDuW4N
	5s3EEeqGfTlRUGZsdTv6sDqz1Bz3ZoDVRePoziChK13EIcuqoaT/l5NUkN8/iR6q
	jLTLsdfqg7OhOEpn81qICCEFZhuM0xaD03D9x+X93WxHhO9p4Ch2wyR3evPXfL6E
	REl0vGGPMmEvIr0WV7hnDZxjhQn3VB9/17K81Ow3hxdf5czq59IzeiqaiB87T3G0
	X7nt/NIlUEWOfoUsPUQA7yqteLNRUcx5EflLYeMuv2QxCSCAlGV9Y73D3tdCNZLY
	abIMS64SJdWtrwII6vOZsihskqJGenjycvw==
X-ME-Sender: <xms:uBYeatmDoxQU1Y6q1MZlD5mJ-502chifPKz6rxz5Lfx15viZCEh6EA>
    <xme:uBYeav3ZTs-tsufakEMVZ16by5HMLhKWtm3wGJBmsfyiqHTDV4vYfHVIaZGgPQX66
    kdmBP0uF1cbPH68Jw2W4PQe0EubMPVGQKFDZS4-YC14zilh-9_JEVA>
X-ME-Received: <xmr:uBYeaooskuUkTLVrz0R1F2euIT7dNOmy8kQkDT-Vmr9xaKLmSRb77SlFw87q2vgifMMsPWIfUITCWNOQRY_b8gk0iKdn5DykLaCy>
X-ME-Proxy-Cause: dmFkZTFHzA4+092gameXRtyMkId+ezWq7uOaZb5ZnnK0PuOyJ2o/CwYXJKpNt9ue6xhDrq
    ZmFv/J9UX1PwlpkOx56/gyql4FnknW1c7Z09jkiAUedCSMcOSjI2az0yYTiLU5fxNq8Cl3
    gnxLU7AMh72rvFUvN50dW9YIhF2/KUZ0svpcHUWXJeKrdEW0VjIqkUWnbbcF7y3p+gxYnS
    cRPt3WDExJGoKyz5GFSEvg1wlSWABWSuUVI2rJYo+guJMVYd/mPKrgQkB50Zqf0EI6jwPq
    UVGB7dVv3ESUD91h5CSubdespV4sB8SWBllMOtnY20wvlaNrlk4XXL2GgaDzdHW8w4BwNR
    eHpihc5GALHZVoBCfnxVdIEec9yAiXRd01paAvsUwyvPqYTBKCGgFBKS9tQ7FfIbZIZflI
    a6oWhwbvaeWEmSLzcTnOcxGOXxdwUrGtpn0YxlzV6YNkdpdqH30PeIh7aCWJr/iw4deowo
    UWfsUM2tLnZj9hVeSzdHHx9xwrPDeJZQdlOwUcMej7DjO92Scw6wCQRizkT6zEfSx+6D0M
    r8AKQYvEQRucD2GFyHqrOrpfO+tLfg6ywjzw7LO7PrpOZHtoLflmI4wFx5OKQ5jIWchG1B
    7+u1qPN7R0erQUNu5Xp8zFKUBg8aNjO5uw/BerAlGioMJtRr8zcKNj7DM2Kw
X-ME-Proxy: <xmx:uBYeascAmacwL9NYOIY5BJjOtt1b_hjP-9poWm_vdTUiwUvjwUheSQ>
    <xmx:uBYeanpUjcnuIRG130TeOA7tF4UmScBR2w_o4wWTp-0zhIYa0QoTSg>
    <xmx:uBYeatHhIMaljBxFUi4p_9SCKbHzoeJ8KwU_I0FCv5ND4l-p-sAbxw>
    <xmx:uBYeanv_eNnV6Muj-uBPCmsO7iV1PNSDSxhOATa9dhrwbv-N9Jy6xQ>
    <xmx:uBYeakKjLEWYQlekg0513dJgP1OZdEkx_g8pIUfQVUg-U46UBP7EJnRY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:33:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ivan Baluta <ivanbaluta.dev@gmail.com>
Subject: Re: [PATCH v2] doc: clarify push.default=simple behavior
In-Reply-To: <pull.2115.v2.git.1779767888508.gitgitgadget@gmail.com> (Ivan
	Baluta via GitGitGadget's message of "Tue, 26 May 2026 03:58:07
	+0000")
References: <pull.2115.git.1779433093971.gitgitgadget@gmail.com>
	<pull.2115.v2.git.1779767888508.gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 08:33:10 +0900
Message-ID: <xmqqjysh25vt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ivan Baluta <ivanbaluta.dev@gmail.com>
>
> The documentation for the 'simple' push mode currently singles out
> the centralized workflow, which can cause confusion about its
> behavior in other scenarios, such as triangular workflows.
>
> Clarify that 'simple' always pushes the current branch to a branch
> of the same name, but only enforces the strict upstream tracking
> requirement when pushing back to the same remote being pulled from.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ivan Baluta <ivanbaluta.dev@gmail.com>
> ---
>     doc: clarify push.default=simple in triangular workflows
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2115%2Fivanbaluta%2Fdoc-push-simple-triangular-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2115/ivanbaluta/doc-push-simple-triangular-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2115

Looking good.  Thanks.

> diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
> index d9112b2260..28132eedfe 100644
> --- a/Documentation/config/push.adoc
> +++ b/Documentation/config/push.adoc
> @@ -41,9 +41,10 @@ this is a deprecated synonym for `upstream`.
>  `simple`;;
>  push the current branch with the same name on the remote.
>  +
> -If you are working on a centralized workflow (pushing to the same repository you
> -pull from, which is typically `origin`), then you need to configure an upstream
> -branch with the same name.
> +This mode requires that the remote repository to be pushed to is
> +known.  When pushing back to the same remote you pull from, the
> +current branch must also have an upstream tracking branch with the
> +same name.
>  +
>  This mode is the default since Git 2.0, and is the safest option suited for
>  beginners.
>
> base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
