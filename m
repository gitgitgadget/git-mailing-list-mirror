From: Jan Keromnes <janx@linux.com>
Subject: Fwd: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Fri, 29 Apr 2016 14:53:49 +0200
Message-ID: <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 14:53:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7vf-0006kC-L2
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbcD2Mxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:53:52 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35836 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbcD2Mxv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:53:51 -0400
Received: by mail-wm0-f52.google.com with SMTP id e201so26489376wme.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to;
        bh=kkhzz5tJIZyJpYi+vjtSre6TmdPldPC/a5LGW4j5FUM=;
        b=Ps4RkwAWWvUcD9nZRGFDHa4o/5N6Ly4fUj47pwLVnBcweFuvBCseIRImIlzWgHGrW4
         q5+oR8kbr448QDDvsaWW20yQDPRVSu9qX6trMMjbyHmVMClPsIOAmGZGnYUeOXDaP9LG
         xis1Cj1Zdz1xYwHodpmFTAWGUgqM/w1v5ICDwmlpS3TcGO/GbRVnqUevTideew6Z5c2f
         rgBjx33mewaZrN4WjyTrQTbUxTVDlMlGvDNLmMDedz99G/QgZ2MHPh4feLTZ0xrTePy5
         Vno5DCOQrodNrNUrXLMErXe5lzQQ5QnpCEY4A69QYi7DJQ0x7TDNXYAoJTJiy1uzOiJx
         sn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=kkhzz5tJIZyJpYi+vjtSre6TmdPldPC/a5LGW4j5FUM=;
        b=nBjo5J06OoNKRcqzKIq5Cjc7TZ+RC3khkWQp1oy8gc/Xk5aKEKJs/Fnu3sGJJ0ASV3
         zFHT0mDsQHxS9GOHMC41vdYpCcaf5p+vqMYAfoIbHZvdTYTEPx9vkbVrcwwYgcbpfY4w
         qqyHHHhN1sCz2lbB5U3gqK7J2JVZpPvIkTBYnOuNbK3TFeHdg+ZvigHriS7Nk93QTWIQ
         7aZRZduW7swDuS8vVO4rtrrHvuo9BO4hDbewhqqWXaHyiHSGQMSw06OrqSgCt0tntqNF
         Xxab8iFEIx8g79dkEnaNACOKxmXS2kEpj50MpD0FkOUofLWcFmGD8MTIgcFw7YaaRuc5
         MQ2A==
X-Gm-Message-State: AOPr4FUeYJCaM0M0Xsg7iWemqG0gCvZheS/3lZLrpllE9/AC50/NIy3/QFCkRFf3nx1kKdphzjCLY6fD7JYFQw==
X-Received: by 10.28.85.137 with SMTP id j131mr3795303wmb.15.1461934430019;
 Fri, 29 Apr 2016 05:53:50 -0700 (PDT)
Received: by 10.28.175.74 with HTTP; Fri, 29 Apr 2016 05:53:49 -0700 (PDT)
In-Reply-To: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
X-Google-Sender-Auth: XixINHhQABg6xdkrmXkbAAbWPMY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292993>

Hello,

I tried running a full profile build of Git 2.8.1, but it looks like
test #32 in `t7300-clean.sh` fails:

Commands:

> curl https://www.kernel.org/pub/software/scm/git/git-2.8.1.tar.xz | tar xJ
> cd git-2.8.1
> make prefix=/usr profile-install install-man -j18

Logs of test-suite that fails:

*** t7300-clean.sh ***
ok 1 - setup
ok 2 - git clean with skip-worktree .gitignore
ok 3 - git clean
ok 4 - git clean src/
ok 5 - git clean src/ src/
ok 6 - git clean with prefix
ok 7 - git clean with relative prefix
ok 8 - git clean with absolute path
ok 9 - git clean with out of work tree relative path
ok 10 - git clean with out of work tree absolute path
ok 11 - git clean -d with prefix and path
ok 12 - git clean symbolic link
ok 13 - git clean with wildcard
ok 14 - git clean -n
ok 15 - git clean -d
ok 16 - git clean -d src/ examples/
ok 17 - git clean -x
ok 18 - git clean -d -x
ok 19 - git clean -d -x with ignored tracked directory
ok 20 - git clean -X
ok 21 - git clean -d -X
ok 22 - git clean -d -X with ignored tracked directory
ok 23 - clean.requireForce defaults to true
ok 24 - clean.requireForce
ok 25 - clean.requireForce and -n
ok 26 - clean.requireForce and -f
ok 27 - core.excludesfile
ok 28 # skip removal failure (missing SANITY)
ok 29 - nested git work tree
ok 30 - should clean things that almost look like git but are not
ok 31 - should not clean submodules
not ok 32 - should avoid cleaning possible submodules
#
#               rm -fr to_clean possible_sub1 &&
#               mkdir to_clean possible_sub1 &&
#               test_when_finished "rm -rf possible_sub*" &&
#               echo "gitdir: foo" >possible_sub1/.git &&
#               >possible_sub1/hello.world &&
#               chmod 0 possible_sub1/.git &&
#               >to_clean/should_clean.this &&
#               git clean -f -d &&
#               test_path_is_file possible_sub1/.git &&
#               test_path_is_file possible_sub1/hello.world &&
#               test_path_is_missing to_clean
#

Best,
Jan
