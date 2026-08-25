Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489039281D
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694107; cv=none; b=QhgBVQwZBO2A6bcYqdId0xQNmKO3pqRIBvRvcxKrT+WMXzK23UY9+ltjMWYLnYp21DM2PO4On0mYCbWGIVqV1SWfOamhLyyDkhznJbry8dXdn+xHr3CNCAOllR2d+8h/an4p45THjK3H9vsfM48hIEifChJmDeLHagTSwHw8r+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694107; c=relaxed/simple;
	bh=odOliccZ7A0ZG3dPMzhQ+yoSANWmCkhmvLu7k46BFdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCzY5Jgy6GbdrJeyg3fnCoiU+fwkUO0JFD6QX0dWwGtvMwzZrWBp4JLKIeNzo5a++3U4IxSk8v4b7wF5xKw5U1jViQp/J8nhBhJO01z6Np/BMuzAUhQHo1wmiTzq/oeioBK+lXO7jWs2hk8RAZXFV1Bs4lsXh/ljwoScla68VYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kI7YSeEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeU5qKin; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kI7YSeEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeU5qKin"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E938714000BB;
	Tue, 25 Aug 2026 17:41:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 17:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787694104; x=1787780504; bh=rAWTPpvUWZ
	K20XNqeqZ5VIKz96/BCpA99KAWytLr3Vk=; b=kI7YSeEtyQPXi51LlpUWHtSl2i
	ke7iDQNQ5UOBqLyW/Kl1zJYclVBpQGqKhjtghbGmbGFwGaRaqt3ecAPbvxS83vVj
	TTFIcgZe8w3Ns8dkZ8Dy9OG8hqwKlx1Px5KJ5L6N3Lc7w+jH+B3XHu/n0aisbvl4
	pZUWZW9ygO7SwkbrJhKxqIticOneHX8YWx95PuSCOPn3Vd7fAyLwVGPRmi/pIhVy
	YReZ5M9dHprpNvBdVP5QnZ7SFjZlf3PppnD05HSj3jl4S39S7MhVQUhtld0AlmCO
	qaurd3LsDb/VBSNVvskfHR1iiHOjCSkdGxRb4Q6I9wKsYjKDYReHX+SkfMDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787694104; x=1787780504; bh=rAWTPpvUWZK20XNqeqZ5VIKz96/BCpA99KA
	WytLr3Vk=; b=jeU5qKinhtw79SVrlIvYuJlSgPIM0QEvtSghs/8epumar0OSkAv
	BV54TPeojym/I8XtIaH/WBf6yCnhOKuZNUu5yv/IaHQbEsdGwebZWIGKP/kJ9pXl
	NKw0Rhljv2Vsl0euMVHJdZi0pyycwO9AgSOfnTB3k8labwPh9od/soU7onoJkbzR
	5u/l1dFM1HWcZrOY9ZL+SCBC74Ap+cG9l2YocWR6Xty4sA3A1Zcog97VhE4fl+W3
	28H51rjf0Mghs46+BaERVqccVYDvEQP5ZgST2Qy5j1V8WbXTogUZI8FnYJPtucbA
	a+L8srkJlVI1YT88BeTU1601mKkBI2WRR+A==
X-ME-Sender: <xms:GAyOak4XOlvTe5USB9yqWXVQm-UGjZ9qKsShjpQQi3NJSkC7T3qy6Q>
    <xme:GAyOas7Awotsc_wtbDmBEvscv9vwC3DfH56SpH7BEZHb9QK3yCMAN3fFNEmli20Jq
    xLDkchtYpGs5jxAyM01g76akOEeekprSgpsgHIDiiCY8-mdLT_5wg>
