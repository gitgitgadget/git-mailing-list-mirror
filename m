Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212FE1F461
	for <e@80x24.org>; Sat, 22 Jun 2019 11:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFVLYH (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 07:24:07 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24305 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVLYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 07:24:06 -0400
Received: from [192.168.1.22] ([89.243.184.39])
        by smtp.talktalk.net with SMTP
        id ee7nhKNKnWIpcee7ohNx4g; Sat, 22 Jun 2019 12:24:05 +0100
X-Originating-IP: [89.243.184.39]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=3GZFt4OQGy0NQQxJwP7nlQ==:117
 a=3GZFt4OQGy0NQQxJwP7nlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=fAO4vL-9AAAA:20 a=yMhMjlubAAAA:8 a=i26yTtmzlxz-QGRswo0A:9
 a=QEXdDO2ut3YA:10
Subject: Re: windows: error cannot lock ref ... unable to create lock
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
 <CAPig+cTFfhBz+xiq6VAMNOW4OTvByHJ1g5oF=RTTh_buA+nUQA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <98e1e1e5-c410-caf1-0e2f-9cb0cc6d7e94@iee.org>
Date:   Sat, 22 Jun 2019 12:24:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTFfhBz+xiq6VAMNOW4OTvByHJ1g5oF=RTTh_buA+nUQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfMbo60zGYGk7zDVYNtjKeH0a0JIPM2sMsmo0Qf0uggR1OELYmXUbK7/YBCNC46YSFc4qfT1pwAvGsAgDUrsm1RBGt72dowUk4bsOkzp701M6rwBmWzCG
 0AdInGTd2S7aLmVknthwyvDzK42Ff7ztkaEjMEJ29GVYn3tT+5f0XNc+myaSWymIh4ib5wO9SxPE7VRfO7F2p/TTCZFybIXbRLg3qG9KgeR4+8/JsX9hcbTu
 v+6cahYAb05j9djm2oJj+9HkhFgM7uny2CK+YfzqVdE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/06/2019 18:01, Eric Sunshine wrote:
> On Tue, Jun 18, 2019 at 12:39 PM Anthony Sottile <asottile@umich.edu> wrote:
>> + git fetch origin --tags
>> Unpacking objects: 100% (10/10), done.
>>  From https://github.com/asottile-archive/git-windows-branch-test
>>   * [new branch]      master     -> origin/master
>> error: cannot lock ref 'refs/remotes/origin/pr/aux': Unable to create
>> 'C:/Users/IEUser/x/x/.git/refs/remotes/origin/pr/aux.lock': No such
>> file or directory
>>   ! [new branch]      pr/aux     -> origin/pr/aux  (unable to update local ref)
> AUX is a reserved[1] filename on Windows. Quoting from that source:
>
>      Do not use the following reserved names for the name of a file:
>      CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7,
>      COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and
>      LPT9. Also avoid these names followed immediately by an
>      extension...
>
> The default Git "ref store" is filesystem-based, so a branch named
> "aux" is problematic. Other ref store implementations would not be
> subject to this limitation (though I'm not sure what the state of the
> others is -- someone with more knowledge can probably answer that).
>
> [1]: https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#naming-conventions
This sounds interesting. I thought (but I'm not certain) that Git for 
Windows avoided creating files in the working tree with such problematic 
names, so that a clone of a repo that contained a file "AUX" (any case, 
any extension IIRC), would be bypassed with possibly a warning message.

However this looks to be a slightly different case where a _branch_ 
called "AUX" (lower cased) has been created within the clone, and it's a 
problem not trapped. Maybe worth creating a proper issue on the 
Git-for-Windows repo. Also cc'ing Dscho who may remember better than I.
--
Philip
