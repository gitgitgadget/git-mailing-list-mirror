Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BA7C001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGCSTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGCSTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:19:49 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 11:19:47 PDT
Received: from infplacm016.services.comms.unsw.edu.au (smtp.unsw.edu.au [149.171.193.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC904DD
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=unsw.edu.au; i=@unsw.edu.au; q=dns/txt;
  s=outboundall; t=1688408388; x=1719944388;
  h=date:from:to:subject:message-id:mime-version;
  bh=XS9NzCrZW9aSAoY3Ck9whjCbtvLQyRXUXXIcbhdxjcs=;
  b=rulRngF++GX/sUqhpwlPWSqBGRICznXauluWg5+Yzk4eefJffsDaELsI
   lXEknYZ20r4F0ljEpgkE6K7AAaEO/UBzV10CD0Z4Xzcslx0yYL470LWT8
   ua1nk+uDzwenWDKr2TjaGRPLOPdalS70jg7GSx+AdZZ3njET16HfjVJns
   eJh6GzbJG4wMU6XD1A2Qnvyg9i+Pg7P9q2n5ox0j/Ys3hmEdC19gfTg2j
   TPG4xHIMQwcn42s4ov2RVjh7x8lmxH2v5LD+kV90GoE18Hv7paYB58FNz
   U4oEo5kXUjbm7DyuNdy/tVYbUx85UG2dkVgzWMUaG1+po+JzNAUu52PhI
   w==;
X-IPAS-Result: =?us-ascii?q?A2E2CQAbEKNk/2QgFKxagQmBT5sQg0eZIYEsggQJAQEBA?=
 =?us-ascii?q?QEBAQEBCAFEBAEBixQmNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQEFAQEBAQEBB?=
 =?us-ascii?q?gQCAoEZhS86DIZPOlUBIBwxhW6rOYE0gQGzEQkNgWgJAYE4jTeEeYFJRIkJh?=
 =?us-ascii?q?nsEjh6FXweMJ2WBJ29NUYEeL0sCCQIRZ4EICF6Bbz4CDVULC2OBHIJOAgIRO?=
 =?us-ascii?q?hRTeBsDBwNKOxAvBwQvJgYJGC8lBlEHLSQJExVBBINYCoENPxUOEYJXIgI9P?=
 =?us-ascii?q?BtOgmoJFw44U4E7A0QdQAMLcD01FBuCSYFvCkilN4EOgikOxQ2EE4Fdnz4zh?=
 =?us-ascii?q?AGlV5giIIIvpUYCBAIEBQIWgWOCFmwZgyNRGQ+iH4EeAgcLAQEDCYhugXxeA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:AwaEZapM3cJRAnvfRInN50Kdm0ReBmJUZBIvgKrLsJaIsI4StFCzt
 garIBmPOarbZzb9edFyPYnnpxwCu5+Gx982TFFoqC8yEioQo5acVYWSI27OZC7DdceroGCLT
 Sk9QoKZcJ1rFC+0SjOFaOWJQaxUjPnQLlbEILeYfHo3HWeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTb8XuDgNyo4GlD5gNmPqgS1LPjvyB94Kw3dPnZw0TQH9E88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8aiM7XAMEhhXJ/0F1lqTzTJ
 OJl7vRcQS9xVkHFsL5AAkMAS3kW0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklK0
 dhBch8ENiuznsL1mpuSTvMznvo8eZyD0IM34hmMzBn4K9gefr3zGv2So9ZUmio2nd8IEPrDI
 cMEAdZtRE2fOVsVYhFMUtRnxL/AanrXKlW0rHqH+PNuvjaOnCR6y7WrLdzOZZqHSdgTl1vwS
 mfurj2nXUBBbID3JTyt90Kni7TfhgzHR70PSLezzftO3hqByTlGYPERfR7hyRWjsWaxWs53N
 UMZ4GwtoLI0+UjtScPyNyBUu1aFuBAERNdASrVirgiBjLfS+BnfC2QZCDdcADA7iPILqfUR/
 gfht7vU6fZH6tV5lVr1Gm+okA6P
IronPort-HdrOrdr: A9a23:kCM5EakDEFAMGMFvLoyIb8jLByLpDfI/3DAbv31ZSRFFG/Fws/
 re+8jztCWE7Ar5N0tPpTntAsi9qBDnhPtICOsqTNWftWDd0QPCRuwPgrcKqweQfREWndQttp
 uIHZIfNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AAwEibmtU7nLQVCT/WPO+fNtt6IshVlmElljZe3S?=
 =?us-ascii?q?IEEYqEpS8TUXP4J17xp8=3D?=
X-Talos-MUID: 9a23:shrifgsRTHpqWTjYU82ngQFpOZx4+IuSF38QzZ8NgMyga2tiNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,178,1684764000"; 
   d="scan'208";a="91679304"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from infpwex100.ad.unsw.edu.au ([172.20.32.100])
  by infplacm016.services.comms.unsw.edu.au with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2023 04:18:43 +1000
Received: from INFPWEX101.ad.unsw.edu.au (172.20.32.101) by
 INFPWEX100.ad.unsw.edu.au (172.20.32.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 04:18:42 +1000
Received: from maillard.cse.unsw.edu.au (129.94.242.31) by
 INFPWEX101.ad.unsw.edu.au (172.20.32.101) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 04:18:42 +1000
Received: by maillard.cse.unsw.edu.au (Postfix, from userid 219)
        id 658A56EC3D; Tue,  4 Jul 2023 04:18:42 +1000 (AEST)
Received: from vx12.cse.unsw.edu.au (vx12.orchestra.cse.unsw.EDU.AU [129.94.242.94])
        by maillard.cse.unsw.edu.au (Postfix) with ESMTP id 5A9146EC3A
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 04:18:42 +1000 (AEST)
Received: by vx12.cse.unsw.edu.au (Postfix, from userid 35317)
        id 581AB11C78D2; Tue,  4 Jul 2023 04:18:42 +1000 (AEST)
Date:   Tue, 4 Jul 2023 04:18:42 +1000
From:   Dylan Brotherston <dylanb@cse.unsw.edu.au>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Possible Bug with `git commit -a` in v2.41.0
Message-ID: <ZKMRAkH1r2mQ85Ff@vx12.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit -a` is unable to remove the last file in the index in v2.41.0

 

comparing git version 2.30.2 to 2.41.0

 

```

$ git --version

git version 2.30.2

$ git init

Initialized empty Git repository in /tmp/tmp.vXqq6iVaqq/.git/

$ echo "foo" > a

$ git add a

$ git commit -m "C1"

[master (root-commit) b3abdc4] C1

 1 file changed, 1 insertion(+)

 create mode 100644 a

$ rm a

$ git commit -a -m "C2"

[master c3d4c44] C2

 1 file changed, 1 deletion(-)

 delete mode 100644 a

```

 

```

$ git --version

git version 2.41.0

$ git init

Initialized empty Git repository in /tmp/tmp.vXqq6iVaqq/.git/

$ echo "foo" > a

$ git add a

$ git commit -m "C1"

[master (root-commit) af7c07d] C1

 1 file changed, 1 insertion(+)

 create mode 100644 a

$ rm a

$ git commit -a -m "C2"

On branch master

Changes not staged for commit:

  (use "git add/rm <file>..." to update what will be committed)

  (use "git restore <file>..." to discard changes in working directory)

        deleted:    a

 

no changes added to commit (use "git add" and/or "git commit -a")

```

 

- Dylan Brotherston
