Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39291F3FF8
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001800; cv=none; b=f6Anm2QVuDSAWr78tXPlj+9l3oEGcvFChX+wndBJMX22o5eClgNnAWI/u3eTBfhDB6kyFpR475/eWIqqwPSEBQ51fSzjDQ1spjlZo5V3QYtEu7swBK29pcU/Tlq/D/JGiLg0TdpEa6ZCLwGLJElIPVoA5WxCnGC3WyamoVerXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001800; c=relaxed/simple;
	bh=3GfeaOjZUdTXrEc1Z1QknR/pfgtxXE0gbVa3J17tsTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LBWCu9X0somEl0cRtPzMXSHKB1UMqJ+PKzX7cpvJ+5pSZ7h6f2hX/kZgPZJukSpgwFlzLmeCcaS64njZktQUgjkkO4I2AC5x9YsZoPUw8UgJ5nx9T213HoTGPuhEq1V5sT7Pm5YTBKukIOnaQbbmZIDkgROVKGKpbokQF7U0e9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCbmIJpQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCbmIJpQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so7512855e9.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743001796; x=1743606596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YS0uYL2uqbzlHpZ5kQl7NYcVbN7WgdNNlmRshJJIsTU=;
        b=RCbmIJpQV7A7l8IOMH7rKLgasxuB6Jyw9iB09HSwKBSQeB8JLhWb19qGpv3qRghule
         bDajJZJsq+w5S7g5g0hwPEtDO1wUscNF9OCl00QdtQuUDhi2NMj40oGe68ZXNOnDAlcZ
         V/4y1w+g2lq8WU4CFLm+vCJqMA+68nuaotf43v9TcrlDDmwHp8TQ1Mz+EqK76oohK0+z
         RfdD6jPPWfwEtmVnCajxS/PRZr7wNH9WArsfzZqVAmiJM2CRGsSFxeEca5e+jWd/BUeU
         2wET/9yJj7E+QC2ML5bhMVUGIlgGT1EU+sXzgE0/CPpEIEKeHIoz5ZJZ3ea4bPs1naNH
         tQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001796; x=1743606596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS0uYL2uqbzlHpZ5kQl7NYcVbN7WgdNNlmRshJJIsTU=;
        b=oVnOOtiIcANd8Qw1cVd0Hc3BqqPNTsxzJ6eh6EjY+LOFl/k81cdMobCjezOJ/065nh
         1Ro/XUimbaRLh3HMsI+yMSx0kRBQBPfMxysfjHUpSA9SSLmDUjX3l2+x2yxPMfjPhMm3
         SYxnfsjY+cGqu+c15xsyj/6laSJ9ma4uQuObUbLAwprIiSVJGcAZXMV0d7EKTShDntO/
         1sxXFAUl2IogyJ2pW4On+MWeh1nGtLhmlRtiFNI3xx/kojuvrLNEHaMW1upc/h4+Hkqq
         V33gc1qshDjSkjWgbImzjK3TG29omtTZ4nkkSTGA1pGPp+/gED5EsUBX6GopTcKYtox8
         SReA==
X-Forwarded-Encrypted: i=1; AJvYcCVVh48vlvnScY0rhzZiTYq929uP7Z4bK75FKgR3Fb4uX9w+YMb7wsicljTyYul+wYRiIEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAQ6IRmADL/uat8UK6kus4/9VrXDCzpzrHPUP+MgQFlQXJIkc
	jYQq5Tegns2oIvlbL5wUzYVjR5PTc37HfxELsm7ANMM556pdsabDSMwH2w==
