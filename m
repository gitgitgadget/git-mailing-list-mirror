Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECF41F731
	for <e@80x24.org>; Thu,  8 Aug 2019 23:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfHHXI0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 19:08:26 -0400
Received: from rdnemail.bankofamerica.com ([171.161.147.155]:30879 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732375AbfHHXI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 19:08:26 -0400
Received: from txdmzmailmx05.bankofamerica.com ([171.180.168.230])
        by lrdna0myxepmx02.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x78N8Phx025326;
        Thu, 8 Aug 2019 23:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565305705;
        bh=LzolXqIgQ/uAT0BqQXwoe6gi78k5L9cjY7GFM2Ok2kk=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=c6qso/xI2o3FZKkkICJodcFHOQBSon2GKshjvYh4XYNLlgoZgwl2BE6vLjlqE4Zf0
         FCS7qBVTqxq0ySymca+b6HZls5i7qngy0AmvXMxKzMQy4l7OvS6Dy1dWKyz+c0fEFk
         9/3A1t45eD3BwBO4W4VjDU2BoWsOklWC4DMVckTs=
Received: from lrdna0n4xepmx12.bankofamerica.com (lrdna0n4xepmx12.bankofamerica.com [171.206.154.16])
        by txdmzmailmx05.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x78N8Frv025324;
        Thu, 8 Aug 2019 23:08:25 GMT
Date:   Thu, 08 Aug 2019 23:08:14 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <3269668c03a8482d8d854ec19dd43907@bofa.com>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsA==
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_09:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, my attempt at better wording for the docs is not going well, because it turns I that I still don't understand the behavior here!
I thought that "input" means that CRLF will become LF on "git add" but that seems to be true only sometimes.
For instance, consider the following 11-line shell script:

mkdir empty
cd empty
git init
git config core.autocrlf false
echo -e '1\r\n2' > test.txt
git add .
git commit -m test
git config core.autocrlf input
cp test.txt t2.txt
echo 'a\r\nb' > test.txt
git add .

The output from the last git add is:

warning: CRLF will be replaced by LF in t2.txt.
The file will have its original line endings in your working directory.

Which is a very good warning indeed, but why does it only apply to the new file t2.txt?
Why does the existing file test.txt retain its CRLF line endings.

I am so confused.

Any pointers?

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
