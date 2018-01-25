Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7967B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 18:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeAYSQg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 13:16:36 -0500
Received: from st11p06im-asmtp002.me.com ([17.172.125.150]:49929 "EHLO
        st11p06im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeAYSQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 13:16:35 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2018 13:16:35 EST
Received: from process-dkim-sign-daemon.st11p06im-asmtp002.me.com by
 st11p06im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3401800FSP3K00@st11p06im-asmtp002.me.com> for
 git@vger.kernel.org; Thu, 25 Jan 2018 17:16:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1516900595; bh=ZyjNrOmxY2NaWIKWl9j09YSCHJTfMhYLuM6iQgZnjzA=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=d6kndCWrrxOkoeBuVcs0gF9/ah4AxVVroLQ40m3r0lK80z/gA4kwpNUWzKfnaHlao
 hg15UjmNkpgg1xYrPhjjagmJDMGV8caI0YfhQXgRXsonrZ6tXo/Up8WwqQvAGERpWT
 vno0dzuU20fu/x7ClES5PmhXWza5iPhMb1rFgb/lEjmqfR0mZWPpV2TunZS1Th9rgR
 5VwXRYfJw0u+8mWCVvQl6eGUw0GqJR2oGOk0d8GmmCWOo1ESzPq6hFbcEa+ONJUNIT
 2KcXgn+nzxptRq1vYsiRVwSSOyc7csNo9QcrxzcXXXa3Qa7NflPDs8lK2I6xqQMiZL
 Wz09peKnQug9w==
Received: from icloud.com ([127.0.0.1]) by st11p06im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0P3400V76FZL1W10@st11p06im-asmtp002.me.com> for
 git@vger.kernel.org; Thu, 25 Jan 2018 17:16:34 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-01-25_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=12 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1801250233
From:   Robert Leach <hepcat72@me.com>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
Reply-to: rleach@princeton.edu
MIME-version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: git credential-osxkeychain bug/feature?
Message-id: <7445BC5F-F041-4E7D-8CB5-9513EEFF2C8C@me.com>
Date:   Thu, 25 Jan 2018 12:16:33 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3251)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wanted to submit an issue regarding the credential-osxkeychain =
interface functionality.  I don't know whether it's a bug or a feature =
request.  Maybe it's even impossible to address? - I don't know, but =
here's my issue.  Let me know if fixing/implementing this is a bad idea =
or if it's an issue relating to something wrong on my system and not an =
issue with git itself.

I have a git repo in a dropbox directory (not sure if that's relevant - =
just giving full disclosure).  I have set up git to not ask me for my =
password by using the credential-osxkeychain feature, and it works =
great... unless I'm connected via ssh to the machine that has a copy of =
my Dropbox on it.  Various git commands interrogate me for my login =
instead of using the credentials stored in the KA database on that =
remote machine, e.g.:

git remote show origin
Username for 'https://github.com': ^C

When I'm sitting at that machine, I do not get asked for my login =
credentials.

It's a minor issue, and kind of silly TBH.  I can always just work on my =
repo locally and synch, but if I'm working on a project that processes a =
large dataset, it's faster to edit the project on the machine with the =
data I'm testing it with.  I could VNC in or just synch after each =
change, which works around the issue, but it's nicer to just do =
everything on one ssh terminal session.

But perhaps access to KA from a remote ssh session is restricted for =
security reasons?  I'm just curious I suppose.  Should/can this work?

Thanks,
Rob