X-Gm-Gg: ASbGncuM85xDbr9u8zM4ul+9PzzISa99vvPla1nsWGKHchDQjdvWstAY07hH76zI6TU
	IqyAiDHyZLq5JJ/d9mDsM/SH/iBNYvzHLutHA8tWviyqDzgXxX4ypmSEbgTbOSXuZoCZEoWtb1R
	K9oOVsCNzUGZetxovvFoDbdnx0WSdSbMaurKNC4mUJebLDMgE+t6oFspbTDmyRV5kN4etZXdsLv
	AefjF1g0aM9ndX48Yusljd+PRVCVzdQZ/hTRCw3vmZrGvtBVtTNLQhr37wJdIXb3wU6jusDDQ0q
	mZKNgxeT6O2gc2HauRh1+oeBvHZq9fFJkjDDV4VltCvLQwuIo6VvM6iG9DGUXnecBFCpIn1vH9y
	D+vd+VChof0QAl1s6krc0
X-Google-Smtp-Source: AGHT+IFUELI6Nr/6FMHquWYXH3QBeiGBbEUnFcjwRhRAFlXCfjISJ0iY3Vrdw7qXz9AlGKDqwarHXw==
X-Received: by 2002:a05:600c:3c85:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-43d776eb9a7mr40155795e9.15.1743001795771;
        Wed, 26 Mar 2025 08:09:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82f8080dsm4633975e9.38.2025.03.26.08.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:09:54 -0700 (PDT)
Message-ID: <339b8557-d41a-4a40-912b-eb2cff63159f@gmail.com>
Date: Wed, 26 Mar 2025 15:09:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git p4 fix for failure to decode p4 errors
To: Nikolay.Shustov@gmail.com, git@vger.kernel.org
References: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
 <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
 <fdbb3f88-7321-4dc0-9ead-7ed9ef0fc995@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fdbb3f88-7321-4dc0-9ead-7ed9ef0fc995@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nikolay

On 25/03/2025 23:09, Nikolay Shustov wrote:
> I think this fix is important.
> git-p4 is used in the companies where there is an intent to migrate from 
> Perforce to Git and having the issue that this change fixes is a real 
> roadblock.
> The better we can make git-p4, the more adoption Git would get in the 
> commercial world.

Unfortunately I don't think any of the regular git contributors use 
git-p4 so to find someone to review this patch I would look at who has 
contributed to git-p4 recently and cc them. Before you do that I have a 
couple of suggestions below

> On 3/22/25 07:48, Nikolay Shustov wrote:
>> ping, pretty please? :-)
>>
>> On 3/19/25 23:20, Nikolay Shustov via GitGitGadget wrote:
>>> From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>>
>>> Fixes the git p4 failure happening when Perforce command returns error
>>> containing byte stream of characters with high bit set. In such 
>>> situations
>>> git p4 implementatino fails to decode this byte stream into utf-8 
>>> string.
>>>
>>> Design:
>>> Make use of existing decoding fallback strategy, described by
>>> git-p4.metadataDecodingStrategy and git-p4.metadataFallbackEncoding
>>> settings in the logic that decodes the Perforce command error bytes.

Our usual style for commit messages is to explain what the problem is 
and how it is fixed by the changes in the patch. Rather than saying 
"fixes the git p4 failure" I would start by explaining what that failure 
is and how it is caused. It would also be helpful to explain what the 
settings that you refer to do so that someone who is familiar with 
python but not with git-p4 can understand and potentially review the 
changes.

>>> Details:
>>> - Moved p4 metadata transcoding logic from
>>>    metadata_stream_to_writable_bytes(..) into a new 
>>> MetadataTranscoder class.
>>> - Enhcanced the implementation to use git-p4.metadataDecodingStrategy 
>>> and
>>>    git-p4.metadataFallbackEncoding settings for p4 errors decoding.
>>> - Added test.

Thanks for taking the time to add a new test, it is much appreciated. 
When there is a bullet list in a commit message it is often a sign that 
the commit is doing more than one thing at once. In this case it appears 
there is a bug fix mixed in with some refactoring. I would split the 
refactoring out into a preparatory patch so that reviews can clearly see 
which changes are due to creating the MetadataTranscoder class and which 
are the changes that fix the bug. The new test should be added in the 
commit that fixes the bug.

