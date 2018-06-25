Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DD91F516
	for <e@80x24.org>; Mon, 25 Jun 2018 15:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932156AbeFYP6Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 11:58:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35158 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeFYP6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 11:58:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id c13-v6so4272129wrq.2
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=inmd/E0gC5W91Jfsa/a7/hxgyDsuwKzJYWGyEEDfnGQ=;
        b=p+aw1pN0X9RJlbtI1fwLwKBfa1iOmMKpCDotGrKgzOe0QZpXEQzsDwNPIkooW4Pd2Y
         8zq+5sCnlnrD3KPDaxs8uOtL9MwYU6guGlc8A+mRjVjGE+gHUAkCcccZcm9uaRjwqdDu
         8x9d6DmIHpm5ZeoG2z7IbfR1oh9PcRqEa5q6R6+M36GISSmJwC9jexAZVMMLXHcv5GzR
         CxtCvHyVTpqDFHeRVjG3U5TlKaM3ol7NOVOL3ZVJPRhkzEJSpNbbfKX09PdtSk2xU0xF
         w9hjcHn5xOYO9dcUSi9NeZ15PwrCdeJMhfBWf6V5i0a5G4RkYmJR9zirtqfxHyvetyoA
         wmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=inmd/E0gC5W91Jfsa/a7/hxgyDsuwKzJYWGyEEDfnGQ=;
        b=lq0favI/uZEvph0OK1d5bSsgkkTZeFSNIHz3pthMrGNvjbYms5BGmHNGL12NuMUmZw
         BX0zDy9hoVmk+jyrP6pSpUSqkmcbEJe/ixH+sAWQgslz17TsS1MSU50EigfkLTNrkEHe
         pctxTeTIS6DDrgF1OLcPK+wJ3Z5nMJJp02uF/KrjpB2F5Mjrygq4VpzsnDl8pPX+bkf/
         ryZ5qVAPJD/RAyYJJV0LcqkUw9v/C4stP5VguQ8n/hEWNQaQ4sATPYe52jtwqwhEzSX+
         u3fse8Utz04DYKCY6QD/pdTeqN0K9kBdxlDXbohGNkBGCSEU042aajdKQaYan0qdqTeR
         LaoA==
X-Gm-Message-State: APt69E3LY3YYRuF7KckeCSCKxCfl3ySPK86rqn831w7OY0mJFUyaBoOV
        BlfQ5JlP8bTKAWJqgHIrJa4=
X-Google-Smtp-Source: AAOMgpd0knN+2KbHzvtRKyImIIVZn0kC34wPawKMZZOYORX60Rw4zspGJMf1+9pznM62wjVy87IuDg==
X-Received: by 2002:a5d:4902:: with SMTP id x2-v6mr10623132wrq.66.1529942301863;
        Mon, 25 Jun 2018 08:58:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s184-v6sm6495802wmf.5.2018.06.25.08.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:58:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule.c: report the submodule that an error occurs in
References: <20180620223253.226092-1-sbeller@google.com>
        <20180622081713.5360-1-szeder.dev@gmail.com>
Date:   Mon, 25 Jun 2018 08:58:20 -0700
In-Reply-To: <20180622081713.5360-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 22 Jun 2018 10:17:13 +0200")
Message-ID: <xmqqmuviq2n7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> When an error occurs in updating the working tree of a submodule in
>> submodule_move_head, tell the user which submodule the error occurred in.
>> 
>> The call to read-tree contains a super-prefix, such that the read-tree
>> will correctly report any path related issues, but some error messages
>> do not contain a path, for example:
>> 
>>   ~/gerrit$ git checkout --recurse-submodules origin/master
>>   ~/gerrit$ fatal: failed to unpack tree object 07672f31880ba80300b38492df9d0acfcd6ee00a
>> 
>> Give the hint which submodule has a problem.
>> 
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c               | 2 +-
>>  t/lib-submodule-update.sh | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/submodule.c b/submodule.c
>> index 939d6870ecd..ebd092a14fd 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
>>  	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
>>  
>>  	if (run_command(&cp)) {
>> -		ret = -1;
>> +		ret = error(_("Submodule '%s' could not be updated."), path);
>
> This is a translated error message ...
>
>>  		goto out;
>>  	}
>>  
>> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
>> index 1f38a85371a..e27f5d8541d 100755
>> --- a/t/lib-submodule-update.sh
>> +++ b/t/lib-submodule-update.sh
>> @@ -781,7 +781,8 @@ test_submodule_recursing_with_args_common() {
>>  		(
>>  			cd submodule_update &&
>>  			git branch -t invalid_sub1 origin/invalid_sub1 &&
>> -			test_must_fail $command invalid_sub1 &&
>> +			test_must_fail $command invalid_sub1 2>err &&
>> +			grep sub1 err &&
>
> ... so the test should use 'test_i18ngrep' to check it.

Thanks for being a careful reviewer, as always.

Will tweak locally to skip one round-trip.

