Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BITCOIN_SPAM_02,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C964DC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912D62464F
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqS97MGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfLESmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:42:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45266 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLESmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 13:42:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so4175217qkl.12
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AQs7Xdyxj61UMgDxkvkh69BbIsLWJf3XGwdg740zVeA=;
        b=hqS97MGxVRVm1JuApWgjdXFMEvDhx77wNMvAZTFiCEjwBFyInYydDuaqWqENYHCGSF
         PU+Hl1xAQAU00L/CHO6Bl7yLorVCFHfiNoKdF4nDFgcAkHCIbAKsqeeLpUfbD8iH0gi7
         FmZ+ogSIdr2/Y3ZGzqSmIZjT/2DEtiemgwO/eMvguMdsA+1Ntab5ZEnjnY8eXVgRWdjd
         Ekv0RKI5eAFzVJB2ERzjpxeemmrd2WP9iRXbVsgFkxEJRxXSoJLyumi8+BTzI8YDYHoS
         Oqg1Ala3oIy5+FhfEvQvobFqB07YOK7CZyBEvhWcf94oVa8pyBH14sbenr3DuWfB9NcW
         GYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AQs7Xdyxj61UMgDxkvkh69BbIsLWJf3XGwdg740zVeA=;
        b=XhK0eib0q/OXeIB9A4gCnF266hf0xc2APeOwUfp2miecATA+Yw1lP3oyZ4l2DjmJiz
         iFT5uWlLBKIL701cEZf5wxmRJ9UQ8tlr2wpb4tNzYi8OAog7SUT5tRza8PSt8HrSPgOK
         n941tl6MmJ6NdCjAMD4L7i8XmJz80CssGx2bvzkIAIeJSMaeHgbo/tWG0j4Fsm4yaLni
         /pyxzGlMT8MvUYm3NgETGizPYo/PvV5KSQfcogN76YxInEEtS5wm4UdckEUNIz3aMt8x
         d9M9ZY+BHoW/jXecgcK/UOaLFgGunv6/d4DWkKiE82oWAbQpfSMjIoqnSN2uXiOemIFa
         /qXw==
X-Gm-Message-State: APjAAAWQQ5r5VK68pzUtMluZUZ5YtU5ShaUkpf+qUlYXK8198bQY+7j8
        XpPZI5s2vxxcu31fPkzDv06dsf9ijLI=
X-Google-Smtp-Source: APXvYqzF1HcjLFUkg0xDK5w6bSpmlCSTIygPe2wEqey4F9YlOlW+NJtYssQI91N3DGSGt/eN+Yupsw==
X-Received: by 2002:a05:620a:849:: with SMTP id u9mr535462qku.389.1575571329134;
        Thu, 05 Dec 2019 10:42:09 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id 11sm5164306qkl.71.2019.12.05.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:42:08 -0800 (PST)
Subject: Re: [PATCH v4 03/11] git-p4: add new helper functions for python3
 conversion
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <f0e658b984ca009c575368e661016f785922f970.1575498577.git.gitgitgadget@gmail.com>
 <20191205104056.GA1192079@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <c6969495-912d-3364-9876-b7cb6a7a3e04@gmail.com>
Date:   Thu, 5 Dec 2019 13:42:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205104056.GA1192079@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 5:40 AM, Denton Liu wrote:
> On Wed, Dec 04, 2019 at 10:29:29PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
>>
>> Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
>>
>> Change the existing unicode test add new support functions for python2-python3 support.
>>
>> Define the following variables:
>> - isunicode - a boolean variable that states if the version of python natively supports unicode (true) or not (false). This is true for Python3 and false for Python2.
>> - unicode - a type alias for the datatype that holds a unicode string.  It is assigned to a str under python 3 and the unicode type for Python2.
>> - bytes - a type alias for an array of bytes.  It is assigned the native bytes type for Python3 and str for Python2.
>>
>> Add the following new functions:
>>
>> - as_string(text) - A new function that will convert a byte array to a unicode (UTF-8) string under python 3.  Under python 2, this returns the string unchanged.
>> - as_bytes(text) - A new function that will convert a unicode string to a byte array under python 3.  Under python 2, this returns the string unchanged.
>> - to_unicode(text) - Converts a text string as Unicode(UTF-8) on both Python2 and Python3.
>>
>> Add a new function alias raw_input:
>> If raw_input does not exist (it was renamed to input in python 3) alias input as raw_input.
>>
>> The AS_STRING and AS_BYTES functions allow for modifying the code with a minimal amount of impact on Python2 support.  When a string is expected, the as_string() will be used to convert "cast" the incoming "bytes" to a string type. Conversely as_bytes() will be used to convert a "string" to a "byte array" type. Since Python2 overloads the datatype 'str' to serve both purposes, the Python2 versions of these function do not change the data, since the str functions as both a byte array and a string.
> How come AS_STRING and AS_BYTES are all-caps here?


