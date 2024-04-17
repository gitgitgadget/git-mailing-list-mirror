Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C806A329
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337522; cv=none; b=X4kVjYlwikWNlrtI3gDuiCAZacUqYF6JnVKkCaip8NeAnjEQbhqXE6jFelLV/UvaKkRLKVfExIOZL0vwjP3YD49Z1CAKsCmIeV1B3SkHEmjlwhhE1b8vj3x2cXMHK6k3n4tIWG3iQs+JpoRAilq6VMMGcpXnCV6zONF5keXYfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337522; c=relaxed/simple;
	bh=OuAhpOm1lObGixujPJZslhWQnEELVIBLUao4bokbJ0w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hOLOObeKRqGOlaGvrgTauXGiSsKGeQTVqEbOQ8ikrdANCr4e97JKh7xRI4wQtqGTTVSbi5vllhd8i9I81xCfykOKGxIas4EhhFrb0AtJchSNzaiXO/TFj8i+8TsEpnYeDDTy1AAR+PKcvhlVJcTNQKvfTDZhUACmL0Jj/CbMcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MYIJ5EHM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MYIJ5EHM"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713337514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbGHuBU2hxiIYiPP87MXU2HTCyp8ZmscPHhMXXO+1ko=;
	b=MYIJ5EHMPGEXCvZs8itIDD17HRk1SSznLf61hrtW2JvCn52HI2D25LaBHlupmbGrO+Lg17
	Bt9FUnUpMIMnj2fPp37J29soy13c1UwMKB9yTp+hQLw4PqfNEOYPI+kWBokz5HDZ+VB+Dd
	fcsw1TiHCgZJZ/FWvzWjqatpTqwHNMtRobvgIADL2+8o3yue13Yeaddvj9TcMxZj7aiX8f
	VLOnk0BBQwihh2YREPBlldJdLZ3I+6mJPmDKPmkkqatXhM/FOeXmFWjpjvMw0o/lgFuSMw
	DWKsM4tjpIBhsLS0DO7/Zxfl2ie7ARaJRrQ9ckL3MzFIWvJSz9JacFnvmwoCcQ==
Date: Wed, 17 Apr 2024 09:05:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <CAPig+cRzOHROK0VpkLR9fk7Gr0NRH9VKcH4dGXOuoaO5Ky2c2A@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRzOHROK0VpkLR9fk7Gr0NRH9VKcH4dGXOuoaO5Ky2c2A@mail.gmail.com>
Message-ID: <a0b93341380c2157f6b87e19129abb49@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:35, Eric Sunshine wrote:
> On Tue, Apr 16, 2024 at 11:33 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Add --resend as the new command-line option for "git format-patch" 
>> that adds
>> "RESEND" as a (sub)suffix to the patch subject prefix, eventually 
>> producing
>> "[PATCH RESEND]" as the default patch subject prefix.
>> 
>> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing 
>> lists
>> for patches resent to a mailing list after they had attracted no 
>> attention
>> for some time, usually for a couple of weeks.  As such, this subject 
>> prefix
>> deserves adding --resend as a new shorthand option to "git 
>> format-patch".
>> 
>> Of course, add the description of the new --resend command-line option 
>> to
>> the documentation for "git format-patch".
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/builtin/log.c b/builtin/log.c
>> @@ -2111,7 +2116,9 @@ int cmd_format_patch(int argc, const char 
>> **argv, const char *prefix)
>>         if (keep_subject && subject_prefix)
>> -               die(_("options '%s' and '%s' cannot be used 
>> together"), "--subject-prefix/--rfc", "-k");
>> +               die(_("options '%s' and '%s' cannot be used 
>> together"), "--subject-prefix/--rfc/--resend", "-k");
> 
> You probably want to be using die_for_incompatible_opt4() from
> parse-options.h here.

Thanks for the suggestion.  Frankly, I haven't researched the
available options, assuming that the current code uses the right
option.  Of course, I'll have a detailed look into it.

> (And you may want a preparatory patch which fixes the preimage to use
> die_for_incompatible_opt3() for --subject-prefix, --rfc, and -k
> exclusivity, though that may be overkill.)

I'm not really sure what to do.  Maybe the other reviewers would
prefer an orthogonal approach instead?  Maybe that would be better
for bisecting later, if need arises for that?
