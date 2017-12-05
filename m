Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA57220A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbdLEWTU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:19:20 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:6472 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbdLEWTU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:19:20 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id MLYbeoqxVAp17MLYbejRRG; Tue, 05 Dec 2017 22:19:18 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=Dx4yW56zAAAA:8
 a=kuvQDUYgI6n_t7CoH0kA:9 a=QEXdDO2ut3YA:10 a=X_u8qhY6y2Nm79co_leF:22
Message-ID: <F5CBA33407434DD9A31D674581B65330@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>, <git@vger.kernel.org>
Cc:     "'Vitaly Arbuzov'" <vit@uber.com>
References: <001e01d36e01$7f145d20$7d3d1760$@nexbridge.com>
Subject: Re: [RFE] Inverted sparseness (amended)
Date:   Tue, 5 Dec 2017 22:19:16 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171204-2, 04/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfI9XAe3pVq/Jyn07i/yZZhF57YjwF/I55tL2au0cztpTbuIz1iEmFZm4cc3c4fCjorZl54J6BpqDnNM5M+gyz0HBCHbrG7Rn+QssviV8KGqSyvhdNpA7
 tLbmAoq0x1SNEFchguI9Hn8HPa+AqcKY30+/wB3ugq0pRtr2Itql9pqnymaIhlGtltvd883zvY1xvqulvnYpIx/rwv4IxFzTKHUsUG7wyMNDlkwhOCMByW0o
 UlZvtvIbOPS8XmyGSqK0sA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>
On December 3, 2017 6:14 PM, Philip Oakley wrote a nugget of wisdom:
>From: "Randall S. Becker" <rsbecker@nexbridge.com>
[...]

>If using the empty tree part doesn't pass muster (i.e. showing nothing
>isn't sufficient), then the narrow clone could come into play to limit
>what parts of the trees are widely visible, but mainly its using the
>grafts to cover the regulatory gap, and (for the moment) using
>fast-export to transfer the singleton commit / tags

>Oh Just remembered, there is the newish capability to fetch random blobs, 
>so that may help.

I think you hit the nail on the head pretty well. We're currently at 2.3.7, 
with a push to 2.15.1 this week, so I'm looking forward to trying this. My 
two worries are whether the empty tree is acceptable (it should be to the 
client, and might be to the vendor), and doing this reliably 
(semi-automated) so the user base does not have to worry about the gory 
details of doing this. The unit tests for it are undoubtedly going to give 
me headaches.

Thanks for the advice. Islands of shallowness are a really descriptive image 
for what this is. So identifying that there are shoals (to extend the 
metaphor somewhat), will be crucial to this adventure.

These islands of shallowness, however, are also concerns as described in the 
[Re: How hard would it be to implement sparse fetching/pulling?] thread. The 
matter of the security audit is important here also:
> I'm just thinking that even if we get a *perfectly working* partial 
> clone/fetch/push/etc. that it would not pass a security audit.


Philip says:
I'd totally disagree in the sense that if we had a submodule anywhere_ in 
the repo that would be an independent island of code, and we are quite happy 
with that - we use the web of trust with the auditors for them to go check, 
separately, the oid of the independent portion, which may be at another site 
or another vendor/client. That's OK, so what's the problem here...

We do the same for pinning the tips and tails of the lines of development 
that make for the shallowness and narrowness that create these shoals, and 
oxbows of development. Managing them is normal human activity, with the 
technical support that the Git chain provides - so much better than previous 
'versioning systems' that we see regularly in engineering, with backdoor 
tweaks etc.

The key is to ensure that there is a proper hand holding across the air 
gaps, such that the oids exist both sides of the gaps, and a properly built 
on, such that the hash chain is unbroken. It's a similar negotiation to 
those used for establishing web security between IP clients, so it is 
doable. But you are right to have concerns and suspisions to ensure that it 
is all tested and verified
--
Philip (sorry about the poor quoting of the reply)




Not having the capability would similarly cause a failure of a security 
audit.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately 
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



