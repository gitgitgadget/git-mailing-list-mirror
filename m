Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C727C16B
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499007; cv=none; b=MfDAS15iuCT4MGXePpG0uKa0f/WsXJlE/+qqWJfQCc93PnwJl7+FFxcztPORv6SILzMMurz/CyuC/DVuSZ5UsinWgdTvL7oaU6o4ICk4qQAzEPl4kuKNIDqVrpMIbgxtMThcNU0bg4nJxxcwHXhZy4Lz5kPFhy7vf8SGGXGip4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499007; c=relaxed/simple;
	bh=bMtGbL2jgexymNFtmPDv085tzgfO04+LXv8w58pGy5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz1WaFYxAsWiC+X//6nQXZwFNb8y3BGGJZ8kz7SLM01EQeONLhS2BX3ipEMXLA00D0+JOYBqW1X2geTZTBV+KWTi6/e54j9Bbv7MMsPvlkQtSAIwD84BZMsgK1Wr55oxA82Zw28v4GrPCA/84fq0wWwjt6rJ92dIuU1HZbk59Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvc/8UOt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvc/8UOt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af589091049so617128a12.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499005; x=1746103805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMqX7vCSVpvI0xiCvB4yTbi0H0SbjDTiMRni0L86H9k=;
        b=Yvc/8UOtt5UCY4m7D1UsNHDiBiKV8keYp5ZPcwEIlg10K25/vxFGa5LprYGnM/ouHJ
         PqMgqFyEDJjc1tB9tSr9V61uqB3e+k6QpPhJzpXPi/0RcGOQG8LZNZ2AE4HVFduNiXWJ
         Vh8pDiaeOg4rXu2WKTHk691EW4YMCLpDtjP+YwAdPgY6/mt2I3R2e1HOfRPnszUAeG6L
         zmbj/lVaxSGf3Gvhrei8EPTZikLAypPg77Kl7Qd1i0lM+H6DZvyoN8yDQ3CDXoHe/kUo
         hRjaFbBucpzf8DJLOLJAuqdOvpSwd3AzKRZvknevOf9imTWFIVdAS4IXkZUqlz4eNVHt
         X6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499005; x=1746103805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMqX7vCSVpvI0xiCvB4yTbi0H0SbjDTiMRni0L86H9k=;
        b=fSG5tKYjR1QRWpdV04u0d2nCWRdgxhA6jp28if0VcJi16SsscbL8XoqsrNtGkCbj7K
         eQB6fjuQ0TTWcFtkKI5S5r3UM2W88XEg+8vNFQqqmMpM0ZuLFp82JEUV5s8noF8NghS1
         wduMkDj+eQoDV+M5Ztx80+Eg32y9rQhG8GavV9HQBmVk83cEBPxFrIwzGK2/i8wOoFBW
         1zgXD164gpNN6IEoxpuzJjULXTlTn/tfdz8bCfyELUwR7g4w4Rjw91CscVPyz6BsfBgL
         KmpsLvigFTGdn5u1vKGAR2dPIeaYjzE8vgjGkdjcKqFBBLYHZ90u+jWvSZo7AvnoZUrr
         yPBw==
X-Gm-Message-State: AOJu0YyiZU2exMorVWVQgHd9h1FjXAMwMvWVp8UnZfFNVbv/7CSg0GHL
	oZ77/vrn5gVOtjZfkX572KYwgu6dl2wwEczyvb0N7/RExeqkZj0V
X-Gm-Gg: ASbGnctfIjntxPGTt7X/IvpsC3xtzJkZlSTNR8M3VFg2Cufqxd0Jn14yat5t6Gpw/nh
	i9/IVvEhM1ta/kVbtwgcXabyx2tt39JF0+RkNNw5J0MM7fV7ivA72SRqLWyMI+cLluVJeu8fL0T
	TDy8I9djuQ5IIsAFUg5U0nBd+j3y5KKzGlup3U6pSsC1PrhchUft3cJ+De9PbY7YtiaQO/GgdkG
	eP7fewCbzkWu1L9K5wJLzzrsHYBet2ACGcz1Tt2fOwLneXqxI6k1PdTjv2MwG8UDAByDYFfCPqe
	Qlprzyaq1XuwrVzPbx5iC5FoQMTGjNWzbs5x
X-Google-Smtp-Source: AGHT+IGcU7H2y5UwvSGd4BSXFk0hcRbFb/Fgs86c192lVTuITDfgfTkRJwAYDUl3eOvmcrRYc7CWHg==
X-Received: by 2002:a17:90a:d88c:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-309ed36e9d0mr3181097a91.34.1745499004879;
        Thu, 24 Apr 2025 05:50:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309ef04ba89sm1250365a91.10.2025.04.24.05.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:50:04 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:50:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.orga
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/5] u-string-list: move "test_split" into
 "u-string-list.c"
