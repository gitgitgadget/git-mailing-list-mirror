Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6281F97E
	for <e@80x24.org>; Sun, 11 Nov 2018 09:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKKT2I convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Nov 2018 14:28:08 -0500
Received: from mail235c25.carrierzone.com ([64.29.147.249]:54402 "EHLO
        mail237c25.carrierzone.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727440AbeKKT2I (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Nov 2018 14:28:08 -0500
X-Greylist: delayed 990 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 14:28:07 EST
X-Authenticated-User: federico@speakeasy.net
Received: from [10.0.1.14] (music.snoogins.com [66.92.75.42] (may be forged))
        (authenticated bits=0)
        by mail237c25.carrierzone.com (8.14.9/8.13.1) with ESMTP id wAB9MquC012643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 11 Nov 2018 09:23:24 +0000
From:   Federico Lucifredi <flucifredi@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Date:   Sun, 11 Nov 2018 04:22:52 -0500
Subject: BUG REPORT: git clone of non-existent repository results in request for credentials
To:     git@vger.kernel.org
Message-Id: <708E1759-B2E3-436C-9D54-214159655B1B@acm.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
X-Mailer: Apple Mail (2.2104)
X-CSC:  0
X-CHA:  v=2.3 cv=AM3936jT c=1 sm=1 tr=0 a=vAdrRuyFyCEsOXct86Hm0Q==:117
        a=vAdrRuyFyCEsOXct86Hm0Q==:17 a=kj9zAlcOel0A:10 a=FYT53FELAAAA:20
        a=N54-gffFAAAA:8 a=ea1wpVp6sBQ_-EyOqZAA:9 a=CjuIK1q_8ugA:10
        a=6l0D2HzqY3Epnrm8mE3f:22 a=p-dnK0njbqwfn1k4-x12:22
        a=jjky5lfK57Ii_Ajn6BuG:22
X-CTCH-RefID: str=0001.0A090207.5BE7F50D.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git clone of non-existent repository results in request for credentials

REPRODUCING:
sudo apt install git
git clone https://github.com/xorbit/LiFePo4owered-Pi.git    #this repo does not exist

Git will then prompt for username and password on Github.

I can see a valid data-leak concern (one could probe for private repository names in a brute-force fashion), but then again the UX impact is appalling. Chances of someone typing an invalid repo name are pretty high, and this error message has nothing to do with the actual error.

RESOLUTION:
The error message should indicate that the repository name does not exist. 


Best -F



_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - flucifredi at acm.org - GnuPG 0x4A73884C

