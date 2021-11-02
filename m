Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A373C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F301B60EBC
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhKBPug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhKBPue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:50:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98353C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:47:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r12so77894684edt.6
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gcliNeaJjqqSxwm9qvngmAjhEd9zCzOmAv+7KxgM9dQ=;
        b=o01fvaZK76bRBkG1njKheLP+wjhaC3CUDygjiytQ1psXKVnJBGmkNy0uXNQdqIdNID
         7pt541uoJW79u0coi1agqWJaz7bucPIWH7jnDljvaFL6hg6xO9dr0knJNa44x+eiMNNN
         aW6gMWGZba+U6URXcQWtX9w0R8vQ4GAdCnY9+R3XQh/ov7NP9ftydjM2dA2q/OMo+I7a
         QnrEsbqUXEgANoSpmjAqyeCCvEt8Z0Rq496CP2QX6+MGgEYwU2ApUzgXYELk5k3a2wKP
         jcreThmlbIyiOUpuZ8jpChTxy8QKh1+UoUPodkQOVb36zTxKZdb9FrUzeAn4EIaLk2Qn
         fSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gcliNeaJjqqSxwm9qvngmAjhEd9zCzOmAv+7KxgM9dQ=;
        b=CxevJe5i3xU4Z2eKLeEzBtOHUU9A992wrltSU/i52kCFdGKW5pRConcGd6AwgARaMz
         clENiIUawIfFSO8/iLIYPk/NSR15ha4Ee/67bQGZ6iDeTDYtkZG6PPpfnDtLZcTNKMzA
         v19SaK9OZOscya8u8KfaKS2cKMNIJdIkB57xpayR2uYOuimlaHjqGj4JesS8lb2NfMgQ
         2nO+4Gclk6VF2VkyfjRSVZ4GoviWQqo1ZuICY3oRIKiAwqX/A133FhPTG3aHCybPtkF6
         FFDNci+zoGTf1+1KPnLOoJVmRX7mjL4/cKFrOB/B2A4EGSgnS5u9WZmGIZcy5O3PFCIo
         N10g==
X-Gm-Message-State: AOAM533PnpIiuBN9MtpNOhbCjDjprN9mOSBip3mfHOoCIWYtO0kFPr5p
        lrZFaWnDF5+9arBtQVwI9UY=
X-Google-Smtp-Source: ABdhPJzZPV885ULVbnFnWhyM9S8qpCxeVXJQbEMagPY0CUEH/QtxXMLDdV3KfuNIudW6O4+hO4LHcg==
X-Received: by 2002:a17:906:fa90:: with SMTP id lt16mr42535186ejb.95.1635868078056;
        Tue, 02 Nov 2021 08:47:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j15sm10971052edl.34.2021.11.02.08.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:47:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhw0y-002EMh-W8;
        Tue, 02 Nov 2021 16:47:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        newren@gmail.com, matheus.bernardino@usp.br, vdye@github.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
Date:   Tue, 02 Nov 2021 16:33:04 +0100
References: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq7ddr9z0i.fsf@gitster.g>
 <2f1d2e09-faf5-0caf-6be8-7bcede9fe8d1@gmail.com>
 <7a62be4e-aa69-8a79-4608-971b96ee4d7c@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <7a62be4e-aa69-8a79-4608-971b96ee4d7c@gmail.com>
Message-ID: <211102.86pmri1rv7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 02 2021, Derrick Stolee wrote:

