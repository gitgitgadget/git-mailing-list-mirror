Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1213220F5C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122498; cv=none; b=mBzP69OE3zM/xIeks3TGI0WEq/FL5H2LPoC86yW+UVfJYy9NI8hGazrxTZUCVTHuGJ4opZFDIclELVeDDESjpS451y9+w39GAsqAWP+gTUX7+UfmfLAxlRdHhlluTozNNMJ59nZvj+pyqIDHiJYN+HcmG75xATSlrwpQ84xcPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122498; c=relaxed/simple;
	bh=EOw35y5EeFWV60dgXFbWbPwIZh6ZEijEDX+AD0KzEkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJODdrynlROPtXXOrX8AvJ+VSzNnEE4YgrlEANPNez3n1DEUmTzxL7AUwY9JufSCQ/J1nMptjDOGSjoGJaifVyd6aBH1K3XIASWkw2kZfsgUESYf3n43tGkRxCkcFyFd0bYWoCpmCtxX42gBm9UOKFhRz9sOK58N2nqXPBBh/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d//1/DIt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNu4onoS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d//1/DIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNu4onoS"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F666EC01DE;
	Wed, 17 Sep 2025 11:21:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 11:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758122493; x=1758208893; bh=eNmw/jCXvk
	J0XbOX3eDBqH9t8IMqZ3dlR6STur5vYJ0=; b=d//1/DItLJKR5BeL79jgSTRN3x
	KrhNIe6+L0djw/TNIkKwvCeyb5w8e2REWqL2EletqU53BtV1nBA0oi/tZapwwhO4
	ABkWkVDFl19O0cVv3JJEbOd1Z4hJaNDUtm/witj1Ue8dHVJSXAiM804NgheiLfRO
	UyFWbWklChdAeinv4kID96yJSAkh75j4bP0PuPvF4EvUryt58Eex5KBH8p7NieXC
	d8z1DwHpwsgXXkrH32g4SuKPF60T/AzFOGrqwSGLc1geALZOx/B/5kqtNtpNInA7
	krvWotg4stN9I18EnA5sMoirkorQ+arsW103eEZOhYPh/G78a03xSmd27MkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758122493; x=1758208893; bh=eNmw/jCXvkJ0XbOX3eDBqH9t8IMqZ3dlR6S
	Tur5vYJ0=; b=SNu4onoSgB224tIPSqvsJaix98qWrUiepcqAR8UquHW3NPlnfQd
	y5xJKeU2ZciUGPvtg5SNC6nbma1+sqAyT/9QkcyqoVQrPr8c6AEIRAF+OXcGEMhy
	YGGCv5WsSXfbnAxO3Rt9WAlJYoIYPGlOv9eI7Sn9z7sDtjzl91XxMqVCxqzco3iw
	VUebEZwu6wz1ue0fynY9auNtNEw3aOeqaUj/s8UdDg1iGR5YzyWpl/xiIu3b4Uso
	mTnSNVKBmV6QBCxlyhlBsgQCre9WGUuR1SH8pbeBGl23NuWMJJTy/f8RyKJwsOOw
	99xwOSEpUZQThN6RCkT1F1VQOS/aeZ1TG4A==
X-ME-Sender: <xms:_NHKaFAr5oh68ivYMjQ9SQjWqokYfa9Ij5I8KjXqKpGtmCQ-tulTCw>
    <xme:_NHKaBEt7k2QNWdwR8QdvtZOCO7vNoQRubJbCsrkYIDu6qCGWT8MqF1qmNR8LWMbX
    fZV6CN1tmjJkLxyWw>
