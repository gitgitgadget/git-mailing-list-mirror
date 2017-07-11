Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7392035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756225AbdGKR1P convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 11 Jul 2017 13:27:15 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24699 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbdGKR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:27:14 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v6BHR6W5043081
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2017 13:27:07 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Nikolay Shustov'" <nikolay.shustov@gmail.com>,
        <git@vger.kernel.org>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
In-Reply-To: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
Subject: RE: "groups of files" in Git?
Date:   Tue, 11 Jul 2017 13:27:01 -0400
Message-ID: <000801d2fa6a$eb5e5130$c21af390$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEnCwQoG4DjnH1V432YkgIanxAKDqOmvdTg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On July 11, 2017 11:45 AM Nikolay Shustov wrote:
>I have been recently struggling with migrating my development workflow from Perforce to Git, all because of the following thing:
>I have to work on several features in the same code tree parallel, in the same Perforce workspace. The major reason why I cannot
>work on one feature then on another is just because I have to make sure that the changes in the related areas of the product play together well.
>With Perforce, I can have multiple changelists opened, that group the changed files as needed.

>With Git I cannot seem to finding the possibility to figure out how to achieve the same result. And the problem is
>that putting change sets on different Git branches (or workdirs, or whatever Git offers that makes the changes to
>be NOT in the same source tree) is not a viable option from me as I would have to re-build code as I re-integrate
>the changes between the branches (or whatever changes separation Git feature is used).
>Build takes time and resources and considering that I have to do it on multiple platforms (I do cross-platform development) it really denominates the option of not having multiple changes in the same code tree.

Change sets are core git functionality. When you commit, you commit a group of changes across multiple files, not single file at a time, like most legacy SCM systems. Individual features are managed typically managed using topic branches that can be switched (using checkout) rapidly, which in your case will cause a localized rebuild based on what files were swapped.

If you need something slightly different than topic branches, do multiple clones off a base integration branch. This will give you multiple working source trees. Switch each clone to its own branch and work with them locally. If you need to move changes from one branch to another, commit, push on one branch, and pull merge to the other branch.

You could also use stash to accomplish similar things, but I wouldn't.

Cheers,
Randall