Message-ID: <aAozhkSJXkJ_nRPs@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAetv8l8jrxvEywB@ArchLinux>
 <xmqqr01j3n15.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr01j3n15.fsf@gitster.g>

On Tue, Apr 22, 2025 at 02:27:02PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We rely on "test-tool string-list" command to test the functionality of
> > the "string-list". However, as we have introduced clar test framework,
> > we'd better move the shell script into C program to improve speed and
> > readability.
> >
> > Create a new file "u-string-list.c" under "t/unit-tests", then update
> > the Makefile and "meson.build" to build the file. And let's first move
> > "test_split" into unit test and gradually convert the shell script into
> > C program.
> >
> > In order to create `string_list` easily by simply specifying strings in
> > the function call, create "t_vcreate_string_list_dup" and
> > "t_create_string_list_dup" functions to do above.
> >
> > Then port the shell script tests to C program and remove unused
> > "test-tool" code and tests.
> >
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> 
> This is the most interesting in the u-string-list patches, as it
> adds not just a moved test but adds supporting functions that are
> shared with test functions added in later steps.
> 
> > diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> > new file mode 100644
> > index 0000000000..0c148684ea
> > --- /dev/null
> > +++ b/t/unit-tests/u-string-list.c
> > @@ -0,0 +1,86 @@
> > +#include "unit-test.h"
> > +#include "string-list.h"
> > +
> > +static void t_check_string_list(struct string_list *list,
> > +				struct string_list *expected_strings)
> > +{
> > +	size_t expect_len = expected_strings->nr;
> > +	cl_assert_equal_i(list->nr, expect_len);
> > +	cl_assert(list->nr <= list->alloc);
> > +	for (size_t i = 0; i < expect_len; i++)
> > +		cl_assert_equal_s(list->items[i].string,
> > +				  expected_strings->items[i].string);
> > +}
> 
> Perhaps call it "string_list_equal()" or something?  "check" is a
> convenient name that can mean different kind of validation that is
> not limited to "is the actual answer identical to the expected one?"
> 

Good idea.

> Wouldn't it be cleaner to read if you wrote it without an extra
> variable expect_len?  The compiler would notice repeated reference
> of expected_strings->nr and optimize them away anyway, I would
> imagine.
> 

Yeah, the compiler would definitely optimize this. Will update in the
next version.

> > +static void t_string_list_clear(struct string_list *list, int free_util)
> > +{
> > +	string_list_clear(list, free_util);
> > +	cl_assert_equal_p(list->items, NULL);
> > +	cl_assert_equal_i(list->nr, 0);
> > +	cl_assert_equal_i(list->alloc, 0);
> > +}
> 
> Validating the result of clearing a list may be a good thing to do
> at least once in the test suite, but this is called from many places
> in other tests.  Conceptually it feels kludgy to call this from
> other places where they should all just call string_list_clear(),
> like ...
> 

I agree that we should not call `t_string_list_clear` in many places.
It's overkill.

> > +static void t_vcreate_string_list_dup(struct string_list *list,
> > +				      int free_util, va_list ap)
> > +{
> > +	const char *arg;
> > +
> > +	cl_assert(list->strdup_strings);
> > +
> > +	t_string_list_clear(list, free_util);
> 
> ... this place.
> 
> > +	while ((arg = va_arg(ap, const char *)))
> > +		string_list_append(list, arg);
> > +}
> 
> To put it differently, you could be calling t_string_list_append()
> in this loop, which would 
> 
>  - remember list->nr
>  - call string_list_append()
>  - cl_assert_equal() to ensure that list->nr is one larger than
>    the value we remembered upon entry to the function.
> 
> which is not wrong per-se, but hopefully you'd agree that it is
> overkill.  t_stirng_list_clear() is overkill in the same way.
> 

You're right. I will improve this in the next version.

> > +void test_string_list__split(void)
> > +{
> > +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> > +
> > +	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "baz", NULL);
> > +...
> > +	t_create_string_list_dup(&expected_strings, 0, "", "", NULL);
> > +	t_string_list_split(":", ':', -1, &expected_strings);
> > +
> > +	t_string_list_clear(&expected_strings, 0);
> > +}
> 
> This is a good place to call t_string_list_clear(), just once in
> this script.  All other callers are conceptually simpler to call
> string_list_clear(), as the point at their callsites is to clear
> after themselves, not about testing string_list_clear() works
> correctly.
> 
> Thanks.

Thanks,
Jialuo
> 
