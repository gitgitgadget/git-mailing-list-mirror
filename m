Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D35C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjDCTdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDCTdH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:33:07 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88BD198C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680550372; i=l.s.r@web.de;
        bh=b+2d+nMK19RT13p34FrUkJtzcvMtETAOQGsAULLgTpE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GBX5gC24HGkP9c02nrTnIIqZxFTcJ3Lwk0CscvzY7wfrbfMkfVijzr8aKTD1w0vwb
         e4LsOCw00hF4FS8ly7kmjDNB6Y54idM9wWpph9mupHglkv9wid9Jw2TDruOcNGpi16
         xb5q7kTNzObrWmNe/Mp4EU6lrhW46E0PoWDfLYWf1MV4v0ZnIdF7Fy68RwX23gaext
         Rq2/m9AekuTXPnJR3umT3RyfO9aAgcj2avuRqwafEuf2Gs0WTgOeiH2cBq928FHngq
         559YvPot7V5+Qc4XuS9YWt8oi1FcQ/C6611jfp3nrWhPPPlezDNrSUXmRt4W15J8ao
         v+F2n+XC+D67w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1qRaLM2j9E-00zx2L; Mon, 03
 Apr 2023 21:32:52 +0200
Message-ID: <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
Date:   Mon, 3 Apr 2023 21:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: regex compilation error with --color-words
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
 <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5yad7wv3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Vxskq1a/OtDvHqCGSUds4baPwjo267Vnp0dSrxq+ZjTW5lf8IL
 ihQAfGp9ukWTScqtJvzN+XDwe2pZWdcFWFzeiIt8er1NW6aBhKQLGIqaw4z355e/lo4BTgr
 PM5YQlGH1ttzstXuH1qJt3ZoQy5NsXrmy6fY6R+ZbKaWmjyRKSmuRXaRYlSUbkRk71iH98K
 y2CyPOseDegoP49c9J5OA==
UI-OutboundReport: notjunk:1;M01:P0:X6aXOEVLRmk=;oRM/CudCWhgE7q7MsJXSurCtdRF
 4TQDgMXlLt19F7VnArFZvvX7oEdO4xIZQwe8sA9BCqvrB8dubiyI6skm6omYuaNz3y/cr0NdD
 W25oj8EnJtCE620A3ky89FzyVtRmNFUIt5xAV18lZZnJnxr751So2z1hHqs0nN+x0tnlnlb7E
 ljZ9g6L6ZfZZ/O5Lci9OHK8yebpPz54WVzspZltp4YmOxgR7GogV4/in1ok/yx/8G2QoBfDLw
 qacqrDRdSfNMpQpxa3hvTp9G4ZEHnOYKW7UO3JD3xwdRRgQaZ4RAkCegkdp5bMb6KHaAEANKC
 aFDfg4+yvwZdUMaGITRp377CApDpQ0TfFGb9c4ILcCjmWzSMFneInlUQBnf5zdZ2jNBzncy4s
 KS+iMM6SigCI9xpCOztJ/HzlAXTv5IaF0wz6Q758U62K8eDwaiYzbgOG//NltOLLMXfG+XqPH
 fC/ZdvRfHlYa98m0ieonjJxMt/niCmidr69ZEnAugNf/reiJmFRKqOQowC0Bw9IkBC8xLWKIZ
 4Qs5brybgOKu1aDS2PVAPZurE6dfM9aX/1Xux7nSRNUnUqH/3F7r3DGslKlJPcTaKfN3LQw8x
 Hfxqn84ZrStBMQjtZOmkekzF9JUpqHSmFa27gvFwuoErXGFDYqez3Pl5ccaBy9h6JNAVcv6lD
 BdD7vzdRoGR9De3nP3dsqtix+/lix2hkDCw3tXbLMHV5niSNYNBn6/vTUaOnxfqaOMlMZyHLL
 6KphJd7reIcNYgYKWwGe2Sj0frCYE4Bz+JKKYKmSWhA7WXvpWATwurBhusV9uValLyuovJjen
 1A8fFoDK2F7YENoFHPeQ2L9Vw9GCwN4VX0nvrnlyZeXIaJw8qV7ktdsZ9Ce3Io7FShQPZQ5wo
 cE/+tyeBTtp3vHGhSYhs1Si6kqNM59ZQhaOf089PVfFYRWRvy1G66oAOXDNc3Ix+bshjIYXb/
 WBdB970hNRwFxvwlyqsEjPCRPu4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.23 um 18:29 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Actually we can drop the "|[\xc0-\xff][\x80-\xbf]+" part in that case
>> because the "[^[:space:]]" suffices.  And we probably need to do that a=
t
>> runtime because it depends on the locale.  The rather elaborate patch
>> below does that.  It leaks the truncated word_regex, which isn't that
>> bad because it's done only once per run, but certainly untidy.
>
> Small ugliness like what we see below is fine in a technology
> demonostration.
>
>> I suspect/hope this can be done simpler and cleaner after refactoring
>> the userdiff code to allow for runtime assembly of regular expressions.
>
> Do we expect "does the regcomp(3) and regexec(3) correctly match a
> non-space multi-byte UTF-8 sequence as expected?" to be the only
> choices, do we expect we will choose from only two, and do we expect
> that the differences between the MB version and fallback version to
> be the same "OR_MULTI_BYTE_CHAR may be omitted"?  For now I think
> it would be reasonable to answer yes to all three.
>
> How are .is_builtin and .has_multi_byte_char_fallback bits expected
> to be used?  For what kind of files do we expect them to be set
> differently?

