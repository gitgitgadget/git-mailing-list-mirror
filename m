Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E5D1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 12:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdF1MbK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Jun 2017 08:31:10 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:64328 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdF1MbI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 08:31:08 -0400
Received: from amu316.rsint.net ([10.0.26.65])
          by mail02.rohde-schwarz.com
          with ESMTP id 2017062814311655-217012 ;
          Wed, 28 Jun 2017 14:31:16 +0200 
Received: from rus18.rsint.net ([10.0.33.18])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 371;
          Wed, 28 Jun 2017 14:31:04 +0200 (CEST)
Received: from GMU02.rsint.net ([10.0.32.24])
          by RUS14.rsint.net (IBM Domino Release 9.0.1FP8)
          with ESMTP id 2017062814302035-3308 ;
          Wed, 28 Jun 2017 14:30:20 +0200 
Received: from GMU01.rsint.net (10.0.32.21) by GMU02.rsint.net (10.0.32.24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 28
 Jun 2017 14:30:19 +0200
Received: from GMU01.rsint.net ([fe80::9832:f3b2:8965:c618]) by
 GMU01.rsint.net ([fe80::9832:f3b2:8965:c618%12]) with mapi id 15.01.0669.032;
 Wed, 28 Jun 2017 14:30:20 +0200
From:   Robert Siemer <Robert.Siemer@rohde-schwarz.com>
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: submodules of submodules use absolute gitdir in .git file
 (instead of relative)
Thread-Topic: Bug: submodules of submodules use absolute gitdir in .git file
 (instead of relative) /ur/
Thread-Index: AQHS8ApOY7zvDV9YE0aHVVGFhVxBbg==
References: <0d924a0671b642d2b8ba79af8d4fa0d7@rohde-schwarz.com>
 <xmqqr2y531xv.fsf@gitster.mtv.corp.google.com>,<CAGZ79kZmV9Aufrsmf1iohhP5qHzA4AZ3DDv8sn1GMaCZ+SbV5Q@mail.gmail.com>,<a882773a8f0f4632a204090baa0f182b@rohde-schwarz.com>
In-Reply-To: <a882773a8f0f4632a204090baa0f182b@rohde-schwarz.com>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.9.40]
MIME-Version: 1.0
X-GBS-PROC: OUwKE2gkgrAOj7T8KnJFp7w8jcRxhWLKaEes+PpmNMA=
X-TNEFEvaluated: 1
X-RUS_SENSITIVITY: 10
Message-ID: <a8e69eac41e747f79f8aba335f995d69@rohde-schwarz.com>
Date:   Wed, 28 Jun 2017 12:30:20 +0000
X-MIMETrack: Itemize by SMTP Server on RSSMTP02/RSSMTP at 28.06.2017 14:31:16,
        Serialize by Router on RSSMTP02/RSSMTP at 28.06.2017 14:31:19,
        Serialize complete at 28.06.2017 14:31:19
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I had the problem with version 2.7.4.

The problem is fixed in self-compiled v2.13.2.533.ge0aaa1bed, v2.12.0, v2.11.0 and v2.9.3! Even the older version 2.1.4 does not have that problem.

Thank you for the input!

Robert



________________________________________
From: Siemer Robert CSNPE
Sent: Wednesday, June 28, 2017 14:09
To: Stefan Beller; Junio C Hamano
Cc: git@vger.kernel.org
Subject: Re: Bug: submodules of submodules use absolute gitdir in .git file (instead of relative)

________________________________________
From: Stefan Beller <sbeller@google.com>
Sent: Tuesday, June 27, 2017 19:35
To: Junio C Hamano
Cc: Siemer Robert CSNPE; git@vger.kernel.org
Subject: Re: Bug: submodules of submodules use absolute gitdir in .git file (instead of relative)

On Tue, Jun 27, 2017 at 8:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Siemer <Robert.Siemer@rohde-schwarz.com> writes:
>
>> Hello everyone,
>>
>> $ git submodule foreach cat .git
>>
>> ...shows that the gitdir registered in the .git file of submodules is relative. But if you run
>>
>> $ git submodule foreach --recursive cat .git
>>
>> ...shows that submodules of submodules (if you have any) have an absolute gitdir starting with a slash.
>>
>> 1) Can you confirm that behavior?
>
> Nobody can without knowing which version of Git you are using.  I
> suspect that we had discussed and addressed something related to
> nested submodule's "gitdir" pointer in not-so-distant past.

Yeah there was a period in time where we had this bug.
(Or is it a different bug?)
See 90c0011619 (submodule: use absolute path for computing
relative path connecting, 2016-12-08), which is included in 2.12.

