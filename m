Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B938E8C9
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620176; cv=none; b=gjYn/WbIpvXmIVL8Lw2rmf+3e6hr/F2KpIQTkZmNoIIGdlNkdEpNjnX9vy0yYokd+Ng5oLBm6daQzXa0h25nDnRwbB64NgF9mPzGOF4qzPhcVG/yToudkfiGacZ4FGpeTLPOPB+ThNku6zBjeaeioLwuq/VM91FJyJbhJxqAGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620176; c=relaxed/simple;
	bh=I3xPmL1nY6BzRbiol6Qps/wEMBDvPmxsB6bt8A0ATx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiBB8hv9gaUuwIY+Is4X2m1+9R6fvxkWEq6cLhjYhhDGykNXdVbsQ7pmDVEzf0xewFguCBzuCMFvskro1JKRKVi7khBXlvN5GBuvvZy4Gpo7eahgj9iK6IPZbnQb+rUr5ZnqhXRmAQddSs5IouwreGBgfB3kKGidPX0bRS/htyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VFGKxVlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tDadUyVb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VFGKxVlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tDadUyVb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8FCDB1D00030;
	Mon, 28 Sep 2026 14:29:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 14:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790620172; x=1790706572; bh=+y3bx9E9De
	OnSG5qZe5SdJCm+egr+ZSrKT14D71bdbM=; b=VFGKxVlhbRpZBdJgBZOv8xAb9l
	4GPr/jANF/crwQTkTdSH8XZIQi/tN5giU/knCTCmCsr6eJSIcFYgfRGQPTuxb36+
	Q/s2Toa7Z2kzsxSddwC3HsWOdPIwAIfECjo9jExQAMsQqGOykkqwKNbLY5Cy3Ofl
	40jGtm9J6fPGw1JJc+z5sImvcwOkulGO1qFgyYxWm9nbYM/GXaQPCnzfYCsvZ0CQ
	AtiSyA7g5zODu13l5rxvP4mQscL8n7vopFJOTtvZ05v2gS+byseMrkVF1aOT8kNF
	B16yLLXjP73xNsmnbEX0NVpnuGJtzuEYAkZNNDN9dnvuW44gG9NM0if07Ocw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790620172; x=1790706572; bh=+y3bx9E9DeOnSG5qZe5SdJCm+egr+ZSrKT1
	4D71bdbM=; b=tDadUyVbFw/Kqi+UEVI3k0L74bmYuk8fJmCkiYxa2z62AhoQuGK
	/SbJrCyL4RvrT+vjXOJfzr9S/WUBaZAkCPo3McBmBx/+4q2En7vcVSYTgDalYapx
	naPMZCsEQht5TYvFn6nVOaDGRFb8LS0rr82M/+dgqpIgMhapeUz+Pz3yOW3KyXlf
	bLLUytjG6kovicpDmsK6eW1/ZyXxfor7l34Ta5fN2RGyFBacAeFHN73vtVxsdzGS
	JXWrirjRAioWP4F82bJLzhiTAqWsuayo0liPbvDZOEhAeUQuR8+qFsv4e1be019v
	Prat1XnKEdVpAB8HavYRDBIqgA2pladp3pQ==
X-ME-Sender: <xms:DLK6akbWkb99UD4RJVp1v9yQPgk9-RcjtsXSAC4YjwOpodJbIv_xZw>
    <xme:DLK6amQGUO9t3jZbgGswhK7n4LWasIbNRAMZp27nAcB6zsP8oI48-QV4w3LXOAQoc
    9pMNbYQi2bHmAx-TPnNgf34QEXFNReowKRWbmZrMlTBi9T5ZrkgoA>
