Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99B3201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdBXUdn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:33:43 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:37134 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXUdm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:33:42 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id hMYdcFOyqgKsthMYdcZM6X; Fri, 24 Feb 2017 20:33:40 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=ybZZDoGAAAAA:8 a=WzfummkPaZyQDFx0aBMA:9 a=QEXdDO2ut3YA:10
 a=nJcEw6yWrPvoIXZ49MH8:22 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <E817E45267184196A3832C3220075D14@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "David Lang" <david@lang.hm>,
        "Ian Jackson" <ijackson@chiark.greenend.org.uk>,
        "Joey Hess" <id@joeyh.name>, <git@vger.kernel.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk> <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc> <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com> <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
Subject: Re: SHA1 collisions found
Date:   Fri, 24 Feb 2017 20:33:39 -0000
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
X-CMAE-Envelope: MS4wfKyAqWJmn6A/ajvatChWy655NWER83KGS6Sopm7/4mm2jAfyaW4pqwT0gXcgAELmfhBnrr3YlrpEHxOTMHMKpUSxeznlrx3xd59+v0YLnNvm87tklUCN
 f14zM5DHn8rh54jiQh1RjafxOAahnckZiBaaBTw76AOuL6s4aqcqt0gzcmXxJ6ryBs9EapC1/ZftfkkTUCBHcewvr7F66pRMqC8FE555kPLn5mzU77/FZmSR
 w8+h1oPgGvG083K3QWBzbPg2yznaKLzr8AePudUj39gB4Z1F5fRnisWpx9JU64y1s3xsT3xcPTRvEguc/D929A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> On Fri, Feb 24, 2017 at 10:14 AM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>
>> you are inviting people to start using
>>
>>     md5,54ddf8d47340e048166c45f439ce65fd
>>
>> as object names.
>
> which might even be okay for specific subsets of operations.
> (e.g. all local work including staging things, making local "fixup" 
> commits)
>
> The addressing scheme should not be too hardcoded, we should rather
> treat it similar to the cipher schemes in pgp. The additional complexity 
> that
> we have is the longevity of existence of things, though.
>

One potential nicety of using the md5 is that it is a known `toy problem` 
solution that could be used to explore how things might be made to work, 
without any expectation that the temporary code is in any way an 
experimental part of regular code. Maybe. It's good to have a toy problem to 
work on.

There are other issue to be considered as well, such as validating a 
transition of identical blobs and trees (at some point there will for some 
users be a forced update of hash of unchanged code), which probably requires 
two way traversal.

Philip 

