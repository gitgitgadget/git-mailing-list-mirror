Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF8AC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbiCaQya (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiCaQy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:54:29 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0DA231ADB
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:52:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e15-20020a17090ab38f00b001c9989ae56cso2160927pjr.9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=UqE+NxQx2RB66+B5OWkm3DS+ETdxZpjFPNxv++SLqF4=;
        b=aCkd6m7UReVYQzUh4/Q70x4BYXy+KKXD7xouROT2E87DmuiYDoESRS3iWfMXxUjPXU
         6d7I1Id+HHCKVLeqkdnEvRIZSg6L4vQLA2PyuPXIFNJiZpdxZczWCnBBRbzFxWnBG6dS
         yCfQ/lI6DhWnqDJmrQiuosoJKUyHVQkaoBiXRDN+hCcyIvpbipl3c2B1Mb5q3Bo2HyC+
         H6NVToKFF6i6dujixIFCGfYniV0RyqqWYGfPxuN6gQNiRqoYYabMptFzyyDp3gD6rVNU
         R1t8UGIUW/3eYQpoOWGEeAx16talzAqdxb8K/HCBIRKpfbNXVYy0WcXedocHCHWNuefw
         p8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=UqE+NxQx2RB66+B5OWkm3DS+ETdxZpjFPNxv++SLqF4=;
        b=FVOsya3uozqZOWMRoWJjP0PIZh/le+cNy80AxXw40QKdydCFqQpSXv7qsPJw9unoSA
         7gjO2kqYw4YUdIzgHiG0IkvLWG5pDYLwxSchBia7tRX7+qlqozAaSvvNcplkvd4rvGN2
         d9683Jj0zpY4eq/JbFFbcfOF4C5aD4/tEd+r0J8bTF+UfTEr9R6rXwiAV9ONIHokR1Xw
         Uqnke7LE9Z1wA+pklqBtqRFOZ1tomhu3odHmgk4bKYbOCNDbh5XpuJPniWFc4Y4tygHA
         5OHTxJ0kNDT7aIAMnAHNNB9dTyPNDTOdSABlfKEUvTxZtSGYryTHASWTfyhCEVQ9DByG
         h0zQ==
X-Gm-Message-State: AOAM532RyizQOdd8TOWDwrF1P7R5oWTRo7rJrKfpsgPO2SBq7Gv3Va+g
        +Pwnm/yfhPuxePWNM0HS2LE+dLVq8uXHRw==
X-Google-Smtp-Source: ABdhPJyaL2ObzlOl8r36KJCbmMV5l2SbodlaSpOr9wCKrx7gKkoZns0ayEGyz+MzxhcTR9Nr1KR2xFwVWtNX3Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8d47:0:b0:4f6:a7f9:1ead with SMTP id
 s7-20020aa78d47000000b004f6a7f91eadmr6363572pfe.42.1648745561604; Thu, 31 Mar
 2022 09:52:41 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:52:38 -0700
In-Reply-To: <220331.867d8bt6i6.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l1qyit67d.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
 <8e6ea3478b376b24835f3a3fef7fca39bed0afec.1648584079.git.gitgitgadget@gmail.com>
 <220331.867d8bt6i6.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 3/4] branch --set-upstream-to: be consistent when advising
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 29 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>>
>> "git branch --set-upstream-to" behaves differently when advice is
>> enabled/disabled:
>>
>> |                 | error prefix | exit code |
>> |-----------------+--------------+-----------|
>> | advice enabled  | error:       |         1 |
>> | advice disabled | fatal:       |       128 |
>>
>> Make both cases consistent by using die_message() when advice is
>> enabled (this was first proposed in [1]).
>>
>> [1] https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.=
com
>
> Thanks for following up on this :)

:)

>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  branch.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 133e6047bc6..4a8796489c7 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -389,9 +389,10 @@ static void dwim_branch_start(struct repository *r,=
 const char *start_name,
>>  	if (get_oid_mb(start_name, &oid)) {
>>  		if (explicit_tracking) {
>>  			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
>> -				error(_(upstream_missing), start_name);
>> +				int code =3D die_message(_(upstream_missing),
>> +						       start_name);
>>  				advise(_(upstream_advice));
>> -				exit(1);
>> +				exit(code);
>>  			}
>>  			die(_(upstream_missing), start_name);
>>  		}
>
> This is really close to being much better, i.e. we can now just do this
> (this is on top of your branch):
> =09
> 	diff --git a/branch.c b/branch.c
> 	index eb231b950bb..5b648cb27ed 100644
> 	--- a/branch.c
> 	+++ b/branch.c
> 	@@ -342,8 +342,6 @@ static int validate_remote_tracking_branch(char *ref=
)
> 	=20
> 	 static const char upstream_not_branch[] =3D
> 	 N_("cannot set up tracking information; starting point '%s' is not a br=
anch");
> 	-static const char upstream_missing[] =3D
> 	-N_("the requested upstream branch '%s' does not exist");
> 	 static const char upstream_advice[] =3D
> 	 N_("\n"
> 	 "If you are planning on basing your work on an upstream\n"
> 	@@ -388,13 +386,11 @@ static void dwim_branch_start(struct repository *r=
, const char *start_name,
> 	 	real_ref =3D NULL;
> 	 	if (get_oid_mb(start_name, &oid)) {
> 	 		if (explicit_tracking) {
> 	-			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
> 	-				int code =3D die_message(_(upstream_missing),
> 	-						       start_name);
> 	-				advise(_(upstream_advice));
> 	-				exit(code);
> 	-			}
> 	-			die(_(upstream_missing), start_name);
> 	+			int code =3D die_message(_("the requested upstream branch '%s' does =
not exist"),
> 	+					       start_name);
> 	+			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
> 	+					  _(upstream_advice));
> 	+			exit(code);
> 	 		}
> 	 		die(_("not a valid object name: '%s'"), start_name);
> 	 	}
> =09
> I.e. the only reason we needed to mention upstream_missing multiple
> times is because we didn't have something like die_message() before, now
> we can just skip that other "die" entirely.

Oh, good point. Yeah I like this better, I'll do that.

> The advise_if_enabled() might be worthwhile to change while at it, maybe
> not.

I think it's worthwhile; this does exactly what we want. I would have
used it if I had known it existed.

>
> But also useful, is that we can now simply inline the "upstream_missing"
> string, which will give us type checks for the printf format. The reason
> we had a variable before was also because of the lack of die_message()>
>
> I notice that we can do likewise with the advice itself, and with
> "upstream_not_branch" if we either make that a "goto", or add a trivial
> helper function.

Interesting, I hadn't considered type checking. So in general we prefer
to inline the strings and not use variables? I'll keep that in mind.
