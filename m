Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C99220A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeLLUNL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 12 Dec 2018 15:13:11 -0500
Received: from cluster-j.mailcontrol.com ([85.115.54.190]:50346 "EHLO
        cluster-j.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeLLUNL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 15:13:11 -0500
X-Greylist: delayed 3216 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 15:13:07 EST
Received: from ag-outbound.3ds.com (static-126-173-147-69.axsne.net [69.147.173.126])
        by rly01j.srv.mailcontrol.com (MailControl) with ESMTPS id wBCJJGDw032983
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:19:28 GMT
Received: from AG-DCC-HUB14.dsone.3ds.com (10.6.51.214) by
 AG-DCC-HUB11.dsone.3ds.com (10.6.51.31) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 12 Dec 2018 14:19:26 -0500
Received: from [149.65.130.213] (10.65.2.213) by smtps.ag.3ds.com
 (10.6.51.214) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 12 Dec
 2018 14:19:25 -0500
To:     <git@vger.kernel.org>
From:   James Mason <James.Mason@3ds.com>
Subject: How to perform efficient incremental update of a git repo from a
 large SVN repo? Bug or clueless user?
Message-ID: <9181bfae-8a36-2051-179f-438706ba7968@3ds.com>
Date:   Wed, 12 Dec 2018 14:19:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Originating-IP: [10.65.2.213]
X-TM-SNTS-SMTP: 6957133CFE2A98922F1F9FA03684DA098DDF9CD3CB9360134E56D050758DB1E92000:8
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24282.002
X-TM-AS-Result: No-11.519700-8.000000-10
X-TMASE-MatchedRID: MABEo13OmFKZRWwXDNkgw7iMC5wdwKqd1zqopo0lhEn9Ez/5IpHqp8Bd
        s02zys/OTkKYxrJLC+tQiH8QZCOjAo9Tk4aumaegQpxiLlDD9FUIjen4m7yaqlVgGGTe6VdAoPF
        0Y5ArR7Rx7xikOpVTj0qrZq3j0WF9qFeW+hmVZ3e2AZ59hFA16y2HcsEx5e57nnYC/uGwSQ9okn
        rFUvq5quInzQYz6ijPtge0l0NZODRZC7NPTJvUlBWUpKmwDqYXD0SPCEki8WLI9BHsOEzeNvs64
        gPKRsd37T1wAB4Bvwk/ce98R5uesmRxLDvGKY2Wzr16YOzjZ10xXH/dlhvLv7w2tvOM+/Mnl0Br
        H8BQUYUCbSJEifReLwBQwS9nx78SbBkLGPxXO7uBrMxBIa9TIGVJUFD+9LAIG1VFRGOlP68vsUv
        6Hr1LBloRDrQpYDLbvdBFVbH6wdh8HJwhpjYiQrxygpRxo469QV6BZJ9WeFZqqcld733BhqK2wf
        B8RrpnfuqrZyF3cN3KX3Pdweau2oSr0/wfsEQvdl7DHkZIxlBVut265IUrOHekRURO7ynxOF1Mg
        OSlvngM+ZJPBxG1vl+24nCsUSFNjaPj0W1qn0TKayT/BQTiGgwWxr7XDKH83oF6dBup9+EcrgDA
        5vsZMB5tFMicMkcX+gzwZenJFFqYOjrGGmHjtw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.519700-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24282.002
X-MailControl-OutInfo: MTU0NDY0MjM3MDpGUEtleTEucHJpdjpOK8XsXGiEESfY9UAKnilDxKdlStZzUMLr7VSefuGsCylIohfId6nqCrnCQdTJeGlGnga3km+LTbrLN4tOwq+IuX51TbGNGZdw0knmIeUTu3JFtp3vsFE08SCrsf1nrcgysmPqLXwzbEAPIaXofbXw2CQ81xTcrMKQ7pEdzLp+vd5SVrIyKWSGwUK7CjairC+TGTqdxVmeoN3/EqME90rP23Bjg6KE7iaEnDNCZ6AkbqLe0YvD9L+WYTtEwpClfZRGV+U4zUOaGYznbl/P6Ym7SJq0/OL6dWa4C20cscR0Jn+neNVuE2hY7AAJ6G2XM7aryAuFTtjzFbnUikzZ2gXv
X-Scanned-By: MailControl 44278.2058 (www.mailcontrol.com) on 10.74.0.111
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a large and active SVN repository.  More than 36,000 revisions,
thousands of branches - new ones created daily - and a non-standard
layout.  Also, a secondary git repository that serves as a faithful
"git" copy of the work accumulating in SVN (git version 2.9.5).  I seek
an efficient way to routinely (nightly?) update the git repo with new
changes accumulating in SVN.

Most of what I have found on the web suggests that, when properly
configured, incremental update will be correctly accomplished by "git
svn fetch".  My experience so far is that - while that will eventually
work - it is remarkably slow.  It's true that "git svn fetch" doesn't
redundantly add content - but it doesn't resume without appearing to
walk over all the old SVN revisions (watch the contents of
svn/.metadata).  For a large SVN repository - this can take days.

I initially posed this as a question on stack overflow (see "Routinely
updating a git repo from a large svn repo" ).  It appeared that I had
learned something about how to use "--revision" to speed things along -
so I recently added that as an answer to my own question (update now
taking routinely less than an hour).  Still that all seemed really odd.
"--revision" isn't documented as an option to "git svn fetch", you need
to dig START out of .git/svn/.metadata and END out of the SVN repository.

Today I searched on the string "branches-MaxRev" and found something
more explicitly at odds with my experience (in the git-svn document):

     Note that git-svn keeps track of the highest revision in which a
branch or tag has appeared. If the subset of
     branches or tags is changed after fetching, then
$GIT_DIR/svn/.metadata must be manually edited to remove
     (or reset) branches-maxRev and/or tags-maxRev as appropriate."

I read the documentation as saying that "git svn fetch" tracks where it
left off (which was my assumption before experiencing otherwise).   So
what I'm seeing seems like a bug - but I'm worried that my use of
"--revision" may not be entirely legitimate.

Any assistance, advice, etc., would be most appreciated.

-jrm

This email and any attachments are intended solely for the use of the individual or entity to whom it is addressed and may be confidential and/or privileged.

If you are not one of the named recipients or have received this email in error,

(i) you should not read, disclose, or copy it,

(ii) please notify sender of your receipt by reply email and delete this email and all attachments,

(iii) Dassault Systèmes does not accept or assume any liability or responsibility for any use of or reliance on this email.


Please be informed that your personal data are processed according to our data privacy policy as described on our website. Should you have any questions related to personal data protection, please contact 3DS Data Protection Officer at 3DS.compliance-privacy@3ds.com<mailto:3DS.compliance-privacy@3ds.com>


For other languages, go to https://www.3ds.com/terms/email-disclaimer
