Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64BE33F8BC
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667653; cv=none; b=sI+zjJ4QPTQeB8bMbJCuDk/+l8w9SQweGvTxtjQmUyUMIWKaHMMUGw1P0RTyMmi+ryswOLVhAUkDjX7nL3fKM2Vsee3I0/JBTtN9yhVJ/ohSEYQ16fcuxXel7MfEbR0g/YeBbCZcBsKSfn3Ax7GHiC/ZxGLVVk7BRivLe3G5nZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667653; c=relaxed/simple;
	bh=oW2/dkQ1DycR/dr4ngEoVN6i+U6Pj/+BrFlxusulDTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA1gcxqZQI2RijSy7+TmJ7fjmJA89op+fOmXuqFEQNErZ4QoU4D/yAMDHpMocn/pG7ZI64OBcMwnOBsoT40o1GtypYhvMT4LMC88yLvlSGqBwG4d/tBsjbZfqzb6NoxXDf2+1I/9cXd9GyRmT0zKO3hCv5ssO+drSC34bN1BxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=SuxikcNC; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="SuxikcNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1761667648; x=1762272448; i=antonin@delpeuch.eu;
	bh=ILnoywz3yPiur0E+nKGlL3268Y3qQe0fHxGtmFIuqyc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SuxikcNC17MOPh0RUgJGeUEWKnWL1SRnhI5nQIitN0gdfcmfma7sDfc8rWzz3RuI
	 gRKyL+OjccGNbknQiT8cr4mrUFUmDJPo4WgC2Z/MLUleCaMoatsqnTj98fz3JtIU5
	 b505FzBZnSnAWgPmQEdfpfmhvHa3B9X7FsZXLnSXde9QP5rIfI4ZUkF2uiEypobrw
	 IZluh5qbAIaXZbekt6cOQOcg/246KYefQSuHhA5nMdcM7VAIdoXJCJQo4/pkyYJKW
	 RlNXu4caRI76OlnPfWPjQDU9Z0oVwsQZ6dpmoAgrnvFE/rEH6wq19i+ZBZ/L8Vqux
	 Ee9ctVGBnb4zRAq1PQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([79.246.85.239]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowSu-1w3rea1Ywo-00gwOl; Tue, 28 Oct 2025 17:00:46 +0100
Message-ID: <362c7dc4-c35f-440a-ae20-e1d06e183fce@delpeuch.eu>
Date: Tue, 28 Oct 2025 17:00:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blame: make diff algorithm configurable
To: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
 <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
 <xmqqjz0fdpa3.fsf@gitster.g>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <xmqqjz0fdpa3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CxYYJQuBi2Th/GyZKupTJVDgcHe6GOoFNGfSib7SfGF0HfE2LE1
 RLKZx8smQRQj+hGArALpU06Moja1p6rZjDxE+zJ5m/GX9JC4euC7YpY9zqdiHBcXcx5A0kf
 AkpObCFRj6hDtz5yOH7odCCHDLHTXdNn/GHXlPFtxMP7jU2Z+wARvmwCJzr7dDjnAwXsk4T
 7RxfG3/0GUXbP4pFfKT7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sTTFXLOtWko=;sCwmJWB3CnWqfJaoVBt9pqfCVku
 1MSoVb4JHikuE2WBcGhSgP3RhyQ5uOf0sa47+BOrOeGQ5R+hPZOF7/9qzsHeold5Za6xVQPxl
 XtD9ncVpt6RqEr6bcpW1jGtZteMbAZeM6NgjJhhW2E7GuMc6KdeFZ92RnErIhIvswnM8ZnrwA
 mG3JdoTdY2LY4TvFoTWdABPzJ5Lre0cKMSZjCf5BtA3xqe4ImL56oE31NZ5vmsuvCysmFTSCE
 4h6aMqZV0vM3xjxwBwjcDIuwhYeiClx1hP8QMlJHNHYr9zCgc9+lsXp4BR8OOVi6xVRegpqid
 EFzSUmY4TDJEytuvsWhcUQxJTACkwS6WZyKmGovB0zH4Zja0sFtUbg5rKYmmHcn1ntkmO0liA
 cNQyOnrdFqVkixMRz7XMxC8owcj4KKlwkWpbzvQcmeGOv2dBO9qGCIF4adrF4k3CY6E52UJSH
 ymtewVX2ao3D5ojpnnZsxPmW7sG/yvqR0JkvzMpQWTzgpHpQCAqs56STYozSjs1ybm1lFiXiB
 ZIUV2Gd84fhFMpgNARhQ07T7uwzf57xi11KxOCCFFmN2JTzUZX8lGdizM4Xij7PgogX+3LugF
 duuAT1smf1cRbTiNNveF9AweLUXvM1JsUxMQFj0TeiaKTG1myEH6nAjG0FdHhct8Td5+kYPJ2
 S95YrwTi1uhWFbRolIaZG0e6C9oFu89Jl2sbk0t9Qoia+EL8O7cuofbx+74MMGPCUW31PBl1U
 JZ9HfpNRVU1toEV0un37FymdJUyLGsXTLAw25Tejka9bBa6NI4KTI7OhHRy4MpaYbG3vSNf/g
 uFjZMYyVriruhnctvDd/FkhOLcRGwbqAEzeBibIrkIz74TgbluztVbMz6EitoZuEh4ifvYjNR
 KLPBBT4c8kfsAD4hBJ64udTjvbe8I9oaJlDfI6Y/4Ek19uWwyqyqb4CUuQrGUSIeMMxBwwRyx
 atmi0TZ+8SDxuFXp7XR/K7ig216NQFgtZCT5eQ1DiG+ToJJmyvdsDCHsKg0qs38T7ayJjkZW6
 L3O2GUzbAeFYBhDGhW+qrHMgXWAWm7HX+GbsNia9z/PDXmDrquWM3vDt7AqEOpqV5P8q66gRE
 zZYyfyXtIKiE5BHJ168K1qAtYeNMKMwFCMQvyYHwJJX+6nwe4SHUGmLWuDpyx5ExtHaFo1Twn
 KeOXknivhHfMcUh1qq9XmYeRacPHoDqG7LlBsl+HVfXjcGvJrI/k80p8aRMKXzMZihxB9QfM3
 NBTh4uI90Xj8zoI2ICJV47Sqp6Yqe/24blWqpXcaZOVJMzACZnOFBy5faRCnhDDZv4u61NcnX
 fm3kJsQUmYMWlntqfV6unmVtThUaESdmGbVhuUkHf6tvv5S/jKESa38FOpirMYp7zXVWVGCvU
 hzJChhTk29oSe+SIK6JNwQY9XVAdJtdT3fF0WXD14w5YlkHJ93tl8+AS8PAiTjriD9MzZdEP9
 GNSUpW3gYw7Xzr8KI757Wbew3K3wQJApd8asEgIUwNal5YJjTTMahbkCbTyOJIAsprEH/rKCD
 NgUnVFuhqKp2tH4UV9XuJf4dh1p+QiwStsKk+m/0OyyPOa5UGz4rjmPh8VI8Kt1REzDmYUS7R
 w5rv56PfuIAXUR/nsC4MW+B/hBMtje3rRid0ho4gxy9Pz/9AnKvRxmAedhFPaPBwm+nu8aty6
 sPfCp4BDHrHxYrE3YC7bwa

Hi Junio,

On 28/10/2025 16:22, Junio C Hamano wrote:
>>      Changes since v1:
>>     =20
>>       * add tests
>>       * ignore --diff-algorithm when it is provided before --minimal
> Sensible.
>
> I presume the reverse is true, i.e. giving "--minimal" and then
> "--diff-algorithm=3Dhistogram" in this order would make "histogram"
> survive, in other words, the usual "last one wins" rule is applied?
Yes, that was already the case in the version 1 of this patch. Philipp=20
noticed that it was only true in one direction, so this fixes it.
>>   static int is_a_rev(const char *name)
>>   {
>>   	struct object_id oid;
>> @@ -915,10 +960,17 @@ int cmd_blame(int argc,
>>   		OPT_BIT('s', NULL, &output_option, N_("suppress author name and tim=
estamp (Default: off)"), OUTPUT_NO_AUTHOR),
>>   		OPT_BIT('e', "show-email", &output_option, N_("show author email in=
stead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>>   		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), =
XDF_IGNORE_WHITESPACE),
>> +		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
>> +			       N_("choose a diff algorithm"),
>> +			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),
>>   		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("i=
gnore <rev> when blaming")),
>>   		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("=
file"), N_("ignore revisions from <file>")),
>>   		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metad=
ata from previous line differently"), OUTPUT_COLOR_LINE),
>>   		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age")=
, OUTPUT_SHOW_AGE_WITH_COLOR),
>> +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
>> +			       N_("spend extra cycles to find better match"),
>> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>> +			       blame_diff_algorithm_minimal),
>>   		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find bet=
ter match"), XDF_NEED_MINIMAL),
> This OPT_BIT() can stay here?  I thought parse_options_check() was
> capable of detecting duplicated long-form commands as programming
> error, but apparently it does not.  (#leftoverbits) We should look
> into teaching parse_options_check() to check duplicated option
> names.

Oops, that's an oversight on my part indeed. I'll fix it.

>
>>   		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions fro=
m <file> instead of calling git-rev-list")),
>>   		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file=
>'s contents as the final image")),
>> ...
>> +test_expect_success 'blame honors --minimal option' '
>> +	cat >expected <<-\EOF &&
>> +	Initial
>> +	Initial
>> +	Initial
>> +	Second
>> +	Second
>> +	Second
>> +	Second
>> +	Initial
>> +	Second
>> +	Second
>> +	Second
>> +	EOF
>> +
>> +	git blame file.txt --minimal | \
>> +		grep --only-matching -e Initial -e Second > actual &&
>> +	test_cmp expected actual
>> +'
> Do we need to test combination of configuration variables and
> command line options (to verify that options trump configuration),
> or two command line options (to verify that the last one wins)?
It's easy enough to add such tests, I can add a few more.
>
> When xdiff/ part of the system gets improved, the above expected
> patterns may have to change, these tests may fail.  Whoever updates
> the diff algorithm to cause such a failure has to tell between a
> genuine _bug_ in their update to diff implementation and the test
> expecting a suboptimal result based on the behaviour of the diff
> algorithm before their improvement.  And for that, they need to
> debug these tests.  But I suspect that these tests will probably be
> very difficult to debug, as it is almost impossible to see which
> line in the original each of these lines correspond to.

I'm happy to make the tests a bit clearer by including the lines in the=20
expected output.

I'll submit a new version with those changes.

Best,

Antonin