Best Wishes

Phillip

>>> Signed-off-by: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>> ---
>>>      git p4 fix for failure to decode p4 errors
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr- 
>>> git-1926%2Fnshustov%2Fgit-p4-error-decoding-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr- 
>>> git-1926/nshustov/git-p4-error-decoding-v1
>>> Pull-Request: https://github.com/git/git/pull/1926
>>>
>>>   git-p4.py                        | 135 ++++++++++++++++++-------------
>>>   t/meson.build                    |   1 +
>>>   t/t9837-git-p4-error-encoding.sh |  53 ++++++++++++
>>>   t/t9837/git-p4-error-python3.py  |  15 ++++
>>>   4 files changed, 149 insertions(+), 55 deletions(-)
>>>   create mode 100755 t/t9837-git-p4-error-encoding.sh
>>>   create mode 100644 t/t9837/git-p4-error-python3.py
>>>
>>> diff --git a/git-p4.py b/git-p4.py
>>> index c0ca7becaf4..72a4c55f99e 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -234,67 +234,91 @@ else:
>>>       class MetadataDecodingException(Exception):
>>> -    def __init__(self, input_string):
>>> +    def __init__(self, input_string, error=None):
>>>           self.input_string = input_string
>>> +        self.error = error
>>>         def __str__(self):
>>> -        return """Decoding perforce metadata failed!
>>> +        message = """Decoding perforce metadata failed!
>>>   The failing string was:
>>>   ---
>>>   {}
>>>   ---
>>>   Consider setting the git-p4.metadataDecodingStrategy config option to
>>>   'fallback', to allow metadata to be decoded using a fallback encoding,
>>> -defaulting to cp1252.""".format(self.input_string)
>>> +defaulting to cp1252."""
>>> +        if verbose and self.error is not None:
>>> +            message += """
>>> +---
>>> +Error:
>>> +---
>>> +{}"""
>>> +        return message.format(self.input_string, self.error)
>>>     -encoding_fallback_warning_issued = False
>>> -encoding_escape_warning_issued = False
>>> -def metadata_stream_to_writable_bytes(s):
>>> -    encodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') 
>>> or defaultMetadataDecodingStrategy
>>> -    fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') 
>>> or defaultFallbackMetadataEncoding
>>> -    if not isinstance(s, bytes):
>>> -        return s.encode('utf_8')
>>> -    if encodingStrategy == 'passthrough':
>>> -        return s
>>> -    try:
>>> -        s.decode('utf_8')
>>> -        return s
>>> -    except UnicodeDecodeError:
>>> -        if encodingStrategy == 'fallback' and fallbackEncoding:
>>> -            global encoding_fallback_warning_issued
>>> -            global encoding_escape_warning_issued
>>> -            try:
>>> -                if not encoding_fallback_warning_issued:
>>> -                    print("\nCould not decode value as utf-8; using 
>>> configured fallback encoding %s: %s" % (fallbackEncoding, s))
>>> -                    print("\n(this warning is only displayed once 
>>> during an import)")
>>> -                    encoding_fallback_warning_issued = True
>>> -                return s.decode(fallbackEncoding).encode('utf_8')
>>> -            except Exception as exc:
>>> -                if not encoding_escape_warning_issued:
>>> -                    print("\nCould not decode value with configured 
>>> fallback encoding %s; escaping bytes over 127: %s" % 
>>> (fallbackEncoding, s))
>>> -                    print("\n(this warning is only displayed once 
>>> during an import)")
>>> -                    encoding_escape_warning_issued = True
>>> -                escaped_bytes = b''
>>> -                # bytes and strings work very differently in python2 
>>> vs python3...
>>> -                if str is bytes:
>>> -                    for byte in s:
>>> -                        byte_number = struct.unpack('>B', byte)[0]
>>> -                        if byte_number > 127:
>>> -                            escaped_bytes += b'%'
>>> -                            escaped_bytes += hex(byte_number) 
>>> [2:].upper()
>>> -                        else:
>>> -                            escaped_bytes += byte
>>> -                else:
>>> -                    for byte_number in s:
>>> -                        if byte_number > 127:
>>> -                            escaped_bytes += b'%'
>>> -                            escaped_bytes += 
>>> hex(byte_number).upper().encode()[2:]
>>> -                        else:
>>> -                            escaped_bytes += bytes([byte_number])
>>> -                return escaped_bytes
>>> +class MetadataTranscoder:
>>> +    def __init__(self, default_metadata_decoding_strategy, 
>>> default_fallback_metadata_encoding):
>>> +        self.decoding_fallback_warning_issued = False
>>> +        self.decoding_escape_warning_issued = False
>>> +        self.decodingStrategy = gitConfig('git- 
>>> p4.metadataDecodingStrategy') or default_metadata_decoding_strategy
>>> +        self.fallbackEncoding = gitConfig('git- 
>>> p4.metadataFallbackEncoding') or default_fallback_metadata_encoding
>>> +
>>> +    def decode_metadata(self, s, error_from_fallback=True):
>>> +        try:
>>> +            return [s.decode('utf_8'), 'utf_8']
>>> +        except UnicodeDecodeError as decode_exception:
>>> +            error = decode_exception
>>> +            if self.decodingStrategy == 'fallback' and 
>>> self.fallbackEncoding:
>>> +                try:
>>> +                    if not self.decoding_fallback_warning_issued:
>>> +                        print("\nCould not decode value as utf-8; 
>>> using configured fallback encoding %s: %s" % (self.fallbackEncoding, s))
>>> +                        print("\n(this warning is only displayed 
>>> once during an import)")
>>> +                        self.decoding_fallback_warning_issued = True
>>> +                    return [s.decode(self.fallbackEncoding), 
>>> self.fallbackEncoding]
>>> +                except Exception as decode_exception:
>>> +                    if not error_from_fallback:
>>> +                        return [s, None]
>>> +                    error = decode_exception
>>> +            raise MetadataDecodingException(s, error)
>>> +
>>> +    def metadata_stream_to_writable_bytes(self, s):
>>> +        if not isinstance(s, bytes):
>>> +            return s.encode('utf_8')
>>> +        if self.decodingStrategy == 'passthrough':
>>> +            return s
>>> +
>>> +        [text, encoding] = self.decode_metadata(s, False)
>>> +        if encoding == 'utf_8':
>>> +            # s is of utf-8 already
>>> +            return s
>>> +
>>> +        if encoding is None:
>>> +            # could not decode s, even with fallback encoding
>>> +            if not self.decoding_escape_warning_issued:
>>> +                print("\nCould not decode value with configured 
>>> fallback encoding %s; escaping bytes over 127: %s" % 
>>> (self.fallbackEncoding, s))
>>> +                print("\n(this warning is only displayed once during 
>>> an import)")
>>> +                self.decoding_escape_warning_issued = True
>>> +            escaped_bytes = b''
>>> +            # bytes and strings work very differently in python2 vs 
>>> python3...
>>> +            if str is bytes:
>>> +                for byte in s:
>>> +                    byte_number = struct.unpack('>B', byte)[0]
>>> +                    if byte_number > 127:
>>> +                        escaped_bytes += b'%'
>>> +                        escaped_bytes += hex(byte_number)[2:].upper()
>>> +                    else:
>>> +                        escaped_bytes += byte
>>> +            else:
>>> +                for byte_number in s:
>>> +                    if byte_number > 127:
>>> +                        escaped_bytes += b'%'
>>> +                        escaped_bytes += 
>>> hex(byte_number).upper().encode()[2:]
>>> +                    else:
>>> +                        escaped_bytes += bytes([byte_number])
>>> +            return escaped_bytes
>>>   -        raise MetadataDecodingException(s)
>>> +        # were able to decode but not to utf-8
>>> +        return text.encode('utf_8')
>>>       def decode_path(path):
>>> @@ -898,14 +922,14 @@ def p4CmdList(cmd, stdin=None, 
>>> stdin_mode='w+b', cb=None, skip_info=False,
>>>                       decoded_entry[key] = value
>>>                   # Parse out data if it's an error response
>>>                   if decoded_entry.get('code') == 'error' and 'data' 
>>> in decoded_entry:
>>> -                    decoded_entry['data'] = 
>>> decoded_entry['data'].decode()
>>> +                    decoded_entry['data'] = 
>>> metadataTranscoder.decode_metadata(decoded_entry['data'])
>>>                   entry = decoded_entry
>>>               if skip_info:
>>>                   if 'code' in entry and entry['code'] == 'info':
>>>                       continue
>>>               for key in p4KeysContainingNonUtf8Chars():
>>>                   if key in entry:
>>> -                    entry[key] = 
>>> metadata_stream_to_writable_bytes(entry[key])
>>> +                    entry[key] = 
>>> metadataTranscoder.metadata_stream_to_writable_bytes(entry[key])
>>>               if cb is not None:
>>>                   cb(entry)
>>>               else:
>>> @@ -1718,7 +1742,7 @@ class P4UserMap:
>>>               # python2 or python3. To support
>>>               # git-p4.metadataDecodingStrategy=fallback, self.users 
>>> dict values
>>>               # are always bytes, ready to be written to git.
>>> -            emailbytes = 
>>> metadata_stream_to_writable_bytes(output["Email"])
>>> +            emailbytes = 
>>> metadataTranscoder.metadata_stream_to_writable_bytes(output["Email"])
>>>               self.users[output["User"]] = output["FullName"] + b" <" 
>>> + emailbytes + b">"
>>>               self.emails[output["Email"]] = output["User"]
>>>   @@ -1730,12 +1754,12 @@ class P4UserMap:
>>>                   fullname = mapUser[0][1]
>>>                   email = mapUser[0][2]
>>>                   fulluser = fullname + " <" + email + ">"
>>> -                self.users[user] = 
>>> metadata_stream_to_writable_bytes(fulluser)
>>> +                self.users[user] = 
>>> metadataTranscoder.metadata_stream_to_writable_bytes(fulluser)
>>>                   self.emails[email] = user
>>>             s = b''
>>>           for (key, val) in self.users.items():
>>> -            keybytes = metadata_stream_to_writable_bytes(key)
>>> +            keybytes = 
>>> metadataTranscoder.metadata_stream_to_writable_bytes(key)
>>>               s += b"%s\t%s\n" % (keybytes.expandtabs(1), 
>>> val.expandtabs(1))
>>>             open(self.getUserCacheFilename(), 'wb').write(s)
>>> @@ -3349,7 +3373,7 @@ class P4Sync(Command, P4UserMap):
>>>           if userid in self.users:
>>>               return self.users[userid]
>>>           else:
>>> -            userid_bytes = metadata_stream_to_writable_bytes(userid)
>>> +            userid_bytes = 
>>> metadataTranscoder.metadata_stream_to_writable_bytes(userid)
>>>               return b"%s <a@b>" % userid_bytes
>>>         def streamTag(self, gitStream, labelName, labelDetails, 
>>> commit, epoch):
>>> @@ -4561,6 +4585,7 @@ commands = {
>>>       "unshelve": P4Unshelve,
>>>   }
>>>   +metadataTranscoder = 
>>> MetadataTranscoder(defaultMetadataDecodingStrategy, 
>>> defaultFallbackMetadataEncoding)
>>>     def main():
>>>       if len(sys.argv[1:]) == 0:
>>> diff --git a/t/meson.build b/t/meson.build
>>> index a59da26be3f..656424fdff3 100644
>>> --- a/t/meson.build
>>> +++ b/t/meson.build
>>> @@ -1090,6 +1090,7 @@ integration_tests = [
>>>     't9834-git-p4-file-dir-bug.sh',
>>>     't9835-git-p4-metadata-encoding-python2.sh',
>>>     't9836-git-p4-metadata-encoding-python3.sh',
>>> +  't9837-git-p4-error-encoding.sh',
>>>     't9850-shell.sh',
>>>     't9901-git-web--browse.sh',
>>>     't9902-completion.sh',
>>> diff --git a/t/t9837-git-p4-error-encoding.sh b/t/t9837-git-p4-error- 
>>> encoding.sh
>>> new file mode 100755
>>> index 00000000000..1ea774afb1b
>>> --- /dev/null
>>> +++ b/t/t9837-git-p4-error-encoding.sh
>>> @@ -0,0 +1,53 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='git p4 error encoding
>>> +
>>> +This test checks that the import process handles inconsistent text
>>> +encoding in p4 error messages without failing'
>>> +
>>> +. ./lib-git-p4.sh
>>> +
>>> +###############################
>>> +## SECTION REPEATED IN t9835 ##
>>> +###############################
>>> +
>>> +# These tests require Perforce with non-unicode setup.
>>> +out=$(2>&1 P4CHARSET=utf8 p4 client -o)
>>> +if test $? -eq 0
>>> +then
>>> +    skip_all="skipping git p4 error encoding tests; Perforce is 
>>> setup with unicode"
>>> +    test_done
>>> +fi
>>> +
>>> +# These tests are specific to Python 3. Write a custom script that 
>>> executes
>>> +# git-p4 directly with the Python 3 interpreter to ensure that we 
>>> use that
>>> +# version even if Git was compiled with Python 2.
>>> +python_target_binary=$(which python3)
>>> +if test -n "$python_target_binary"
>>> +then
>>> +    mkdir temp_python
>>> +    PATH="$(pwd)/temp_python:$PATH"
>>> +    export PATH
>>> +
>>> +    write_script temp_python/git-p4-python3 <<-EOF
>>> +    exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
>>> +    EOF
>>> +fi
>>> +
>>> +git p4-python3 >err
>>> +if ! grep 'valid commands' err
>>> +then
>>> +    skip_all="skipping python3 git p4 tests; python3 not available"
>>> +    test_done
>>> +fi
>>> +
>>> +test_expect_success 'start p4d' '
>>> +    start_p4d
>>> +'
>>> +
>>> +test_expect_success 'see if Perforce error with characters not 
>>> convertable to utf-8 will be processed correctly' '
>>> +    test_when_finished cleanup_git &&
>>> +    $python_target_binary "$TEST_DIRECTORY"/t9837/git-p4-error- 
>>> python3.py "$TEST_DIRECTORY"
>>> +'
>>> +
>>> +test_done
>>> diff --git a/t/t9837/git-p4-error-python3.py b/t/t9837/git-p4-error- 
>>> python3.py
>>> new file mode 100644
>>> index 00000000000..fb65aee386e
>>> --- /dev/null
>>> +++ b/t/t9837/git-p4-error-python3.py
>>> @@ -0,0 +1,15 @@
>>> +import os
>>> +import sys
>>> +from  importlib.machinery import SourceFileLoader
>>> +
>>> +def main():
>>> +    if len(sys.argv[1:]) != 1:
>>> +        print("Expected test directory name")
>>> +
>>> +    gitp4_path = sys.argv[1] + "/../git-p4.py"
>>> +    gitp4 = SourceFileLoader("gitp4", gitp4_path).load_module()
>>> +    gitp4.p4CmdList(["edit", b'\xFEfile'])
>>> +
>>> +if __name__ == '__main__':
>>> +    main()
>>> +
>>>
>>> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> 

