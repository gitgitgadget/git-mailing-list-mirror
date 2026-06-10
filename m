Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523030C629
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121017; cv=none; b=tWUS6ug/G2Mvhob6IlWH/1JRsIPvTanPEXxqVDBphDP+P+rwwiK8qkwUUsGONMVnI5jQJ02O4q7IstdhRhJzJjGUVB4ruAdA474QyG25mQJ3fzKExjUBR3KM7Hcb9SUWDHxgJnlPNjiCi0wzugrj84PHNVM4qS3rMn1schYggm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121017; c=relaxed/simple;
	bh=F7mzpmP5QtK8XFVD7hybS1Di94/7bgMZPrWbKNRfsYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncUljAgIkvTG+tsHSDAnHwIgijrwvXa+Yg8T3QxaLBD40moCLAd2CuJ0JLV9EmwAT/5TwTS/3Qli0jBovdZL8jwrQFzAhwDkKVKk0F9ZqDl7prRG+P6KbvA3cvSPKveJgfZn4FEwy/E/X5a7+2m9AdjK0ybX0Y0YZr4cBSeTNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IuUY3sZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZ6awusO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IuUY3sZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZ6awusO"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50431140007F;
	Wed, 10 Jun 2026 15:50:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 15:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781121015; x=1781207415; bh=Tc7N05HpLd
	srKUXrwlLs3Lj91KNYU2gcdWe5qNTVz0E=; b=IuUY3sZyLqGq2eCNz5L0zn85uZ
	sx9JPtYFUMbDyxQ7ivMZZZ9oy0vIFJlb+iqsu7Q36LUJ9mkJPdIdrZbAr2pqMi5H
	gcb2woU0shlIi/liJOFjlDDbUqTfoZw6tUCrOsa7OAFufgmAmXPCCvvY9JWo8Xp0
	Oyu0PFlEvZlvBlZj/fhcIf+V+VtnQjmuvrIgrdC9M46YaZJ7cPBgvIa44XeSkJud
	JDH6tjo9hFQnag3uEWga5C43XChv/T+Ss3ZSFfHEUkgPpQPTF2OQu0lOmexUorak
	6UhrRtDCWuln6fLZLMTIDmjl03XnnpdIks8uVAFejbv61CBKkU4S7i7ZMJZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781121015; x=1781207415; bh=Tc7N05HpLdsrKUXrwlLs3Lj91KNYU2gcdWe
	5qNTVz0E=; b=BZ6awusO84DHKqJucmqjV+6gUHpIeZVlRvVIo+lwatno1gVgo2l
	OXp0xGI8vX4iUUxv9u9wekU8q5VZ7aG2cbe18W/SvxEHKjyY4QXcAkQT3fNCu0+H
	gjHsl3Ku6NFBB8rWK6LT6r4V9rTHK2/adGPOTWJsoodlxYACWBqE7WnTq44GmIeW
	W/oCt90xYHG/466Gda4RtH2JWBJyskYjIwpNgNqYVFKkC6YBQtEoxEJ9TcOm4eky
	UPa5oCgB6W0pHRf60lNMzOqMoyz5ZOWgU59SJihIq1h1X+VcOs8WS5Jj5+90OQEx
	fFLt89ZJBb65TMR6ydg46chVg9de54FwpFg==
X-ME-Sender: <xms:9r8paq1E3QghVm94cJvPf-N9AA6-hJFmm2OaRdguZcTCAo5nl2lmYw>
    <xme:9r8pakijN5nA6v-Usn7fUnXYxCdphqUPojYdQDjtnsCs58kA3XStRHY6b1_TuLk2R
    wDZkC48wawwuaBrk1RPC5TzWp-nk0oujJetcXBnHluvYr_z6Z-aqzA>
