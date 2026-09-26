Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353941D432D
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790413232; cv=none; b=V/wWmVxfmlZbBCShiO7p29hZuOSkb5l/0QMNLYeVnYw4QXQrKfZBhgM5ZmlX6q0folxXIxmtNu67sQ0oz6pXK5+Se6HmbFpn/RrhcPqUMQ/WtMz8hb88u7rnx/DlZzAgY8ZabXIy7cc06RgdS+puHWOK1z+ugfeYsczI4c0evxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790413232; c=relaxed/simple;
	bh=IB6azGVEy1S8GKwFY4Jvcc+1q1Zzks5yN1yaG3LFUOc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MPY6kMA4ThB9xgDv5WKaw47N03QxPGvRfk64ForxyNwlRSHNG8mBt7WitiIs6V0awVzRcybWjMlrPA3/4CAQqOyZIZz2LcRjNeececvz18J+eTSwLhewPPlZyzmCAb3wkDMZEEo2hiNmCZ3bhrolnBc49IWQ4RjmcSNMS6jMO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=j6A7Aqso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJb+OQxT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="j6A7Aqso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJb+OQxT"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACF047A0086;
	Sat, 26 Sep 2026 05:00:28 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 26 Sep 2026 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790413227;
	 x=1790499627; bh=2tz97FXOk31Ww2ypV+Zd8P+CpaaEFW8WwobbYJc+DUU=; b=
	j6A7Aqso58EUDc/4ytma6Pgx3hl1XaqVw/ANIfC2GGW5CWSYxC+hYtQQbbbTHH4s
	DFmGPRtF4LRiM1H6GEIktuYxA/fZ2R4kyNcWm4egWLwxefSD+wfZzQQ0FfiJtczs
	IpmM8CEKuZPQA8Dn8ug10YD5eTo2WYsyhlR3hqhoI1kLE/wW0SW4ypooEAdEaIYS
	g+7OLcbnJdZ4keyioC8rmTYyxt6FEQZKZ634KsZq4agNQSRsziyBz6HsNmj+CV6r
	vW7BLzF3mK6N+9YPiay8S8dxTY7yo1JosREAD7wapPHtPzt6Yf9a61YkqcMyiTnd
	802vV04vqHFPHyDymBpH6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790413227; x=
	1790499627; bh=2tz97FXOk31Ww2ypV+Zd8P+CpaaEFW8WwobbYJc+DUU=; b=M
	Jb+OQxTyFncfbBHahtQ3AgdLouGU8tC5ZKWGEQbT06Jxtn8ed+vRyggjFpZfQIlY
	r30hwdHvYzdkuh/sweewUoAZyTFxaBGw9I0Sy7p0OtbdfSmStQ9Ix3LbPD5e/W8b
	36HHMtBhE8jLdETYAZuh7Hq/e/EHWiqc7kGH1RpwRUFtqi791BM0UwGk5qsrorgW
	wRwj6k3PZuCdeC2IQKmArTEm/diCNQ25aHuhVgHCLMlh2iB+a5KmanQKOlI+qV0x
	zGKiWqEDmsKWvPexgyyg2ZZsKxRUAlTCEeex1dc4Dl16Lu/sK9VuTId7NZLwEN6T
	H9sIV9ZwA+CH+0o802Lkg==
X-ME-Sender: <xms:qYm3arqD51oJZIxBHdejTE3XwYzqpepTGTqynbf9h9NHgYY_emi9R5I>
    <xme:qYm3agcG80v6fH94_RSSvoDUeFRe_t7kIetDxSKCIe7E5xeRwrdFau4w-tuHEhtqy
    2L8U_klCMT26_nJMJmbmJweXZFirDuVXTpJJlHD6BaYwgyQcGf5iA>
