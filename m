Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC23128D7
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830748; cv=none; b=tWzuDwC1sAQC0Xmz6w0lSrNymEiqoGfPKx75UeByDXC8xj0AQ2XsbEkdernognH3pfnOdOCNJ/SuCIHnuuJxoQt7FI6xOj/Oy2djl9dAAT7A9G5RgAD92RsIdG3SLrlab2bLgj/gacbEq9Yl77IqyBG7Tc/acVWSFytffQJRfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830748; c=relaxed/simple;
	bh=C8D82I3J6RX4CP9u5ckOswGX8e7gabpH7BSHgWy8yVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKdWi9VFbr+cidiQtf/0AtHwl6zylN1+jMfQp6fNDL2JoPUVAgN0lnoL4yPDF8yfrDxvDaWkgFGCc6f48m2Dq59rlx7JxuqLK5xqX2KjJc7SpWqndugrCRHYe6IhHlrpVLlUEwopVxQqNFiTewm8Yoh5M3jS1Z4KdjzUfBIjEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ty+GGoJq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2UTF51W; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ty+GGoJq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2UTF51W"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD82C1400064;
	Thu, 25 Sep 2025 16:05:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 25 Sep 2025 16:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758830745; x=1758917145; bh=/qJubgj2ON
	ecuX7MHFtpog1J+ISQ+xnuChZeRVQsrvw=; b=ty+GGoJq2WHNjZOhlASRDVdq/q
	CEZklwYlZTqA5C2yXXXHGVlsY9JD8Q8Y4vkt7UsAA24BFW7HefCb9Ijw0VhwhhFz
	B4W+m/X+1EkBS/BUy8+h87OHQ2JkfvPgmsBGFdZYUE71OVyXbCT49ovj0VIRixa+
	0BYWqLtYGBw4w2bNMjrnVxRqZg3OEZ8Ht6s/rQGFt9sYRjMwWojNFha3mWFifkSY
	ceZW+TJ52xQEKsZoPTOpNRAJLey4q1hWnhQUTAYBnb0SPn3t4Ly70PrGbHz9hXHQ
	ztp8oLmwZhKFuMEIsM0+cIw+IHsoMRbRwqPTPDsnN2N5J951HnxIQRkTYmGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758830745; x=1758917145; bh=/qJubgj2ONecuX7MHFtpog1J+ISQ+xnuChZ
	eRVQsrvw=; b=U2UTF51WFutp0B2xLzaMP/5AVkGAlFgjmGoEkjkAmlJZvdF5nMN
	B/2Jz2g9pOM7HA5IxkMIEm1iQD4+4f4RFkAiBSiXLxzb6v3Fm0GnlzQkHVTz3WQ4
	6Y2F99s6Qiz6P4R5VlkTsJ9PEXDpW+E2Z/siZcS3VxOnPBvNd21bIuDJctGuXLtq
	nRdk5xx0LFNdH1MvlRRK6+Gd4FV9Om4ZRMvYF//BsdN+YnmAlMSiY3fDkMWyDGXE
	cw5lQstoVTyQX08kUxRNQRhxkR8gPH94pzzNx6s/ov+LG32MBDyE84MrYdL5Gu5C
	XBFDsAptwr1sCrsRYEu81BsddPmLstqd7yQ==
X-ME-Sender: <xms:maDVaOH0qDI-qv7gJ0NB_prFJvc8gMmObdGiQcAWjjch8Q80Io_ICQ>
    <xme:maDVaOZkx8leQg_twVAt4f0zSoXZpyB18TNvOo8yYXziOkrqAt393T_jkY49yilc3
    nU_qIG8xPvfN1sb5Jvn_tOWNFJ8pvt_hsybBPmOTyo_U4Q3f3s--g>
X-ME-Received: <xmr:maDVaOVXIRoCneayyd9_xqCS-c-ZupDdtNXHorU9bZbBorlf8upRlUl9ogX0erHyMn30ts7kD9VrKWDGkJ_HOE_TKnnQGis63Lcf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:maDVaElILycujGC_PoHC2JQQpHlcg0t7La7IOLYf57ch8sHlPhjVjA>
    <xmx:maDVaJDrnUPPSs76AtZfBbotkNJwestiBZIMZ9_5L7gdmsdnp3N7sA>
    <xmx:maDVaDiqWJVXt5zbndosXW2x-F4_Vi6bQrHSofNKFFVZa0Ocp_S-mQ>
    <xmx:maDVaGwaEj5_VF2H_aMkSZt1HZVQKa4t-EQTKLi145l_up-CNxq70g>
    <xmx:maDVaDzsizG5Jvz4g_vS6Ui_REIade8OL_qPabki_Hj5yPnE13jR_CXT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 16:05:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 02/10] hook: provide stdin via callback
In-Reply-To: <20250925125352.1728840-3-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 25 Sep 2025 15:53:45 +0300")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-3-adrian.ratiu@collabora.com>
Date: Thu, 25 Sep 2025 13:05:43 -0700
Message-ID: <xmqqh5wqfgbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> @@ -69,6 +69,10 @@ static int pick_next_hook(struct child_process *cp,
>  	if (hook_cb->options->path_to_stdin) {
>  		cp->no_stdin = 0;
>  		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
> +	} else if (hook_cb->options->feed_pipe) {
> +		cp->no_stdin = 0;
> +		/* start_command() will allocate a pipe / stdin fd for us */
> +		cp->in = -1;
>  	}
>  	cp->stdout_to_stderr = 1;
>  	cp->trace2_hook_name = hook_cb->hook_name;

OK, so when feed_pipe is defined, just like when path_to_stdin is
specified, we stop saying there is nothing coming from the standard
input, and intead set cp->in so that the child process would read
from there.  Unlike path_to_stdin case it is not pointing at a file
descriptor that is opened for a filesystem entity.  ".in = -1" is a
standard signal to run-command.[ch] machinery that a pipe to that
child is to be prepared.

> @@ -37,6 +38,24 @@ struct run_hooks_opt
>  	 * Path to file which should be piped to stdin for each hook.
>  	 */
>  	const char *path_to_stdin;
> +
> +	/**
> +	 * Callback to ask for more content to pipe to each hook stdin.
> +	 *
> +	 * If a hook needs to consume large quantities of data (e.g. a list of all refs received in a
> +	 * client push), feeding data via in-memory strings or slurping to/from files via path_to_stdin
> +	 * will not be efficient, so this callback allows for piecemeal reading and writing.
> +	 *
> +	 * Add initalization context to hook.feed_pipe_ctx.
> +	 */
> +	feed_pipe_fn feed_pipe;
> +	void *feed_pipe_ctx;

The comment for the member is a bit too wide.  More importantly,
this does not seem to capture the fact that this is completely
ignored when path_to_stdin is already in effect.  We should at least
document it if we wanted to leave the behaviour as is, but I wonder
if we want to detect and flag it as BUG() if both feed_pipe and
path_to_stdin are not NULL.  There is no inherent reason why the
data prepared in a file must take precedence over data coming over a
pipe.

Thanks.