I changed them.  I used all caps to designate that they are code string. 
I changed them to as_string() and as_bytes()


>
>> basestring is removed since its only references are found in tests that were changed in the previous change list.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit 7921aeb3136b07643c1a503c2d9d8b5ada620356)
>> ---
>>   git-p4.py | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 66 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 0f27996393..93dfd0920a 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -32,16 +32,78 @@
>>       unicode = unicode
>>   except NameError:
>>       # 'unicode' is undefined, must be Python 3
>> -    str = str
>> +    #
>> +    # For Python3 which is natively unicode, we will use
>> +    # unicode for internal information but all P4 Data
>> +    # will remain in bytes
>> +    isunicode = True
>>       unicode = str
>>       bytes = bytes
>> -    basestring = (str,bytes)
>> +
>> +    def as_string(text):
>> +        """Return a byte array as a unicode string"""
>> +        if text == None:
> Nit: use `text is None` instead. Actually, any time you're checking an
> object to see if it's None, you should use `is` instead of `==` since
> there's usually only one None reference.

I changed this in this commit and will attempt to fix this in all the 
following commits as well.


>
>> +            return None
>> +        if isinstance(text, bytes):
>> +            return unicode(text, "utf-8")
>> +        else:
>> +            return text
>> +
>> +    def as_bytes(text):
>> +        """Return a Unicode string as a byte array"""
>> +        if text == None:
>> +            return None
>> +        if isinstance(text, bytes):
>> +            return text
>> +        else:
>> +            return bytes(text, "utf-8")
>> +
>> +    def to_unicode(text):
>> +        """Return a byte array as a unicode string"""
>> +        return as_string(text)
>> +
>> +    def path_as_string(path):
>> +        """ Converts a path to the UTF8 encoded string """
>> +        if isinstance(path, unicode):
>> +            return path
>> +        return encodeWithUTF8(path).decode('utf-8')
>> +
> Trailing whitespace.
>
>>   else:
>>       # 'unicode' exists, must be Python 2
>> -    str = str
>> +    #
>> +    # We will treat the data as:
>> +    #   str   -> str
>> +    #   bytes -> str
>> +    # So for Python2 these functions are no-ops
>> +    # and will leave the data in the ambiguious
>> +    # string/bytes state
>> +    isunicode = False
>>       unicode = unicode
>>       bytes = str
>> -    basestring = basestring
>> +
>> +    def as_string(text):
>> +        """ Return text unaltered (for Python3 support) """
> I didn't mention this in earlier emails but it's been bothering me a
> lot: is there any reason why you write it as "Python3" vs. "Python 3"
> sometimes (and Python2 as well)? If there's no difference, then we
> should probably stick to one variant in both the commit messages and in
> the code. (I prefer the spaced variant.)


The difference was sloppy typing.  Like the "is None" and trailing white 
spaces, I'll work on fixing these.


>> +        return text
>> +
>> +    def as_bytes(text):
>> +        """ Return text unaltered (for Python3 support) """
>> +        return text
>> +
>> +    def to_unicode(text):
>> +        """Return a string as a unicode string"""
>> +        return text.decode('utf-8')
>> +
> Trailing whitespace.
>
>> +    def path_as_string(path):
>> +        """ Converts a path to the UTF8 encoded bytes """
>> +        return encodeWithUTF8(path)
>> +
>> +
>> +
> Trailing whitespace.
>
>> +# Check for raw_input support
>> +try:
>> +    raw_input
>> +except NameError:
>> +    raw_input = input
>>   
>>   try:
>>       from subprocess import CalledProcessError
>> -- 
>> gitgitgadget
>>
