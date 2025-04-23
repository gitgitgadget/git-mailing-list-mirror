Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36356FC08
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409202; cv=none; b=kq0wsnIRNVfaP6HuDlwThcQ1jraN2SvkBs4EUFD+o1YiPXaF9uVmBKkQoRvOoOaabl6Ld/t9WRzf0ohlhjpwTHHaEEQT3M7/atCmaaBxlwGcRZ1NhPqVWym6I94tFh+lhQSXObpUjCH/kgqc1PH1jb1F70c0V8IjVGLybBpt9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409202; c=relaxed/simple;
	bh=tziJSeemUWRn75xVxGolNVUHo28f8jG4H/K7LQ7JffI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/v75wffsKzQivm/H/AX0CG/HDNNANPYkrVhZXYdEntsqLYJ3SsjL4qjOLYQ8quS/JlF2sw+zghFWwCCoDdhT+YN1g8kOA126LM1jUcYKRBl01sLvuLp32EEknllqddpLO042mptzrrBKZO1ADCkFlHoNBQgxrovPyJUQPK6eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gM3ohxdB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mHCjWbVa; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gM3ohxdB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHCjWbVa"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 44CBE138016B;
	Wed, 23 Apr 2025 07:53:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Apr 2025 07:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745409199; x=1745495599; bh=TLAZGxBhh7
	S0VJmKTh6ATe0OtfvOUwlqDq4C6ZNp1Xs=; b=gM3ohxdBTSdT2zEguHhLpvZh9M
	FW6JlMRk4CZI6KFHUDvAUEiWiYSUvUy9VbXngIaz5irteLs6TZoIhXrY1SVDBf3s
	QrKTVFpBQuxfNQot1YN9bcGo+ei+aM+KSJGUkk7bqzzYYv7KjhMWyIJ1eA/q5opg
	IZv3HHCWqTKXPYCUd+Z1fIZpOJHlEqLcrh8XMM7PUY2C9n/3BHBIsEcJpCpX+ug/
	VaOAptEw239XeTYU1Z4koPWhUQY6C1FnOuOeeQOt4GVMxZ4OSFSELwGhE13JU086
	aUyCYjSouh14X1+UJahF4JLP7DY2QyWDH8bvb1Tc+gF8XMdYTf9EpR/0o1jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745409199; x=1745495599; bh=TLAZGxBhh7S0VJmKTh6ATe0OtfvOUwlqDq4
	C6ZNp1Xs=; b=mHCjWbVaG6eKmmNVFV0yvqlUYcRWty3mIRmE5/WIrCurHLMX24/
	bY2bKBIDmaR7lVpGYZ5c14FPEvH/MaR6IxAGukVAMWilN+t7fHr92Z06bpy3CKdX
	FygOFjUb6VA5DR4tjHODAwATj1UW3935xMlQrnPCMJTRZXf6qpQiQU4jcjpxAysf
	39tzXs2OCKCrpwcsw8ZCQMH2H+z4/17AHWrIkgMCZ4kjdl9zC4Vxl4iZ1xFnsiIW
	WIWMrUFrXFvWsGkAaHwcfQpSbYDuKrBVw1bPr1hh6lQLgIlKthtTbDPcL0zR1afC
	a4RpQ2I0Y5VBrx3551ofDrnrVvxRpxe/yQg==
X-ME-Sender: <xms:r9QIaK7v_RHD1c2itcqYaC7RiUt7NA9Suc6eK22mGrThCU-4nDPAKQ>
    <xme:r9QIaD590-5bQGNv0zPGKmssjGYCD_y_jotYZkag9PCHg8SXYJnaj5sxbaV23CSIn
    LWnIxAUaLdA-SOEjw>
X-ME-Received: <xmr:r9QIaJdfGuOULg4tzrZbR1fpQ3XtbnvnlncUJLvUNiCuCPixHyNIv-ATiVZrmMLTRqkBWwJGvdGREJmcSzRJH4QD-wWtLs21g2TdkG6Z0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:r9QIaHLJM7rb6TERH1LjP8bPoDC46or7o5MjCK6q0Xt7mMm1g6qK-A>
    <xmx:r9QIaOL1ZJxoRpOjaRJimeAcywBNTxYt2myoloZUzFpgsUjq88_MFw>
    <xmx:r9QIaIxZJHV2VzzeDJjoMyE16RsZtt2vjwuDL1j6IAhHQTm3u65WTw>
    <xmx:r9QIaCJ6m_BsEgs8qSLXryodYavA7etTuTq1ayWQqJr9QKCxerkuJA>
    <xmx:r9QIaFmQ0g9sSowSQcMs-VtCs2SmRv95tlxG3NlthStCuH5gqOr1CP2U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:53:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 976fa94d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:53:17 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:53:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] u-string-list: move "test_split_in_place" to
 "u-string-list.c"
Message-ID: <aAjUrNTsL966mGeN@pks.im>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAetyvcw7ZgXa3f7@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAetyvcw7ZgXa3f7@ArchLinux>

On Tue, Apr 22, 2025 at 10:55:06PM +0800, shejialuo wrote:
> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> index 0c148684ea..44ec8de3d0 100644
> --- a/t/unit-tests/u-string-list.c
> +++ b/t/unit-tests/u-string-list.c
> @@ -84,3 +84,42 @@ void test_string_list__split(void)
>  
>  	t_string_list_clear(&expected_strings, 0);
>  }
> +
> +static void t_string_list_split_in_place(const char *data, const char *delim, int maxsplit,
> +					 struct string_list *expected_strings)
> +{
> +	struct string_list list = STRING_LIST_INIT_NODUP;
> +

Nit: this empty newline should be removed.

> +	char *string = xstrdup(data);
> +
> +	int len = string_list_split_in_place(&list, string, delim, maxsplit);
> +	cl_assert_equal_i(len, expected_strings->nr);
> +	t_check_string_list(&list, expected_strings);
> +
> +	free(string);
> +	t_string_list_clear(&list, 0);
> +}
> +
> +void test_string_list__split_in_place(void)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +
> +	t_create_string_list_dup(&expected_strings, 0, "foo", "", "", "bar",
> +				 "", "", "baz", "", "", "", NULL);
> +	t_string_list_split_in_place("foo:;:bar:;:baz:;:", ":;", -1, &expected_strings);

Same question here, can we handle expected strings via varargs to avoid
code duplication? Also for subsequent patches.

Patrick