X-ME-Received: <xmr:GAyOaoc590q8OzLjKDrQSt5afvo6z33cDW_FRwCZ8DvCIRJwQw6An4WNu4IEJPr7KZwo9EIAEpYpFreEhk2wZPRrhBppEh0uyw>
X-ME-Proxy-Cause: dmFkZTEEAFt0ukbFzb21yVLf/ingKHGjdn+LVNNXEbVI9aBM/y4iYaKc2b+MUBm9vfZJ9N
    nzP7+c0ohK0H3LlIixhk0L9P4O1pHQZPOrOPj1W48opF/MPgkOJkOeTBbSpZTmhT/dQtGx
    ZiU9tC2nQUgQ5lJERrgPszMSEecaDKmnico5ZZEaqLqjzW5ekwJrZpuoB29GyGQG+uRPke
    N3XuOoELmTderTcdrWPJqP/CT2+oEEUKBcKPIgNdkxoQ6JB2IiXzwaZfiBqLNS2ay+w7Z+
    BSpIJN5lwFB2NU6JMa0xpakSY03/vs6thuG4XaZFve117cm91iSoHCtyKkVcnaMeByXEeu
    fBNwFB02WC+VD34uw46cWoepqAHFBvMQBt/IjjGBvvTVIu7c4/ovO5o4M46DI4X0IWwKXk
    x8ZVw1mkt/KAAGlSK04E/YHhpHmLSjosuBdhA17ACq4vNMetE6ouqZ5/6mu85ZEfm6Kjk0
    M4IUCODOU/MS98jYX/0Cl4U6n7OVtIFAt8OP0VhGtoLu+RH6mjaahbASoVj7ffnxvRmvm4
    jPNsY4xjXVIR8Re5J95VtNeu2je9pZBIx94+x77KvIS1xGwW5c7lvViQ0yWHPEu05R3NsV
    syUQ3BiCur7Q0POAW/A123JTghEHy+Y+bXkAL/mZExeCzyNwxmrLMogHC/Gw
X-ME-Proxy: <xmx:GAyOaoDWhvz169P66QpW5sDygNo4KotoE8wJtMw77eubtLnYNMjL-w>
    <xmx:GAyOaj-KYRVc768d-Nry_LJkfMK8YI_t-D0e3XPcZgIQcP0sE4M0yw>
    <xmx:GAyOarLEZh-rtarMCN6OiU_l-RwwA7l6UWpdQlPBAzycfJivywGkkg>
    <xmx:GAyOaki_fOuHC_wfm4xtiYcp1CBoBSDMQbxq97kqvPpDKaEmqkLqjA>
    <xmx:GAyOan_uZ3Evh-YR6k86ud7P_Cg0wbCXBUv53IEIDKOLLrqvpu28sWT5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 17:41:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Andrew Pleeter <andrewpleeter@gmail.com>
Subject: Re: [PATCH] builtin/whoami: add new 'whoami' command
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com> (Andrew
	Pleeter via GitGitGadget's message of "Tue, 25 Aug 2026 20:46:42
	+0000")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 14:41:43 -0700
Message-ID: <xmqq7bldlvxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     builtin/whoami: add new 'whoami' command

In general, I would really really want to see us refrain from adding
any more random subcommands.

> +`-a`::
> +`--author`::
> +	Show author identity.
> +
> +`-c`::
> +`--committer`::
> +	Show committer identity.

This pair hints the users they are equals.

But the code tells us otherwise:

> +	if (show_name) {
> +		if (show_author)
> +			puts(author_name.buf);
> +		else
> +			puts(committer_name.buf);
> +		goto cleanup;
> +	}
> +

So when "-n" is in effect, "-c" is completely ignored.  Lack of "-a"
means "-c" instead.  The same story holds for "-e".

Yet later in the code that is executed when neither "-n" or "-e" is
in effect:

> +	if (show_author) {
> +		puts(author_info.buf);
> +		goto cleanup;
> +	}
> +
> +	if (show_committer) {
> +		puts(committer_info.buf);
> +		goto cleanup;
> +	}
> +

Here, lack of "-a" is not sufficient to view committer information
and you'd explicitly need to pass "-c" if you want to view committer
information.

So confusing.

> +`-n`::
> +`--name`::
> +	Show name only.
> +
> +`-e`::
> +`--email`::
> +	Show email only.

Why not make -a/-c/-n/-e more additive instead?  Something along the
lines of ...

    $ git ident -a -e -n
    Andrew Pleeter <andrewpleeter@gmail.com>
    $ git ident -a -n -v
    Author: Andrew Pleeter
    $ git ident -a -c -e
    <andrewpleeter@gmail.com>
    <andrewpleeter@gmail.com>
    $ git ident -a -c -e -v
    Author: <andrewpleeter@gmail.com>
    Committer: <andrewpleeter@gmail.com>