X-ME-Received: <xmr:_NHKaHDkQQMWYWOSD9yMnK25nce7-CnyBMLGEtynkYCso864h_ns0CuJckUzFHSnG9WeuxqtVYRAKRgHvbVWff238f0HRo6zMtCpBvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehhuhgrnhhgshgvnhefieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_NHKaBW4P5XvkrIlyku93Whjk4MT8rY8_FlDjGqiih6WvjWcFJYVNQ>
    <xmx:_NHKaLqeLQe4Gyga3v7it_wL2cddNNjN1d3voLRvLcAGozsJ5AfsgQ>
    <xmx:_NHKaNQMWh4WhTvW3viMlOJlOxTX7LJ6o6Zyh0tsgVp_wfS-CPpBUQ>
    <xmx:_NHKaF3ptg0saUro64kyJ6n9yG7YvzqI3h_XWA8oVFrLWNQE4SQrgg>
    <xmx:_dHKaMLx1OYvkR5GK-GZvWXJ2wfnIDXjkAHZv2qqzQiWw9A4YEL78I_3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 11:21:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
In-Reply-To: <70fa7537-3b89-4c3b-9dea-5a7ea0174a9d@gmail.com> (Phillip Wood's
	message of "Wed, 17 Sep 2025 15:53:34 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
	<xmqq4itarqfd.fsf@gitster.g> <xmqqv7lhigb7.fsf@gitster.g>
	<70fa7537-3b89-4c3b-9dea-5a7ea0174a9d@gmail.com>
Date: Wed, 17 Sep 2025 08:21:31 -0700
Message-ID: <xmqq7bxxf6kk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> The test changes up to this point strike me as somewhat unfortunate as
> these tests are perfectly content with the existing advice. I assume
> this stems from us not setting GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> anymore when WITH_BREAKING_CHANGES is enabled. I think we should do
> something like
>
> diff --git b/t/test-lib.sh b/t/test-lib.sh
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -127,13 +127,15 @@ then
>  	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
>  fi
>  +# Explicitly set the default branch name for testing, to avoid the
> +# transitory "git init" warning under --verbose.
>  if test -z "$WITH_BREAKING_CHANGES"
>  then
> -	# Explicitly set the default branch name for testing, to avoid the
> -	# transitory "git init" warning under --verbose.
>  	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
> -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +else
> +	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=main}
>  fi
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

That does make it more in line in spirit with what your
"breaking-changes: switch default branch to main" does here.
Instead of assuming that we won't have "no default set" hint after
3.0, we do assume the "no default set" hint will be there and
squelch for a bit longer.

OK.

> To address that which will also stop the advice appearing when the
> tests are run with --verbose as well.
>
>>   	git -C repo rev-parse --show-ref-format >actual &&
>>   	echo $GIT_DEFAULT_REF_FORMAT >expected &&
>> @@ -868,18 +868,18 @@ test_expect_success 'overridden default initial branch name (config)' '
>>   	grep nmb actual
>>   '
>>   -test_expect_success !WITH_BREAKING_CHANGES 'advice on
>> unconfigured init.defaultBranch' '
>> +test_expect_success 'advice on unconfigured init.defaultBranch' '
>>   	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
>>   		init unconfigured-default-branch-name 2>err &&
>>   	test_decode_color <err >decoded &&
>>   	test_grep "<YELLOW>hint: " decoded
>>   '
>>   -test_expect_success 'advice on unconfigured init.defaultBranch
>> disabled' '
>> +test_expect_success 'advice on unconfigured init.defaultBranch can be disabled' '
>>   	test_when_finished "rm -rf no-advice" &&
>>     	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>> -		git -c advice.defaultBranchName=false init no-advice 2>err &&
>> +	git -c advice.defaultBranchName=false init no-advice 2>err &&
>
> The indentation is changed here but not above. I'd be happy to leave
> this alone, but if we're going to remove the indentation here shouldn't
> we do the same above?

QUite honestly, I didn't even notice that the line that begins with
"init unconfigured..." was a continuation line.  We definitely
should fix it to match.

>>   	test_grep ! "hint: " err
>
> Do we want to check the advice that is printed now that we have two
> different messages?

I am not sure; isn't this checking that there is no advice, not two
advice messages?

Ahh, you mean two new tests, one with !WITH_BREAKING_CHANGES and one
with WITH_BREAKING_CHANGES, to see default_branch_name_advice[]
appears in the advice output?  I am not sure if that is needed here.
Without [PATCH 5/4] there is no test that checks the exact wording
of "... will change to main in Git 3.0" message, either, and I think
that is a sensible thing *not* to have a test that insists on the
exact phrasing for such things.


