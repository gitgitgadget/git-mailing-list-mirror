Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5644AA59F
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443883; cv=none; b=DBCXZ/n8Fot4Cmpqr+fwC8gi1dk6e//b93EzZwu6YBPWC1TZXvgX2tucKzB4t6qd8c5rP3r/Vxo+u74Rd8S7mpt6yzVZ6E/Y2Q1L0RP7YyRosolsr0nES3uVFYDkL5Nmks+yjxkuIDYiFxSxQLvrJYpyxS+PZOtPr0BLB+uni8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443883; c=relaxed/simple;
	bh=HLpmFtABUgGOOhsre9GJP+JCV2Aa4NYGk4rw6PSOndM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=frRM7mUVfXFkcqFiqveB8NXit4JRLXI61aF+H+iq2PSydds6p+l/zm6liqi99/KlhbUtuqiU27xdiP8RxFJfcvMt3eS8urqHotR1xVnOjgoRXO5eR6uhex7VTaJ3c1SZFII+Bx/MgdIAW6IBCLXlsjD6ZSkaoDpNxa9mdT7Zo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fImlzvLG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fImlzvLG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so21927025e9.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443865; x=1789048665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJpJvp9ymhQEYtFRjArVI8W1/jQcFY46CqpHaFDBzr8=;
        b=fImlzvLGlBt7NIgMZK9Ro90cwwZEMRPSI4Fb7RW62YFnui2t2H4NILiX9yJE4ZZ5bq
         aFBBkdL6ItBL8z1L7O7weWcYQM6uxwXP3cz0Dmk9tRAhHlDB/e/5ITh6YJ7HyyxOcBxy
         uceDWYRPRfXBO5T+6oiDc6vN/3ul81M91By4AT/AXMRIUwc3LEq7zCkfBkSRdEAXlCcX
         x0dHa52nmWn/WmgKnjxp9Yf4hzL39TOVxK2IXebNJ5Ut81I0ETQJ1wJPsXhzMfWFC5PI
         S2fBOva2XFrMPi6TSlUnuhwxGGBaxTTO84hhCNDm65RDFJYteEaKTykXhBi/sozxvODE
         ISoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443865; x=1789048665;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJpJvp9ymhQEYtFRjArVI8W1/jQcFY46CqpHaFDBzr8=;
        b=kWVE21hJpg5gRDBdspCYsGeNJk+Orj8uWwbpg77LQP/ftggqrfajIdr8b89MEYG12v
         A+mAP7pe0beQTxX8ABQDDHTN+QpjjKy/NYQwR/DC/LBMMHXiyjaTrDXP8lsQqhIN7xq6
         DcYtA+iANp5pIH7Op/5k+yCBUce5CMuplr2nmRmhdxC/xbg538ACR1p6VpI+5lzUuHaC
         PjqSVOUeg6hGDQ9QzAq+DdyBkRHLEJNG0u4IZz8u59UmnlKLsAVNsbCwyfgdzgjT8X8S
         NfL5e2nV7ebAOuCXPFwqVoqrCtswX5YnWFq1KXZqMfUqHrNTIUSF7VtwimY76smCxukV
         I1Sw==
X-Gm-Message-State: AFuF++khAgCFiqHNzfs5DvL6olN3AwS4DO/JvZxNcg3K0xzDm2sq1WFL
	JkYqiWYDyw4JMKla1YDPgXmYrDWNExVRDSjWwZnNh0o/lkjCzxeA3Dd5
