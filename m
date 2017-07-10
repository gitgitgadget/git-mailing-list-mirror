Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE0520357
	for <e@80x24.org>; Mon, 10 Jul 2017 19:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbdGJTxJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 15:53:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36766 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbdGJTxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 15:53:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so15846068pfk.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n24VxG5s0n0evqVmimG0m2HNKxHwFxtIn1vc4KUYWXM=;
        b=REm0IDQTVrBbzhyXsyKs0HA6x86bK3guf2pYwfaswfilr2ZHZTj2roppWTdrOZSDIJ
         xlBy67EuzHqQhY6nO8QxFx/6XsZroUKMDI0FZWn/WHN7pjwDEY6r6522hihToBuop8Rh
         rB70+0aK63nR/+vBDf0YNgByHeBtpeFlaeDufo1477uTRSaaNvvCWL1LRSi/uDZhZPVI
         tx/DOmkkBLbeKWKD6Qr2AsXUSalSWM4HKqwCfzij0+03cHaOtrIVnnOLot8ktyrJgsvg
         /22dIAumFpzAleXvj+f6Oxyr1W6pk7hjMom0bxoxT+5zWLlP4VSE3ykm12VON9KodV35
         ZSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n24VxG5s0n0evqVmimG0m2HNKxHwFxtIn1vc4KUYWXM=;
        b=YQGgpG6s8JM24Q0z5JlZu8ds/oS3n9jvdhAQA6c6IG1eTqSYfNo0wMjrBe/iLvGz9K
         IaaqHp//9n/77HIGrqjfnKS5njk/FO6v5+ar34sbBzyQAxaws8uXltR2tQMPq0bJQhF9
         GxkWuj68gNFTaY5ZzUG5FHZVQVDEPF9EzRuq4nB1/4jpS431LeFVzf+Zr+S9adIXrYFG
         41Pn0R6d2A2U/xwKidaOOIq04URD6L82wrkq3YgXVWjw6jVpk24Q8yANES9k+eczRyOz
         mxJ3IU7EOg2f8S2XTrIY/sJZQFosGwUUVgqJLpWvjCmwTwMtiyaX9u/MA99RiVsgd4rB
         GqAw==
X-Gm-Message-State: AIVw1122EShlutmUrFHTqNpaUHjLk+hscPfGnodZGlTWUQI46Ih7cOCI
        bsvLMOby0OCxEQ==
X-Received: by 10.99.127.23 with SMTP id a23mr16364305pgd.47.1499716387775;
        Mon, 10 Jul 2017 12:53:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id o13sm20865147pgr.40.2017.07.10.12.53.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 12:53:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] hook: add signature using "interpret-trailers"
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
        <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
        <20170710141744.8541-3-kaarticsivaraam91196@gmail.com>
        <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
Date:   Mon, 10 Jul 2017 12:53:06 -0700
In-Reply-To: <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 10 Jul 2017 16:13:39 +0100")
Message-ID: <xmqqfue45asd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> It works well in all cases except when the user invokes
>> "git commit" without any arguments. In that case manually
>> add a new line after the first line to ensure it's consistent
>> with the output of "-s" option.
>> 
>
> Again, s/signature/sign-off/g, or similar (including subject line).

Thanks for being a careful reader.

>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> ---
>>  templates/hooks--prepare-commit-msg.sample | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
>> index 708f0e92c..a15d6d634 100755
>> --- a/templates/hooks--prepare-commit-msg.sample
>> +++ b/templates/hooks--prepare-commit-msg.sample
>> @@ -32,4 +32,8 @@ SHA1=$3
>>  # esac
>>  
>>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>> -# grep -qs "^$SOB" "$COMMIT_MSG_FILE" || echo "$SOB" >> "$COMMIT_MSG_FILE"
>> +# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
>> +# if test -z "$COMMIT_SOURCE"
>> +# then
>> +#   @PERL_PATH@ -i.bak -pe 'print "\n" if($first_line++ == 0)' "$COMMIT_MSG_FILE"
>> +# fi

I think we should do

	print "\n" if !$first_line++

for brevity (and also avoid "if(" that lacks SP) here.

