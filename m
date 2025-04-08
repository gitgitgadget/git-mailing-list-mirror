Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB231265CAF
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114426; cv=none; b=cBOFj6Nn/F4OYKiIqcAtnujwgk0cbneNO4hSjcpreqrYnGMEZQe2sOIXpimlwQwot66iN9KKMPbFPzl4+O5opCDSZzrEmslNwtCFf/oCnIYm8Cq0VHaO61ZhFAhKj9/LWSnzAq7cMIejh+rGUYVSKni9bfzIlffklDzZ3HiZw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114426; c=relaxed/simple;
	bh=Aqo3fWe0ipGjjdoLPW085jprjFMRfPR3V/D6v7Fjxgw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CuuJK9ZKoVDaIX39bxTs80jenotWkk2CVTAcZRkX/fDRaJ9hKs6AGRBcAEMbJkkL/wh5w1PzOUlcR5/Lt+A44RNd/dXI6HmkgFyZQd6uj3wAQtU3pDrv2xdrqAQsl95dJfJWVLpFIYjYE5bTEWQO+8X7/tnTpdng9pxYhxi/D4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyalsSo6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyalsSo6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c554d7dc2aso900894285a.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744114423; x=1744719223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sK0qz68j0SsMc4Nwm7a6bGRG584TdheWVfc1cN2XNg=;
        b=CyalsSo6wnE1igOiYiiJ8cfXExCy8HlOlCX99DQy3AapOo6FEctxaauhuXvfOASR2G
         JbT4qfbbkiZ5HzqjCDjNaJTPJGhBb/hk9YoIpaIElfLaeAK4PbkxKGKbhE8zRjAcL+cF
         Ppz5F2g9A0S0VLjSTl83YkbmxhJj45N0GnCOnFuVUHxYuHDCKBN/q3amw+stX38ugkMS
         oYrv4/nb4EN1O3VhC9ImdzSk6Xz4ddbSNu1dweKfisYeYIxOp5Yi9y9+Vz7arETPFBVR
         WmJCA+0wz8sj/MI8mg4dBmnY1qhvmzya+cSe/swIKip71d/vhx4I6DNCtVJwRU52/7q2
         gMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744114423; x=1744719223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sK0qz68j0SsMc4Nwm7a6bGRG584TdheWVfc1cN2XNg=;
        b=K6ibN/NNZLIQfHCip/UFJUMHVLhf8UwcTOrFZtyk7NQeJSuZG3jkfRaukan0+CEmQC
         qg5GK1OUBv6Nm9+XZPAGh9pixnY/xQfvp3hSvAzAkYguZu5hEqLIhFRhtwp3nZfbDVQt
         FTAB+yxKWO0q3BCSttVINkMGxJ+RvhQDa00xbRYfOrUnU0HrQZ49p8FcSUcLyjQfE5DI
         xuZlgxO9YfPM+hEk3eyCTIt9iH0lIIT50wPvgEwkG2/4MGnhaNxXLx2QnTyXfhaB4W2N
         7A9JqmWLqqjyyDe+tTE9eQs7KwqkzSMvTMSvXablaAzK7BO8cpVg+g8qhrim5XXCc6zX
         yGrA==
X-Forwarded-Encrypted: i=1; AJvYcCVok1vPnQL27pZAlqG80FvKQF+7Dlp5cywGL8xJaYy0hFAsDSsQzCAAlY5AcK05CAnPVs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0gOYDAv5UgAO9+5FDa+8IF3llZJ38CHtv/ImHOTGgQ44+3Hc
	bIINz50RSppQTKmt+aaM0UgtnRHdrjzCkeeXHDENZp7iIaxJbLAW
X-Gm-Gg: ASbGncvtqBuvUItvWFK3FUaK4zNMYV3LIIbCuGtx3SkWtrqEoWGtnTIE56zSt/CW6rx
	cueIsDrgGC/8YA3u9QqZJGFhv0kqYLgPI9JL1DyxM3hpYxiQjWR3sa5fLq9kWkiYxGtK8CsUWFl
	W+Fepvf0j1pMedDt7bxISuZgH9pGI+2rBkp5jr9/xZ8SgyaBuXlsMSAdsnCioRLkx2OSJPPeA6v
	BRl2LW/ejbj3PvOjqqjZ3073VToQhhbfyp+kiVxulBP5Fa8iXqQqF7MBVnxUN2fF6YcrPWEutYu
	HdzBjLysZPddBOxYkw2qBZNZHPvrjti06dJgvNlW4sbIwO+BnrTBisvj9Rh7Mb4TiiUB4+pyQNj
	Vk2QxAij7v+j07Y91XtCxhA==
