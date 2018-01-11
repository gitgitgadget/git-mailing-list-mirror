Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459361FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeAKVjP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 16:39:15 -0500
Received: from elephants.elehost.com ([216.66.27.132]:38157 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932566AbeAKVjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 16:39:14 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE788df7b17383-CM788df7b17380.cpe.net.cable.rogers.com [99.228.167.204])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0BLdBhN067289
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 16:39:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
References: <003601d38aea$e0e08ff0$a2a1afd0$@nexbridge.com>
In-Reply-To: <003601d38aea$e0e08ff0$a2a1afd0$@nexbridge.com>
Subject: RE: [BUG] Weird breakages in t1450 #2 on NonStop
Date:   Thu, 11 Jan 2018 16:39:04 -0500
Message-ID: <000201d38b24$9e27ac40$da7704c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQExQbaZU2sHaLe3IAgxbGtzSYtiSqSzw5lA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 11, 2018 9:46 AM, I wrote:
> This one has me scratching my head:
> 
> The object file name being reported below in t1450, subtest 2 is corrupt,
but I
> can't figure out why the script might be generating this condition -
there's
> nothing apparent, but it looks like the git commit -m C step is reporting
or
> using a bad name. This breakage was not present in 2.8.5 (now at 7234152
> (2.13.5) and is persistent (i.e. always happens). This is the only test in
all of
> git where I have observed this particular situation.
> Adding set -x to test_commit is unrevealing. The git fsck in this test is
never
> executed because the test_commit fails with a non-zero git commit
> completion code. There is no rn---- (actual r n 252 252 252 252) in the
objects
> directory - even the 'rn' does not correspond to anything.. I am
suspecting an
> unterminated string that ran into freed memory somewhere, but that's
> speculative.

Does anyone recall fixing this one at or near
dfe46c5ce6e68d682f80f9874f0eb107e9fee797? There was a rewrite of sha1_file.c
including link_alt_odb_entry where I am finding memory corruptions. I think
I'm chasing something that was already fixed some time after 2.13.5 but the
common parent to where I am is pretty far back compared to master.

Thanks,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.





