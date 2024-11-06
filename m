Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197821DE3C2
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890752; cv=none; b=DSPItH7ODIDtWtaBObJf8H1oEjwGawfImk7ztlWFCHMa0cWim+6iN2Kr9j91UyOHARTHb8uVdLUGfmOq8rcqyu2vshcw1E2fvXRAiljbkA//sdHcnK/V9n+lGC3H4GWeDCkWmEDBEEMKbtIAo5ZMzSGCFrLCYZE2oWE9wzeE0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890752; c=relaxed/simple;
	bh=aT+e3uZajVIB49B48+2lPFjjI2jWEM0bCMdF8V95oyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbDW41rgfIScsQe/hVdBK3oWlQAYtEZSau0CmoM8td7ds5QiACK5bqyaAQuwkLCA2+8hxkR8yZhOxFepRTvmN4OAXTyOll2Zatf8nukzzfHjdjmF4gmOmaTnjnDF4ewwMyjgiSiZwIdHGIBuJkK36TTsYUTpmrTOUxSmIitTf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUmubLHs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUmubLHs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43169902057so51038805e9.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 02:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730890749; x=1731495549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PmBxG+8WWPETbUqbAKuRVzrTvrkM3fiWkK3M927vygo=;
        b=FUmubLHsjJkmfnDpyoREeWqBjR197bp3wquJBNCvNLKD8pA4fEYVf0fmhM25fqAR0W
         j1pneaD2ECUS7MAYhpUJ5Q9R0GvTaChkFp/M7ixh7Za9Ou2vZgUiwxo6vc5awQY2+lbk
         +GNPpqm+klM4IoEb7JDiDMC3Tj2FYK+7/LobP+6WVnJz8lE74mDHBrcKmlhmhPRnmDZ+
         4PMkbsYwKTt/VkVFlcEAuYIBcUOcuTdexmN9kVZfZU5FNLfOlwTe6ipEJVi1XOhc+Hvv
         E5RBPVqDRlcF5xbC7etnJXwTB4Q3LGm6Gbo8iX+9lDkX4b5v9i7NDBNkpnHkYLCMinWo
         67VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890749; x=1731495549;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmBxG+8WWPETbUqbAKuRVzrTvrkM3fiWkK3M927vygo=;
        b=cQ9sijVxz9qNRJ7dEdzX6uDQmptWaSfPPkNFpnIFuRNUCuem3t8dIr4aaWZZditF4F
         AqIvqTg8Y8WtkhKDbIiI1iotUBP9m1GL/0KYVHT/Ui0etbDFZnceL4jQAuWP4mbr4zbw
         +ODjaOl5jbg91ahtF/wmLUFhbqJ9ethupjBcZ9iBObQ46fY6bjSio7Oes/9F+U3mnZuR
         G0+Zr/Xq4bbDRWp6rooIA4D8XjNKIL/Vz1arGM4vzdJ4NtZfE9RPQv3AWDCZVMYEY98n
         /9ehEIF9A6hZsES8wHZn14m9ZYWzNy3elTc1Wcx0J+LvlPs82pg+BMTFcI8McKRQQkhV
         +vrg==
X-Gm-Message-State: AOJu0YxGC8xgVf9q59NKzSlRSmq1au3BTVJwkLDNhdhxj4zPjcjS9NOU
	jsUipN2EmhJPGvNRYbD+M8eTmF071JWnG+ObSZmZbCLdXWhQF2MdRY5vuA==
X-Google-Smtp-Source: AGHT+IGmnn4y/g29KupRz58HaBqqGJgHOG3PcLJhbZPso1QNmuwKD53XtLLjMT2xFMHLh2L325P6Yw==
X-Received: by 2002:a05:600c:4691:b0:431:2460:5574 with SMTP id 5b1f17b1804b1-431bb9d1425mr232990965e9.27.1730890749145;
        Wed, 06 Nov 2024 02:59:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6bf546sm18316885e9.21.2024.11.06.02.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 02:59:08 -0800 (PST)
Message-ID: <829fe630-e46a-4a3a-82dd-4e5feedd190c@gmail.com>
Date: Wed, 6 Nov 2024 10:59:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/5] cmake: set up proper dependencies for generated
 clar headers
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?=
 <asedeno@mit.edu>, Toon Claes <toon@iotcl.com>, Taylor Blau
 <me@ttaylorr.com>, Ed Reel <edreel@gmail.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Edgar Bonet <bonet@grenoble.cnrs.fr>,
 Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
 <bb005979e7eb335b0178094251b5c37682d7d47b.1729506329.git.ps@pks.im>
 <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 05/11/2024 19:55, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 21 Oct 2024, Patrick Steinhardt wrote:
