Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE6CC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 16:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FE220801
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 16:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEoSHfuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfLEQQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:16:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38295 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfLEQQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 11:16:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id 14so4047792qtf.5
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oNNYgEuGMkSOp8oy7CUiQrl7s+u007kUIoOi2fsLSv0=;
        b=mEoSHfuWlud5Opaz2x7V9i+bYFhPn1dtksnGZH3HKZ8yfYAOp8i0wroxG6JmXP+ZiI
         EbQtRy4eitclul+PfzdnCXujGhCWITpudX/VjzTy7xNeaCp/dJfs04Uef3hr1tF0m7LZ
         0MxrAtSg3h7oeV3VyTjpnFWho+1bowo1du5Btq80XrTx/SG3cucuncKmUXpxx6s45GXk
         gxPzool5SDxGDRvl86QAMmhFDkL2N9YoudTKaSmKE6qasylhP0xM6+DHILy7EAHUhs5d
         U7EH+38yBPdKihzWE01AmwEIfIcwY2jkaljd2LLL/w6u5M/jPVzppL6SDD1JV6LUEDNF
         MqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oNNYgEuGMkSOp8oy7CUiQrl7s+u007kUIoOi2fsLSv0=;
        b=lvxMlWbHQBs0bRdjoYRRnyXTqEi0GWurpdRDvuDhh7ncfv895s/oAVytt+ueLIhiEc
         6+2NDFH5Xowiiq9HGZmf4MsYT7UvY4reDVp5hooQ55DPQlQz4G3f9A9Zk1CaD3I/Dzf3
         0R/665EOkdQ4azVAhi0UbOyFQIZvbztKUW1oBWDW5GJ1LdX505f7As4JKmwivTEA+2fc
         2NxFzguM2pUPEy2+20X8upDZlkP8+EZN2NfSqrP2w1HK71Lyuu6DWNCUfFaani04TmU2
         vUbTUQlLpphOhPVbSnTs+T13aItf9hwWIkVn+omzUTOChnaFcWNucOX5rZga99HIP/HV
         gU4w==
X-Gm-Message-State: APjAAAWlhk0Ilz3IsYB5WlgZmA2i4wMt7T2IPaXzmAXXbeDYNygeFQQq
        B42gi394aEjIlu/ctbpO9u9MGJz2BlQ=
X-Google-Smtp-Source: APXvYqy+0QWOvF7QAkNnS8tHzQLN+svI4GhQ8Nhqukff4KoIqEQ7PphWQzY6pgPjVHLtemKNbtAUxg==
X-Received: by 2002:aed:2b07:: with SMTP id p7mr8318947qtd.180.1575562588425;
        Thu, 05 Dec 2019 08:16:28 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id p3sm4915250qkf.107.2019.12.05.08.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 08:16:27 -0800 (PST)
Subject: Re: [PATCH v4 00/11] git-p4.py: Cast byte strings to unicode strings
 in python3
