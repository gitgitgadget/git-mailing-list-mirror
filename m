Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB923D16EF
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788305152; cv=none; b=X0H5qTVL/jdsBeajb6Hd5JEA6MhSAXIXOXx4+uwEoNaTPxQGQ7MuT2wDUyjzol8F8ugm1it4K72GZP1AOwL7CZUq6r2W748KSyQTnIpCcT5M+XOdZ0xZ9R4xZiZ9FZF0fCfSR8S3h/CSGBm4IaSTF8SM4o9gyDE9zzCuHckHRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788305152; c=relaxed/simple;
	bh=pocjikOK31jQ3wpVl1JsSIwZHJ8YfFPe94Mgji+tgBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L05KvCWbfpXI4j1jLOJjFPSBJXVMr445zuWWq253GwLPN5dhpnpHcG6dnyS6KoQgnBM1/18t0fHUVw+XT94K9RFVYYRr+aR4+tS0i4MgYceGtELk/IOwi++dma9xNJ9eklwi5yWOJMXMj3ryaoq4eBb1mIDdTcVk8jVucHpB9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q/Eudkgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kq9W0M7G; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q/Eudkgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kq9W0M7G"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 715D21D000A6;
	Tue,  1 Sep 2026 19:25:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 19:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788305150; x=1788391550; bh=CIAG5bIVgN
	vw4kWhJ6pSnFhvsCGXgBBIvGRnBKqIUpw=; b=q/Eudkgy4x6PgZUGqaxk1vxjKO
	sh/qTm8B1hHjE0x2wGprrUMhUvtOuGvlj5id9VWfTo5XaJfUA9ypPUZYpTRs5wwm
	ske8BHmR3WsrELTUICK8Xu57wAmZ9QcOgW8vkCOIBGgZeTOfCL/T7qmENUxoU6sE
	3hWoSLTXLW4DDkxAWVVGkFssgq5L7+A0BPZkOHHFuV8dn8ydjToVVymA6aFEFWk0
	KWJymhLhlULzlBpmIBcE4X7fuLH5EP19QeK26el55cei41dFpHMUmOOjCghlteIW
	xs+HeZMJaJdcK0jG66wnxSHK4E9Oo0G7CpYIcGNzSofioJmtb9Tf1EyOfKhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788305150; x=1788391550; bh=CIAG5bIVgNvw4kWhJ6pSnFhvsCGXgBBIvGR
	nBKqIUpw=; b=Kq9W0M7GvaFrv/tZ/a+wzDll3WaeZQ5l/pVjtpvjdIYLgsJ3b/u
	+XmaFyxHkccCIsaeXxajd7H1Amv/0C0mjzPgdHaS/Ry9C+k9C3z/3X5FzEet8MTs
	KhUmdxvVPTbkbBZqlgXzd5Nc2JHYBzl5ybNCxcNHv9M9j2HNR/UtqCTJ0e/fEF3q
	JnvGZrBKA8ETO3vKxLL2yyvEirOvjWWWud2syVfantPJZ4GqK6nwUA0utGHeyRqQ
	AkBXjLa6Wg4BE23PvLCQHeHnkPe0M6ulHQ7ieLiS1rHPDUzVkiRmKmdU7bo1/1Q9
	HBntR942090Ezkvs/fGWYBMJRllLdO3mwcg==
X-ME-Sender: <xms:_l6Xambgc9cb0pF2XnAF1LDZVtiMvk1mkdL0vUgNzOOGYED0YL_79Q>
    <xme:_l6Xag0nzNs1x-kghIWfZISajemmVx4jjgPYOX8oJ7hk60gH24TZQDyF4imB4blog
    Ds7MtDlD6SJqPA8hIFGRQYPxfK9A6a2_rUGKa2_m29OCGxBQ9empA>
