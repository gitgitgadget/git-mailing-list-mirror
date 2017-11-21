Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACD62036D
	for <e@80x24.org>; Tue, 21 Nov 2017 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdKURT2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 12:19:28 -0500
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:43611 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKURT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 12:19:27 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Nov 2017 12:19:27 EST
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0OZR00H00ZQATK00@pv33p36im-asmtp001.me.com> for
 git@vger.kernel.org; Tue, 21 Nov 2017 16:19:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1511281167;  bh=gy01kin5+wjHuvH+w3Wkjp9F/w8yYfV1W7SEfOFr3qQ=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=o6o/bwslHGsp3NPmhQnbo7j7o6nX3Sq/ViPApWQq1torORnTn0Nbvao1yjsronjBl
 Veu1NZChHqPvkyrZ74JO78SguvJNmkEe56FpS+5YJXhGFnrN/7MxSm0BVtlc3QeQ1o
 iqNxcOoKyzsx+4sWhxwuuxQHMtcDfKvFimnjjlyDZV+RTp4BPze9kY2OhGFeZ4u8x8
 j/PkBd+9KIR4xG7G1P3JN0DEumwAOwYY5ll9TBdQfTUaDXmi+RVHzgXwZc9/ClAVNv
 e/lUU5AlsILMAA1aM5C4UHS8mTJH9Eok2uBGf5a511Hl3jaBfzVCqE4RFSjiZs2/i+
 8A9UmjnEDRxoQ==
Received: from icloud.com ([127.0.0.1]) by pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0OZS000FH005XI30@pv33p36im-asmtp001.me.com> for
 git@vger.kernel.org; Tue, 21 Nov 2017 16:19:26 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2017-11-21_06:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=3 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1711210217
From:   Laetitia Pfaender <laetitia.pfaender@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: bash script to pull in branch B the changes from parent branch A
Message-id: <BEFA6451-9A9A-4B44-B067-727136AD39EF@icloud.com>
Date:   Wed, 22 Nov 2017 00:19:22 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a bash script to pull in branch B the changes from parent branch =
A that does the following:

cd repo-in-branchB
git branch --set-upstream-to=3Dorigin/branchB
git pull
git branch --set-upstream-to=3Dorigin/branchA
git pull
git branch --set-upstream-to=3Dorigin/branchB

It does exactly what I want but, as I have many children branches B to =
update, I would like to prompt my username and password only once and =
then makes the script use them in all following git requests. I came to =
the conclusion that I needed to update my script as follow:

read -p "Username for 'https://github.com': " username
read -s -p "Password for 'https://$username@github.com': " password
echo ""
cd repo-in-branchB
echo =E2=80=9Cpull from branchB"
git pull https://$username:$password@github.com/myrepo.git heads/branchB
echo =E2=80=9Cpull from parent branchA"
git pull https://$username:$password@github.com/myrepo.git heads/branchA

I have never used this kind of URLs, so just to make sure, are these 2 =
versions conceptually equivalent? Will they do the exact same thing?

Best regards

Laetitia

PS: I=E2=80=99m open to suggestions but note that I don=E2=80=99t want =
to rebase, neither can I configure my username and password in a =
permanent way on this server.



