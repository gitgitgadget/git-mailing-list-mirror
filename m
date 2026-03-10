Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42522868B5
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152485; cv=pass; b=anBMdaS0TpAPBu2MRHTCrHnQXcrEc+D5zaPRbci4LVsFMgs0NWSFy6tPyLi7arbAHKtA2e/U+U3bkBK23jD4ctIGHdUBA8v11mWOFZSANP9On9yNsE3dgfrnJAdMef665/y+wnm3/gRWwXMoXmSuaiaEtnv3qbss7ktei4cseek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152485; c=relaxed/simple;
	bh=xcRY/MS5VRV70OZXZHaXX5mCI5UBS9Q3MCMhkR55Tlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t39ICTBAtTQGyVbBtcz0igoXr4VjJiNAoeRPlnGADWhxL2Z++mgjdKqGaZkBWCv+CasEfT42IUR/pEgOwR0rtHG2gBN+vGeltQ/xianoYLktkUZajYS0MNLV+ySv1PQWWeoy+mrlC2o6vd5VlkNTuy7b1W0zfKCf64LOWOckDTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lONW6t0W; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lONW6t0W"
ARC-Seal: i=1; a=rsa-sha256; t=1773152459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VIeWQ4ZhHfyFonl+bGk6yzJdwyz+SpjJYvL/EnJoGXoHkYr4dD1GgL+jgmvD0Uru4kxz5M5k4RcDgGd8uWq9uMfN4EBotwycMQNpx8Pg6JzY4P89nze8NXRGKl7I5UHKbi6cKHizwxiK7MMVjiouEEdLv7O1vcjhNrofgGGmz48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773152459; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tQ/64W9fyqS6v+9JH1gg3FlfWXmiSfARH97R1Q7SZ50=; 
	b=k+TxlvMnZZuKwsqquRoselsmZWKLLCT8FpT8SEZaWSM6+moIxkrG3qyO2jn1MVG26RilN4hgbLDgDpKCfONBxVzIHbKqSAHZqtjfXKXLG+hp9NLk9x7HtuznHeJ4SxmCUgQ0aqa4sAjZVRuxhZ9q8zNfZQWCmfp5bDf7KQTEqL8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773152459;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tQ/64W9fyqS6v+9JH1gg3FlfWXmiSfARH97R1Q7SZ50=;
	b=lONW6t0WUFwrG12Oj3n7YluHiqeON16Q9++GDaEfHs/x/o5DaBXCpOAe9yGMWcWC
	ikBYEVz5HzZsptgjM9JyS/aR+srLcuuyOgD0TmxUq0zXexmwxu9ya0P7AFADNApvM3C
	Yv7wQR9E5XH+nGGe5k0tU8OqCrW03z2xYwZEtSGQ=
Received: by mx.zohomail.com with SMTPS id 1773152456470730.8434276955337;
	Tue, 10 Mar 2026 07:20:56 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, "brian m .
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 05/10] hook: replace hook_list_clear() ->
 string_list_clear_func()
In-Reply-To: <CAPig+cRngzGdd-ABWLSiypuJVQ-LVv-xqmn2h+c7qB8_OBpyRg@mail.gmail.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-6-adrian.ratiu@collabora.com>
 <CAPig+cRngzGdd-ABWLSiypuJVQ-LVv-xqmn2h+c7qB8_OBpyRg@mail.gmail.com>
Date: Tue, 10 Mar 2026 16:20:52 +0200
Message-ID: <87eclrg3zv.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Sun, 08 Mar 2026, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Mar 8, 2026 at 8:55=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabo=
ra.com> wrote:
>> Replace the custom function with string_list_clear_func() which
>> is a more common pattern for clearing a string_list.
>>
>> To be able to do this, rework hook_clear() into hook_free(), so
>> it can be passed to string_list_clear_func().
>>
>> A slight complication is the need to keep a copy of the internal
>> cb data free() pointer, however I think it's worth it since the
>> API becomes cleaner, e.g. no more calls with NULL function args
>> like hook_list_clear(hooks, NULL).
>>
>> Suggested-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>> diff --git a/hook.h b/hook.h
>> @@ -186,10 +194,10 @@ struct string_list *list_hooks(struct repository *=
r, const char *hookname,
>>  /**
>> + * Frees a struct hook stored as the util pointer of a string_list_item.
>> + * Suitable for use as a string_list_clear_func_t callback.
>>   */
>> +void hook_free(void *p, const char *str UNUSED);
>
> See [*] regarding UNUSED in header file.
>
> [*]: https://lore.kernel.org/git/xmqqcy1g25fl.fsf@gitster.g/

Thank you for pointing this out!

I will fix it in v2 together with your other suggestion.