X-Google-Smtp-Source: AGHT+IF2c3ZPo9cxpjrTugG5qCdF2zx9HKfESCc4ZhG089OS2NyfB/wvQyGotdsRR86Uzw+nlzoMHQ==
X-Received: by 2002:a05:620a:d81:b0:7c5:48bc:8c89 with SMTP id af79cd13be357-7c774d5f0e4mr2713491085a.27.1744114422217;
        Tue, 08 Apr 2025 05:13:42 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e75ec7bsm750367485a.43.2025.04.08.05.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 05:13:41 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <e91c0859-da89-47a2-b0c7-ce1943318529@gmail.com>
Date: Tue, 8 Apr 2025 08:13:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: [PATCH] git p4 fix for failure to decode p4 errors
To: Fahad Al-Rashed <fahad@keylock.net>, git@vger.kernel.org
Cc: bekenn@gmai.com, ps@pks.im, phillip.wood@dunelm.org.uk
References: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
 <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
 <fdbb3f88-7321-4dc0-9ead-7ed9ef0fc995@gmail.com>
 <339b8557-d41a-4a40-912b-eb2cff63159f@gmail.com>
 <7e5d0613-d116-4e60-8ccf-efb092776398@gmail.com>
 <652def28-2e97-4177-9197-bd93caa57886@gmail.com>
 <A1896FA9-F09C-4099-8A7E-4AFFD2DBCF7F@keylock.net>
 <1948dfea-88c9-4e4e-937a-e162ad42d8aa@gmail.com>
 <501e308d-61b3-429a-bc4a-6f0c81455279@gmail.com>
Content-Language: en-US
In-Reply-To: <501e308d-61b3-429a-bc4a-6f0c81455279@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fahad,
I hope you are doing well.
If there are troubles with trying this on your Perforce system, maybe we 
could think of other way verifying the patch?

Thank you,
- Nikolay

