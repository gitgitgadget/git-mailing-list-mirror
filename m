Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB912202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 15:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbdJZPIR (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 11:08:17 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:40149 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932366AbdJZPIQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 11:08:16 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Oct 2017 11:08:16 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 87517182D5422
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 15:03:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C55E01802EB28
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 15:03:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ring06_191f87e8fe903
X-Filterd-Recvd-Size: 892
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 15:02:52 +0000 (UTC)
Message-ID: <1509030170.10651.59.camel@perches.com>
Subject: grep vs git grep performance?
From:   Joe Perches <joe@perches.com>
To:     git <git@vger.kernel.org>
Date:   Thu, 26 Oct 2017 08:02:50 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Comparing a cache warm git grep vs command line grep
shows significant differences in cpu & wall clock.

Any ideas how to improve this?

$ time git grep "\bseq_.*%p\W" | wc -l
112

real	0m4.271s
user	0m15.520s
sys	0m0.395s

$ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
112

real	0m1.164s
user	0m0.847s
sys	0m0.314s


