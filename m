Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57751C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbhLBTb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhLBTb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 14:31:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA0C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 11:28:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so964397wrb.3
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 11:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dDcOBEbERWViuDOtdwyjUWfP07O8m6Oc6Pv+w2YbKrw=;
        b=j8WXMbaOVleWJ8gmbGYjmcxv9fTBaZjNLWFdPJyxuKgwD8baJM0QEcGP0v9unfGxWb
         fkRGx1RV0/QdAQ17W6nknn1gjbpo9P4CmUL9m3IAtGpdKOKcK8s0bBXThP05pNOQGrra
         f5nTjJ/OOyCUOEKzt30YPGNiiswuktgHCBE/6d6SDyvZTsvgUPfwA3WjzNdw+zLVMD7j
         BaRO+VI+WB4lHFlnWmN0FqXWlb8ke5BWv08lrob7bq9H4eSyIDPxM4FwsRq2n4zs/tG7
         1p8yfxfkzlIIGbLPx1kd2143eHUDd8g+rDt4ScPmjSTIz7cArxS5WkqKqeJ632XA5kX+
         AIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dDcOBEbERWViuDOtdwyjUWfP07O8m6Oc6Pv+w2YbKrw=;
        b=SRV7Fjnf+3eRMmEgnO+l6xx2H5oCtiwQD7efcLXnvDskO59g+Tqh2B8Jw1Uk9k06bY
         c+xamlH33ugbha+DLUYBuTYcZ7fl6fB2Fy1KBgZy0Ihz8BvdrVaZ+OLOEEQ2XAnwmDeW
         SJUZGlPPETgtWDs5CNlN7d2w6AbA+HXY3l3neogLi6ogbGTY3ZH3LaYOE5FOwhjUso0g
         neC5KRFnhtmDnjYCKUwUsgjsjviuczGGbbenyONkWplJiY4HjkAySbn0jCEIq3UPWzIz
         OtqafuBP6YlgWLvrTDTvbhWK4AhbhTOYZNKxNKqrFom2fMJTsKBMVnPFsMJAn7d4IMHg
         jedg==
X-Gm-Message-State: AOAM532QalPpZHtnCUo1AnpTq9+ZgEpL/V9CPGLzbGkboBhQ8XpuyPn0
        s/z0t1289KI39zCyUtW1Bfk=
X-Google-Smtp-Source: ABdhPJwyDil7f18VsjOmZAeCzsOP0W2m/ZXChDG22TmfirC3fmAcrAUCiwbrZbzH86un1aCLoY7tYg==
X-Received: by 2002:a5d:5385:: with SMTP id d5mr15999137wrv.132.1638473283999;
        Thu, 02 Dec 2021 11:28:03 -0800 (PST)
Received: from szeder.dev (78-131-17-57.pool.digikabel.hu. [78.131.17.57])
        by smtp.gmail.com with ESMTPSA id n4sm779864wri.41.2021.12.02.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:28:03 -0800 (PST)
Date:   Thu, 2 Dec 2021 20:28:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] t1510: remove need for "test_untraceable", retain
 coverage
Message-ID: <20211202192802.GC1991@szeder.dev>
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <patch-v2-1.2-91402624777-20211201T200801Z-avarab@gmail.com>
 <20211202191635.GB1991@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202191635.GB1991@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 08:16:35PM +0100, SZEDER Gábor wrote:
> On Wed, Dec 01, 2021 at 09:11:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > Amend the tests checking whether stderr is empty added in
> > 4868b2ea17b (Subject: setup: officially support --work-tree without
> > --git-dir, 2011-01-19) work portably on all POSIX shells, instead
> > suppressing the trace output with "test_untraceable" on shells that
> > aren't bash.
> > 
> > The tests that used the "try_repo" helper wanted to check whether git
> > commands invoked therein would emit anything on stderr. To do this
> > they invoked the function and redirected the stderr to a "message"
> > file.
> > 
> > In 58275069288 (t1510-repo-setup: mark as untraceable with '-x',
> > 2018-02-24) these were made to use "test_untraceable" introduced in
> > 5fc98e79fc0 (t: add means to disable '-x' tracing for individual test
> > scripts, 2018-02-24).
> > 
> > It is better to have the "try_repo" function itself start with a
> > "test_when_finished 'rm stderr'", and then redirect the stderr output
> > from git commands it invokes via its helpers to a "stderr" file.
> > 
> > This means that if we have a failure it'll be closer to the source of
> > the problem, and most importantly isn't incompatible with "-x" on
> > shells that aren't "bash".
> > 
> > We also need to split those tests that had two "try_repo" invocations
> > into different tests, which'll further help to narrow down any
> > potential failures. This wasn't strictly necessary (an artifact of the
> > use of "test_when_finished"), but the pattern enforces better test
> > hygiene.
> > 
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > ---
> >  t/t1510-repo-setup.sh | 83 +++++++++++++++++++++----------------------
> >  1 file changed, 40 insertions(+), 43 deletions(-)
> > 
> > diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> > index 591505a39c0..f1748ac4a19 100755
> > --- a/t/t1510-repo-setup.sh
> > +++ b/t/t1510-repo-setup.sh
> > @@ -40,9 +40,6 @@ A few rules for repo setup:
> >      prefix is NULL.
> >  "
> >  
> > -# This test heavily relies on the standard error of nested function calls.
> > -test_untraceable=UnfortunatelyYes
> > -
> >  TEST_PASSES_SANITIZE_LEAK=true
> >  . ./test-lib.sh
> >  
> > @@ -62,7 +59,7 @@ test_repo () {
> >  			export GIT_WORK_TREE
> >  		fi &&
> >  		rm -f trace &&
> > -		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
> > +		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null 2>>stderr &&
> 
> I suspect that it's lines like this that make Peff argue for
> BASH_XTRACEFD :)
> 
> While this is not a compound command, it does contain a command
> substitution, and the trace generated when executing the command in
> that command substitution goes to the command's stderr, and then,
> because of the redirection, to the 'stderr' file.
> 
> I find it suspicious that this doesn't trigger a failure in a
> 'test_must_be_empty stderr' later on.

Ah, that's because this hunk is executed in a subshell that starts
with 'cd "$1"', creating an extra 'stderr' file in a subdirectory:

  $ ./t1510-repo-setup.sh -r 1 -d
  [...]
  $ find trash\ directory.t1510-repo-setup/ |grep stderr
  trash directory.t1510-repo-setup/0/stderr
  trash directory.t1510-repo-setup/0/sub/stderr

Changing that redirection to '2>>"$TRASH_DIRECTORY"/stderr' makes a
bunch of tests fail with:

  + test_must_be_empty stderr
  'stderr' is not empty, it contains:
  + pwd
  error: last command exited with $?=1
  + rm stderr
  not ok 1 - #0: nonbare repo, no explicit configuration


