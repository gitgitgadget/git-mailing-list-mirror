Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E192523C
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342864; cv=none; b=dGlyrZHmEqmw7qqBXRtiZMEDqEeWt55p/jqpLD5lmXPOY+gbITG64ggPuBIAmS2oSsIg89Vc08S1kjoCCQ5xe9iEUiUgtwTG+EzxMRZzc88o6/UICvKn7hXa4mM5GQvgSMasd75gbiQ1gFfpEx0dfa3sF1hrQa+f+2UOvOeYt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342864; c=relaxed/simple;
	bh=bIlSfHjwyDPcFAImd4uxd8/7b0KCDpjTQCA28cmlQRs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qtRYfkUMthkZ4O4g97qzcVtirFkXCLN5OOWx2Nva+jOLTgnoBEqnqwc2y2G4tlRB+7iMyPjAwV6WccJOfo2yvm9UPXizz+o2CCTaFqaSIX1Ri+YSFFCycj0lhOWymVm2U+ey9awK/LQ4AFak5Co7/0KDWzBReAVHzcQDfmdlvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FgvL2Xs7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FgvL2Xs7"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710342858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hitKwZb5gnJTmp7kXoCnl76zzptFZ9rs1CC1Q8P8hJA=;
	b=FgvL2Xs7LfeW3mnXjwxSktpmqxJfFu9BpM53yapoef5X7fQd2yek2UTphYzcF0tRHJKyIF
	OGccfwEYmzrlQ8FhWKdFN3UzV24YI3r5x86qWO3+t6eIgUB8fts9T6kDKm9aJlh+4ITu1J
	zuGhDsuss3ink+UD7U/cpmf7OcKeYXlCcoHZyMbOiN4DdODItB4vdRWD71ApIpqak6JG1r
	QZLqheS3+ZRcYbaXzZ1+pUQSf3If3HdvnhH66XJaA4Ybd09CPY7zVI1rLKiiPVWlZNVBwn
	ypbgW1+4CATSZ+LLBHFMRdS7ux/0jmd7oU8l8+9eVTxq8yGYlVj7g1sifGa1bw==
Date: Wed, 13 Mar 2024 16:14:17 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org, Junio C
 Hamano <gitster@pobox.com>, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <d15eb4b0-2ea9-44d7-af5a-2ea1162294f4@gmail.com>
References: <20240312231559.GA116605@quokka>
 <fac4fec23597bff0f4594112d2a9976d@manjaro.org>
 <d15eb4b0-2ea9-44d7-af5a-2ea1162294f4@gmail.com>
Message-ID: <e14ec355d447e16a794f313543dccf5b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-03-13 16:06, Phillip Wood wrote:
> On 13/03/2024 02:15, Dragan Simic wrote:
>> Hello Peter,
>> 
>> On 2024-03-13 00:15, Peter Hutterer wrote:
>>> Allow the default prefixes "a/" and "b/" to be tweaked by the
>>> diff.srcprefix and diff.dstprefix configuration variables.
>> 
>> The only thing that's left is to update the patch description
>> to use camel case. :)
> 
> If that's the only change that's required I don't think we should be
> asking for a re-roll. We do place a high value on good commit messages
> in this project but I don't think it is reasonable to require a
> re-roll for a purely aesthetic change.

Well, I required nothing, I just noted it.  Such a small change can
also be performed by Junio while applying the patch.