X-Gm-Gg: AYBFou390BW4w2/bClR9znbJnq6c7hFGSQ/LbpYa49FgtQiDmc+EkVJaGEP0sELvAbe
	cBz19SP1BkWtEeazINJHwYLs2MiHgMQnPp083ndskG+Z/Hlcf/iM9DED8dgmLyjM9T5BYBuYvPM
	R+b277n8Qg3kCfOd+2Ynlv9VMHZzF/qHVTnAU8TCPvir5P2jAamEqgmplQyVoo6gY7DAauegwat
	qnRJ/d43dCyeObvDV5joPI2FasipAfywyWgsXp39cUvKDBatA2NMJlE3mdHkvhUJq0BLqeianL3
	I+8yuCqX2t9t7Qaa1N9k+OUfvRiX2S2G63uC1DDVqmfv+kPwhFahe+52v9Yu+BYAAd7SfunUFp1
	3C+u9N05oJddj/flJpgJamW3Dg6iSLQ6hsLQEjpc12+M8cMnuOkn8amplaBiGk+3vGZkbU/+ANs
	Uq7EJrUAMlHqed43UbHHsOA6YW/4W6iWkEt6dIw+4wyXunanEPRAz5q+QJ0OksR1k/eDe9ZGKB1
	MWYZkhz8LmPyd1T0lqR4WF9rjvgQMuSeJfChHSdHwc=
X-Received: by 2002:a05:600c:45c4:b0:49c:e1df:79a4 with SMTP id 5b1f17b1804b1-49ce57fdd1emr231641335e9.5.1788443864991;
        Thu, 03 Sep 2026 06:57:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dadddsm88652805e9.9.2026.09.03.06.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 06:57:44 -0700 (PDT)
Message-ID: <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
Date: Thu, 3 Sep 2026 14:57:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
 <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
 <xmqqwlt3h1oc.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqwlt3h1oc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2026 20:51, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> "git stash apply", "pop" and "branch" exit with status 1 both when
>> applying the stash entry resulted in conflicts and when they fail for
>> other reasons, so callers cannot tell the two apart.
>>
>> Follow the convention of "git merge-tree" and the merge strategies,
>> which exit with status 1 to indicate conflicts and with a different
>> non-zero status for errors: those subcommands now exit with status 1
>> only when applying the stash entry resulted in conflicts, in which
>> case the stash entry is left in place, and exit with status 128, the
>> status die() uses, when they fail for other reasons.  Document the
>> exit statuses.
>>
>> cmd_stash() used to collapse the return values of the subcommand
>> implementations to a boolean.  It now maps negative values, which
>> signal a failure, to 128 and passes everything else through as-is.
>> The only implementations that return a positive value are "apply",
>> "pop" and "branch", which return the value of do_apply_stash():
>> "apply" returns it directly, and "pop" and "branch" drop the stash
>> entry, via do_drop_stash(), which always returns 0, only when the
>> application succeeded.  The positive value is always 1, as
>> do_apply_stash() only returns a positive value when the three-way
>> merge was unclean.
>>
>> Make the convention explicit by introducing enum stash_apply_result
>> with the values STASH_APPLY_CLEAN, STASH_APPLY_CONFLICT and
>> STASH_APPLY_ERROR, and use it for the in-process autostash helpers,
>> too.  They spawn "git stash apply" and can now tell conflicts apart
>> from other failures, e.g. a crash or death by signal of the child,
>> which map to exit statuses above 1.  Since we know the stash entry
>> was saved, tell users so in the error message instead of leaving them
>> wondering what happened to their stashed changes.
>>
>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>> ---
> 
> The above is on the overly verbose side.  The first two paragraphs
> give enough discussion and the remainder mostly repeats with small
> details sprinkled in, which can probably be shortened to 1/4 of the
> amount of text, but it is OK.

I think the analysis in the middle of the third paragraph is useful to 
make it clear that the return paths have been audited correctly. I agree 
the rest could be condensed or cut.

Thanks

Phillip

