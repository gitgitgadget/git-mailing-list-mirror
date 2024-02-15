Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAF1E4AE
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036703; cv=none; b=gntkShI2XwmF/aPNHykEYlwDEg66bqWvaPIT8Nmf86PxdRCXxnHYN2UaErImx6c1bq/kCi3ZJ5mabXvBKVJc4mMLuoDgklssvIj6oOqYkvSi/howI8iGxT2lBGV6aSZwBqCWWscIT32V4YSxAM8YvzJKLjtVKnikzCh9Au8ek9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036703; c=relaxed/simple;
	bh=0Ej9bjA35jjeg5jpTwt3MloxXY6Xeebhr5F6wYvkHxo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O+EbeqlRd8Nms4YtpyHJ++zfjt1FySxfjkzrk7w0MUCOznXwbi8ubBHv4BS1v1JZkZm7vzS+noig9dAZuF5Y+k1GM1MzSOgBTVy3gEDnFUZBaOJoKHdFFmGftuegN/5HbVwMhMdnjJ3JXS5RbJv3HfV8mDcv4pW8WmOsvb9RW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ggmzBjAR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ggmzBjAR"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708036697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7gIM4RWufR7+YYClh/WLgwHTz7GHdr1ddXy2eHBAMg=;
	b=ggmzBjARKWRuta3kttGaIMymxg6sTBMvmIJ3JfavlaOyq24anMhjYBizeJSY0f57gB820V
	VAzjXcr4zerX7t1axrBBu0Q0FG8P4nR9YQdCsPHgBQwbCAi9PWfe5bOLHn6r8xFbp7YFed
	9JOADzyltRX7ZCY2EKBB/4EbpGaUPtPTKygtSTX1l7oc0gJ0J2isvWR7F9lf1fJxp6ddKn
	XLFbFPstGNLArhw1Xw7yWF7bLIWFgp5Laig0iKbsTv5IMDgTNpC5g47mN9JN4lBP2B+DmI
	Txt1Zw7LgR++subo25jY+vJ5mZLxk/c+2WFGyCqFmjNA3sUmOENbP2+bJOt+Aw==
Date: Thu, 15 Feb 2024 23:38:17 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <CAO_smVioz0izmunDRyHjU_7GGz-_Om_6AVw2CZGFyb4ZF8yedg@mail.gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <CAO_smVioz0izmunDRyHjU_7GGz-_Om_6AVw2CZGFyb4ZF8yedg@mail.gmail.com>
Message-ID: <e02b953f3320eff7d6ae2ecf684c8be2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Kyle,