X-ME-Received: <xmr:_l6XauVWfHv4zwkVfwidKnuGA33nbEdkrSQgLhzqxFKr9pUvSuFixOxQ2caH7-8tCFmO8RF5Ao_bmvJNWHM3hwwSyDB1yTMVCg>
X-ME-Proxy-Cause: dmFkZTGs2BGgg1gNqTrMzrHBZ5qAw9QXo0dwgB6iXKjVtQiRdf8JxVwe6ZQ4ia0p8Tjzg5
    7rCyAEu+13HaLZnVTcQnwidNPZaWOUGOZHWi5tUjw9o5hwW0oRU3EsYcxz2zEomUut9pR2
    QpvhsFTQ9t/rx60qXPFwNGkZXCioYipabnSlkMeBN/fdUHOiS5fafKdEh5jXD5+5RwKsBw
    dcQrzhwF5YdOFV7Ta8ToW1DjJux0YBvPgnUn7ux6RlSjdr5hqWlNUVazmHlzu2tTz8+hLK
    8QYrAKVB7+/Uk0fMyMecVSwjAxFOFAS5WYujTVV2U1NpvEghgY4nQpl/66kATYOObFdscm
    jMTL+EZXaaoH6HyZkvBiviewnJJNH5QJ5L1iiKwmhsDBB0mZJTx6n6MUuJ78CAUmkmlb+i
    0dAJCo89Xyq2Hea0XzFVdyfK60O28UFy5JzLmC8SIW3vP4LUTbapDeCOnKbryopuBK5NG9
    IdGhR0/WQDnIjqlyfuXrgUmR6zPRxrsLbRAwNJBiSurSRV/Oe+QkIA4lsw9bGXgYHbWSyx
    lG25UA3USdm/jc8G2bKIgSOtHkAtxqVyOUchphZ0Sq3UL0fBz79mvS2fllGY6x0u3QswRO
    UAg7Eb1x+L/7z9bll+nzSZZVikHbDRuR+6w3fvCvfOhnVtYJ2sWjuG8Zv+fA
X-ME-Proxy: <xmx:_l6XaiVB6ePUKcsH6DvE7ocTSwL7yNQ-mp0bl9Pq9zOg1wRRWzbz1A>
    <xmx:_l6Xald2VSn7EfFXx_o798vY3JVWO6l56eyh1Gv4r3wkB3KJW-b1tQ>
    <xmx:_l6XajUOe_Y7eE03opstcGhifXgDw9ugQJv5UVDqPSC5kE8Q6z1Q-Q>
    <xmx:_l6Xame01_0UCmgM6mkHD6nL3Y1KrjuglvR6FXnw4tLmtBf5NpAWsg>
    <xmx:_l6Xao1D305KzzyoboPQIfM6LSuApj5BrVVGeMRqIn8scoCdq7CKUZJ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 19:25:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] checkout: restructure switch, restore, and
 checkout entrypoints
In-Reply-To: <CAOLa=ZTHGAfRZJKjrB=u-AxiUWgL2p_5HijdfJmCN_wJCE8BqA@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2026 07:14:42 -0700")
References: <20260828225206.310500-1-gitster@pobox.com>
	<20260830204835.1040408-1-gitster@pobox.com>
	<20260830204835.1040408-7-gitster@pobox.com>
	<CAOLa=ZTHGAfRZJKjrB=u-AxiUWgL2p_5HijdfJmCN_wJCE8BqA@mail.gmail.com>
Date: Tue, 01 Sep 2026 16:25:48 -0700
Message-ID: <xmqqik4olfk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> cmd_switch(), cmd_restore(), and cmd_checkout() pass their options
>> to checkout_main(), which parses options and configuration,
>> validates and dispatches to checkout_branch() or checkout_paths().
>>
>> Now that option initialization, validation, and branch setup have been
>> split into dedicated helper functions, restructure cmd_switch(),
>> cmd_restore(), and cmd_checkout() to invoke these helpers directly and
>> dispatch to checkout_branch() or checkout_paths().
>>
>> In cmd_restore(), handle the --staged default from_treeish = "HEAD" and
>> resolve opts.from_treeish into new_branch_info and opts.source_tree.
>>
>> This allows us to remove checkout_main() and enum checkout_command
>> as they are no longer needed.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/checkout.c | 297 +++++++++++++++++++++++----------------------
>>  1 file changed, 149 insertions(+), 148 deletions(-)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 2edaca5539..b18515ac7f 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1341,12 +1341,6 @@ static void setup_new_branch_info_and_source_tree(
>>  }
>>
>>
>> -enum checkout_command {
>> -	CHECKOUT_CHECKOUT = 1,
>> -	CHECKOUT_SWITCH = 2,
>> -	CHECKOUT_RESTORE = 3,
>> -};
>> -
>
> Okay so this is how the first commit fits in. Now it makes sense.

Yes.  The point of the series was to get rid of the monolithic
checkout_main() that everybody goes through.  And the enum is
primarily for that monolith to decide which code path the original
request  is about.

In the step that gets rid of the monolith, the enum no longer
becomes needed, even though an error message with advice to tell
which options are mutually incompatible may need to know the exact
name of the option.  That makes [1/8] more reasonable than passing
enums around.
