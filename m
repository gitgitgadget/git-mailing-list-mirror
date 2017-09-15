Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFA620A21
	for <e@80x24.org>; Fri, 15 Sep 2017 06:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbdIOGXZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Sep 2017 02:23:25 -0400
Received: from mail.greatergiving.com ([208.187.18.38]:64514 "EHLO
        APVWEB37.auctionpay.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751184AbdIOGXZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Sep 2017 02:23:25 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Sep 2017 02:23:24 EDT
Received: from APEXC04.auctionpay.com (192.168.2.11) by
 APVWEB37.auctionpay.com (192.168.2.17) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 14 Sep 2017 23:18:15 -0700
Received: from APEXC04.auctionpay.com (192.168.2.11) by APEXC04.auctionpay.com
 (192.168.2.11) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 14 Sep
 2017 23:18:14 -0700
Received: from APEXC04.auctionpay.com ([fe80::4d53:2f59:1dec:ea9d]) by
 APEXC04.auctionpay.com ([fe80::24ba:89c:65c4:8a2c%16]) with mapi id
 15.00.1178.000; Thu, 14 Sep 2017 23:18:14 -0700
From:   Wesley Smith <wsmith@greatergiving.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Is finalize_object_file in sha1_file.c handling errno from "rename"
 correctly?
Thread-Topic: Is finalize_object_file in sha1_file.c handling errno from
 "rename" correctly?
Thread-Index: AdMt6BzgEtMQTdVEQOO+ofsy4hJiUw==
Date:   Fri, 15 Sep 2017 06:18:13 +0000
Message-ID: <c9b3bc17110048f0b7943704cfbd8f68@APEXC04.auctionpay.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [24.22.20.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: =?us-ascii?Q?H4sIAAAAAAAAC12Sf0gTYRzGe7fbdpYX5+b02+iHXRSSP9JKTEL6HVlUlpBM?=
 =?us-ascii?Q?sjrtcgPdxm6jiURGFrVQR5FREi40KykwyzJWMxdRqbQYaqJQaCKlGWGUFa51?=
 =?us-ascii?Q?tzttdn993ud9n+f9Pi+HS5VuhQZnbBbGbKALKfls7OlNyZyEGyaXNuluu687?=
 =?us-ascii?Q?bI2965xkPdr2rWlhJsqR6Q15Rtshme7kWCVm8iyzDddeQ6WoNMaOZuNKsgnB?=
 =?us-ascii?Q?cKBaPr2o6x1TCAs3gtKzPzA7CsPlZAK0Ok9xjOOR5AqoeKPmZRWphbLyShnP?=
 =?us-ascii?Q?keQBaPP2KQROhH5nFeIZI5fC8P3WIBPkFqgMuIOMyCiYaL8t4VlKRkPfUE2Q?=
 =?us-ascii?Q?gYyDhyNumcDx0NTTgAmcDnUVPqnAJNQ99opMQXn/F9Grhk8f/ojeRJgofyrn?=
 =?us-ascii?Q?RwZyD9ypNglyCnyu84mRSdB83S3yKmisDcimrnp5xy/Gb4Kfzb2ivggC795j?=
 =?us-ascii?Q?QuQ6uNSzdUqe/FGhEDgTXju8wRcE8oUEak78EXOy4ETjVMV0+HrRhTnQyish?=
 =?us-ascii?Q?7QWOB6drXC5wHNRfG5VeCb5cBLy6PIQ5EdaAojdk7svesnFVaiJtzbfojQYT?=
 =?us-ascii?Q?XZyYbyxqQsK/ENGCGidzPCgNl1Bq4knCI61ybp7xcLGOZnUHzdZChqUWEjs6?=
 =?us-ascii?Q?W7TK6GmZtbImfb7eaGUPWs2FHrQOxykgTEaXVhlhZgoY2xF9IffDifbFxKWS?=
 =?us-ascii?Q?h1qlJnTn/wQJHuZBqXg4FUnU8jEEa6KLWH2BGLGAcPITRE2pM+3taK0mmvAU?=
 =?us-ascii?Q?cT6SP6GzGqZv18QQPTu4jXkhGzPdPqTWqIjjDHco3MSYi/QWwdmHVPiARIkZ?=
 =?us-ascii?Q?jAZGw73VLO6LRSMoBUeUitjGTxmuN1j+DTmfuMUPqRbFmbeMcO0kXLvOjha+?=
 =?us-ascii?Q?nYW2hLbzdwTbiepMp6YUwRfM0upVJskqLfu9Vx2qM3lkvV91I/fr87FzSaer?=
 =?us-ascii?Q?3rm6dgeab/4+Eulvu6Xo1pRdji2girs+lnWe99keZFF3jw4O5so3DF8cd6RV?=
 =?us-ascii?Q?delGL/xafc9Rn6FgdpKxGUuO9e3Nfpb81q8d31Qir5+MeWkf2T9Af6/e/D1j?=
 =?us-ascii?Q?0piyfVdDehaFsTo6ebnUzNJ/ASamrVtRBAAA?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using git 2.14.1 for Windows

I'm seeing an issue with the follow sequence of commands:


git init D:\XXX\workspace
git fetch --no-tags --progress https://XXX/_git/PAPI +refs/heads/*:refs/remotes/origin/* --depth=20
git fetch --no-tags --progress https://XXX/_git/PAPI +refs/heads/*:refs/remotes/origin/* --depth=20
git fetch --no-tags --progress https://XXX/_git/PAPI +refs/heads/*:refs/remotes/origin/* --depth=20

The third "git fetch" command hangs forever and takes 100% of the CPU.

I've debugged this a bit, and what I've found is that after the first fetch, the .git/objects/pack directory contains 2 files:

pack-b64910484b4254836a6413ce6a94019278fc54c5.pack
pack-b64910484b4254836a6413ce6a94019278fc54c5.idx


After the second fetch, the directory contains 4 files:

pack-b64910484b4254836a6413ce6a94019278fc54c5.pack
pack-b64910484b4254836a6413ce6a94019278fc54c5.idx
pack-ae983dc9c8057f4d5d2c8cdc3485cb6badde864b.pack
pack-ae983dc9c8057f4d5d2c8cdc3485cb6badde864b.idx

When the third "git fetch" is run, it spawns this chain of commands:

git fetch --no-tags --progress https://XXX /_git/PAPI +refs/heads/*:refs/remotes/origin/* --depth=20
  git remote-https https://XXX/_git/PAPI https://XXX/_git/PAPI
    git-remote-https https://XXX/_git/PAPI https://XXX/_git/PAPI
      git fetch-pack --stateless-rpc --stdin --lock-pack --thin --depth=20 https://XXX/_git/PAPI/
         git --shallow-file D:/XXX/workspace/.git/shallow.lock index-pack --stdin -v --fix-thin "--keep=fetch-pack 15728 on DT0004" --pack_header=2,3425

It's the final of these git instances  (the --shallow-file one) that's hanging.

Upon debugging this "git --shallow-file" process, the problem is as follows:  (line numbers relative to https://github.com/git/git/blob/master/sha1_file.c)

In sha1_file.c,  finalize_object_file is called with a tmpfile value of "tmp_pack_AmXsya" and a filename of "pack-ae983dc9c8057f4d5d2c8cdc3485cb6badde864b.pack". Note that this filename already exists (it was created by the second fetch).  On line 3236, the condition (object_creation_mode == OBJECT_CREATION_USES_RENAMES) is true on Windows, so the code runs the goto try_rename.

On line 1378,  rename is called, which on Windows is defined as a specialized function called mingw_rename.  I've identified a bug in this Windows-specific mingw_rename function that causes an infinite loop if the new filename (pack-ae983dc9c8057f4d5d2c8cdc3485cb6badde864b.pack) already exists, _and_ is locked by another process.  In this case, it appears that the first "git fetch" call in the process chain has opened the pack file, which is why this process can't rename the temp file to that name.

I can fix the infinite loop in the mingw_rename function, but the question is what errno should be returned by mingw_rename, and that brings me to my question regarding the finalize_object_file function.

On UNIX-style OSes, the code would first try to perform a "link" call in line 1380.  According to my reading of the link(2) man page, I think (but haven't tested) that link call would return EEXIST in this case (the newpath already exists).  If link returns EEXIST, then the code will skip most of the rest of the code in finalize_object_file, and will return 0 (success) on line 1411.  However, on systems where object_creation_mode is OBJECT_CREATION_USES_RENAMES, then the code will call "rename" instead on line 1396.   According to my reading of the rename(2) man page,  EACCES would  be returned in this case (because the pack file is locked by another process).  Notably, EEXIST would _not_ be returned from rename, as rename only returns EEXIST if "newpath is a nonempty directory".   Since finalize_object_file doesn't have any special logic for EACCES, if I fixed the Windows version of the rename function to return the correct errno (EACCES), then the finalize_object_file will return the error "unable to write sha1 filename" on 1403 and that will cause the program to die.

My questions:

1) This bug is triggered because "git fetch" is causing a pack file to be written when that same pack file already exists.  It seems like this is harmless and shouldn't cause a problem.  Is that correct?
2) It seems that finalize_object_file is not accounting for the fact that "link" will return EEXIST if the destination file already exists but is not writeable, whereas "rename" will return EACCESS in this case.  Is that correct?  If so, should finalize_object_file be fixed to account for this? Perhaps it should check if the newfile exists before calling rename.  Or, should the Windows mingw_rename function be modified to return EEXIST in this case, even though that's not the standard errno for that situation?

Thanks for your help,

Wesley Smith