On 2024-02-15 23:31, Kyle Lippincott wrote:
> On Thu, Feb 15, 2024 at 10:43 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Move the descriptions of the <oldbranch> and <newbranch> arguments to 
>> the
>> descriptions of the branch rename and copy operations, where they 
>> naturally
>> belong.  Also, improve the descriptions of these two branch operations 
>> and,
>> for completeness, describe the outcomes of forced operations.
>> 
>> Describing the arguments together with their respective operations, 
>> instead
>> of describing them separately in a rather unfortunate attempt to 
>> squeeze more
>> meaning out of fewer words, flows much better and makes the 
>> git-branch(1)
>> man page significantly more usable.
>> 
>> The subsequent improvements shall continue this approach by either 
>> dissolving
>> as many sentences from the "Description" section into the "Options" 
>> section,
>> or by having those sentences converted into some kind of more readable 
>> and
>> better flowing prose, as already discussed and outlined. [1][2]
>> 
>> [1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
>> [2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> 
>> Notes:
>>     This patch was originally named "branch: clarify <oldbranch> and 
>> <newbranch>
>>     terms further", submitted and discussed in another thread, [3] but 
>> the nature
>>     of the patch has changed, causing the patch subject to be adjusted 
>> to match.
>> 
>>     Consequently, this is effectively version 2 of the patch, which 
>> includes
>>     detailed feedback from Kyle and Junio, who suggested moving/adding 
>> the
>>     argument descriptions to their respective commands.  This resulted 
>> in more
>>     significant changes to the contents of the git-branch(1) man page, 
>> in an
>>     attempt to make it more readable.
>> 
>>     [3] 
>> https://lore.kernel.org/git/e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org/T/#u
>> 
>>  Documentation/git-branch.txt | 44 
>> +++++++++++++++---------------------
>>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> Thanks! I think this is a great improvement to this document.

Thank you, I'm glad that you like it. :)

>> diff --git a/Documentation/git-branch.txt 
>> b/Documentation/git-branch.txt
>> index 0b0844293235..370ea43c0380 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -72,16 +72,6 @@ the remote-tracking branch. This behavior may be 
>> changed via the global
>>  overridden by using the `--track` and `--no-track` options, and
>>  changed later using `git branch --set-upstream-to`.
>> 
>> -With a `-m` or `-M` option, <oldbranch> will be renamed to 
>> <newbranch>.
>> -If <oldbranch> had a corresponding reflog, it is renamed to match
>> -<newbranch>, and a reflog entry is created to remember the branch
>> -renaming. If <newbranch> exists, -M must be used to force the rename
>> -to happen.
>> -
>> -The `-c` and `-C` options have the exact same semantics as `-m` and
>> -`-M`, except instead of the branch being renamed, it will be copied 
>> to a
>> -new name, along with its config and reflog.
>> -
>>  With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
>>  specify more than one branch for deletion.  If the branch currently
>>  has a reflog then the reflog will also be deleted.
>> @@ -128,18 +118,28 @@ Note that 'git branch -f <branchname> 
>> [<start-point>]', even with '-f',
>>  refuses to change an existing branch `<branchname>` that is checked 
>> out
>>  in another worktree linked to the same repository.
>> 
>> --m::
>> ---move::
>> -       Move/rename a branch, together with its config and reflog.
>> +-m [<oldbranch>] <newbranch>::
>> +--move [<oldbranch>] <newbranch>::
>> +       Rename an existing branch <oldbranch>, which if not specified 
>> defaults
>> +       to the current branch, to <newbranch>.  The configuration 
>> variables
> 
> Very minor nit: the prevailing style in this document appears to be to
> have a single space after the period, but it's definitely
> inconsistent. I don't see anything in Documentation/CodingGuidelines
> suggesting one way or the other, so don't consider this comment as
> blocking, just informational. If we want to achieve (eventual)
> consistency, we may want to use a single space after the period now.

In this case, I went with following the intersentence spacing used in
the surrounding text.  Though, my brain and muscle memory are kind of
hardcoded to use double spacing, which may not be as prevalent as a 
while
ago, but IMHO makes reading text rendered using a fixed-width font much
easier.  I can adjust if needed, of course.

>> +       for the <oldbranch> branch and its reflog are also renamed 
>> appropriately
>> +       to be used with <newbranch>.  Renaming fails if branch 
>> <newbranch>
>> +       already exists, but you can use `-M` or `--move --force` to 
>> overwrite
>> +       the files in existing branch <newbranch> while renaming.
>> 
>> --M::
>> +-M [<oldbranch>] <newbranch>::
>>         Shortcut for `--move --force`.
>> 
>> --c::
>> ---copy::
>> -       Copy a branch, together with its config and reflog.
>> +-c [<oldbranch>] <newbranch>::
>> +--copy [<oldbranch>] <newbranch>::
>> +       Copy an existing branch <oldbranch>, which if not specified 
>> defaults
>> +       to the current branch, to <newbranch>.  The configuration 
>> variables
>> +       for the <oldbranch> branch and its reflog are also copied 
>> appropriately
>> +       to be used with <newbranch>.  Copying fails if branch 
>> <newbranch>
>> +       already exists, but you can use `-C` or `--copy --force` to 
>> overwrite
>> +       the files in existing branch <newbranch> while copying.
>> 
>> --C::
>> +-C [<oldbranch>] <newbranch>::
>>         Shortcut for `--copy --force`.
>> 
>>  --color[=<when>]::
>> @@ -311,14 +311,6 @@ superproject's "origin/main", but tracks the 
>> submodule's "origin/main".
>>         given as a branch name, a commit-id, or a tag.  If this
>>         option is omitted, the current HEAD will be used instead.
>> 
>> -<oldbranch>::
>> -       The name of an existing branch.  If this option is omitted,
>> -       the name of the current branch will be used instead.
>> -
>> -<newbranch>::
>> -       The new name for an existing branch. The same restrictions as 
>> for
>> -       <branchname> apply.
>> -
>>  --sort=<key>::
>>         Sort based on the key given. Prefix `-` to sort in descending
>>         order of the value. You may use the --sort=<key> option
>> 
