Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E002D2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdFBW7M (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:59:12 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:8836 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBW7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:59:11 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id GvXAdXJsI9tMzGvXAdd0u0; Fri, 02 Jun 2017 23:59:09 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=gBe9XszjAAAA:8 a=NEAV23lmAAAA:8 a=-AnQz9JOAAAA:8 a=va3cMattxlb2u8WgFgUA:9
 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22 a=Qe3B-uv14le7UHpwobC2:22
 a=3bnadFWGKyIZm4bBUiDd:22
Message-ID: <7B6DC5C9C2354BD9BB08DD84FF6628D1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Philipp Gortan" <philipp@gortan.org>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org> <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
Subject: Re: git-gui ignores core.hooksPath
Date:   Sat, 3 Jun 2017 00:00:40 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170602-4, 02/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfFXSpeg6R+C0tgC6HQR+sVAPvOFYQVq6kYEwtJAnr80R/2fkIa9Yxch+rJk6M1yylNfAcVULboXH6nsrBAHbaPoqTUkzatAmwoLcor06mun5bXIpkn3j
 o+HqqQ306v4XNDrRIspaIxd2DmTfDfjElaO9ZPROiQAsmdbWt34JrwPIlEyp0FKajdjBmh9Qyey9yKp1p4doNlf4Tg9d/NfflGhSHAZYVLC5lJUajNeoX7hv
 7BIpIXikDiGkw4zas074zUK1gwxTza5Jur2pjSnkJLQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
> On Fri, Jun 2, 2017 at 3:41 PM, Philipp Gortan <philipp@gortan.org> wrote:
>> Hi git devs,
>>
>> First off, thanks for your awesome work!
>>
>> I've been unhappy for quite a while that I had to configure the hooks
>> manually for each of my repos - until I found out recently that there is
>> the core.hooksPath config variable that (when set globally) allows me to
>> specify a hooks directory to be used for all my repositories.
>>
>> Now I was happy - for a few minutes, until I tested this feature in
>> git-gui, and realized that it doesn't work there.
>>
>> This seems to be caused by "proc githook_read", which says "set pchook
>> [gitdir hooks $hook_name]" instead of querying "git config
>> core.hooksPath" first - cf
>> https://github.com/git/git/blob/2cc2e70264e0fcba04f9ef791d144bbc8b501206/git-gui/git-gui.sh#L627
>>
>> Would be great if this could get fixed...
>
> Hi. I added core.hooksPath, glad to see it's useful to other people.
>
> This indeed is something that should be fixed, but git-gui development
> is managed outside of git.git, it's just occasionally pulled in. I'm
> not what the best place to contact is, but I've CC'd
> Philip Oakley who's been making recent commits to git-gui.git at
> http://repo.or.cz/git-gui.git/

The proper maintainer for the git-gui is Pat Thoyts (cc'd) who now has a 
repo at https://github.com/patthoyts/git-gui where Pull requests can be 
made, with patches posted here initially for wider review.

I'm just another contributor, but I have managed (with a bit of help from 
google and formative years using FORTH;-) to get a few git-gui patches 
tested and incorporated. tcl/tk isn't that hard, its just interpreted 
code.., the main part, for me, was working out how to ru the code in the 
Git-for-Windows SDK environment (with help).
--
Philip 