X-ME-Received: <xmr:9r8pagQ-QWQVsvmwAuuYaeTWdNGqo4NVRN8XUvU9LjbuQ5M9R4x1WJGR7E5HeC7hUZYr5L4i9O9yQNTWfJqu3VxLJTIDN7MbO_rV>
X-ME-Proxy-Cause: dmFkZTERA/MRjvahlUV4/Ax5TfOK0V5I3Bo/qFe1ZgJk9s1QsY6mjLQNHwuQbOHVijDcf5
    VzUDrGfGlp48Ug1cTklF8B/OGhYFNJbkSqekUEV6cVZkWic8NfBh+eyZNuwjQM2SCvjgYe
    UsXQFWqzqYJiAyeV6+po+4Wmj0rwAd4psTt4ZhrJAz6ENNg+OVYTwqklFyDSSYy4GVYpqD
    ot0qu6z+InJtISDmkREXMvq5bGaUacjZlFQe/8Fpi52n558ehGg4b6qh62JZtI0wzRGyGs
    NBHPIjFVp5Tzt21moMT5rU183UbO1rq6OJiguSJpelxYfZlMGm4zTNfjTUq0DnSuT3naPG
    xOxl0Upbugu3L/T+IuJkela1apJXFjJpxVynUs7Sy0ntDKzvbAXS9MV+qJ2JOhrrWgsesN
    aF6ICm8G6BpbhiSmZMH/VOgSNzPDL83FScczXITtkb6fTuEYbLE+4rGJ02vJseZ2QknPmA
    DoTn+P6aRh5b3VsnlBS2cni6gasADE62LXlcSIxO4Kr4zC1lrOuGYS8ZYW2+c36F3nfIAn
    sy0L2pCaaMtWBOLyF37mn9NA5TCdXydp/9GmxXgVbecK30DDkvRX2FJkworutDpFEmNn58
    4dcLmxTwzHgcwbt0zfY4rigrwFhPNMx5vjY3CVpfMI3idE/YGq9gP8ZidYNQ
X-ME-Proxy: <xmx:9r8paliD-dnPVynCAZgXNbOqYFNKP9PU_b0166hEEVP90T9J92YFMg>
    <xmx:9r8pag54v8pWg6hfrtcJyQVaw6YBRpj-SQAzf0qo3N47EjUHQsxPXQ>
    <xmx:9r8paiAz3DTL_B3IHDcgQIxS86LX5FYJhlsBue-zPvKY1l2gNNRUbA>
    <xmx:9r8panaOA6fXq_qsN5WpwDoNPAiTCapDv0rz8Xf9VoruIHWNKgfWoA>
    <xmx:978pasM8354F67z-kKy4An54Xf_BcpOpKfo_8p52HHJ3i_8skE4Hx4yO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 15:50:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] doc: git-config: escape erroneous adoc markup
In-Reply-To: <20260610185148.23920-4-taahol@utu.fi> (Tuomas Ahola's message of
	"Wed, 10 Jun 2026 21:51:48 +0300")
References: <20260610185148.23920-1-taahol@utu.fi>
	<20260610185148.23920-4-taahol@utu.fi>
Date: Wed, 10 Jun 2026 12:50:13 -0700
Message-ID: <xmqqecieuqdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Paired octothorpes are used in AsciiDoc to mark highlighted text,
> <mark> being the equivalent HTML tag.  To use the symbol as a literal
> character, it can be escaped with a backslash.
>
> Do so in git-config.adoc.
>
> While at it, tweak the text slightly to make it scan better.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/git-config.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.  

What we see in
https://git-scm.com/docs/git-config#Documentation/git-config.txt---commentmessage
is rather embarrasing.  This would be a vast improvement ;-)

> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
> index 8439ce97df..708e88cdeb 100644
> --- a/Documentation/git-config.adoc
> +++ b/Documentation/git-config.adoc
> @@ -119,10 +119,10 @@ OPTIONS
>  	Append a comment at the end of new or modified lines.
>  +
>  If _<message>_ begins with one or more whitespaces followed
> -by "#", it is used as-is.  If it begins with "#", a space is
> +by "\#", it is used as-is.  If it begins with "#", a space is
>  prepended before it is used.  Otherwise, a string " # " (a
>  space followed by a hash followed by a space) is prepended
> -to it.  And the resulting string is placed immediately after
> +to it.  The resulting string is placed immediately after
>  the value defined for the variable.  The _<message>_ must
>  not contain linefeed characters (no multi-line comments are
>  permitted).