> 
>> The auto-generated headers used by clar are written at configure time
>> and thus do not get regenerated automatically. Refactor the build
>> recipes such that we use custom commands instead, which also has the
>> benefit that we can reuse the same infrastructure as our Makefile.
> 
> For the record: I did not use a shell script to generate the header for a
> specific reason: Unix shell scripts are not native to Windows. Therefore
> they cannot in general be run on Windows, however that was precisely the
> idea for the CMake definition: to be run on a vanilla Windows with Visual
> Studio installed.
> 
> Sadly, even Git's CI definition sets things up in a way that Git for
> Windows' Bash can be used in the CMake definition, but in the intended use
> case (opening a checkout of git/git in Visual Studio without any further
> tools required) won't have a usable Bash.
> 
> Therefore I am unsure whether this patch is desirable.

CMakeLists.txt tries to find sh.exe from git-for-windows and errors out 
if it cannot be found. It then uses that shell to run a number of 
scripts. Perhaps we should do the same in this patch? It would certainly 
be a worthwhile improvement to regenerate this file at build time if the 
source has changed.

Best Wishes

Phillip

> Ciao,
> Johannes
> 
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>   contrib/buildsystems/CMakeLists.txt | 50 +++++++----------------------
>>   1 file changed, 12 insertions(+), 38 deletions(-)
>>
>> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
>> index 093852ad9d6..9f80ab92656 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -1002,46 +1002,20 @@ foreach(unit_test ${unit_test_PROGRAMS})
>>   endforeach()
>>
>>   parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
>> -
>> -set(clar_decls "")
>> -set(clar_cbs "")
>> -set(clar_cbs_count 0)
>> -set(clar_suites "static struct clar_suite _clar_suites[] = {\n")
>> -list(LENGTH clar_test_SUITES clar_suites_count)
>> -foreach(suite ${clar_test_SUITES})
>> -	file(STRINGS "${CMAKE_SOURCE_DIR}/t/unit-tests/${suite}.c" decls
>> -		REGEX "^void test_${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*\\(void\\)$")
>> -
>> -	list(LENGTH decls decls_count)
>> -	string(REGEX REPLACE "void (test_${suite}__([a-zA-Z_0-9]*))\\(void\\)" "    { \"\\2\", &\\1 },\n" cbs ${decls})
>> -	string(JOIN "" cbs ${cbs})
>> -	list(TRANSFORM decls PREPEND "extern ")
>> -	string(JOIN ";\n" decls ${decls})
>> -
>> -	string(APPEND clar_decls "${decls};\n")
>> -	string(APPEND clar_cbs
>> -		"static const struct clar_func _clar_cb_${suite}[] = {\n"
>> -		${cbs}
>> -		"};\n")
>> -	string(APPEND clar_suites
>> -		"    {\n"
>> -		"        \"${suite}\",\n"
>> -		"        { NULL, NULL },\n"
>> -		"        { NULL, NULL },\n"
>> -		"        _clar_cb_${suite}, ${decls_count}, 1\n"
>> -		"    },\n")
>> -	math(EXPR clar_cbs_count "${clar_cbs_count}+${decls_count}")
>> -endforeach()
>> -string(APPEND clar_suites
>> -	"};\n"
>> -	"static const size_t _clar_suite_count = ${clar_suites_count};\n"
>> -	"static const size_t _clar_callback_count = ${clar_cbs_count};\n")
>> -file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${clar_decls}")
>> -file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar_cbs}" "${clar_suites}")
>> -
>>   list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
>>   list(TRANSFORM clar_test_SUITES APPEND ".c")
>> -add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
>> +add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>> +	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
>> +	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
>> +add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>> +	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>> +	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
>> +
>> +add_library(unit-tests-lib ${clar_test_SUITES}
>> +	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
>> +	"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>> +	"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>> +)
>>   target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
>>   add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
>>   target_link_libraries(unit-tests unit-tests-lib common-main)
>> --
>> 2.47.0.72.gef8ce8f3d4.dirty
>>
>>
> 

