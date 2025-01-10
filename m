Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFCA24B241
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537090; cv=none; b=oRVvxW3YbNOoAzkuaDkJIbcqqS8ewQfGnHrrCBGY9jAgEuWx0bhxr77+XCATdSH95wC/GVEpgOpjtLRcV8Bi/N8Bsu1UVpggF0vki6FeMpEmXHMk6tHGwi12FQYaHJRRW8YanDD/c9sUa5SgpjT8h6yj5PZzT3d0t5R1JlsRD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537090; c=relaxed/simple;
	bh=MuDwgaSLr6cWwVKq/cKBIK37vwVVg2EXGdJsOeIEpx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZudjVBPhb2XjK9s99zI2IwXUOHJasiXXjHMUqRssteo+GExKO6lTHr5qxVMH0NSdKpi0tiTaRcrkFRPAJKViUEpkW6PBSrpEvRbc21lKCwnz7/zXWUZ7Tip1kpHwpWCki9o2mqxkXJ+oqVyXDwbsO2WFKrJnL/f7XdM95O2gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=4oTUaRwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKcaardS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="4oTUaRwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKcaardS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A846D25401D5;
	Fri, 10 Jan 2025 14:24:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 10 Jan 2025 14:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736537086; x=1736623486; bh=ZGn3jtUeIz
	Dh9CArEZrxw7fDNRDylOe+CCf041tmoCk=; b=4oTUaRwTeaGEKtgsQbKNCPtWtf
	taS9JuY8a07xh7Cz4w2B3QhfeZ4R4suN+2yxFH+SwfzM4xrN7SO6jRUt3KQ9NBSC
	QhDfv03b7sB/RCV7jxXjBSv9x5Eb7w+Zu6Q33mBnSK/3VoVYm9xfUgSiAQ1OwN70
	gX7Py+1q6s6oMWOBWhrkTBVCPhCj6JP/AiVWHeV0KDeyxaMZ8mQ4bU0fm3R+7miO
	JusTvR7n4CB9M7k4T4b2nbqJVajevLQpx63DpAW1lU4irOZq12uE0XeFux9PR6ch
	pr4bJ24RNMzcZFadafHlaquoEcewY14Up1jqOZUXFC4qigoEZIZy8F0cxsbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736537086; x=1736623486; bh=ZGn3jtUeIzDh9CArEZrxw7fDNRDylOe+CCf
	041tmoCk=; b=SKcaardSjnUfarTLm9YbvEL8yklIycYuBCrq/LOdhPrglH6YOc3
	6l11WFm3jffKq3YKkHfOsx349qRfdEx6H1wy/0Clj0YHoV93tgBjnf2nyg7z+pPM
	6nfPR3IR0rcXGbHQJoZIQuPMOEL5tOnzK7jy3d4r9+iEP/GwJt5Xlp+rF9Th0Mos
	rToAhdtTdRLfcybLuLwSuah0YnE0UaP7XH1aKcgwBOVvNf427wazEezCFdl2p12s
	a/8JPehbfGYj/6wpQqVg3doQYzgxz42GijEyD2xl9PN+ZQ4uV9xwuaHdpRZvk355
	a1I32DHCf5EinrhIbOy/4symcX1Dq3l8EEA==
X-ME-Sender: <xms:_XOBZ6JNsZ7PMv7tsZRbDr7RLtxRsR8nXl6qWVIZPVv_vXaxmABN3Q>
    <xme:_XOBZyK2izKV4VdTfLex9lk9b21TmCIsF_fsscVBRaoij55Ljq0_3KxqBMrvjgws2
    z9WARZ8qeGxlI4sFg>
X-ME-Received: <xmr:_XOBZ6tw12XQu5eiaef1l06Ggf6kGEG4A0WxSpzlOYG3B7IJXpLMVKUqEWzMZD3jjB4kDecAGqjwm3hhV48pBqXXW60fbWhxWgkH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhr
    gh
X-ME-Proxy: <xmx:_XOBZ_YGfFgGauKbELOz3HUfkkVst-5mUhAzy_h9iLEF32jUkYJzdA>
    <xmx:_XOBZxa_GxZDEl9CpYgBjIp4qHk-Z4KdJaiwd-on23VKVCuXo-N5ww>
    <xmx:_XOBZ7C8rBQ69_BqNVTrL999cl1m1_zAp_5MpC4q86iNB_uJfOFU2w>
    <xmx:_XOBZ3YI8APQ2MfsOfL_1Acr_7zeyzQdateX5mwyUo5Gy0YFu7GTKA>
    <xmx:_nOBZ-RC6DpVvtS9qQHcfGj-1bZ5rFxfJskN99zvjUkmIY0VwIV0WvW3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 14:24:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] connect: advertise OS version
In-Reply-To: <CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
	(Usman Akinyemi's message of "Fri, 10 Jan 2025 23:26:14 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>
	<xmqqfrlvzzcd.fsf@gitster.g>
	<CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
	<xmqq1pxdnuxo.fsf@gitster.g>
	<CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
	<xmqq5xmokn0z.fsf@gitster.g>
	<CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
Date: Fri, 10 Jan 2025 11:24:44 -0800
Message-ID: <xmqqldvi5v5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> First of all, I mentioned "registry of canonical os-version strings"
>> to help the users of the "Please use this string" so their server do
>> not have to suffer from different names and spellings to identify
>> the same class of clients.
>>
>> But the server operators that *want* such tighter control *and* are
>> capable of enforcing their choice to their users are probably $CORP
>> in-house operators.  They can tell their employees what string to
>> use, or they may even do that in /etc/gitconfig on the machines they
>> give to their users.  In other words, they do not need our help at
>> all.
>>
>> At least that is my thought.  Others may have different opinions.
> Hi Junio,
>
> Thanks for this.
>
> So instead of having a .format config, we should have a .string config
> which just
> takes a string and uses it as the value for the `os-version` capability ?

Ah, sorry, I totally misread your patch.  I somehow thought you _already_
have the "any string goes" variant implemented in the patch being reviewed.

If there isn't any such thing, then my preference is add neither of
the configuration knobs and let the system provided function give a
not-too-specific os-version string (like "Linux").  Once people gain
experiences with that feature, then we will learn more about what
degree of customizability is required.

Sorry for the confusion.