X-ME-Received: <xmr:DLK6anQjEwqXfiro0BmjwpT_n09yUPtgwHV0E7QhNIzHGsLGAGkra3EseTU9_R9sU_nQSSQZvKtnkwFRteXzzZ_QEoudHArpsdhL>
X-ME-Proxy-Cause: dmFkZTGwMuC+T1f0lffgYDZD+OPvQKdWN1trRS5QnLbt9GqKhZTFrK4C0L4IwxaMhGmwz1
    yq6DxFJ9THz2sO+JKAlRR2dUl5bf5yUbGqLBqp5GndRCnCJRJraclJdPwFVsRIjW9Hmfxq
    GJ1QdCEXGl9SngN/Aw5VjSuPOZ0zrxZkTT47w0dYSMBpUQDrzqARN6DajhwPsHoGAsMFAd
    wLff48gIrvEPiOeJV1mZ4a88BwOaAzxr5vFqmOyBbNFt5SWDdnHAAKBAvTbuTpFq2Kh+2l
    LHt+XY8VmxHOIhd/cn/+IChPNvgECq+DwippOBhPDYoBX+BZoK1E32pKq0ZCt+YyZ4q+eH
    0M7RgfgFYahUBGnHTgdHjGMfqc/k94vXfnfE7nUiP1VxrCdfcJO+N+EBvgNFlQvAHJ0KCX
    ARTHa29+UMiQlYtQALSQ1NhVfWYSSjBx+1+07bJy+/6XNU3CmVxotezS5qUseup8ny3xx8
    uB3p+DeXEZSp/GnrfOjVWZyngH8BdMuO0WUR4S/2+3XkHgUwsl6ivflbDdNYQHxnwHS7la
    5s+6qKAp1I6W22AhnM+OrfWHEMhiZmNZxPrloKJewR3UNJAgVfTlgKTLxCRhqUwrgQBuRY
    x8saBZ1BCCbzckQF/o7GfDYdAugXMjSOomJzajvRrjob2tjvrvuCbfAYEnJg
X-ME-Proxy: <xmx:DLK6aqR6kUjPNgl9oPZmQJBpZ_4TJVSUZNU5k_5JKxvdVKL60c3-kg>
    <xmx:DLK6as5MZhZBjTcGfiiwZzXqJh4wFzS1SabL4KS5cG-bsX2qDmG0yg>
    <xmx:DLK6am0hdOiUOikRLEXJXfObq68C00AETchPMJVxobQVevZN7GD5WQ>
    <xmx:DLK6anBxL_zLwcmKn3PmhpG2qjB01XTKKoTqR0J5hoFF3Y2OuzQW1g>
    <xmx:DLK6asRbOX5YCO0FDczMV7nZsDCg_6CIC7SuM9HW0doU-UenUhI1yuGL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 14:29:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] doc: interpret-trailers: fix cmd examples
In-Reply-To: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 27 Sep 2026
	16:12:27 +0200")
References: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
Date: Mon, 28 Sep 2026 11:29:30 -0700
Message-ID: <xmqqh5j9mdpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Fix `trailer.<key-alias>.cmd` examples which have remained unchanged
> since they were written in c364b7ef (trailer: add new .cmd config
> option, 2021-05-03). (Modulo formatting changes.)
>
> Use this example as a guide for how to phrase it:
>
>     Configure a `see` trailer with a command to show the subject of a
>     commit that is related, and show how it works:

This read as if you are declaring that you use a template that
invented to consistently give intro for each example, and made it
look like the use of `see` was as a placeholder.  It would have
avoided the "Huh?" reaction if it were phrased like so:

    Steal how example to show the `see` trailer is phrased and use
    it throughout:

	Configure a `see` trailer ...

Other than that, this looks good.

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Topic name: kh/doc-trailers-cmd-examples
>
>  Documentation/git-interpret-trailers.adoc | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
> index 77b4f63b05c..3e81632b252 100644
> --- a/Documentation/git-interpret-trailers.adoc
> +++ b/Documentation/git-interpret-trailers.adoc
> @@ -305,9 +305,8 @@ subject
>  Fix #42
>  ------------
>  
> -* Configure a `help` trailer with a cmd use a script `glog-find-author`
> -  which search specified author identity from git log in git repository
> -  and show how it works:
> +* Configure a `help` trailer with a command that searches for an author
> +  identity and show how it works:
>  +
>  ------------
>  $ cat ~/bin/glog-find-author
> @@ -329,9 +328,8 @@ Helped-by: Junio C Hamano <gitster@pobox.com>
>  Helped-by: Christian Couder <christian.couder@gmail.com>
>  ------------
>  
> -* Configure a `ref` trailer with a cmd use a script `glog-grep`
> -  to grep last relevant commit from git log in the git repository
> -  and show how it works:
> +* Configure a `ref` trailer with a command that searches for the last
> +  relevant commit and show how it works:
>  +
>  ------------
>  $ cat ~/bin/glog-grep
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
