Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CDCC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIHUsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIHUsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:48:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF1EB2D5
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:48:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 202so17840023pgc.8
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=YGmpNg1FvERVFo8hPF2xBj6ef2B25652e/UCMAXGfs8=;
        b=JrcHHgtJoNXvXgDJTpw8/xAKa0VhOIcvVC7leFj3yH71PWhrK5E7h5sgfRvXNpZqiX
         g3uF+QrGS0uFE6Rjg/JlDt7kQr8R1NTJFjonJAu+VvrUTZGvkoCQCRSL7yfxKjWDxtkg
         JPx1r7zIjlM70zlBmrS0QW3zbWWt9sXLShNOkTdxwkMnbGGkrQ1ynpHVRq8dJ0MM26/P
         RB8bLf/PzsjFdhuWJYeq7jw2MLLpPQz+lhFPmUsDZd8UtxdKKlVbRoQ3QQ39i/uAIDc9
         gVzXL+Dkn3agTDdJqnDY5XvsMf+G5Cd8JnBGR1feJ0A6p3J/PM44FOPQyIET7BE26p9Y
         x7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=YGmpNg1FvERVFo8hPF2xBj6ef2B25652e/UCMAXGfs8=;
        b=nEO8eR1okAKt3b2ppP+EbX3FQ4Icw4XLzXgY6xQS8QKRKKKcfznF/ahAq/drAaEyfs
         RtiMJQbuDNPU0I8jfDV98y5qy1pAQfAUITr1gXFdDsDjLbT9u9Ym/+250xhTVXSiZipL
         TtFhRbfkmJKoekfVHKRgFTDy3IlFSVqg32IYRHwLBQn5aykbvdMzDsD3CzFIPT3lc9tT
         /ZzNXtrFJo25U1j8wxNQeeUOeBEMFAxsW/bEnK06px4EkZqRQ8D+rmIONWQ7ZthQBdMw
         4S4+mDGw3AZ1vwivY6FrlVVutGDeSxXTjelvIaqrHtC1Bjawh6jVH5N4UyE/OIFyg51R
         cfYw==
X-Gm-Message-State: ACgBeo1/0XaNYYq7CZEI8QBXOPCZHYYkd6hT+sdg14QONvp+YfSGNmvw
        n/Y6I5UB9oT9fl7zZXFm9Ks=
X-Google-Smtp-Source: AA6agR7fTm1q8bNuQtl55ILsKZZ00nPmjkK8/9uJ8okkck1vkJHGYuW82tuiY/pXviDclG2ixQj6qA==
X-Received: by 2002:a05:6a00:17a3:b0:540:97a3:f7a9 with SMTP id s35-20020a056a0017a300b0054097a3f7a9mr4169859pfg.12.1662670118954;
        Thu, 08 Sep 2022 13:48:38 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b001753654d9c5sm15204297plg.95.2022.09.08.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:48:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lana Deere <lana.deere@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: add branch.*.merge to default ref-prefix
 extension
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
        <YxpB0dbFTKp5L94k@coredump.intra.peff.net>
        <xmqq1qslpprv.fsf@gitster.g>
Date:   Thu, 08 Sep 2022 13:48:38 -0700
In-Reply-To: <xmqq1qslpprv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        08 Sep 2022 13:36:20 -0700")
Message-ID: <xmqqtu5hoamx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, is strvec_push() a correct thing to use here?  ref_prefixes will
> receive something like 'master' here, without 'refs/heads/master'
> getting pushed, when "branch.*.merge = master"?  Given that the
> advertisement restriction is merely an optimization, I wouldn't be
> surprised if 'master' in .ref_prefixes strvec is further expanded
> by an unnecessary extra call to expand_ref_prefix() later to cause
> the server side to advertise refs/heads/master and refs/tags/master
> etc., but it smells, eh, bad.
>
>>  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
>>  		must_list_refs = 1;
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 081808009b..0b72112fb1 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -218,6 +218,23 @@ test_expect_success 'fail if upstream branch does not exist' '
>>  	test_cmp expect file
>>  '
>>  
>> +test_expect_success 'fetch upstream branch even if refspec excludes it' '
>> +	# the branch names are not important here except that
>> +	# the first one must not be a prefix of the second,
>> +	# since otherwise the ref-prefix protocol extension
>> +	# would match both
>> +	git branch in-refspec HEAD^ &&
>> +	git branch not-in-refspec HEAD &&
>> +	git init -b in-refspec downstream &&
>> +	git -C downstream remote add -t in-refspec origin "file://$(pwd)/.git" &&
>> +	git -C downstream config branch.in-refspec.remote origin &&
>> +	git -C downstream config branch.in-refspec.merge refs/heads/not-in-refspec &&

Ah, OK, so the breakage may be the other way around.

The new code assumes that branch.<name>.merge is a full refname, and
strvec_push() is the right thing to do, when we add the knowledge
that the current branch we are on by default merges with their
refs/heads/frotz.  We just ask them to advertise refs/heads/frotz
and they do not need to advertise refs/tags/frotz etc. let alone
refs/tags/refs/heads/frotz so using expand_ref_prefix() here is
wrong.

It means that the patch claims that remote.c::branch_merge_matches()
assume that branch->merge[i]->src may not be a full refname by
calling refname_match() on it, which is incorrect and may need to be
corrected.  But that is totally outside the scope of this fix.

Thanks.
