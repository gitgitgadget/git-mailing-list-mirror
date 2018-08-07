Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEEA208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 17:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbeHGTqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:46:48 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:62054 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388865AbeHGTqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 15:46:48 -0400
Received: from [192.168.2.201] ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id n5pLfmfWYwhzSn5pLfFahW; Tue, 07 Aug 2018 18:31:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533663084;
        bh=BXPg8ImiijhPh4YU4Jeh+EtUpDd4rtlA4NeT3NqrJXE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oMxHa1H21DR2VmKyKjO20E2DdUAw5g5XDWkrf0lFbwVEmEmwqzHqRaQwpOhUJa/nJ
         X4vTEUGpf7t4Lm9BlwnUMZyUkUlnz/bVYbbdMayZpNhOa2NQp+MuMTTq/KO1BmEtIR
         jDXjwie4F1/kyxMKovJsFQSkPhiySm4Sc7dJFevo=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=qqZBpEShL-AGZSkJ2sEA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com>
 <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
 <CAP8UFD3KbDrvU3zj24F7FF9ui2X75Vih4CoYE=cCZEWMsKP9Fw@mail.gmail.com>
 <6832700d-d7be-1df1-8b24-6e0290de63ed@talktalk.net>
 <CAP8UFD2_oxn=auXb1tYCb5xED5YmKU3W=fCrpMsyxdZBfs2qcw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1424a96b-26e8-aaa8-8e3c-ed84d58c26af@talktalk.net>
Date:   Tue, 7 Aug 2018 18:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2_oxn=auXb1tYCb5xED5YmKU3W=fCrpMsyxdZBfs2qcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIHGEo6lRJk1IYiEPAHWfUY6pLc6HTwTlq77/DqKeQ5aqEF6p7FolRSv2+1kD/7G79e6RAazBJhLNsmKfJHkwyevpVBvm0sG1rGQCWjsX3ZRgfWi1SOe
 +H2pKeKnS6t9LQ7CPDGz4se5VDBixGt07zF69svrby02LMYdLhMZMdf1UkkF4FSz6hhwg4GxUEXcYdapCOd+S8ScfTQoxK8MkgR7Rio/7mh3SP8ZJWceaOnP
 +9xhgjcU6+uzLIbJOULraGF6ac52e1C5YbY6NasXbEZMzIQMR82QGf6gHaRrFm2OqDdqczi8y3rS80aykQs5q1Si4Ck/oEYkgYFQdBzO1Mcn/I6oWZ5zksET
 5bcbzlRcOBNhI17ELvTg1nsiqGr00eDWQoJL2tMyoCMz/ETeJbAd8E/l6ZNbgZMadqSBkwDY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian
On 07/08/18 17:28, Christian Couder wrote:
> On Tue, Aug 7, 2018 at 6:15 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> On 07/08/18 16:25, Christian Couder wrote:
>>>
>>> I agree about checking the return value from fputs(), but it seems to
>>> me that we don't usually check the value of fclose().
>>
>> A quick grep shows you're right, there are only a handful of places where
>> the return value of fclose() is checked (there aren't many checks for the
>> return value of close() either), I'm don't think that is safe though given
>> that write errors may only show up when the file gets flushed by closing it.
> 
> I vaguely remember we tried to check those return values but it didn't
> work well sometimes.
> 

I think there's no point in checking the return value after a successful
read, or when writing and the file is being closed (and then possibly
removed) in some clean-up in an error path, but if the code cares about
ensuring the data is written then I think it should be checking the
return value, close_tempfile_gently() does for example.

In the sequencer code there are some examples where it probably should
be checking the return value, and places such as rewrite_file() and
write_message() (which uses the lockfile api) where the return code is
checked (there are a couple of recently added callers of write_message()
in the code to recreate octopus merges that don't check its return value
but all the other callers do).

Best Wishes

Phillip
