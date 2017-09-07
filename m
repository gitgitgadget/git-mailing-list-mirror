Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D64209AB
	for <e@80x24.org>; Thu,  7 Sep 2017 16:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755173AbdIGQA2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:00:28 -0400
Received: from mail.pdinc.us ([67.90.184.27]:50100 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754518AbdIGQA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:00:27 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id v87G0QOw005621
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 7 Sep 2017 12:00:26 -0400
Reply-To: <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: Git diff --no-index and file descriptor inputs
Date:   Thu, 7 Sep 2017 12:00:26 -0400
Organization: PD Inc
Message-ID: <DF5E912A0E6343DF8C3E984A165490EF@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdMn8mtJkDkE/RHQSvuI+/UIwnQDWQ==
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I was hoping to leverage --word-diff-regex, but the --no-index option does
not seem to work with <(...) notation.

I am I doing something wrong or is this a bug?

-Jason (reply to list please)

root@blackfat /projects
$ git diff --no-index -- <(xmllint --format
HRUniversalServices/pairs/src/esb/wsdl/pairs-american-dependents.wsdl)
<(xmllint --format
/projects/HRUniversalServices.368879ef/modules/pairs/src/esb/wsdl/pairs-amer
ican-employees.wsdl)

root@blackfat /projects
$ echo git diff --no-index -- <(xmllint --format
HRUniversalServices/pairs/src/esb/wsdl/pairs-american-dependents.wsdl)
<(xmllint --format
/projects/HRUniversalServices.368879ef/modules/pairs/src/esb/wsdl/pairs-amer
ican-employees.wsdl)
git diff --no-index -- /dev/fd/63 /dev/fd/62

root@blackfat /projects
$ git diff --no-index --
HRUniversalServices/pairs/src/esb/wsdl/pairs-american-dependents.wsdl
/projects/HRUniversalServices.368879ef/modules/pairs/src/esb/wsdl/pairs-amer
ican-employees.wsdl | wc -l
92

root@blackfat /projects
$ diff -u <(xmllint --format
HRUniversalServices/pairs/src/esb/wsdl/pairs-american-dependents.wsdl)
<(xmllint --format
/projects/HRUniversalServices.368879ef/modules/pairs/src/esb/wsdl/pairs-amer
ican-employees.wsdl) | wc -l
82

root@blackfat /projects
$ git --version
git version 2.13.2

root@blackfat /projects
$ uname -a
CYGWIN_NT-10.0 blackfat 2.8.1(0.312/5/3) 2017-07-03 14:11 x86_64 Cygwin

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