X-ME-Proxy-Cause: dmFkZTGKDYxgg/2tzpJGdZ3XR/SWx5AjK1/VlY4vQRHRZfzfVV9esTPkghnn/YWLlhcrAx
    +ERZJcodueeN/w4yJnNOGfXPp/ejxPnyM8BASjqyfg9/OulMNeSDa98Xvp6EMly3KAwIie
    +1djS70D1j6mp9UXrjPB7smZCCHXz5ZoNAoZpO5ZBa9MN3iumAxDKLWuwPbuYfqD2X2mn4
    QCU/0gCd+dledJ3KdeQp7M1Dcr8LCcA0pvqQuvwFBCB5gLOZ/3q9HxMZtxAwqb9LHibJRi
    1cHp1aoBT2iL2BEaYp5qR9ZbxpD22998gHUXd7/3J4JYvzbcMaYKLgfw4dP/lP395HwTCU
    u4DgJfJzyNguuM0O9LvLuou7O6GhiSH1aJbqMUeUg+7dV2VIIzapvRUOep/pFy7lLMopJk
    pXIYemd/4PAw4xAX11KEmEaQ/mioHakCp9mEdOSfSXDHFzD9C2oj+fnxeyzL377E+F6/AL
    YwIPz8iO23klaFrq8qVQhhZDFmqakx+G9fmEVC1c4y2pmQt76+5h1tM82/VdSb1kJa488f
    eYagQekvzQNfE6f1lAGhT29vfkobiTSBiFrwyM/il7mYRqdMEHfCFxRkNQqFyYlyKJUchD
    3Vssh1r+yJ2IEURymztFxgJt/Hjrrzk5K00sNUw+o6EVUL6Y+FKSdbyOzMnA
X-ME-Proxy: <xmx:qom3amVNYk_nqbHTU-HJho6JiweraqNZUnbbWFIQZRlpGSimdoXBJg>
    <xmx:qom3agj7WTX8fbtdFDGh8ubghie-ySOQfE6cAix6yQbQK2QEUrd4kg>
    <xmx:qom3ah-Q_9MGk6Pd8Z0oKhvcv2pjxrZRQAFqVQS8-jqZE35CDFyO-g>
    <xmx:qom3aqAieDv4WONZio9ZpOpUEhVjqzS0MDw1NjzT-Lsht9HGohEsQA>
    <xmx:q4m3as48NraeUMN9YOIoPsOOalc66Dqq7W2CmiYbnt7JjlMyVnaAmepZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 62F8422C008B; Sat, 26 Sep 2026 05:00:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A112ALcwTyqk
Date: Sat, 26 Sep 2026 11:00:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <add1abaa-5d51-43dc-9907-d6d3851004f5@app.fastmail.com>
In-Reply-To: <20260925203958.GB1544493@coredump.intra.peff.net>
References: <20260925203359.GA1506705@coredump.intra.peff.net>
 <20260925203958.GB1544493@coredump.intra.peff.net>
Subject: Re: [PATCH 2/2] revision: handle argv movement in parse_revision_opt()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026, at 22:39, Jeff King wrote:
> The argument parser used by setup_revisions() modifies the argv array
> that is passed to it, consolidating non-options and unknown options at
> the start of the array. This led to problems with memory leaks when ar=
gv
> pointed to allocated strings. We addressed that in cd43948798 (revisio=
n:
> manage memory ownership of argv in setup_revisions(), 2025-09-19). Now
> instead of copying strings to the earlier part of argv, we actually mo=
ve
> them, setting the original location to NULL (so that we know we have
> exactly one pointer to the string).
>
>[snip]
>
> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

I personally prefer the email that I use for commits:

<code@khaugsbakk.name>

(Which has always been the case. But I didn=E2=80=99t want to disrupt the
process previously.)

I ought to send in a `.mailmap` change with my canonical email address.

>[snip]
> +test_expect_success 'unknown revision options are reported correctly'=
 '
> +	test_must_fail git shortlog -n --no-such-option 2>err &&
> +	test_grep "unknown option .*--no-such-option" err
> +'

Just thinking this through. This is a regression test indirectly related
to git-shortlog(1). So the test does not name `shortlog`, so that=E2=80=99=
s good.
The subtlety of the previously discussed:

    Making things even more confusing, it only happens if there's
    another option before the unknown one!

is not obvious from the test description, but one can surmise that it is
needed since it=E2=80=99s there in the first place.

For the next readers of this test suite that come along, it might seem
strange that this specific sequence is tested for, and on a shortlog
test suite. But it seems normal in this project to add tests that, in
the context of the file alone, might not be obvious why they are there
(because they are regression tests for very specific bugs). I could
imagine some system where regression tests are marked with some
identifier that however indirectly links back to whatever triggered the
fix. But for one, this would be a new system/convention and wouldn=E2=80=
=99t
make sense to use on just one test. And second, this would just make it
more directly accessible; it is still directly accessible for people who
know how to query git(1). Well, maybe more indirectly as time goes on if
the test is changed and you use the =E2=80=9Cpickaxe=E2=80=9D technique.

This is all to say that this test makes sense as it is written now.

> +
>  test_done
> --
> 2.56.0.rc2.289.g137cf50cac

Thanks for fixing. :)
