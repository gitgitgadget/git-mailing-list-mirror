Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7614E2FC
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722695692; cv=none; b=NyGAnhvg/n1f8J3x7jm9FlxRxY1wqwYjwkH5fkEf/7ZU0FY423X63j4IL4qUebkpf1ax+p5dNzXexYEs/FP9JgcZ1l3Qp8iwmRdQRPEQzn04EUWia6zDRWXLNCiYG2Nm13RKbIDhBIq/qp+R5CcqevgO//igyhKy3jbCJKp+dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722695692; c=relaxed/simple;
	bh=yrTlhFGbFbKIXHFTvkv8rIMKGprCQYTJRdhA7t8RvkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBBhYJFVUOvrrLhmhU6j1T7uBANJMxTNcadVUz+bypg9ly+NjNPh98oyl47gOls3d/w9f/HFrcI9IYezgTwTWJjoidic7EQSLd6uXnFl0BtGByp/+5mXIWPZWyKviwGl6DHjeRsD4FF4yRKcft+l9NmL6hNWexK75ef28LQGvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMfi2dPj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMfi2dPj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36868fcb919so4702739f8f.2
        for <git@vger.kernel.org>; Sat, 03 Aug 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722695688; x=1723300488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNXPPWsy/CfvsdCZINc/b8gxAh/mjX53N8Z3NWLRgOA=;
        b=ZMfi2dPjku1frJ/os/MTaOljGe2vvJmlkRj/DpLppbPeLS0DNuu/P5OYc9irc+hJYX
         QMM1ciDcxinHWDCoS+bRcd34w0TSR9T3MXpZQz/0SBa2BNFgu2DWCluXyIP0SBcDNWlt
         tiDpUpaPWi0ILcA/KKPhj0S0jGB39nrKANzfwlWZJkdOO5GXLD2vnkGXYiBhdMoLkcmy
         KVmlFKunn0nF/K0H8B0ourIY2I0u+P2l1pnhZ8QedyXSPF5MIlBD9Ob156jy5/GBK+cU
         Mb7DrbpZIqn2mVG0rxksDXy06CLkmjMSnhTLjUgHIlSCoEOf47/fNPpRfU9fauJB70BX
         Jf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722695688; x=1723300488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNXPPWsy/CfvsdCZINc/b8gxAh/mjX53N8Z3NWLRgOA=;
        b=a8V8ZzuKxn/szMlvMK9mTHKMw6JQOkSokDHIr1CULg+sSzKc3gfbifPgUUNGQ5hb96
         IL/OGXPdLh4gMaXOIkSqoZ0Z3ovJR2eeaslAE4bU9M0hGnmHXRq00jb9i3bAzoztUI8W
         LAgY7m8olxsjQIRKoHrQ7q7KpGIgHN587OgG+O6GkN3Jari9uGt+QTtl4C2IwDr9XgbH
         WszKte5M85hBJaZbMqtFS/R9Ex+JLokH4XYE/S9j2SquUa/ffO61A8vvuDQfq05uuU2p
         e//LC8q4qaJJ+ANy2WcWFt5LIbi5sNY/QHjBphJ40zM6HXdQRwy2JveH0flBCf9OTs0X
         oSGQ==
X-Gm-Message-State: AOJu0YzZOkL9PcTFOe2VXr45Jy0244+r0ClEX827ynv9+hrSL15WS+uG
	KDN5pBc6MtVLcfRVpQ0LYXQy8+Uj0aCxdKwHnn8PCPs8ZwvAQGDPQP0Nj46Y26E=
X-Google-Smtp-Source: AGHT+IFROeNN+ld8ebFrnEdW0E+V3MHVXg164hPG5GjuXtTxL89IwN+QeK5/Lw1ECQ5Qa0/C+wftOw==
X-Received: by 2002:a5d:5e12:0:b0:36b:bd38:c724 with SMTP id ffacd0b85a97d-36bbd38c869mr4174189f8f.47.1722695688081;
        Sat, 03 Aug 2024 07:34:48 -0700 (PDT)
