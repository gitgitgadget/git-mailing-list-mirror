Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5F60DE5
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937420; cv=none; b=TNB31op422IQ5gbvSpNOrjeBZEHAw3M2Wot0TQod6G9DtxKAF5hTU2fvuZuJDnd4iU+S37q9weZUuSWoSG2hMqje+eyJHBNWG1t6q9buy0dtLtm5Bo7Wg8tB51yvO1nlL0gP1JnCt8dQKU/xyM+CUj4basteXp8Yc5cF0ktp+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937420; c=relaxed/simple;
	bh=EFYaVdBroTiiEliWsOVdYtsEM4HxvB2K0jhDWmA1QJA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BpX8CVREAKtbKG68delJ/bicNOp4GV3kG9qkFSb7drUeOL68lr2O24uqxRuI+Js0J1Sqfx6RPXvzBM7kp2/quHBeKLo74FH875rnM1iaQVhH1I+ayyAmzah/CxvnN6uDBxq0PFeYfNdZGLYaOyth3YXFy2jfPd6OjPsBozZxSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Wo/3YzS+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Wo/3YzS+"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707937415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpQETNN78Y/fxLDV9FwyOTSpnyJgenG+MLTpXRVtoNg=;
	b=Wo/3YzS+sKLIAJbtdHcA50gLc4vku0ktdc2u4DcbH9x1YcDwiO37z2WNHXGjA21xw46I3P
	bTZf0vOY4hUYWqz6XgR/9ywpaeJu6yEnKDa1ZTM4+nxYni6QZiFSra4k3FCL/htn+2cy/o
	NJLWiIaPLxpP2AR6htGi79K2AbjpE3NkwbvDhBYuURij7lk5F9tvuhalqKPNoskN8HFFkh
	VZSkPzz+LcEWiQ8THzDkGRj6c3izuwEzYc6HB8BP853vmrZTE2RDMpu5vnbOcCDhb/E0HY
	4NWVC1N1qEK89yjlikdu8PKLpPCTjO5bwxzYDGWf1Xh4PIE9LpHC6RpYTl1yzQ==
Date: Wed, 14 Feb 2024 20:03:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: add shortcut to "am --whitespace=<action>"
In-Reply-To: <c329d3ed43f852453ad78ba430363416@manjaro.org>
References: <xmqqplwyvqby.fsf@gitster.g>
 <c329d3ed43f852453ad78ba430363416@manjaro.org>
Message-ID: <91433860217a138ec528c8385b99e50b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-14 20:01, Dragan Simic wrote:
> On 2024-02-14 19:44, Junio C Hamano wrote:
>> We refer readers of "git am --help" to "git apply --help" for many
>> options that are passed through, and most of them are simple
>> booleans, but --whitespace takes from a set of actions whose names
>> may slip users' minds.  Give a list of them in "git am --help" to
>> reduce one level of redirection only to find out what they are.
>> 
>> In the helper function to parse the available options, there was a
>> helpful comment reminding the developer to update list of <action>s
>> in the completion script. Mention the two documentation pages there
>> as well.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Looking to me, with one small nitpick below.

Oops...  s/to me/good to me/
Sorry for the noise.

>> ---
>>  Documentation/git-am.txt | 3 +++
>>  apply.c                  | 3 ++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
>> index 82dadbecc8..67b12f315f 100644
>> --- a/Documentation/git-am.txt
>> +++ b/Documentation/git-am.txt
>> @@ -128,6 +128,9 @@ include::rerere-options.txt[]
>>  	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
>>  	program that applies
>>  	the patch.
> 
> It would be nice to, while there, move "the patch." to the line above.
> 
>> ++
>> +Valid <action> for the `--whitespace` option are:
>> +`nowarn`, `warn`, `fix`, `error`, and `error-all`.
>> 
>>  --patch-format::
>>  	By default the command will try to detect the patch format
>> diff --git a/apply.c b/apply.c
>> index 3d69fec836..4e57831aeb 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -78,7 +78,8 @@ static int parse_whitespace_option(struct
>> apply_state *state, const char *option
>>  		return 0;
>>  	}
>>  	/*
>> -	 * Please update $__git_whitespacelist in git-completion.bash
>> +	 * Please update $__git_whitespacelist in git-completion.bash,
>> +	 * Documentation/git-apply.txt, and Documentation/git-am.txt
>>  	 * when you add new options.
>>  	 */
>>  	return error(_("unrecognized whitespace option '%s'"), option);