To:     Luke Diamand <luke@diamand.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <CAE5ih7-6EbEM4z5BtY87=82H_tLypiOPq4WY5mm3190QExTZWQ@mail.gmail.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <be2a6839-aa73-dbf8-de19-823d3ae5265a@gmail.com>
Date:   Thu, 5 Dec 2019 11:16:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAE5ih7-6EbEM4z5BtY87=82H_tLypiOPq4WY5mm3190QExTZWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 4:54 AM, Luke Diamand wrote:
> On Wed, 4 Dec 2019 at 22:29, Ben Keene via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Issue: The current git-p4.py script does not work with python3.
>>
>> I have attempted to use the P4 integration built into GIT and I was unable
>> to get the program to run because I have Python 3.8 installed on my
>> computer. I was able to get the program to run when I downgraded my python
>> to version 2.7. However, python 2 is reaching its end of life.
>>
>> Submission: I am submitting a patch for the git-p4.py script that partially
>> supports python 3.8. This code was able to pass the basic tests (t9800) when
>> run against Python3. This provides basic functionality.
>>
>> In an attempt to pass the t9822 P4 path-encoding test, a new parameter for
>> git P4 Clone was introduced.
>>
>> --encoding Format-identifier
>>
>> This will create the GIT repository following the current functionality;
>> however, before importing the files from P4, it will set the
>> git-p4.pathEncoding option so any files or paths that are encoded with
>> non-ASCII/non-UTF-8 formats will import correctly.
>>
>> Technical details: The script was updated by futurize (
>> https://python-future.org/futurize.html) to support Py2/Py3 syntax. The few
>> references to classes in future were reworked so that future would not be
>> required. The existing code test for Unicode support was extended to
>> normalize the classes “unicode” and “bytes” to across platforms:
>>
>>   * ‘unicode’ is an alias for ‘str’ in Py3 and is the unicode class in Py2.
>>   * ‘bytes’ is bytes in Py3 and an alias for ‘str’ in Py2.
>>
>> New coercion methods were written for both Python2 and Python3:
>>
>>   * as_string(text) – In Python3, this encodes a bytes object as a UTF-8
>>     encoded Unicode string.
>>   * as_bytes(text) – In Python3, this decodes a Unicode string to an array of
>>     bytes.
>>
>> In Python2, these functions do not change the data since a ‘str’ object
>> function in both roles as strings and byte arrays. This reduces the
>> potential impact on backward compatibility with Python 2.
>>
>>   * to_unicode(text) – ensures that the supplied data is encoded as a UTF-8
>>     string. This function will encode data in both Python2 and Python3. *
>>        path_as_string(path) – This function is an extension function that
>>        honors the option “git-p4.pathEncoding” to convert a set of bytes or
>>        characters to UTF-8. If the str/bytes cannot decode as ASCII, it will
>>        use the encodeWithUTF8() method to convert the custom encoded bytes to
>>        Unicode in UTF-8.
>>
>>
>>
>> Generally speaking, information in the script is converted to Unicode as
>> early as possible and converted back to a byte array just before passing to
>> external programs or files. The exception to this rule is P4 Repository file
>> paths.
>>
>> Paths are not converted but left as “bytes” so the original file path
>> encoding can be preserved. This formatting is required for commands that
>> interact with the P4 file path. When the file path is used by GIT, it is
>> converted with encodeWithUTF8().
>>
> Almost all the tests pass now - nice!
>
> (There's one test that fails for me, t9830-git-p4-symlink-dir.sh).


Which version of Python are running the failing test against?  I run it 
against Python 2.7 and it passes the test. I don't expect all Python 3.x 
tests to pass yet, just t9800.


>
> Nitpicking:
>
> - There are some bits of trailing whitespace around - can you strip
> those out? You can use "git diff --check".


Is there a way that I can find out which branches I need to remove white 
space from now that they have been committed?


> - Also I think the convention for git commits is that they be limited
> to 72 (?) characters.


I'm going through all my commits and fixing them.


> - In 10dc commit message, s/behvior/behavior
> - Maybe submit 4fc4 as a separate patch series? It doesn't seem
> directly related to your python3 changes.


I moved the enhancements to https://github.com/git/git/pull/675


> - s/howerver/however/
>
> The comment at line 3261 (showing the fast-import syntax) has wonky
> indentation, and needs a space after the '#'.
>
> This code looked like we're duplicating stuff:
>
> +    if isinstance(path, unicode):
> +        path = path.replace("%", "%25") \
> +                   .replace("*", "%2A") \
> +                   .replace("#", "%23") \
> +                   .replace("@", "%40")
> +    else:
> +        path = path.replace(b"%", b"%25") \
> +                   .replace(b"*", b"%2A") \
> +                   .replace(b"#", b"%23") \
> +                   .replace(b"@", b"%40")
>
> I wonder if we can have a helper to do this?

I was just looking at this code block, and at this time, I'm not sure if 
the text coming in will be Unicode or bytes, so I'm hesitant to change 
it until more of the code is converted, but I understand about the 
duplication.


>
> In patchRCSKeywords() you've added code to cleanup outFile. But I
> wonder if we could just use a 'finally' block, or a contextexpr ("with
> blah as outFile:")
>
> I don't know if it's worth doing now that you've got it going, but at
> one point I tried simplifying code like this:
>
>     path_as_string(file['depotFile'])
> and
>     marshalled[b'data']
>
> by using a dictionary with overloaded operators which would do the
> bytes/string conversion automatically. However, your approach isn't
> actually _that_ invasive, so maybe this is not necessary.
>
> Looks good though, thanks!
> Luke
>
I toyed with making a class object that would hold the path data and 
have methods to cast to bytes and encodeWithUTF8() and Unicode versions, 
but it quickly got out of hand.

