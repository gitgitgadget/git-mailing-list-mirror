Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6871F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbcIAVMU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:12:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753350AbcIAVMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:12:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99315392AA;
        Thu,  1 Sep 2016 17:12:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X/QO4BbC+8WzT+Y1l8FcAR33/LM=; b=U6i1v9
        WQijlRzJ+2qMw4BkUHuakhletTd0MdHWvA85mO171sk+jtTp8SpWmr5R679TNPLl
        Ey+iaM4QgFsqSzBw86IOb0q6tqDLud0T8KJfZSFx3G7QcAznAi9fPSTpUhGOIt7P
        xZuusGLhw5rt0o2cvWFQtOD+FKTg8R0j30tNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=srZAVzz8sFLwZKZd6kFREQ5yOkacGEJh
        gg0eYdChcHIhAiYmVBgSnff5qiO9ZdEF3vgmwHaAF5yXAjqmdftU5VGWv2UlGG34
        LabzlMQID/9wsb9Qq3t2UfOfflUyUCZwuqZ1yrCsLInAT8dFiY/MLYAmgH/cV+ie
        zDjY/O/jVTc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92077392A9;
        Thu,  1 Sep 2016 17:12:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20357392A7;
        Thu,  1 Sep 2016 17:12:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Uma Srinivasan <usrinivasan@twitter.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
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
        <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
        <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com>
        <xmqq4m5zwevl.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaVBX_zLsSwkz=d_JUfvkeYHyZ1kkYm7Ae_dGBfFarDCQ@mail.gmail.com>
Date:   Thu, 01 Sep 2016 14:12:14 -0700
In-Reply-To: <CAGZ79kaVBX_zLsSwkz=d_JUfvkeYHyZ1kkYm7Ae_dGBfFarDCQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 1 Sep 2016 14:04:07 -0700")
Message-ID: <xmqqlgzbuxxt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C27BA9DC-7088-11E6-B09C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +test_expect_success 'fetching submodule into a broken repository' '
>> +       # Prepare src and src/sub nested in it
>> +       git init src &&
>> +       (
>> +               cd src &&
>> +               git init sub &&
>> +               git -C sub commit --allow-empty -m "initial in sub" &&
>> +               git submodule add -- ./sub sub &&
>> +               git commit -m "initial in top"
>> +       ) &&
>
> This is not needed, as setup() set up some repositories for you.

I didn't want any random cruft left behind in the top-level by
previous tests, so this is very much deliberate.
