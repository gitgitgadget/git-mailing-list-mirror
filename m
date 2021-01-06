Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D784C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40B723106
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbhAFLme (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:42:34 -0500
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:45619 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbhAFLme (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 06:42:34 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 06:42:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1609932929;
        bh=wsgppVF+BC5H9chb8bZrJCstCT86e6Rp78RqMv15j+0=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=ac4evOFI1Iqcie/nbRjDT2iwFrN1BNNgsUzXs6WjY4SQqPTVu/HxqUzp//c3zyjWV
         fs2hwrlvzlmM6h6xXuX+sJInKclZJoyBLAyVKD+2vofCjnJWoRn5LvpkumNnfp14qm
         QMVIjm7Hjnp1uqYDflKaiY//06VWg26d5cNnRaeDD1SmmYo7iEqHWHPpGB32s9arUd
         1a6FdLoPFuLhL7uUgBsctRGOpQ3J8bq+J5u5Czwrx2bV+B3Go85qsspkTs8XYudK+L
         QB9ZcdMVmf3UDvevzgwxRwgwjXMLgTxfKWnVKAlboiO85HEwIm7/fM0UqKnu1a0WIt
         rvIWfsSQ9PR2A==
Received: from [10.71.42.86] (unknown [193.32.127.239])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id 65367540549
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:35:29 +0000 (UTC)
From:   Daniel Troger <random_n0body@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-Id: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
Date:   Wed, 6 Jan 2021 12:35:26 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_05:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101060072
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I ran `git restore -p .`

What did you expect to happen? (Expected behavior)
git restore to open in interactive mode and letting me select data to =
discard

What happened instead? (Actual behavior)
I got an error message:
```
me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git restore -p .
BUG: pathspec.c:495: error initializing pathspec_item
Cannot close git diff-index --cached --numstat --summary HEAD -- =
:(,prefix:44)[redacted]/paulbrunng=C3=A5rd-springyard/src/ () at =
/usr/local/Cellar/git/2.29.2/libexec/git-core/git-add--interactive line =
183.
```

What's different between what you expected and what actually happened?
The main problem is that the command didn't do anything. It basically =
printed an error message instead of changing a file in the way I wanted.

Anything else you want to add:
Yeah. So pretty obviously the problem is the "=C3=A5" in the filename. =
The interesting thing is that the folder with the "=C3=A5" in the =
filename seems to exist twice, with differently encoded "=C3=A5"s. But =
their content IS AUTOMATICALLY PERFECTLY SYNCED. And the only tool which =
recognizes them as two different folders is git. ls in the terminal =
shows them as one, finder shows them as one, even "glob" in php shows =
them as one.
This is what git seems to see them at (taken from git status):

`modified:   "paulbrunnga\314\212rd-springyard/`
And further down:
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	"paulbrunng\303\245rd-springyard/"
```
Here is a zip containing the folder (emptied): =
https://arxius.io/f/7ec7e1c7
I tried creating a new git repo, extracting the zip in it, going into =
the folder and running `git add empty` and could reproduce that git sees =
it as two different folders.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Sun Jun  2 20:31:42 =
PDT 2019; root:xnu-4570.71.46~1/RELEASE_X86_64 x86_64
compiler info: clang: 10.0.0 (clang-1000.11.45.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