> On 11/2/2021 9:42 AM, Derrick Stolee wrote:
>> On 11/1/2021 8:34 PM, Junio C Hamano wrote:
>>> Glen Choo <chooglen@google.com> writes:
>>>
>>>> This patch changes the behavior of .gitignore such that directories are
>>>> now matched by prefix instead of matching exactly.
>> 
>> Thank you for pointing out an unintended consequence.
>> 
>>>> The failure that we observed is something like the following:
>>>>
>>>> In "a/.gitignore", we have the pattern "git/". We should expect that
>>>> "a/git/foo" to be ignored because "git/" should be matched exactly.
>>>> However, "a/git-foo/bar" is also ignored because "git-foo" matches the
>>>> prefix.
>>>>
>>>> I'll prepare a test case for this as soon as I figure out how to write
>>>> it..
> ...
>> In the meantime, I'll try to create a Git test that demonstrates a
>> problem one way or another.
>
> I created a test, but had some trouble reproducing it due to some
> subtleties higher in the call stack. Here is a patch that reverts
> the change and adds some tests.
>
> The Scalar functional tests passed with the revert, so the original
> patch was worthless to begin with. I don't recall what motivated the
> change, but clearly it was a mistake. Sorry.
>
> ---- >8 ----
>
> From d1cfc8efeab015273bfebd6cd93465e6f38dc40f Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Tue, 2 Nov 2021 10:40:06 -0400
> Subject: [PATCH] dir: fix directory-matching bug
>
> This reverts the change from ed49584 (dir: fix pattern matching on dirs,
> 2021-09-24), which claimed to fix a directory-matching problem without a
> test case. It turns out to _create_ a bug, but it is a bit subtle.
>
> The bug would have been revealed by the first of two tests being added to
> t0008-ignores.sh. The first uses a pattern "/git/" inside the a/.gitignores
> file, which matches against 'a/git/foo' but not 'a/git-foo/bar'. This test
> would fail before the revert.
>
> The second test shows what happens if the test instead uses a pattern "git/"
> and this test passes both before and after the revert.
>
> The difference in these two cases are due to how
> last_matching_pattern_from_list() checks patterns both if they have the
> PATTERN_FLAG_MUSTBEDIR and PATTERN_FLAG_NODIR flags. In the case of "git/",
> the PATTERN_FLAG_NODIR is also provided, making the change in behavior in
> match_pathname() not affect the end result of
> last_matching_pattern_from_list().
>
> Reported-by: Glen Choo <chooglen@google.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c              |  2 +-
>  t/t0008-ignores.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index c6d7a8647b9..94489298f4c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1294,7 +1294,7 @@ int match_pathname(const char *pathname, int pathlen,
>  		 * then our prefix match is all we need; we
>  		 * do not need to call fnmatch at all.
>  		 */
> -		if (!patternlen && (!namelen || (flags & PATTERN_FLAG_MUSTBEDIR)))
> +		if (!patternlen && !namelen)
>  			return 1;
>  	}
>  
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 532637de882..1889cfc60e0 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -803,6 +803,32 @@ test_expect_success 'existing directory and file' '
>  	grep top-level-dir actual
>  '
>  
> +test_expect_success 'exact prefix matching (with root)' '
> +	test_when_finished rm -r a &&
> +	mkdir -p a/git a/git-foo &&
> +	touch a/git/foo a/git-foo/bar &&
> +	echo /git/ >a/.gitignore &&
> +	git check-ignore a/git a/git/foo a/git-foo a/git-foo/bar >actual &&
> +	cat >expect <<-\EOF &&
> +	a/git
> +	a/git/foo
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'exact prefix matching (without root)' '
> +	test_when_finished rm -r a &&
> +	mkdir -p a/git a/git-foo &&
> +	touch a/git/foo a/git-foo/bar &&
> +	echo git/ >a/.gitignore &&
> +	git check-ignore a/git a/git/foo a/git-foo a/git-foo/bar >actual &&
> +	cat >expect <<-\EOF &&
> +	a/git
> +	a/git/foo
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  ############################################################################
>  #
>  # test whitespace handling

We have t3070-wildmatch.sh testing various combinations of these, and
indeed this code resolves back to wildmatch().

But I think in this case this is due to dir.c's particular behavior of
splitting paths before feeding them to wildmatch, as it needs to match
things relative to the subdirectory.

Still, we've got a matrix of these in t3070-wildmatch.sh, which already
tests some (but apparently not all) cases where we need to create an
actual file on disk. These sorts of test blindspots are why I added that
in de8bada2bf6 (wildmatch test: create & test files on disk in addition
to in-memory, 2018-01-30).

Wouldn't it be better & more exhaustive here to change its test lines
like:


    match 0 0 1 1 foo/bar/baz 'bar'

To say:

    match 0 0 1 1 ? ? foo/bar/baz 'bar'

And just add to its match() function so that if we have a subject with a
slash, we mkdir up to that first slash (here: "mkdir foo"), and create a
.gitignore file therein with the "foo" directory with the "bar" content,
perhaps adding "/bar", "bar/" and "/bar/" variants implicitly.

Then create a "bar.txt" in the directory as well, and a
bar-otherdir/somefile.txt or whatever.

And fill in the "? ?" depending on whether those variants matched or
not...

Anyway, just an idea, but if you pursue that you should be able to get
much more exhaustive testing in this area that we've apparently had a
blindspot in.
