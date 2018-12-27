Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA58211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeL0PzN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 27 Dec 2018 10:55:13 -0500
Received: from elephants.elehost.com ([216.66.27.132]:15201 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeL0PzN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:55:13 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash ([99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBRFt7OM041263
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Dec 2018 10:55:07 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Derrick Stolee'" <stolee@gmail.com>,
        <randall.s.becker@rogers.com>, <git@vger.kernel.org>
References: <20181226230523.16572-1-randall.s.becker@rogers.com> <20181226230523.16572-4-randall.s.becker@rogers.com> <5712b2bf-8a90-42d7-9159-261dd990eb66@gmail.com>
In-Reply-To: <5712b2bf-8a90-42d7-9159-261dd990eb66@gmail.com>
Subject: RE: [PATCH v1 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
Date:   Thu, 27 Dec 2018 10:55:01 -0500
Message-ID: <000001d49dfc$89cadd80$9d609880$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHP6M3TTaFeK+MquD7CewJFvBAGhQEdWj2KAWcucVqliACi4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 27, 2018 7:10, Derrick Stolee wrote:
> On 12/26/2018 6:05 PM, randall.s.becker@rogers.com wrote:
> > The NSIG define is also not defined on __TANDEM, so we define it here
> > as 100 if it is not defined only for __TANDEM builds.
> [snip]
> > +#if ! defined NSIG
> 
> Why didn't you use "#ifndef" here?
> 
> Taking a look at the file, I see both "#ifdef" and "#if defined" but no "#if !
> defined".

I'm good with revising as follows and removing the irrelevant lines (stay tuned):

+#ifdef __TANDEM
+#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+#include <floss.h(floss_getpwuid)>
+#ifndef NSIG
+/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
+   known, by detective work using kill -l as a list is all signals
+   instead of signal.h where it should be. */
+# define NSIG 100
+#endif
+#endif
+

Cheers,
Randall

