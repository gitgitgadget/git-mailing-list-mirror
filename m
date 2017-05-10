Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4705920188
	for <e@80x24.org>; Wed, 10 May 2017 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbdEJUZS (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 16:25:18 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:52598 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750897AbdEJUZR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 May 2017 16:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1494447917; x=1525983917;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=YID97HsiBZ5AFfh8qjh1IaLoPoMhtu90kVTc6jaK1FM=;
  b=qEghoP50Zu6OnZ7TJQwvDZ9eTluXvqD6lYhmqp9VgNkKwhh4er1peoQE
   ellGUcSo8BhKC+OSnBh6h7D2GwFxQZYyyw5jtV2olLcvSYRA6oijrDsju
   Mo8Teh23KRZKnYCXJhA7yCToID4NKstK6N370gkHf8KkjJf4SozsGvpk9
   4=;
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2017 15:25:17 -0500
From:   "taylor, david" <David.Taylor@dell.com>
Received: from mailuogwdur.emc.com ([128.221.224.79])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 May 2017 02:18:38 +0600
Received: from maildlpprd54.lss.emc.com (maildlpprd54.lss.emc.com [10.106.48.158])
        by mailuogwprd51.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v4AKPFYf022115
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 10 May 2017 16:25:16 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd51.lss.emc.com v4AKPFYf022115
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1494447916; bh=iRl/DDtdE0Wv1R3MUYnV8X50h0w=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=fZk8ntrWsrnLkFkxPsvXelFfV6BXip9KByqIWJgIww+/cC8DPOaxrb+fSu7Dg3p8X
         wz2DLA0bA6f4Uf4Ml6imRpJr+yKdvl4a8O6hTr8juZ4qL+PJhsPj14FHMKMxaDobr4
         66WtMZ5RnMB7/bQeFyibZIXHGGTnHDbPN9TEw44c=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd51.lss.emc.com v4AKPFYf022115
Received: from mailusrhubprd01.lss.emc.com (mailusrhubprd01.lss.emc.com [10.253.24.19]) by maildlpprd54.lss.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Wed, 10 May 2017 16:24:53 -0400
Received: from MXHUB219.corp.emc.com (MXHUB219.corp.emc.com [10.253.68.89])
        by mailusrhubprd01.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v4AKP135013256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Wed, 10 May 2017 16:25:02 -0400
Received: from MX203CL03.corp.emc.com ([fe80::4dee:b763:b476:8fbc]) by
 MXHUB219.corp.emc.com ([10.253.68.89]) with mapi id 14.03.0266.001; Wed, 10
 May 2017 16:24:59 -0400
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git worktrees must exist even if locked
Thread-Topic: git worktrees must exist even if locked
Thread-Index: AdLJxLnaduSLoWUtQTOTfBkbFAeChA==
Date:   Wed, 10 May 2017 20:24:59 +0000
Message-ID: <63F1AEE13FAE864586D589C671A6E18B0D5F2C@MX203CL03.corp.emc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.238.48.71]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd01.lss.emc.com
X-RSA-Classifications: public
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git documentation in describing worktrees says that one reason
why you might want to lock a worktree is to prevent it from being pruned
if it is on a removable media that isn't currently mounted.

So, my expectation was that if the worktree is inaccessible (and locked), G=
it
would pretend that there is no worktree by that name.

In reality, if you have such a worktree, Git gets an error.

 On local systems, /home is local to a machine; home directories are elsewh=
ere.
Home directories are NFS mounted; /home is not.

. create a repository in /my/home/dir/my-repo.git with

    git clone --bare <some arguments>

. create an empty directory /home/somedir/worktree-tests

. use 'git worktree add' to add /home/somedir/worktree-tests/<branch-name>
  as a worktree on branch <branch-name>.  It gets populated with the correc=
t
  content.

. lock it using'git worktree lock'

So far, so good.  Now, go to a different computer -- one on which
/home/somedir/worktree-tests does not exist (and therefore
/home/somedir/worktree-tests/<branch-name> does not exist).

. cd /my/home/dir/my-repo.git

Now, try issuing Git commands.  Many will fail.

  git fetch =3D=3D> fails:

  fatal: Invalid path '/home/somedir/worktree-tests': No such file or direc=
tory

  git status =3D=3D> fails -- same error as above
  git help worktree =3D=3D> fails -- same error as above
