Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C54020193
	for <e@80x24.org>; Thu,  1 Sep 2016 21:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbcIAVMp (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:12:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55351 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757176AbcIAVKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2233A3797B;
        Thu,  1 Sep 2016 14:32:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kqbwaymas/sGQzc0M1vSH5tDudE=; b=q8MlvF
        FnDNWhy9zl/oDJ28qYQmv0i+qfBLwYXTud+0mVlG/xowzQYlHRunzdrX2Cb6Kdy5
        i9gCBz8pHNeBzNXkayMXFmBW4/zL8UXJNZFHngbb6wYKKrZHt2mPvGJFOCL+PmyY
        46i1SiNc5m2IP7G+aaTvUzJ5JDtD0+qa8FbYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pnDEQVqEacRl7R+gRbR1pS3giE2cF/3Q
        ZG14zGmXyn4c67WJyCt6ut/0v0VSMqIQDT4cS44yfNrcDQ+3sJhH3LHpFVx8Dz58
        xgt+9ECyNybG+xFmdno6Ks2v6ogNPUppYMrjVLazcLUSOmbbdrHBRLbDP02cgKg3
        OqHvYE75MZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ACF13797A;
        Thu,  1 Sep 2016 14:32:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F70F37979;
        Thu,  1 Sep 2016 14:32:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
        <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
        <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
        <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
        <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
        <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
        <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
        <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
        <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
Date:   Thu, 01 Sep 2016 11:32:25 -0700
In-Reply-To: <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
        (Uma Srinivasan's message of "Thu, 1 Sep 2016 09:05:28 -0700")
Message-ID: <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F3987F0-7072-11E6-ACD0-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uma Srinivasan <usrinivasan@twitter.com> writes:

> Yes, this one line fix addresses my problem.
>
> So, what is the next step? Will someone submit a patch or should I?
> Please note that I've never submitted a patch before, but I don't mind
> learning how to.

The final version needs to be accompanied with tests to show the
effect of this change for callers.  A test would set up a top-level
and submodule, deliberately break submodule/.git/ repository and
show what breaks and how without this change.

For example, there is a call in ok_to_remove_submodule() to run "git
status" in the submodule directory.  A test writer needs to find who
calls ok_to_remove_submodule() in what codepath (e.g. builtin/rm.c).
Then after figuring out under what condition the check is triggered,
write a test that runs "git rm" in a way that this change makes a
difference.  Hopefully, the test will fail without this change, and
will pass with this change.

So it is a bit more involved than just a single liner patch with one
paragraph log message.  I may be able to find or make some time
after I tag the 2.10 final this weekend to do so myself.

>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1160,4 +1160,5 @@ void prepare_submodule_repo_env(struct argv_array *out)
>>                 if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>>                         argv_array_push(out, *var);
>>         }
>> +       argv_array_push(out, "GIT_DIR=.git");
>>  }
>>

