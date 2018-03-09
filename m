Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 780C31FAE2
	for <e@80x24.org>; Fri,  9 Mar 2018 09:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeCIJlx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 04:41:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750742AbeCIJlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 04:41:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB44E4023BB3;
        Fri,  9 Mar 2018 09:41:51 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-44.rdu2.redhat.com [10.10.120.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6BC56353C;
        Fri,  9 Mar 2018 09:41:50 +0000 (UTC)
Subject: Re: recent glob expansion breakage on Windows?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     public git mailing list <git@vger.kernel.org>,
        "Carsey, Jaben" <jaben.carsey@intel.com>,
        git-for-windows@googlegroups.com
References: <e0ba9fb9-056e-4979-415b-f8eca47e2490@redhat.com>
 <20180308220356.GA171451@aiede.svl.corp.google.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <3f8076fa-ead3-4034-2d41-364b72169873@redhat.com>
Date:   Fri, 9 Mar 2018 10:41:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308220356.GA171451@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 09 Mar 2018 09:41:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 09 Mar 2018 09:41:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lersek@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08/18 23:03, Jonathan Nieder wrote:
> +git-for-windows
> Hi,
> 
> Laszlo Ersek wrote:
> 
>> Jaben reports that git-send-email is suddenly failing to expand the
>> "*.patch" glob for him, at the Windows CMD prompt:
>>
>> ---------
>> E:\...>git send-email --suppress-cc=author --suppress-cc=self --suppress-cc=cc --suppress-cc=sob --dry-run *.patch
>>
>> No patch files specified!
>> ---------
>>
>> Whereas, moving the same patch files to another subdir, and then passing
>> the subdir to git-send-email, works fine.
>>
>> I seem to have found some $^O based perl code in the git tree that
>> expands the glob manually (in place of the shell) on Windows -- however,
>> that code looks ancient ^W very stable, and doesn't seem to explain the
>> sudden breakage.
>>
>> Is it possible that a separate perl update on Jaben's Windows box is
>> causing this? Or does the breakage look consistent with a recent git change?
>>
>> Has anyone else reported something similar recently?
> 
> This reminds me of https://github.com/git-for-windows/git/issues/339.
> There, Johannes Schindelin writes (about a different command):
> 
> | This is expected because neither PowerShell nor cmd.exe nor git.exe
> | expand wildcards. Those examples you found were written with a shell
> | in mind, and the shell expands wildcards (hence Git does not think
> | it needs to).
> 
> That may or may not also apply to send-email.

Thank you for the reference -- I can't say whether closing issue #339 as
WONTFIX was justified or not, but it certainly seems inconsistent with
Jaben's earlier experience (to my understanding), i.e. that git did
expand the glob.

> In what version did it work?

Jaben, can you please answer that? (One version in which it is broken is
2.14.1.windows.1.) Can you perhaps ask your teammates about their
git/windows versions (assuming the *.patch glob is expanded correctly
for them)?

Thank you, Jonathan,
Laszlo
