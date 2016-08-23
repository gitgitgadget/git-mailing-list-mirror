Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C461FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbcHWQjs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 Aug 2016 12:39:48 -0400
Received: from smtp6.opentext.com ([205.211.178.42]:48932 "EHLO
        smtp6.opentext.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbcHWQjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:39:47 -0400
X-Greylist: delayed 3243 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Aug 2016 12:39:47 EDT
Received: from otwlxg11.opentext.net (otwlxg11.opentext.net [10.2.103.152])
        by wldmzsvc06.dmz.opentext.com (8.14.4/8.14.4) with ESMTP id u7NFkGua007236
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 11:46:17 -0400
Received: from OTWLXG90.opentext.net (10.2.102.170) by otwlxg11.opentext.net
 (10.2.103.152) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 23 Aug
 2016 11:45:34 -0400
Received: from OTWLXG20.opentext.net ([169.254.2.88]) by otwlxg90.opentext.net
 ([10.2.102.170]) with mapi id 14.03.0294.000; Tue, 23 Aug 2016 11:45:34 -0400
From:   David McGough <dmcgough@opentext.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Smart HTTP push permissions failure
Thread-Topic: Smart HTTP push permissions failure
Thread-Index: AdH9UAqG/VuKfPWxRkeGHFrHOKkKBg==
Date:   Tue, 23 Aug 2016 15:45:33 +0000
Message-ID: <89CBBBEBEE33F5469A9FA456B5F70625CCDB9BEB@otwlxg20.opentext.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.111.33]
X-TM-AS-Product-Ver: SMEX-11.0.0.1191-8.000.1202-22530.005
X-TM-AS-Result: No--14.194600-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Community!

I'm trying to get Git on the server.  I installed Git and httpd on Centos 7 and configred for smart http.  I created a project on my local git and I cloned it to a base repository:
git clone --bare DataConversion DataConversion.git then I scp it to the server: scp -r DataConversion git@xx.xx.xx.xx:/opt/git/repository/product/tools.  Then on the server for the project I ran git config core.sharedRepository group  

I added a remote server to my local project: git remote add origin http://xx.xx.xx.xx/git/product/tools/DataConversion.git

git remote -v shows:
origin  http://xx.xx.xx.xx/git/product/tools/DataConversion.git (fetch)
origin  http://xx.xx.xx.xx/git/product/tools/DataConversion.git (push)

When I try to push to the server I get this message:
remote: error: insufficient permission for adding an object to repository database ./objects
remote: fatal: failed to write object

Fwiw I can clone the project from the server to my local.

Here are the permssions on the project and the objects folder.

[git@services-git DataConversion.git]$ pwd
/opt/git/repos/product/tools/DataConversion.git
[git@services-git DataConversion.git]$ ll
total 24
-rwxrwxr-x.  1 git staff  196 Aug 23 11:24 config
-rwxrwxr-x.  1 git staff   73 Aug 22 15:28 description
-rwxrwxr-x.  1 git staff   23 Aug 22 15:28 HEAD
drwxrwxr-x.  2 git staff 4096 Aug 22 15:28 hooks
drwxrwxr-x.  2 git staff   20 Aug 22 15:28 info
drwxrwxr-x. 65 git staff 4096 Aug 22 16:50 objects
-rwxrwxr-x.  1 git staff   98 Aug 22 15:29 packed-refs
drwxrwxr-x.  4 git staff   29 Aug 22 15:29 refs
[git@services-git DataConversion.git]$
[git@services-git DataConversion.git]$ cd objects
[git@services-git objects]$ ll
total 12
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 06
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 08
drwxrwxr-x. 2 git staff   96 Aug 22 15:28 0a
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 17
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 19
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 1c
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 24
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 29
drwxrwxr-x. 2 git staff 4096 Aug 22 15:28 30
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 32
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 33
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 3d
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 3f
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 41
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 4b
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 57
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 5a
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 5d
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 5f
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 64
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 65
drwxrwxr-x. 2 git staff 4096 Aug 22 15:28 69
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 6d
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 70
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 74
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 7a
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 7b
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 7c
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 84
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 89
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 8a
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 8c
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 93
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 9d
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 a0
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 a2
drwxrwxr-x. 2 git staff 4096 Aug 22 15:28 a3
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 a6
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 ab
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 af
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 b1
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 b7
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 b8
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 c3
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 c8
drwxrwxr-x. 2 git staff   96 Aug 22 15:28 c9
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 cb
drwxrwxr-x. 2 git staff   51 Aug 22 15:28 cf
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 d1
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 d8
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 d9
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 db
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 dc
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 e1
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 e7
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 e9
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 ea
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 ed
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 f0
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 f3
drwxrwxr-x. 2 git staff   51 Aug 22 15:29 f5
drwxrwxr-x. 2 git staff    6 Aug 22 15:29 info
drwxrwxr-x. 2 git staff    6 Aug 22 15:29 pack

apache and git users are both in the staff group, and staff group is their default group.  I have also tried to use the set group id bit but to no avail. http://www.gnu.org/software/coreutils/manual/html_node/Directory-Setuid-and-Setgid.html

[root@services-git DataConversion.git]# groups apache
apache : staff git
[root@services-git DataConversion.git]# groups git
git : staff apache

So I am pretty confused about what the issue.  Which OS user is git using to write the files?  I hope somebody can help me understand why the project cannot be pushed to the git server.  

Thanks,
Dave

  






