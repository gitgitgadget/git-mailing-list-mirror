Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C38207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 16:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S974753AbdDXQe4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 12:34:56 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:29865 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S974750AbdDXQez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 12:34:55 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 2gwadmbNa46SJ2gwadlsaK; Mon, 24 Apr 2017 17:34:33 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=Oi53O257nWWIvWR4AIEA:9
 a=wPNLvfGTeEIA:10
Message-ID: <ADC645666B1F4ECA92E9082F0565F475@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Johannes Sixt" <j6t@kdbg.org>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Lars Schneider" <larsxschneider@gmail.com>,
        "git" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Brandon Williams" <bmwill@google.com>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox> <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com> <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org> <alpine.DEB.2.20.1704241622510.3480@virtualbox>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
Date:   Mon, 24 Apr 2017 17:34:32 +0100
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
X-CMAE-Envelope: MS4wfFpk7gm1/twhpHplrwPf7nXQwo08L/+w96INMjLuuzDL8fRSPASQusoNgdZf401gS1LcBhdPZooMMzzrhFui8k/3/NibxJNLeWYaz6qjxKo9Vo9IAFw2
 kX6mk1ehNRoVlu2Y8GM6qgzLKsAKOm4EIqIpdKqaV9wdYcDTqzXTFGrpIjfWlYNX+mdCaB8foF1turbG8DPfBAoLNTeZm00nHoH357HupuIFjNOBtmrRs9wR
 yW3D4SjjLW47GGb51ahNW8QREe8IdhDS9xUWdids1VhbGsH1rW6Aw1++kzHr1bBNZUBQW3/D27m7a15FNBDQl0wYg2X82htSfGuJIbDIyC5e7aUt+T5sYPAv
 IcQj6kmS3RfC3wlPwh5Zrohb+fAs9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Hannes,
>
> On Sat, 22 Apr 2017, Johannes Sixt wrote:
>
>> Am 21.04.2017 um 14:29 schrieb Christian Couder:
>> > First bisect should ask you to test merge bases only if there are
>> > "good" commits that are not ancestors of the "bad" commit.
>>
>> That's a tangent, but I have never understood why this needs to be so.
>> Consider this:
>>
>>    o--o--o--o--o--o--o--o--B
>>    /           /
>>  -o--o--o--o--g--o--o--o--o--G
>>
>> When I mark B as bad and G as good, why would g have to be tested first? 
>> This
>> is exactly what I do when I bisect in Git history: I mark the latest 
>> commits
>> on git-gui and gitk sub-histories as good, because I know they can't 
>> possibly
>> be bad. (In my setup, these two histories are ahead of pu and next.)
>
> I guess the idea behind bisect's reasoning is that you could have merged
> the "wrong" branch first.
>
> Ciao,
> Dscho
>

Sorry if I'm bikeshedding here, but it does look like adding an alternate 
'bisect' strategy may be useful for this style of integration testing.

To me, given the multiplicity of independent branches being brought 
together, it should be possible to do a check on each of the branches 
separately, before the tests along the line of integration . The tests would 
not be a true 'bisection' as they are separate single point tests, but they 
do establish good commits at the tips of those branches.

Thus, for each of the merges in the --first-parent traversal, the option 
could test (in the OS of choice) the *second parent* commit of the merge. 
This sets the known good points. The breakages during the integration then 
become easier to bisect, as it is only looking for the integration of a good 
series into mainline that breaks. [1]

In addition, an aside that dscho made earlier about the merge-base of some 
branches relative to Windows may have been missed. The normal bisect process 
assumes that we start from a set of good merge bases. However, dscho noticed 
that occasionally some series may choose an older point on maint (etc.) that 
itself would _not_ be classed as good when tested on Windows (or on other 
OS's). Those older mergebases can make the classic bisect across all the 
commits in the DAG between here and there a tortuous process, especially if 
the local OS implementation percieves the base points as bad! (which breaks 
expectations).

--
Philip


[1] It maybe that this can be approached via an alternate DAG, which could 
be 'faked' up as if each of the topic branches had been squashed from being 
a long series down to a single commit (the final tree of the series), and 
then likewise (same tree) for the integration merges, such that all the 
singleton commits are not tested, only the pre and post merge commits on the 
first-parent traverse. 

