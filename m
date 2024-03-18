Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B159B6D
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800088; cv=none; b=EZnVf6626ih0cB2CNJvjWjrivH0yoZaHe9LtT8X7Z2Snqq6gceBx3Jk47eA8GSj56OBjmIox4EpMPF0yCon+ZBr5rEYMxHJFBoQEtoFTs71P4ko5UKwvoqioNP5CarLGQqwFJa7cRF/bAibN3RT5v9rvk9QCHQ97YAwAaqjluMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800088; c=relaxed/simple;
	bh=3OA2ojQyDUaZ4R6MThjasvn37m3MBUFHiv2em9XuAaQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WNS0nQUe2cJaCXLbP9JcGkGOLMN9cb+T8yv2A9AVmbK47rfjVrhBuQCFgaP8f81qcHQ2M8j4H5CYLZBUyBEOs4I5+ECiEhKleYwPCOitojrxDim+LqCrdZIEcIIKB1STd2VLUZrYN9PW9UmT/h3/WauNklZI050q0vdB0RJHiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PTSMO0ET; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PTSMO0ET"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710800084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6vAlT0qrhm4HC1hHJLh7XPq/XzmoEZM3quWj5WSn+E=;
	b=PTSMO0ETdfQQyRQqaqj6YqEGAgtXMkmX2Tuo36GjlltMAiNqbFfrnF4TDps4e0/rj5g9EV
	WR/Z48G43OXtzsd783vfM1gWbj5ZJV1HSB15hM87X7HA2D8RQUk1n9MxbMozAC6u1fazK/
	yIFskobH+w0YeTXtJ612vC5lA+gU+GMIYjElVkX7sdA5OPDJ80R3fQry6eonQzda9n28gf
	6yEPtV21vb2hUWYzhGK38WrX5VAHyR9pRNmaOUwU2NkjK9zxwEg8tcPaNdjD3dIQyqED3q
	k/e/vJmo13GTCbdlLuolPMu1Z+nGiOQ2kqAopmy0RV+Kg404RJlq3w6hWWPpbg==
Date: Mon, 18 Mar 2024 23:14:44 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] grep docs: describe --recurse-submodules further and
 improve formatting a bit
In-Reply-To: <CAPig+cQc8W4JOpB+TMP=czketU1U7wcY_x9bsP5T=3-XjGLhRQ@mail.gmail.com>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <784912a8d9156fa00ddee218fd600254d7bab160.1710781235.git.dsimic@manjaro.org>
 <CAPig+cQc8W4JOpB+TMP=czketU1U7wcY_x9bsP5T=3-XjGLhRQ@mail.gmail.com>
Message-ID: <598b8683a06276f5b02dfd045c60d029@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-18 21:02, Eric Sunshine wrote:
> On Mon, Mar 18, 2024 at 1:04 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Clarify that --recurse-submodules cannot be used together with 
>> --untracked,
>> and improve the formatting in a couple of places, to make it visually 
>> clear
>> that those are the commands or the names of configuration options.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/Documentation/config/grep.txt 
>> b/Documentation/config/grep.txt
>> @@ -24,5 +24,5 @@ grep.fullName::
>>  grep.fallbackToNoIndex::
>> -       If set to true, fall back to git grep --no-index if git grep
>> +       If set to true, fall back to `git grep --no-index` if `git 
>> grep`
> 
> Good.
> 
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> @@ -65,8 +65,8 @@ OPTIONS
>>         <tree> option the prefix of all submodule output will be the 
>> name of
>> -       the parent project's <tree> object. This option has no effect
>> -       if `--no-index` is given.
>> +       the parent project's <tree> object.  This option cannot be 
>> used together
>> +       with `--untracked`, and it has no effect if `--no-index` is 
>> specified.
> 
> I believe that there is a patch series currently in-flight which is
> re-styling in-prose <foo> placeholders as _<foo>_, so you may want to
> make that change as well while you're touching this.

Thanks for the notice.  I'll add that to the v2 of this series, if
there will be other reasons for the v2.