.is_builtin is unnecessary here.  It is a remnant of me noticing that we
don't add "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" to user-defined
patterns, but .has_multi_byte_char_fallback alone suffices.

>
> In the simplest case, I would imagine that we could do this
>
>  	...
>  	const char *word_regex;
> +	const char *word_regex_wo_mb;
>  	const char *textconv;
>  	...
>
> in the definition of "struct userdifif_driver", use
>
>  #define PATTERNS(lang, rx, wrx) { \
>  	...
>  	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
> +	.word_regex_wo_mb =3D wrx "|[^[:space:]]", \

Ah, nice, no allocation or string manipulation at runtime at all, at
the small cost of having near-duplicate static strings.

>  }
>
> and similar for IPATTERN, and make a non-NULL .word.regex_wo_mb
> serve as the .has_multi_byte_char_fallback bit to trigger "does our
> regex engine do a good job for multi-byte?"
>
> Thanks.
>
>> diff --git a/userdiff.c b/userdiff.c
>> index 09203fbc35..aa2cd150ba 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -9,6 +9,8 @@ static struct userdiff_driver *drivers;
>>  static int ndrivers;
>>  static int drivers_alloc;
>>
>> +#define OR_MULTI_BYTE_CHAR "|[\xc0-\xff][\x80-\xbf]+"
>> +
>>  #define PATTERNS(lang, rx, wrx) { \
>>  	.name =3D lang, \
>>  	.binary =3D -1, \
>> @@ -16,7 +18,9 @@ static int drivers_alloc;
>>  		.pattern =3D rx, \
>>  		.cflags =3D REG_EXTENDED, \
>>  	}, \
>> -	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
>> +	.word_regex =3D wrx "|[^[:space:]]" OR_MULTI_BYTE_CHAR, \
>> +	.is_builtin =3D 1, \
>> +	.has_multi_byte_char_fallback =3D 1, \
>>  }
>>  #define IPATTERN(lang, rx, wrx) { \
>>  	.name =3D lang, \
>> @@ -25,7 +29,9 @@ static int drivers_alloc;
>>  		.pattern =3D rx, \
>>  		.cflags =3D REG_EXTENDED | REG_ICASE, \
>>  	}, \
>> -	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
>> +	.word_regex =3D wrx "|[^[:space:]]" OR_MULTI_BYTE_CHAR, \
>> +	.is_builtin =3D 1, \
>> +	.has_multi_byte_char_fallback =3D 1, \
>>  }
>>
>>  /*
>> @@ -330,6 +336,25 @@ static int userdiff_find_by_namelen_cb(struct user=
diff_driver *driver,
>>  	return 0;
>>  }
>>
>> +static int regexec_support_multi_byte_chars(void)
>> +{
>> +	static const char not_space[] =3D "[^[:space:]]";
>> +	static const char utf8_multi_byte_char[] =3D "\xc2\xa3";
>> +	regex_t re;
>> +	regmatch_t match;
>> +	static int result =3D -1;
>> +
>> +	if (result !=3D -1)
>> +		return result;
>> +	if (regcomp(&re, not_space, REG_EXTENDED))
>> +		BUG("invalid regular expression: %s", not_space);
>> +	result =3D !regexec(&re, utf8_multi_byte_char, 1, &match, 0) &&
>> +		match.rm_so =3D=3D 0 &&
>> +		match.rm_eo =3D=3D strlen(utf8_multi_byte_char);
>> +	regfree(&re);
>> +	return result;
>> +}
>> +
>>  static struct userdiff_driver *userdiff_find_by_namelen(const char *na=
me, size_t len)
>>  {
>>  	struct find_by_namelen_data udcbdata =3D {
>> @@ -337,6 +362,15 @@ static struct userdiff_driver *userdiff_find_by_na=
melen(const char *name, size_t
>>  		.len =3D len,
>>  	};
>>  	for_each_userdiff_driver(userdiff_find_by_namelen_cb, &udcbdata);
>> +	if (udcbdata.driver &&
>> +	    udcbdata.driver->is_builtin &&
>> +	    udcbdata.driver->has_multi_byte_char_fallback &&
>> +	    regexec_support_multi_byte_chars()) {
>> +		const char *word_regex =3D udcbdata.driver->word_regex;
>> +		udcbdata.driver->word_regex =3D xmemdupz(word_regex,
>> +			strlen(word_regex) - strlen(OR_MULTI_BYTE_CHAR));
>> +		udcbdata.driver->has_multi_byte_char_fallback =3D 0;
>> +	}
>>  	return udcbdata.driver;
>>  }
>>
>> diff --git a/userdiff.h b/userdiff.h
>> index 24419db697..83f5863d58 100644
>> --- a/userdiff.h
>> +++ b/userdiff.h
>> @@ -21,6 +21,8 @@ struct userdiff_driver {
>>  	const char *textconv;
>>  	struct notes_cache *textconv_cache;
>>  	int textconv_want_cache;
>> +	int is_builtin;
>> +	int has_multi_byte_char_fallback;
>>  };
>>  enum userdiff_driver_type {
>>  	USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<0,
>> --
>> 2.40.0
