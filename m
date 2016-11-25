Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E590C1FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 15:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbcKYPtd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 10:49:33 -0500
Received: from mout.web.de ([212.227.15.3]:56115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbcKYPta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 10:49:30 -0500
Received: from birne12.local ([195.252.60.88]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfYTr-1cM21g385T-00P6Gm; Fri, 25
 Nov 2016 16:48:43 +0100
Subject: Re: [PATCH v8 07/10] convert: unify the "auto" handling of CRLF
To:     tboegi@web.de, git@vger.kernel.org
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461942123-16179-1-git-send-email-tboegi@web.de>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <5502e894-bb22-e8b9-ab7a-49346d238283@web.de>
Date:   Fri, 25 Nov 2016 16:48:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <1461942123-16179-1-git-send-email-tboegi@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jpYvqUO18XpvKHDOgoI0d3GRXJpvcUPT1NaAjOIZCN63tsAP/7L
 K2K80DIRjhRFk8k6yraTYqs/dmS+Og/UUzakf1hLGQYytbKXwL41cRzHr8Iis12Cl+SJBmF
 eMLpevb1KNGZHZbocYd1rJnpdYIb1Ld+NvPb7mBbUQkFu6bIhslCcPu0kHy41ETqeeNL8Gc
 JiFoKdHxJ59YuOJVI+9oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lTqYS1yPY0Q=:5pnGgoGZpKsw7HQRhR5/tP
 fv7OJ96JokxcUg/13ViivNggvnNUdGCcZQyKsbMOeP+hqNQ+jBYRsgD8wfYoVzPjmJWg1E7Ei
 2L/geBdNhNlOrU/53uzaVmNZB0rtyWHFk2ulVnI6kOi36E3XH26oKz2xLYhn2hAha2cILzyjS
 FxvW7UayOMuXdzhlEAyob6tcX9/qAZ9c0CAH5Xcek32M8G1WMRPUpyWDVmApMA9ZCVUmrg7Un
 fa/iF1n7cyStmKreXLWI+/mFVOCr06vu1qhZbCsZdwYDZZIWj03vcog19CuV8Y7Jmuwwj+I4K
 btAJvRNWbR5Ezt1Xc4RR4RxGRHAtiFrG2oj35umvM/6rYaPIdtXiEnAWqcRxq3lfEGg9GqxnZ
 P7iGB7SQzTo7bBJOPq/1U4lvXgU93DVE3HZaHZ66O2SoxzqY5Oz9nB5i/OYbEzddLznnLWWk6
 oB7WMJFYYc0yVsrsSq1ae8QPGpGT0dJvY5tISCb38o7JtKsy4YhkTrixBKRl5xTc712qcIT+g
 zxsST4khZK5e7fzvA5BmZEzQx1T2x1VEKm/nxq900zkwFl3CZwX/fdUpYDZ2Qtxk7kEtjzaGw
 rubGUZ5uPR0NstPCeLeaqRsddEhYleX1iofLPfM+ygHlkRaL1Hr3c3ZmORxJppNc5/R1i9UJN
 hCtLnZ2r6bLDr1TRyv/1Mg1oEhkvL1fnsUxhRdtc/UFUG0BS11g7S+5uZGgW4PxYx8jYdurxq
 9sk5/3HrDVwfBmjrdfrokcMsfxGwxYKU7ZDgg+RleqwJzslAtoLAlkjPndZi0otf9SDXTiNQ9
 VhSWqAq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RFH, the normalization as descrived in Documentation/gitattributes.txt
does not work anymore:


From a clean working directory:

-------------------------------------------------
$ echo "* text=auto" >.gitattributes
$ rm .git/index     # Remove the index to force Git to
$ git reset         # re-scan the working directory
$ git status        # Show files that will be normalized
$ git add -u
$ git add .gitattributes
$ git commit -m "Introduce end-of-line normalization"
-------------------------------------------------


I have different ideas, how a a normalizatio  can be done:

A) 
-------------------------------------------------
$ echo "* text=auto" >.gitattributes
$ rm .git/index
$ git add .
$ git status        # Show files that will be normalized
$ git commit -m "Introduce end-of-line normalization"
-------------------------------------------------

B)
$ echo "* text=auto" >.gitattributes &&
$ git add .gitattributes &&
$ git ls-files --eol | egrep '^i/(crlf|mixed).*attr/(text|auto)' | ( TAB=$(printf "\t") ; sed -e "s/.*$TAB/dos2unix /" ) >/tmp/$$ &&
$ /bin/sh /tmp/$$ &&
$ rm -f /tmp/$$ &&
$ git add -u &&
$ git commit -m "Introduce end-of-line normalization"

C) 
Teach "git add" to learn --renormalize and then
-------------------------------------------------
$ echo "* text=auto" >.gitattributes
$ git add -u --renormalize
$ git add .gitattributes
$ git commit -m "Introduce end-of-line normalization"
-------------------------------------------------

(None of them is really tested)

A) may loose the execute bit
B) dos2unix is not installed everywhere (like Mac OS)
C) seems to most attractive, but I couldn't find out how to forward
   options from "git add" into convert.c


Any help is appreciated.