On 4/5/25 14:46, Nikolay Shustov wrote:
> Hello Fahad,
> Did you have a chance to try it with your Perforce system yet?
>
> Thanks,
> - Nikolay
>
> On 3/31/25 19:37, Nikolay Shustov wrote:
>> Hi Fahad,
>> Thank you for taking a look.
>> Yes, you can run this test locally, that should be enough.
>> The test is conditionalized on a) having p4 server installation with 
>> no Unicode support and b) running with Python 3 only.
>> If either of these do not match, it will skip the execution.
>>
>> I tested it on my computer with the freshly installed p4 helix server 
>> and client; but it was on Kubuntu only, did not try it on Windows.
>> Perforce company allows limited use of the server and client for 
>> non-commercial purposes, so it was all legit.
>>
>> Please let me know how it runs for you.
>>
>> Cheers,
>> - Nikolay
>>
>> On 3/31/25 05:01, Fahad Al-Rashed wrote:
>>> Hi Nikolay,
>>>
>>> The patch looks reasonable.
>>>
>>> What I can help with is test it on our Perforce installation when I 
>>> go back to work next week.
>>>
>>> For the purpose of testing, is running 
>>> t/t9837-git-p4-error-encoding.sh locally on my computer enough to 
>>> test your patch?
>>>
>>> Best,
>>> Fahad
>>>
>>>> On 31 Mar 2025, at 4:21 AM, Nikolay Shustov 
>>>> <nikolay.shustov@gmail.com> wrote:
>>>>
>>>> <adding Fahad Alrashed, James Touton and Patrick Steinhardt, whom 
>>>> Git points to as the contributors to the latest p4-git logic changes>
>>>>
>>>> Hello,
>>>> May I ask you to review the below change to p4-git?
>>>>
>>>> Thank you in advance,
>>>> - Nikolay
>>>>
>>>> On 3/30/25 16:06, Nikolay Shustov wrote:
>>>>> Hi Phillip,
>>>>> Thank you for your time and your feedback.
>>>>> It is especially valuable to me as it is the very first PR of mine.
>>>>> I will try to contact the recent contributors of git-p4 changes 
>>>>> for review.
>>>>>
>>>>> To clarify on the fix:
>>>>>
>>>>> The error I hit was while using "git p4 clone":
>>>>> It was throwing decoding exception at line 901 of git-p4, 
>>>>> preventing import from Perforce depot to complete successfully.
>>>>> The root cause is the logic for "git p4 clone" anticipates some p4 
>>>>> operations may return errors, it is a normal part of import process.
>>>>> But that logic uses just .decode() on the byte array of the 
>>>>> returned error message, which does not work well when it contains 
>>>>> the characters with high bit set (which may be the case when 
>>>>> Perforce configured without unicode support). git-p4 
>>>>> implementation has a decoding fallback logic for such cases in 
>>>>> other places, but this specific place did not use any.
>>>>>
>>>>> Using the bullet list in description was not intended to enumerate 
>>>>> the separate changes, but rather to highlight the details of the 
>>>>> change.
>>>>> I will make sure I won't use it in the future to avoid the confusion.
>>>>>
>>>>> That small refactoring I did was not a sidecar but a way I chose 
>>>>> to implement the changes:
>>>>> There was an existing function that was doing the job of decoding 
>>>>> the received p4 metadata, using the existing git-p4 configuration 
>>>>> settings.
>>>>> There also were a few existing variables that kept the state 
>>>>> between the calls of that function (e.g. indicator not to show 
>>>>> decoding fallback warning twice, configuration settings).
>>>>> However, with the way the function was implemented, it could not 
>>>>> be reused as-is for the new case.
>>>>> I would had to add a new function that would have to use the same 
>>>>> core transcoding implementation but behave differently.
>>>>> Adding behavior variances into the existing function felt 
>>>>> suboptimal: it would complicate it quite a bit and I felt sorry 
>>>>> about next one who will have to reverse engineer its behavior 
>>>>> again. Duplicating the part of logic of the existing function also 
>>>>> looked suboptimal: any further changes would have to be done in 
>>>>> two places.
>>>>> So, seeing the need in keeping state between calls and separating 
>>>>> a part of existing logic into separate functions, I went for 
>>>>> moving the implementation into a new class and organizing things 
>>>>> there with the class instance. In my opinion, the new code looks 
>>>>> pretty self-descritpitve.
>>>>>
>>>>> Thank you,
>>>>> - Nikolay
>>>>>
>>>>> On 3/26/25 11:09, Phillip Wood wrote:
>>>>>> Hi Nikolay
>>>>>>
>>>>>> On 25/03/2025 23:09, Nikolay Shustov wrote:
>>>>>>> I think this fix is important.
>>>>>>> git-p4 is used in the companies where there is an intent to 
>>>>>>> migrate from Perforce to Git and having the issue that this 
>>>>>>> change fixes is a real roadblock.
>>>>>>> The better we can make git-p4, the more adoption Git would get 
>>>>>>> in the commercial world.
>>>>>> Unfortunately I don't think any of the regular git contributors 
>>>>>> use git-p4 so to find someone to review this patch I would look 
>>>>>> at who has contributed to git-p4 recently and cc them. Before you 
>>>>>> do that I have a couple of suggestions below
>>>>>>
>>>>>>> On 3/22/25 07:48, Nikolay Shustov wrote:
>>>>>>>> ping, pretty please? :-)
>>>>>>>>
>>>>>>>> On 3/19/25 23:20, Nikolay Shustov via GitGitGadget wrote:
>>>>>>>>> From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>>>>>>>>
>>>>>>>>> Fixes the git p4 failure happening when Perforce command 
>>>>>>>>> returns error
>>>>>>>>> containing byte stream of characters with high bit set. In 
>>>>>>>>> such situations
>>>>>>>>> git p4 implementatino fails to decode this byte stream into 
>>>>>>>>> utf-8 string.
>>>>>>>>>
>>>>>>>>> Design:
>>>>>>>>> Make use of existing decoding fallback strategy, described by
>>>>>>>>> git-p4.metadataDecodingStrategy and 
>>>>>>>>> git-p4.metadataFallbackEncoding
>>>>>>>>> settings in the logic that decodes the Perforce command error 
>>>>>>>>> bytes.
>>>>>> Our usual style for commit messages is to explain what the 
>>>>>> problem is and how it is fixed by the changes in the patch. 
>>>>>> Rather than saying "fixes the git p4 failure" I would start by 
>>>>>> explaining what that failure is and how it is caused. It would 
>>>>>> also be helpful to explain what the settings that you refer to do 
>>>>>> so that someone who is familiar with python but not with git-p4 
>>>>>> can understand and potentially review the changes.
>>>>>>
>>>>>>>>> Details:
>>>>>>>>> - Moved p4 metadata transcoding logic from
>>>>>>>>>     metadata_stream_to_writable_bytes(..) into a new 
>>>>>>>>> MetadataTranscoder class.
>>>>>>>>> - Enhcanced the implementation to use 
>>>>>>>>> git-p4.metadataDecodingStrategy and
>>>>>>>>>     git-p4.metadataFallbackEncoding settings for p4 errors 
>>>>>>>>> decoding.
>>>>>>>>> - Added test.
>>>>>> Thanks for taking the time to add a new test, it is much 
>>>>>> appreciated. When there is a bullet list in a commit message it 
>>>>>> is often a sign that the commit is doing more than one thing at 
>>>>>> once. In this case it appears there is a bug fix mixed in with 
>>>>>> some refactoring. I would split the refactoring out into a 
>>>>>> preparatory patch so that reviews can clearly see which changes 
>>>>>> are due to creating the MetadataTranscoder class and which are 
>>>>>> the changes that fix the bug. The new test should be added in the 
>>>>>> commit that fixes the bug.
>>>>>>
>>>>>> Best Wishes
>>>>>>
>>>>>> Phillip
>>>>>>
>>>>>>>>> Signed-off-by: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>>>>>>>> ---
>>>>>>>>>       git p4 fix for failure to decode p4 errors
>>>>>>>>>
>>>>>>>>> Published-As: 
>>>>>>>>> https://github.com/gitgitgadget/git/releases/tag/pr- 
>>>>>>>>> git-1926%2Fnshustov%2Fgit-p4-error-decoding-v1
>>>>>>>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>>>>>>>>> pr- git-1926/nshustov/git-p4-error-decoding-v1
>>>>>>>>> Pull-Request: https://github.com/git/git/pull/1926
>>>>>>>>>
>>>>>>>>>    git-p4.py                        | 135 
>>>>>>>>> ++++++++++++++++++-------------
>>>>>>>>>    t/meson.build                    |   1 +
>>>>>>>>>    t/t9837-git-p4-error-encoding.sh |  53 ++++++++++++
>>>>>>>>>    t/t9837/git-p4-error-python3.py  |  15 ++++
>>>>>>>>>    4 files changed, 149 insertions(+), 55 deletions(-)
>>>>>>>>>    create mode 100755 t/t9837-git-p4-error-encoding.sh
>>>>>>>>>    create mode 100644 t/t9837/git-p4-error-python3.py
>>>>>>>>>
>>>>>>>>> diff --git a/git-p4.py b/git-p4.py
>>>>>>>>> index c0ca7becaf4..72a4c55f99e 100755
>>>>>>>>> --- a/git-p4.py
>>>>>>>>> +++ b/git-p4.py
>>>>>>>>> @@ -234,67 +234,91 @@ else:
>>>>>>>>>        class MetadataDecodingException(Exception):
>>>>>>>>> -    def __init__(self, input_string):
>>>>>>>>> +    def __init__(self, input_string, error=None):
>>>>>>>>>            self.input_string = input_string
>>>>>>>>> +        self.error = error
>>>>>>>>>          def __str__(self):
>>>>>>>>> -        return """Decoding perforce metadata failed!
>>>>>>>>> +        message = """Decoding perforce metadata failed!
>>>>>>>>>    The failing string was:
>>>>>>>>>    ---
>>>>>>>>>    {}
>>>>>>>>>    ---
>>>>>>>>>    Consider setting the git-p4.metadataDecodingStrategy config 
>>>>>>>>> option to
>>>>>>>>>    'fallback', to allow metadata to be decoded using a 
>>>>>>>>> fallback encoding,
>>>>>>>>> -defaulting to cp1252.""".format(self.input_string)
>>>>>>>>> +defaulting to cp1252."""
>>>>>>>>> +        if verbose and self.error is not None:
>>>>>>>>> +            message += """
>>>>>>>>> +---
>>>>>>>>> +Error:
>>>>>>>>> +---
>>>>>>>>> +{}"""
>>>>>>>>> +        return message.format(self.input_string, self.error)
>>>>>>>>>      -encoding_fallback_warning_issued = False
>>>>>>>>> -encoding_escape_warning_issued = False
>>>>>>>>> -def metadata_stream_to_writable_bytes(s):
>>>>>>>>> -    encodingStrategy = 
>>>>>>>>> gitConfig('git-p4.metadataDecodingStrategy') or 
>>>>>>>>> defaultMetadataDecodingStrategy
>>>>>>>>> -    fallbackEncoding = 
>>>>>>>>> gitConfig('git-p4.metadataFallbackEncoding') or 
>>>>>>>>> defaultFallbackMetadataEncoding
>>>>>>>>> -    if not isinstance(s, bytes):
>>>>>>>>> -        return s.encode('utf_8')
>>>>>>>>> -    if encodingStrategy == 'passthrough':
>>>>>>>>> -        return s
>>>>>>>>> -    try:
>>>>>>>>> -        s.decode('utf_8')
>>>>>>>>> -        return s
>>>>>>>>> -    except UnicodeDecodeError:
>>>>>>>>> -        if encodingStrategy == 'fallback' and fallbackEncoding:
>>>>>>>>> -            global encoding_fallback_warning_issued
>>>>>>>>> -            global encoding_escape_warning_issued
>>>>>>>>> -            try:
>>>>>>>>> -                if not encoding_fallback_warning_issued:
>>>>>>>>> -                    print("\nCould not decode value as utf-8; 
>>>>>>>>> using configured fallback encoding %s: %s" % 
>>>>>>>>> (fallbackEncoding, s))
>>>>>>>>> -                    print("\n(this warning is only displayed 
>>>>>>>>> once during an import)")
>>>>>>>>> - encoding_fallback_warning_issued = True
>>>>>>>>> -                return 
>>>>>>>>> s.decode(fallbackEncoding).encode('utf_8')
>>>>>>>>> -            except Exception as exc:
>>>>>>>>> -                if not encoding_escape_warning_issued:
>>>>>>>>> -                    print("\nCould not decode value with 
>>>>>>>>> configured fallback encoding %s; escaping bytes over 127: %s" 
>>>>>>>>> % (fallbackEncoding, s))
>>>>>>>>> -                    print("\n(this warning is only displayed 
>>>>>>>>> once during an import)")
>>>>>>>>> - encoding_escape_warning_issued = True
>>>>>>>>> -                escaped_bytes = b''
>>>>>>>>> -                # bytes and strings work very differently in 
>>>>>>>>> python2 vs python3...
>>>>>>>>> -                if str is bytes:
>>>>>>>>> -                    for byte in s:
>>>>>>>>> -                        byte_number = struct.unpack('>B', 
>>>>>>>>> byte)[0]
>>>>>>>>> -                        if byte_number > 127:
>>>>>>>>> -                            escaped_bytes += b'%'
>>>>>>>>> -                            escaped_bytes += hex(byte_number) 
>>>>>>>>> [2:].upper()
>>>>>>>>> -                        else:
>>>>>>>>> -                            escaped_bytes += byte
>>>>>>>>> -                else:
>>>>>>>>> -                    for byte_number in s:
>>>>>>>>> -                        if byte_number > 127:
>>>>>>>>> -                            escaped_bytes += b'%'
>>>>>>>>> -                            escaped_bytes += 
>>>>>>>>> hex(byte_number).upper().encode()[2:]
>>>>>>>>> -                        else:
>>>>>>>>> -                            escaped_bytes += 
>>>>>>>>> bytes([byte_number])
>>>>>>>>> -                return escaped_bytes
>>>>>>>>> +class MetadataTranscoder:
>>>>>>>>> +    def __init__(self, default_metadata_decoding_strategy, 
>>>>>>>>> default_fallback_metadata_encoding):
>>>>>>>>> +        self.decoding_fallback_warning_issued = False
>>>>>>>>> +        self.decoding_escape_warning_issued = False
>>>>>>>>> +        self.decodingStrategy = gitConfig('git- 
>>>>>>>>> p4.metadataDecodingStrategy') or 
>>>>>>>>> default_metadata_decoding_strategy
>>>>>>>>> +        self.fallbackEncoding = gitConfig('git- 
>>>>>>>>> p4.metadataFallbackEncoding') or 
>>>>>>>>> default_fallback_metadata_encoding
>>>>>>>>> +
>>>>>>>>> +    def decode_metadata(self, s, error_from_fallback=True):
>>>>>>>>> +        try:
>>>>>>>>> +            return [s.decode('utf_8'), 'utf_8']
>>>>>>>>> +        except UnicodeDecodeError as decode_exception:
>>>>>>>>> +            error = decode_exception
>>>>>>>>> +            if self.decodingStrategy == 'fallback' and 
>>>>>>>>> self.fallbackEncoding:
>>>>>>>>> +                try:
>>>>>>>>> +                    if not 
>>>>>>>>> self.decoding_fallback_warning_issued:
>>>>>>>>> +                        print("\nCould not decode value as 
>>>>>>>>> utf-8; using configured fallback encoding %s: %s" % 
>>>>>>>>> (self.fallbackEncoding, s))
>>>>>>>>> +                        print("\n(this warning is only 
>>>>>>>>> displayed once during an import)")
>>>>>>>>> + self.decoding_fallback_warning_issued = True
>>>>>>>>> +                    return [s.decode(self.fallbackEncoding), 
>>>>>>>>> self.fallbackEncoding]
>>>>>>>>> +                except Exception as decode_exception:
>>>>>>>>> +                    if not error_from_fallback:
>>>>>>>>> +                        return [s, None]
>>>>>>>>> +                    error = decode_exception
>>>>>>>>> +            raise MetadataDecodingException(s, error)
>>>>>>>>> +
>>>>>>>>> +    def metadata_stream_to_writable_bytes(self, s):
>>>>>>>>> +        if not isinstance(s, bytes):
>>>>>>>>> +            return s.encode('utf_8')
>>>>>>>>> +        if self.decodingStrategy == 'passthrough':
>>>>>>>>> +            return s
>>>>>>>>> +
>>>>>>>>> +        [text, encoding] = self.decode_metadata(s, False)
>>>>>>>>> +        if encoding == 'utf_8':
>>>>>>>>> +            # s is of utf-8 already
>>>>>>>>> +            return s
>>>>>>>>> +
>>>>>>>>> +        if encoding is None:
>>>>>>>>> +            # could not decode s, even with fallback encoding
>>>>>>>>> +            if not self.decoding_escape_warning_issued:
>>>>>>>>> +                print("\nCould not decode value with 
>>>>>>>>> configured fallback encoding %s; escaping bytes over 127: %s" 
>>>>>>>>> % (self.fallbackEncoding, s))
>>>>>>>>> +                print("\n(this warning is only displayed once 
>>>>>>>>> during an import)")
>>>>>>>>> + self.decoding_escape_warning_issued = True
>>>>>>>>> +            escaped_bytes = b''
>>>>>>>>> +            # bytes and strings work very differently in 
>>>>>>>>> python2 vs python3...
>>>>>>>>> +            if str is bytes:
>>>>>>>>> +                for byte in s:
>>>>>>>>> +                    byte_number = struct.unpack('>B', byte)[0]
>>>>>>>>> +                    if byte_number > 127:
>>>>>>>>> +                        escaped_bytes += b'%'
>>>>>>>>> +                        escaped_bytes += 
>>>>>>>>> hex(byte_number)[2:].upper()
>>>>>>>>> +                    else:
>>>>>>>>> +                        escaped_bytes += byte
>>>>>>>>> +            else:
>>>>>>>>> +                for byte_number in s:
>>>>>>>>> +                    if byte_number > 127:
>>>>>>>>> +                        escaped_bytes += b'%'
>>>>>>>>> +                        escaped_bytes += 
>>>>>>>>> hex(byte_number).upper().encode()[2:]
>>>>>>>>> +                    else:
>>>>>>>>> +                        escaped_bytes += bytes([byte_number])
>>>>>>>>> +            return escaped_bytes
>>>>>>>>>    -        raise MetadataDecodingException(s)
>>>>>>>>> +        # were able to decode but not to utf-8
>>>>>>>>> +        return text.encode('utf_8')
>>>>>>>>>        def decode_path(path):
>>>>>>>>> @@ -898,14 +922,14 @@ def p4CmdList(cmd, stdin=None, 
>>>>>>>>> stdin_mode='w+b', cb=None, skip_info=False,
>>>>>>>>>                        decoded_entry[key] = value
>>>>>>>>>                    # Parse out data if it's an error response
>>>>>>>>>                    if decoded_entry.get('code') == 'error' and 
>>>>>>>>> 'data' in decoded_entry:
>>>>>>>>> -                    decoded_entry['data'] = 
>>>>>>>>> decoded_entry['data'].decode()
>>>>>>>>> +                    decoded_entry['data'] = 
>>>>>>>>> metadataTranscoder.decode_metadata(decoded_entry['data'])
>>>>>>>>>                    entry = decoded_entry
>>>>>>>>>                if skip_info:
>>>>>>>>>                    if 'code' in entry and entry['code'] == 
>>>>>>>>> 'info':
>>>>>>>>>                        continue
>>>>>>>>>                for key in p4KeysContainingNonUtf8Chars():
>>>>>>>>>                    if key in entry:
>>>>>>>>> -                    entry[key] = 
>>>>>>>>> metadata_stream_to_writable_bytes(entry[key])
>>>>>>>>> +                    entry[key] = 
>>>>>>>>> metadataTranscoder.metadata_stream_to_writable_bytes(entry[key])
>>>>>>>>>                if cb is not None:
>>>>>>>>>                    cb(entry)
>>>>>>>>>                else:
>>>>>>>>> @@ -1718,7 +1742,7 @@ class P4UserMap:
>>>>>>>>>                # python2 or python3. To support
>>>>>>>>>                # git-p4.metadataDecodingStrategy=fallback, 
>>>>>>>>> self.users dict values
>>>>>>>>>                # are always bytes, ready to be written to git.
>>>>>>>>> -            emailbytes = 
>>>>>>>>> metadata_stream_to_writable_bytes(output["Email"])
>>>>>>>>> +            emailbytes = 
>>>>>>>>> metadataTranscoder.metadata_stream_to_writable_bytes(output["Email"]) 
>>>>>>>>>
>>>>>>>>>                self.users[output["User"]] = output["FullName"] 
>>>>>>>>> + b" <" + emailbytes + b">"
>>>>>>>>>                self.emails[output["Email"]] = output["User"]
>>>>>>>>>    @@ -1730,12 +1754,12 @@ class P4UserMap:
>>>>>>>>>                    fullname = mapUser[0][1]
>>>>>>>>>                    email = mapUser[0][2]
>>>>>>>>>                    fulluser = fullname + " <" + email + ">"
>>>>>>>>> -                self.users[user] = 
>>>>>>>>> metadata_stream_to_writable_bytes(fulluser)
>>>>>>>>> +                self.users[user] = 
>>>>>>>>> metadataTranscoder.metadata_stream_to_writable_bytes(fulluser)
>>>>>>>>>                    self.emails[email] = user
>>>>>>>>>              s = b''
>>>>>>>>>            for (key, val) in self.users.items():
>>>>>>>>> -            keybytes = metadata_stream_to_writable_bytes(key)
>>>>>>>>> +            keybytes = 
>>>>>>>>> metadataTranscoder.metadata_stream_to_writable_bytes(key)
>>>>>>>>>                s += b"%s\t%s\n" % (keybytes.expandtabs(1), 
>>>>>>>>> val.expandtabs(1))
>>>>>>>>>              open(self.getUserCacheFilename(), 'wb').write(s)
>>>>>>>>> @@ -3349,7 +3373,7 @@ class P4Sync(Command, P4UserMap):
>>>>>>>>>            if userid in self.users:
>>>>>>>>>                return self.users[userid]
>>>>>>>>>            else:
>>>>>>>>> -            userid_bytes = 
>>>>>>>>> metadata_stream_to_writable_bytes(userid)
>>>>>>>>> +            userid_bytes = 
>>>>>>>>> metadataTranscoder.metadata_stream_to_writable_bytes(userid)
>>>>>>>>>                return b"%s <a@b>" % userid_bytes
>>>>>>>>>          def streamTag(self, gitStream, labelName, 
>>>>>>>>> labelDetails, commit, epoch):
>>>>>>>>> @@ -4561,6 +4585,7 @@ commands = {
>>>>>>>>>        "unshelve": P4Unshelve,
>>>>>>>>>    }
>>>>>>>>>    +metadataTranscoder = 
>>>>>>>>> MetadataTranscoder(defaultMetadataDecodingStrategy, 
>>>>>>>>> defaultFallbackMetadataEncoding)
>>>>>>>>>      def main():
>>>>>>>>>        if len(sys.argv[1:]) == 0:
>>>>>>>>> diff --git a/t/meson.build b/t/meson.build
>>>>>>>>> index a59da26be3f..656424fdff3 100644
>>>>>>>>> --- a/t/meson.build
>>>>>>>>> +++ b/t/meson.build
>>>>>>>>> @@ -1090,6 +1090,7 @@ integration_tests = [
>>>>>>>>>      't9834-git-p4-file-dir-bug.sh',
>>>>>>>>>      't9835-git-p4-metadata-encoding-python2.sh',
>>>>>>>>>      't9836-git-p4-metadata-encoding-python3.sh',
>>>>>>>>> +  't9837-git-p4-error-encoding.sh',
>>>>>>>>>      't9850-shell.sh',
>>>>>>>>>      't9901-git-web--browse.sh',
>>>>>>>>>      't9902-completion.sh',
>>>>>>>>> diff --git a/t/t9837-git-p4-error-encoding.sh 
>>>>>>>>> b/t/t9837-git-p4-error- encoding.sh
>>>>>>>>> new file mode 100755
>>>>>>>>> index 00000000000..1ea774afb1b
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/t/t9837-git-p4-error-encoding.sh
>>>>>>>>> @@ -0,0 +1,53 @@
>>>>>>>>> +#!/bin/sh
>>>>>>>>> +
>>>>>>>>> +test_description='git p4 error encoding
>>>>>>>>> +
>>>>>>>>> +This test checks that the import process handles inconsistent 
>>>>>>>>> text
>>>>>>>>> +encoding in p4 error messages without failing'
>>>>>>>>> +
>>>>>>>>> +. ./lib-git-p4.sh
>>>>>>>>> +
>>>>>>>>> +###############################
>>>>>>>>> +## SECTION REPEATED IN t9835 ##
>>>>>>>>> +###############################
>>>>>>>>> +
>>>>>>>>> +# These tests require Perforce with non-unicode setup.
>>>>>>>>> +out=$(2>&1 P4CHARSET=utf8 p4 client -o)
>>>>>>>>> +if test $? -eq 0
>>>>>>>>> +then
>>>>>>>>> +    skip_all="skipping git p4 error encoding tests; Perforce 
>>>>>>>>> is setup with unicode"
>>>>>>>>> +    test_done
>>>>>>>>> +fi
>>>>>>>>> +
>>>>>>>>> +# These tests are specific to Python 3. Write a custom script 
>>>>>>>>> that executes
>>>>>>>>> +# git-p4 directly with the Python 3 interpreter to ensure 
>>>>>>>>> that we use that
>>>>>>>>> +# version even if Git was compiled with Python 2.
>>>>>>>>> +python_target_binary=$(which python3)
>>>>>>>>> +if test -n "$python_target_binary"
>>>>>>>>> +then
>>>>>>>>> +    mkdir temp_python
>>>>>>>>> +    PATH="$(pwd)/temp_python:$PATH"
>>>>>>>>> +    export PATH
>>>>>>>>> +
>>>>>>>>> +    write_script temp_python/git-p4-python3 <<-EOF
>>>>>>>>> +    exec "$python_target_binary" "$(git --exec-path)/git-p4" 
>>>>>>>>> "\$@"
>>>>>>>>> +    EOF
>>>>>>>>> +fi
>>>>>>>>> +
>>>>>>>>> +git p4-python3 >err
>>>>>>>>> +if ! grep 'valid commands' err
>>>>>>>>> +then
>>>>>>>>> +    skip_all="skipping python3 git p4 tests; python3 not 
>>>>>>>>> available"
>>>>>>>>> +    test_done
>>>>>>>>> +fi
>>>>>>>>> +
>>>>>>>>> +test_expect_success 'start p4d' '
>>>>>>>>> +    start_p4d
>>>>>>>>> +'
>>>>>>>>> +
>>>>>>>>> +test_expect_success 'see if Perforce error with characters 
>>>>>>>>> not convertable to utf-8 will be processed correctly' '
>>>>>>>>> +    test_when_finished cleanup_git &&
>>>>>>>>> +    $python_target_binary 
>>>>>>>>> "$TEST_DIRECTORY"/t9837/git-p4-error- python3.py 
>>>>>>>>> "$TEST_DIRECTORY"
>>>>>>>>> +'
>>>>>>>>> +
>>>>>>>>> +test_done
>>>>>>>>> diff --git a/t/t9837/git-p4-error-python3.py 
>>>>>>>>> b/t/t9837/git-p4-error- python3.py
>>>>>>>>> new file mode 100644
>>>>>>>>> index 00000000000..fb65aee386e
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/t/t9837/git-p4-error-python3.py
>>>>>>>>> @@ -0,0 +1,15 @@
>>>>>>>>> +import os
>>>>>>>>> +import sys
>>>>>>>>> +from  importlib.machinery import SourceFileLoader
>>>>>>>>> +
>>>>>>>>> +def main():
>>>>>>>>> +    if len(sys.argv[1:]) != 1:
>>>>>>>>> +        print("Expected test directory name")
>>>>>>>>> +
>>>>>>>>> +    gitp4_path = sys.argv[1] + "/../git-p4.py"
>>>>>>>>> +    gitp4 = SourceFileLoader("gitp4", gitp4_path).load_module()
>>>>>>>>> +    gitp4.p4CmdList(["edit", b'\xFEfile'])
>>>>>>>>> +
>>>>>>>>> +if __name__ == '__main__':
>>>>>>>>> +    main()
>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
