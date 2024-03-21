Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EE2BB1E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710998167; cv=none; b=I8XfWuMaZxwNqIUJkOOGE4lg/Vz6zfamllMRgLTX8vXxkIa0y39HEQOEieClt3ua5BYfu8tUj6iwPn0NrAdjAPPxJ5wtr+DalnMtu3jYPlf9yi56hi2BQeRIxpLYiM0As3u6Zb+Q3dqmssDBNPO64YSXTJu/vRki6hr2lfJZFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710998167; c=relaxed/simple;
	bh=F01Pfv+Tn+4rncaK9tMogSLg/E6jdpueqmfWUylziEY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZvRQ3NyypyLMQSR18ezIeFZObmGtiU+f1DfUNvCpBvATP9xHvDWbIua0scDBrwMWvExam1kDmF5ognL+xDCy5JbTyLz/o90rtuhee6cXGgBJ7aMxVl3+wGDqqxES+hC7DwkKY+PDJ9EzrE6vVEytUyEbzxHZ7uw1hSJGQYhL4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AuaY4xji; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AuaY4xji"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710998161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5AY4DnuIAgi/pqArq0AjhuYTrfHTKQtUq0QJHvK51s=;
	b=AuaY4xjiJYjN4pN3wwanS5sUzLQJ1ljs7e2a6aVcNCdLAqqykdGYQlWxCJ8UdRKTnk5gji
	ngMUDum7aCXg5tkJi7e+gJJFBtaR0JXJQhbwZ0KBKlX919kvCEaDUFcVCkfewYbCN12Ora
	5Yk8WhXDnIPqixQbDgjf211MNALQBhTwKw3AZlqJeCBlfXKrZQgMoVR9/SS+fxYW8wssVY
	z9junTzVoXu0k9RnpQ2YMBcJ7753liCTdo+jRgN2KVofmgZIPRT4slT1GEcFS10Xn894ZT
	OrMvxDJKUO2RQ/p2hfy2P0iXFUSIEz0Ngr6WWfXwFfJR4a2NyLoTs1uiBrEFgw==
Date: Thu, 21 Mar 2024 06:16:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v4 4/4] config.txt: describe handling of whitespace
 further
In-Reply-To: <CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com>
References: <cover.1710994548.git.dsimic@manjaro.org>
 <f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
 <CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com>
Message-ID: <9a5217f7f7a35768a3eb45060fb3e4f4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-21 06:11, Eric Sunshine wrote:
> On Thu, Mar 21, 2024 at 12:17 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Make it more clear what the whitespace characters are in the context 
>> of git
>> configuration files, and significantly improve the description of the 
>> leading
>> and trailing whitespace handling, especially how it works out together 
>> with
>> the presence of inline comments.
>> 
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -63,13 +64,15 @@ the variable is the boolean "true").
>>  A line that defines a value can be continued to the next line by
>> +ending it with a `\`; the backslash and the end-of-line are stripped.
>> +Leading whitespace characters before 'name =' are discarded.
>> +The portion of the line after the first comment character, including
>> +the comment character itself, is discarded.  Unless enclosed in 
>> double
>> +quotation marks (`"`), any leading or trailing whitespace characters
>> +surrounding 'value' are discarded.  Internal whitespace characters
>> +within 'value' are retained verbatim.
> 
> I find this statement confusing and ambiguous:
> 
>     Unless enclosed in double quotation marks (`"`), any leading or
>     trailing whitespace characters surrounding 'value' are discarded.
> 
> since it might imply that the shown <SP> and <TAB> whitespace is
> retained outside the quotes, as well:
> 
>     key =<SP><TAB>" string "<SP>
> 
> It should be possible to rephrase it to be more definite, while
> dropping the final sentence altogether. Perhaps:
> 
>     Whitespace surrounding `name`, `=` and `value` is ignored. If
>     `value` is surrounding by double quotation marks (`"`), all
>     characters within the quoted string are retained verbatim,
>     including whitespace. Comments starting with either `#` or `;` and
>     extending to the end of line are discarded. A line that defines a
>     value can be continued to the next line by ending it with a `\`;
>     the backslash and the end-of-line are stripped.

Looking good to me, thanks.  I'll include it into the v5, with
a small grammar issue fixed.
