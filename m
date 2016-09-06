Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9381F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 19:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935938AbcIFTCT (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 15:02:19 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:44178 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935399AbcIFTCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 15:02:16 -0400
Received: from PhilipOakley ([92.22.19.150])
        by smtp.talktalk.net with SMTP
        id hLdObQLScY8RwhLdOb7Y4y; Tue, 06 Sep 2016 20:02:14 +0100
X-Originating-IP: [92.22.19.150]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=6ArtXQo7PAGpH5uJiKkWBw==:117
 a=6ArtXQo7PAGpH5uJiKkWBw==:17 a=8nJEP1OIZ-IA:10 a=VKajHbVsdwmrbCEEo18A:9
 a=wPNLvfGTeEIA:10
Message-ID: <6C5AB39424064692A416A490B861D330@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Git" <git@vger.kernel.org>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>        <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609040923390.129229@virtualbox> <8F7471262D1C45D9A7BD1C29277004AD@PhilipOakley> <alpine.DEB.2.20.1609050950130.129229@virtualbox>
Subject: Re: Fixup of a fixup not working right
Date:   Tue, 6 Sep 2016 20:02:16 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfIbMzzYlDGBjmlA8VmEkuRWu8voM/nfIQEdjBQ+TFx/f/HL+Yo0NUZrSAbefjmzSNnzkpYxF7sHDhC9xbucCAS/HMeOSVcqAjetswOS3iT8f7lL+bVVC
 ST8Bwmw1HBLOvhHwAJi/BrQs7l9vK8AMStwXGITelbtRXKYqZE6gBnfxwtVjctzeQJZBAfSzY8azFxruw6Wf/ivSMMYhIzvcbtouc8PlSPmvBTKLKOEvfCYl
 VSK68wNZE1BIi++lzo2Q2f7ErbBcnUvNzQcutdOnhK0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Sun, 4 Sep 2016, Philip Oakley wrote:
>
>> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
>>
>> > The point is that fixup! messages are really special, and are always
>> > intended to be squashed into the referenced commit *before* the latter
>> > hits `master`.
>>
>> I think it's here that we have the hidden use case. I agree that all 
>> fixups
>> should be squashed before they hit the blessed golden  repository.
>>
>> I suspect that some use cases have intermediate repositories that
>> contain a 'master' branch (it's just a name ;-) that isn't blessed and
>> golden, e.g. at the team review repo level. In such cases it is possible
>> for a fixup! to be passed up as part of the review, though it's not the
>> current norm/expectation.
>
> In such a case (which can totally arise when criss-crossing Pull Requests
> on GitHub, for example, where a Pull Request's purpose may be to fix up
> commits in another Pull Request before the latter is merged), the most
> appropriate course of action is... to not reorder the fixup!s prematurely.

We just need to be careful about that plural just there.

If it is multiple fixup!s for the same commit, then I believe they should be 
grouped together at the same point as the first fixup! commit (in their 
original order).

If they are for different commits, then they should stay in their place in 
the commit series (for their first occurrence, then rule 1 applies)

>
>> > In short, I am opposed to this change.
>>
>> It's not like G4W doesn't need fixup!s on the side branches e.g. 5eaffe9
>> ("fixup! Handle new t1501 test case properly with MinGW", 2016-07-12)

I note that you don't have two fixup!s for that commit

> Yeah, well, Git for Windows' `master` branch is special, in that it is
> constantly rebased (as "merging rebases", to keep fast-forwardability). I
> would not necessarily use Git for Windows as a role model in this respect.

I don't see GfW as 'special', rather as being a representative of a broader 
realpolitik where some of the rugged individualism of open source is 
moderated in some way or another.

> Ciao,
> Dscho
>
--
Philip 

