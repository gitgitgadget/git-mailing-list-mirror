Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FF31F406
	for <e@80x24.org>; Thu, 17 May 2018 12:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEQMJ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 08:09:59 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42690 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEQMJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 08:09:58 -0400
Received: by mail-qt0-f196.google.com with SMTP id c2-v6so5365019qtn.9
        for <git@vger.kernel.org>; Thu, 17 May 2018 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTSJLlyEqpDlqsXAhvbff+vdAJMQmEtr2qGm+/y+gD4=;
        b=tIMMZWBjpUQ3Er+zr0XS0AonJuoy3rA36bs/2SOrZatFGV4S2TYk+NJVZTfvgYEPmO
         FdapSvF0SApMAHb7drPTHbNJocrPwDWEc+r3vcHIqhj0bKFErvYy/0my7sKyrr4Nug2M
         ONmDDm3AirqolmbLdHeAs3JP87oAINs/Yfb3mdj9uLn/Vkc4s6NA2usVuYNplxgmJLJa
         1c08Pw6Zd0oSaDnbah8mN/fN30MaDfMvOTrjbGUGykp00gmPLq5oQ07jRGBVIf0Cyaim
         TdvBSudV04e5GF5UtVFXSaFxKqMpkqj0vTLChXRr21umA6D7W/nWHOLHkqAHJ4yDtg+q
         Ldgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTSJLlyEqpDlqsXAhvbff+vdAJMQmEtr2qGm+/y+gD4=;
        b=eFDizrX8SFvnipwiIPXUL0WqrzTOIDC29B//QQXlTEFqAazW2JeEFNiYg0BVt9glk6
         efpkFSoMyWYZdUDO88DQN79tf9Go7yJhS4O7CsZhW+TofK/hd3AXoWmVWQo0xKjDboS3
         DLVfBS7lJf8pbbJ8fdXlAfMb5oOwnmYc4bwf5ghbqP2UiOcy0yQFw/+y4HPKBR3rFHog
         9pf/fY+NjmSPe/8pTtJns7n9n90PjQ/4A7l+BlZgis6ARlVkJTIA5dphZZ3QGfSRutHf
         bwlqpSjJlfwFCi8DhCNHoXAyaP3xD9DPsqA3L4SGkqD1+zzy6/m5WWn4s6DV5mleYdc9
         1YyA==
X-Gm-Message-State: ALKqPwdgdOVM5ajT+7ZmbdZRlu5A+OqKU4SvWkL02CFAJ/z4s7vcBdT4
        3OXDqwOQi7QAXAaIshR/qDGuG4bq
X-Google-Smtp-Source: AB8JxZraXRApIlgdqUW3XHzMyuFj8/WfgoCoI5+CKVB/5SIZsxd9H5mfkthMgh8PdHKWoKUma0fBhQ==
X-Received: by 2002:ac8:396f:: with SMTP id t44-v6mr4901051qtb.22.1526558997438;
        Thu, 17 May 2018 05:09:57 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e56-v6sm3895494qte.52.2018.05.17.05.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 May 2018 05:09:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] unpack_trees_options: free messages when done
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com>
 <CABPp-BFtMQMK_4RAQk=XHoXdFYDxkvwz-Gws9Fz-0DdcfiJKcg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <af7af988-33d8-4237-8653-2020daf5d4c2@gmail.com>
Date:   Thu, 17 May 2018 08:09:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFtMQMK_4RAQk=XHoXdFYDxkvwz-Gws9Fz-0DdcfiJKcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/16/2018 5:54 PM, Elijah Newren wrote:
> Hi Martin,
> 
> On Wed, May 16, 2018 at 9:30 AM, Martin Ågren <martin.agren@gmail.com> wrote:
>> On 16 May 2018 at 16:32, Elijah Newren <newren@gmail.com> wrote:
>>> On Sat, Apr 28, 2018 at 4:32 AM, Martin Ågren <martin.agren@gmail.com> wrote:
>>>> As you noted elsewhere [1], Ben is also working in this area. I'd be
>>>> perfectly happy to sit on these patches until both of your contributions
>>>> come through to master.
>>>>
>>>> [1] https://public-inbox.org/git/CABPp-BFh=gL6RnbST2bgtynkij1Z5TMgAr1Via5_VyteF5eBMg@mail.gmail.com/
>>>
>>> Instead of waiting for these to come through to master, could you just
>>> submit based on the top of bp/merge-rename-config?
>>
>> Sure, here goes. This is based on bp/merge-rename-config, gets rid of
>> all leaks of memory allocated in `setup_unpack_trees_porcelain()` and
>> cuts the number of leaks in the test-suite (i.e., the subset of the
>> tests that I run) by around 10%.
> 
> Awesome, thanks.  I've looked over patches 2 & 3; they look good to me.
> 

I like the symmetry of the naming and locality of the functions.  Should 
help people remember to keep the xstrfmt() and associated free() in 
sync.  Patches look good to me as well.
