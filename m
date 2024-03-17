Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD89320E
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710651059; cv=none; b=t+ptIY4dW3pff+21lRdYFa8kJUwKR3C+aNTHilg0DaajRk6k9n4KI+ryuz8H571hWwCSDloyPwWUy+1Ok3or9gyyYYpxlAp0SgjKsF11EmiNLlkuKtU+1vZ64q6bYOvqr3cLamZjkbX4z/aRZGQNtFmtENWpiWONRrbLWKyRQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710651059; c=relaxed/simple;
	bh=LbkPOlG6jON0kwnGLNNP60qUadk8TjHSkaiIxWeuaVw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CgJYlSVbAE4egcYkwH+8suCvvC9oeWAZMQ5fjMvRTIO7lvhCWXk+szIx0kvnLLaRZ1IgGIGUgwnzEAnTErOsKdhv1VO5a6Cn8aRdO+vMiKVy2MxsBafTAofHrYrNad8b1V667qDYiKI71nKwyEMh0YdAzjAe4OsATClw/P/Jmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Sdw0tFBP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Sdw0tFBP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710651053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzzPmKe9zQrXgUmEfxaDGo6GlrVfW8ufw60YX3FxCF4=;
	b=Sdw0tFBPNKixo1KuzoGGb+LMx3+SoAlUUsSwQebJ/7rUJDxuZ63FQGgOaOYm1fr7Dgcdxg
	upGCqMJKbdA+aqErORnbr47HLwZn14FcqgsxzO/p4tID6c1bpjRTVELC/8MS5G0G+Gy8OQ
	fN5jjX02ulTHoGx5RIj6NrH33/QIv3mTcxL1x/XNvaKvp0eodVdxTEzvmCDWwpGZLqCz6r
	bmqjGF8TpZtVOxEWV4yMV9kFW5qKTUWQ5hDnFMiVuCYz/p5qKRmBlPtIhPCqNxWipbHEbD
	KioqtlFE9WGUNtIaDVkkiBHJ4ZGzEu89yWqiALzPEh1apD8CLAAcKaTTWnluHg==
Date: Sun, 17 Mar 2024 05:50:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
References: <cover.1710646998.git.dsimic@manjaro.org>
 <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
Message-ID: <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-17 05:21, Eric Sunshine wrote:
> On Sat, Mar 16, 2024 at 11:48 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Add a handful of additional automated tests, to improve the coverage 
>> of
>> configuration file entries whose values contain internal whitespace, 
>> leading
>> and/or trailing whitespace, which may or may not be enclosed within 
>> quotation
>> marks, or which contain an additional inline comment.
>> 
>> At the same time, rework one already existing automated test a bit, to 
>> ensure
>> consistency with the newly added tests.  This change introduced no 
>> functional
>> changes to the already existing test.
>> 
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>     [2] 
>> https://lore.kernel.org/git/CAPig+cRG8eFxepkaiN54H+fa7D=rFGsmEHdvTP+HSSaLO_6T_A@mail.gmail.com/
>> 
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> @@ -11,7 +11,97 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +test_expect_success 'create test configuration' '
> 
> In [2] above, I intentionally suggested naming this new test "setup
> whitespace" because "setup" is a common name used in the test suite
> for this sort of test which prepares state for subsequent tests. Using
> a common name (such as "setup") is important since it facilitates
> running only specific tests within a script in which you are
> interested rather than having to run all tests. The section "Skipping
> Tests" in t/README says this:
> 
>     Sometimes there may be multiple tests with e.g. "setup" in their
>     name that are needed and rather than figuring out the number for
>     all of them we can just use "setup" as a substring/glob to match
>     against the test description:
> 
>         $ sh ./t0050-filesystem.sh --run=setup,9-11
> 
>     or one could select both the setup tests and the rename ones
>     (assuming all relevant tests had those words in their
>     descriptions):
> 
>         $ sh ./t0050-filesystem.sh --run=setup,rename

Totally agreed, thanks for pointing this out.  Will be fixed in v3.

>> +       x_to_tab >.git/config <<-\EOF
>> +       [section]
>> +               Xsolid = rock
>> +               Xsparse = big XX blue
>> +               XsparseAndTail = big XX blue
>> +               XsparseAndTailQuoted = "big XX blue "
>> +               XsparseAndBiggerTail = big XX blue X X
>> +               XsparseAndBiggerTailQuoted = "big XX blue X X"
>> +               XsparseAndBiggerTailQuotedPlus = "big XX blue X X"X
>> +               XheadAndTail = Xbig blue
>> +               XheadAndTailQuoted = "Xbig blue "
>> +               XheadAndTailQuotedPlus = "Xbig blue "
>> +               Xannotated = big blueX# to be discarded
>> +               XannotatedQuoted = "big blue"X# to be discarded
>> +       EOF
>> +'
> 
> The <<- operator strips all leading TAB characters, so the extra
> indentation you've placed inside the "[section]" section is stripped
> off. Thus, what you have above is the same as:
> 
>     x_to_tab >.git/config <<-\EOF
>     [section]
>     Xsolid = rock
>     ...
>     EOF

Yes, I was already aware that such indentation ends up wasted, but 
having
it makes the test a bit more readable.  At least in my opinion, but if 
you
find it better not to have such whitespace, for the sake of consistency,
I'll happily remove this indentation in the v3.

> On a related note, it's not clear why you use 'X' to insert a TAB at
> the beginning of each line. As I understand it, the configuration file
> reader does not require such indentation, thus doing so is wasted.
> Moreover, it confuses readers of this code (and reviewers) into
> thinking that something unusual is going on, and leads to questions
> such as this one: Why do you use 'X' to insert a TAB at the beginning
> of the line?

Well, resorting to always not having such instances of 'X' to provide
leading indentation in test configuration files may actually make some
bugs go undetected in some tests.  To me, having leading indentation is
to be expected in the real configuration files in the field, thus 
providing
the same indentation in a test configuration feels natural to me, 
despite
admittedly making the test configuration a bit less readable.

Of course, consistency is good, but variety is also good when it comes
to automated tests.  I'm not very familiar with the tests in git, so
please let me know if consistency outweights variety in this case, and
I'll happily remove the leading "X" indentations in the v3.

>> -test_expect_success 'clear default config' '
>> +test_expect_success 'clear default configuration' '
>>         rm -f .git/config
>>  '
> 
> It's probably not worth a reroll, but it's usually better to avoid
> this sort of do-nothing noise-change since it distracts reviewers from
> the primary changes made by the patch.

The v3 is already inevitable, so I'll drop this change.

>> @@ -1066,9 +1156,25 @@ test_expect_success '--null --get-regexp' '
>> -test_expect_success 'inner whitespace kept verbatim' '
>> -       git config section.val "foo       bar" &&
>> -       test_cmp_config "foo      bar" section.val
>> +test_expect_success 'inner whitespace kept verbatim, spaces only' '
>> +       echo "foo   bar" >expect &&
>> +       git config section.val "foo   bar" &&
>> +       git config --get section.val >actual &&
>> +       test_cmp expect actual
>> +'
> 
> I appreciate the revised test title ("spaces only") which indicates
> that these aren't TABs which were missed when converting to use
> q_to_tab() or x_to_tab().

Thanks. :)