> 
>> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
>> index 50bb89f483..fc6a9a008c 100644
>> --- a/Documentation/git-stash.adoc
>> +++ b/Documentation/git-stash.adoc
>> @@ -426,6 +426,15 @@ include::includes/cmd-config-section-all.adoc[]
>>   :git-stash: 1
>>   include::config/stash.adoc[]
>>   
>> +EXIT STATUS
>> +-----------
>> +
>> +The `git stash` subcommands exit with status 0 on success.  The
>> +subcommands that apply a stash entry, i.e. `apply`, `pop` and `branch`,
>> +exit with status 1 when applying the stash entry resulted in conflicts,
>> +in which case the stash entry is left in place, and with a non-zero
>> +status other than 1 when they fail for other reasons.
>> +
> 
> Great.
> 
>> +static enum stash_apply_result do_apply_stash(const char *prefix,
>> +					      struct stash_info *info,
>> +					      int index, int quiet,
>> +					      const char *label_ours,
>> +					      const char *label_theirs,
>> +					      const char *label_base)
>>   {
>>   	int clean, ret;
>>   	int has_index = index;
>> @@ -717,8 +720,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>>   
>>   	/*
>>   	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
>> -	 * merge was clean, and nonzero if the merge was unclean or encountered
>> -	 * an error.
>> +	 * merge was clean, and 1 if the merge was unclean or a negative value
>> +	 * if it encountered an error.
>>   	 */
>>   	ret = clean >= 0 ? !clean : clean;
> 
> OK.
> 
>> +	if (fn) {
>> +		ret = fn(argc, argv, prefix, repo);
>> +
>> +		/*
>> +		 * The subcommand implementations return 0 on success, a
>> +		 * negative value on failure, and STASH_APPLY_CONFLICT
>> +		 * when applying a stash entry resulted in conflicts.
>> +		 * Map failures to 128, the status die() uses, so that
>> +		 * exit status 1 unambiguously indicates conflicts.
>> +		 */
>> +		if (ret < 0)
>> +			return 128;
>> +		return ret;
>> +	} else if (!argc)
>>   		return !!push_stash_unassumed(0, NULL, prefix, repo);
> 
> Style.  Once one of "if", "else if" and "else" cascade gains
> {braches}, others should do so as well.
> 
>> +static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
>> +							int attempt_apply,
>> +							const char *label_ours,
>> +							const char *label_theirs,
>> +							const char *label_base,
>> +							const char *stash_msg)
>>   {
>>   	struct child_process child = CHILD_PROCESS_INIT;
>> -	int ret = 0;
>> +	enum stash_apply_result ret = STASH_APPLY_CLEAN;
>>   
>>   	if (attempt_apply) {
>>   		child.git_cmd = 1;
>> @@ -4816,9 +4819,11 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>>   			strvec_pushf(&child.args, "--label-base=%s", label_base);
>>   		strvec_push(&child.args, stash_oid);
>>   		ret = run_command(&child);
>> +		if (ret > 1)
>> +			ret = STASH_APPLY_ERROR;
> 
> This kind of code that assigns any random "int" that is returned by
> run_command() to "enum ret" that has much narrower valid value range
> and then makes corrections annoys me a bit.
> 
> One way to do this cleanly might be to make a small helper function
> do_stash_apply(), and use it like so:
> 
> 	if (attempt_apply)
> 		ret = do_stash_apply(stash_oid, label_ours, label_theirs,
> 				     label_base);
> 
> The implementation of do_stash_apply() would be like what you have
> in "if (attempt_apply) {...}" block, perhaps like:
> 
> 	static enum stash_apply_result do_stash_apply(const char *stash_oid,
> 						      const char *label_ours,
> 						      const char *label_theirs,
> 						      const char *label_base)
> 	{
> 		struct child_process child = CHILD_PROCESS_INIT;
> 
> 		child.git_cmd = 1;
> 		...
>                  strvec_push(&child.args, stash_oid);
>                  switch (run_command(&child)) {
> 		case 0: return STASH_APPLY_CLEAN;
> 		case 1: return STASH_APPLY_CONFLICT;
> 		default: return STASH_APPLY_ERROR;
> 		}
> 	}
> 
>> -	if (attempt_apply && !ret)
>> +	if (attempt_apply && ret == STASH_APPLY_CLEAN)
>>   		fprintf(stderr, _("Applied autostash.\n"));
>>   	else {
>>   		struct child_process store = CHILD_PROCESS_INIT;
> 
> Good, and the rest of this function is good.

