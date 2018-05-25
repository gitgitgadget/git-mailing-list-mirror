Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361701F42D
	for <e@80x24.org>; Fri, 25 May 2018 01:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972097AbeEYBXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 21:23:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39048 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965157AbeEYBXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 21:23:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id w18-v6so6315927wrn.6
        for <git@vger.kernel.org>; Thu, 24 May 2018 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WEkvYap9K72+trewSVTHWQqWJarStP8/M8sqB4aZWLI=;
        b=VuzhIGRLKvghmUXc0fEtyF0Fps+G+D1iKhmmbOHYc67DYa9dsnn44q8GAZMsfOlDCC
         +9AuRUyKu0FL96bWJRwUhjJfkaJWlFkQC7DygoiGjqb4Z6ImFTQ+eLlCFLzclZHcUvDb
         BkYKlNKqLDK69g3Nq1M0hstx5SPhEquGj3rAGLa1k6hYdJpCxc9hg2liBO0T8/A/3yiD
         qR2knO6ZahpaveHGThH5fumZw3kilrcRctWZU6HOiMUofWBEN+GSljIWUlWdX6dkZm7v
         Mhx+/VUNVmItcRZULrabuoU4cwOZbqvdSJaRhZVV7j1YvKnGTl9ePlzAz/V1iJ4jf0Xp
         ND6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WEkvYap9K72+trewSVTHWQqWJarStP8/M8sqB4aZWLI=;
        b=nl6Bnxc6F21U9pN15Zk/8PAeZCE8y06aAfp3MLKXNlsqgKyYsPSIrmrvHQoiRyUc2l
         kJAwu7FKhxkLQylQFxtLtUxPuMMfTroHK8XIY+dSFWmBFtZVbr6AR/moVd7JMamCo5iY
         tH+nhoeoPAWbi8FoSkNo1MoVLe8/WnFmns7CzJc7Y3LsRqcldrh24BpavggtuTHB8pZ9
         GqHks14temnlArsVw0mvVBFLVQQouSRePBEeCgkcI1rAH5Yyl83sxEjGWMuvUYiv4oLX
         ILI2aTdXgVF5z6FcXZXTO/9+OE1rXmE6ULVh7/t+oJx4JbAe8D39c+QCahwhMbIh/1SM
         UTWw==
X-Gm-Message-State: ALKqPwffYrmG1WLS/vaXf4jTlUjcP5Nupzb4wL2YZUMHKdmoRXF/cULw
        RDKsvEHTXX6RrWdEOnGS/Dg=
X-Google-Smtp-Source: AB8JxZo93X8zrT+Zw5TOaE/sjJ9xcSgJLMfwnO30rDLfhPwQKYnuNTUwW45Dz/3UJ2RK4M5mKEueaQ==
X-Received: by 2002:adf:abab:: with SMTP id s40-v6mr236577wrc.259.1527211056944;
        Thu, 24 May 2018 18:17:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q13-v6sm734683wmc.29.2018.05.24.18.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 18:17:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
References: <20180524070439.6367-1-newren@gmail.com>
        <20180524070439.6367-3-newren@gmail.com>
        <20180524100507.32305-1-szeder.dev@gmail.com>
Date:   Fri, 25 May 2018 10:17:35 +0900
In-Reply-To: <20180524100507.32305-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 24 May 2018 12:05:07 +0200")
Message-ID: <xmqqy3g8pm8g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> -		test 2 = $(git ls-files -s | wc -l) &&
>> -		test 2 = $(git ls-files -u | wc -l) &&
>> -		test 2 = $(git ls-files -o | wc -l) &&
>
> Here 'git ls-files -o' should have listed two untracked files ...
>
>> +		git ls-files -s >out &&
>> +		test_line_count = 2 out &&
>> +		git ls-files -u >out &&
>> +		test_line_count = 2 out &&
>> +		git ls-files -o >out &&
>> +		test_line_count = 3 out &&
>
> ... but now you expect it to list three.  I was about to point out the
> typo, but then noticed that you expect it to list one more untracked
> file than before in all subsequent tests...  now that can't be just a
> typo, can it?
>
> Please mention in the commit message that when using an intermediate
> file to store the output, 'git ls-files -o' will list that file, too,
> that's why the number of expected untracked files had to be adjusted;
> so future readers won't have to figure this out themselves.

I'd expect that a reader of the commit who cares enough to bother to
wonder by looking at the patch and seeing that 2 became 3 would know
why already.  And a reader of the resulting file would not know that
the 3 used to be 2, and won't be helped by "we used to count to 2,
now we have 'out' also counted" that much, especially in the commit
log message.  What would help the latter would be to name which
three paths we expect to see in the comment (or test against the
exact list of paths, instead of using test_line_count).

> An alternative to consider would be to add a .gitignore file in the
> initial commit to ignore 'out', then the number of untracked files
> don't have to be adjusted.

I think that is a preferred solution that we've used in ls-files and
status tests successfully.