>>> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>>> ---
>>> Changes to v2;
>>> - doc: change to camelcase diff.srcPrefix/diff.dstPrefix for
>>>   consistency with diff.mnemonicPrefix and most other options
>>> - git diff --default-prefix forces a/ and b/ regardless of configured
>>>   prefix, see the 'diff_opt_default_prefix' hunk in the patch below.
>>> 
>>> The latter may be slightly controversial but: there are scripts out
>>> there that rely on the a/ and b/ prefix (came across one last night).
>>> With a custom prefix those scripts will break, having an option that
>>> forces the a/ and b/ prefix helps. Plus the man page explicitly says:
>>>   Use the default source and destination prefixes ("a/" and "b/").
>>> So let's stick with that behaviour then.
>>> 
>>>  Documentation/config/diff.txt |  6 ++++++
>>>  diff.c                        | 14 ++++++++++++--
>>>  t/t4013-diff-various.sh       | 35 
>>> +++++++++++++++++++++++++++++++++++
>>>  3 files changed, 53 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/Documentation/config/diff.txt 
>>> b/Documentation/config/diff.txt
>>> index 6c7e09a1ef5e..afc23d7723b6 100644
>>> --- a/Documentation/config/diff.txt
>>> +++ b/Documentation/config/diff.txt
>>> @@ -111,6 +111,12 @@ diff.mnemonicPrefix::
>>>  diff.noprefix::
>>>      If set, 'git diff' does not show any source or destination 
>>> prefix.
>>> 
>>> +diff.srcPrefix::
>>> +    If set, 'git diff' uses this source prefix. Defaults to 'a/'.
>>> +
>>> +diff.dstPrefix::
>>> +    If set, 'git diff' uses this destination prefix. Defaults to 
>>> 'b/'.
>>> +
>>>  diff.relative::
>>>      If set to 'true', 'git diff' does not show changes outside of 
>>> the directory
>>>      and show pathnames relative to the current directory.
>>> diff --git a/diff.c b/diff.c
>>> index e50def45383e..108c1875775d 100644
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
>>>  int diff_auto_refresh_index = 1;
>>>  static int diff_mnemonic_prefix;
>>>  static int diff_no_prefix;
>>> +static const char *diff_src_prefix = "a/";
>>> +static const char *diff_dst_prefix = "b/";
>>>  static int diff_relative;
>>>  static int diff_stat_name_width;
>>>  static int diff_stat_graph_width;
>>> @@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const 
>>> char *value,
>>>          diff_no_prefix = git_config_bool(var, value);
>>>          return 0;
>>>      }
>>> +    if (!strcmp(var, "diff.srcprefix")) {
>>> +        return git_config_string(&diff_src_prefix, var, value);
>>> +    }
>>> +    if (!strcmp(var, "diff.dstprefix")) {
>>> +        return git_config_string(&diff_dst_prefix, var, value);
>>> +    }
>>>      if (!strcmp(var, "diff.relative")) {
>>>          diff_relative = git_config_bool(var, value);
>>>          return 0;
>>> @@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options 
>>> *options)
>>> 
>>>  void diff_set_default_prefix(struct diff_options *options)
>>>  {
>>> -    options->a_prefix = "a/";
>>> -    options->b_prefix = "b/";
>>> +    options->a_prefix = diff_src_prefix;
>>> +    options->b_prefix = diff_dst_prefix;
>>>  }
>>> 
>>>  struct userdiff_driver *get_textconv(struct repository *r,
>>> @@ -5362,6 +5370,8 @@ static int diff_opt_default_prefix(const struct
>>> option *opt,
>>> 
>>>      BUG_ON_OPT_NEG(unset);
>>>      BUG_ON_OPT_ARG(optarg);
>>> +    diff_src_prefix = "a/";
>>> +    diff_dst_prefix = "b/";
>>>      diff_set_default_prefix(options);
>>>      return 0;
>>>  }
>>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>>> index 1e3b2dbea484..e75f9f7d4cb2 100755
>>> --- a/t/t4013-diff-various.sh
>>> +++ b/t/t4013-diff-various.sh
>>> @@ -663,6 +663,41 @@ test_expect_success 'diff --default-prefix
>>> overrides diff.mnemonicprefix' '
>>>      check_prefix actual a/file0 b/file0
>>>  '
>>> 
>>> +test_expect_success 'diff respects diff.srcprefix' '
>>> +    git -c diff.srcprefix=x/ diff >actual &&
>>> +    check_prefix actual x/file0 b/file0
>>> +'
>>> +
>>> +test_expect_success 'diff respects diff.dstprefix' '
>>> +    git -c diff.dstprefix=y/ diff >actual &&
>>> +    check_prefix actual a/file0 y/file0
>>> +'
>>> +
>>> +test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
>>> +    git -c diff.srcprefix=z/ diff --src-prefix=z/ >actual &&
>>> +    check_prefix actual z/file0 b/file0
>>> +'
>>> +
>>> +test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
>>> +    git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
>>> +    check_prefix actual a/file0 z/file0
>>> +'
>>> +
>>> +test_expect_success 'diff src/dstprefix ignored with diff.noprefix' 
>>> '
>>> +    git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix 
>>> diff >actual &&
>>> +    check_prefix actual file0 file0
>>> +'
>>> +
>>> +test_expect_success 'diff src/dstprefix ignored with 
>>> diff.mnemonicprefix' '
>>> +    git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c 
>>> diff.mnemonicprefix
>>> diff >actual &&
>>> +    check_prefix actual i/file0 w/file0
>>> +'
>>> +
>>> +test_expect_success 'diff src/dstprefix ignored with 
>>> --default-prefix' '
>>> +    git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff 
>>> --default-prefix >actual &&
>>> +    check_prefix actual a/file0 b/file0
>>> +'
>>> +
>>>  test_expect_success 'diff --no-renames cannot be abbreviated' '
>>>      test_expect_code 129 git diff --no-rename >actual 2>error &&
>>>      test_must_be_empty actual &&
>> 