Received: from [192.168.1.6] ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bc5a6fa1csm3491625f8f.78.2024.08.03.07.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 07:34:47 -0700 (PDT)
Message-ID: <dcded6a3-e284-4d52-b36f-dacc056bbc5b@gmail.com>
Date: Sat, 3 Aug 2024 17:34:46 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][Newcomer] t7004-tag: modernize the test script
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240802064719.513498-1-abdobngad@gmail.com>
 <xmqqttg2ewqm.fsf@gitster.g>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <xmqqttg2ewqm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/2/24 19:05, Junio C Hamano wrote:
> AbdAlRahman Gad <abdobngad@gmail.com> writes:
> 
>> Modernaize 't7004-tag.sh' by removing whitespace
>> after the redirect operators.
> 
> It is a good start.  There are other modernization opportunities in
> this file, though.
> 
>   - Output from "test-tool ref-store" piped to "sed" means the exit
>     status from an abnormal exit of "test-tool" is hidden.  They
>     should be split into two commands.
> 
>   - Expected output file prepared outside test_expect_success that
>     uses it.
> 
>   - Here-doc that does not interpolate leaving the EOF marker
>     unquoted.

Thanks for the review. I've just sent a follow-up v2 patch fixing the 
things you mentioned. I also found other issues like:

some test_expect_success are seperated from its name like:

    test_expect_success \
    	'trying to delete tags without params should succeed and do nothing' '

but I preferred to send the patch first as it was getting very long and 
I also wanted to make sure that I am on the right path and not just 
fixing unrelated things.

>> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
>> ---
>>   t/t7004-tag.sh | 50 +++++++++++++++++++++++++-------------------------
>>   1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index fa6336edf9..3100a4c219 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -213,9 +213,9 @@ mytag
>>   EOF
>>   test_expect_success \
>>   	'trying to delete tags without params should succeed and do nothing' '
>> -	git tag -l > actual && test_cmp expect actual &&
>> +	git tag -l >actual && test_cmp expect actual &&
>>   	git tag -d &&
>> -	git tag -l > actual && test_cmp expect actual
>> +	git tag -l >actual && test_cmp expect actual
>>   '
>>   
>>   test_expect_success \
>> @@ -269,9 +269,9 @@ test_expect_success 'listing all tags should print them ordered' '
>>   	git tag a1 &&
>>   	git tag v1.0 &&
>>   	git tag t210 &&
>> -	git tag -l > actual &&
>> +	git tag -l >actual &&
>>   	test_cmp expect actual &&
>> -	git tag > actual &&
>> +	git tag >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>> @@ -283,7 +283,7 @@ EOF
>>   test_expect_success \
>>   	'listing tags with substring as pattern must print those matching' '
>>   	rm *a* &&
>> -	git tag -l "*a*" > current &&
>> +	git tag -l "*a*" >current &&
>>   	test_cmp expect current
>>   '
>>   
>> @@ -293,7 +293,7 @@ v1.0.1
>>   EOF
>>   test_expect_success \
>>   	'listing tags with a suffix as pattern must print those matching' '
>> -	git tag -l "*.1" > actual &&
>> +	git tag -l "*.1" >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>> @@ -303,7 +303,7 @@ t211
>>   EOF
>>   test_expect_success \
>>   	'listing tags with a prefix as pattern must print those matching' '
>> -	git tag -l "t21*" > actual &&
>> +	git tag -l "t21*" >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>> @@ -312,7 +312,7 @@ a1
>>   EOF
>>   test_expect_success \
>>   	'listing tags using a name as pattern must print that one matching' '
>> -	git tag -l a1 > actual &&
>> +	git tag -l a1 >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>> @@ -321,7 +321,7 @@ v1.0
>>   EOF
>>   test_expect_success \
>>   	'listing tags using a name as pattern must print that one matching' '
>> -	git tag -l v1.0 > actual &&
>> +	git tag -l v1.0 >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>> @@ -331,13 +331,13 @@ v1.1.3
>>   EOF
>>   test_expect_success \
>>   	'listing tags with ? in the pattern should print those matching' '
>> -	git tag -l "v1.?.?" > actual &&
>> +	git tag -l "v1.?.?" >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>>   test_expect_success \
>>   	'listing tags using v.* should print nothing because none have v.' '
>> -	git tag -l "v.*" > actual &&
>> +	git tag -l "v.*" >actual &&
>>   	test_must_be_empty actual
>>   '
>>   
>> @@ -349,7 +349,7 @@ v1.1.3
>>   EOF
>>   test_expect_success \
>>   	'listing tags using v* should print only those having v' '
>> -	git tag -l "v*" > actual &&
>> +	git tag -l "v*" >actual &&
>>   	test_cmp expect actual
>>   '
>>   
>> @@ -1171,7 +1171,7 @@ test_expect_success GPG \
>>   	git tag -v emptyfile-signed-tag
>>   '
>>   
>> -printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
>> +printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
>>   printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
>>   printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
>>   printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
>> @@ -1569,7 +1569,7 @@ test_expect_success \
>>   
>>   test_expect_success \
>>   	'message in editor has initial comment' '
>> -	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
>> +	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
>>   '
>>   
>>   test_expect_success 'message in editor has initial comment: first line' '
>> @@ -1587,7 +1587,7 @@ test_expect_success \
>>   '
>>   
>>   get_tag_header reuse $commit commit $time >expect
>> -echo "An annotation to be reused" >> expect
>> +echo "An annotation to be reused" >>expect
>>   test_expect_success \
>>   	'overwriting an annotated tag should use its previous body' '
>>   	git tag -a -m "An annotation to be reused" reuse &&
>> @@ -1639,7 +1639,7 @@ hash3=$(git rev-parse HEAD)
>>   
>>   # simple linear checks of --continue
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v0.2.1
>>   v1.0
>>   v1.0.1
>> @@ -1679,7 +1679,7 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
>>   	test_must_be_empty actual
>>   "
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v2.0
>>   EOF
>>   
>> @@ -1688,7 +1688,7 @@ test_expect_success 'checking that second commit only has one tag' "
>>   	test_cmp expected actual
>>   "
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v0.2.1
>>   v1.0
>>   v1.0.1
>> @@ -1705,7 +1705,7 @@ test_expect_success 'checking that third commit has no tags' "
>>   	test_must_be_empty actual
>>   "
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v0.2.1
>>   v1.0
>>   v1.0.1
>> @@ -1723,14 +1723,14 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
>>   test_expect_success 'creating simple branch' '
>>   	git branch stable v2.0 &&
>>           git checkout stable &&
>> -	echo foo-3.0 > foo &&
>> +	echo foo-3.0 >foo &&
>>   	git commit foo -m fourth &&
>>   	git tag v3.0
>>   '
>>   
>>   hash4=$(git rev-parse HEAD)
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v3.0
>>   EOF
>>   
>> @@ -1739,7 +1739,7 @@ test_expect_success 'checking that branch head only has one tag' "
>>   	test_cmp expected actual
>>   "
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v0.2.1
>>   v1.0
>>   v1.0.1
>> @@ -1757,7 +1757,7 @@ test_expect_success 'merging original branch into this branch' '
>>           git tag v4.0
>>   '
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v4.0
>>   EOF
>>   
>> @@ -1766,7 +1766,7 @@ test_expect_success 'checking that original branch head has one tag now' "
>>   	test_cmp expected actual
>>   "
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v0.2.1
>>   v1.0
>>   v1.0.1
>> @@ -1780,7 +1780,7 @@ test_expect_success 'checking that original branch head with --no-contains lists
>>   	test_cmp expected actual
>>   "
>>   
>> -cat > expected <<EOF
>> +cat >expected <<EOF
>>   v0.2.1
>>   v1.0
>>   v1.0.1

