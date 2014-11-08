From: Michael Blume <blume.mike@gmail.com>
Subject: Test failure
Date: Sat, 8 Nov 2014 11:28:32 -0800
Message-ID: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 20:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnBgv-00077f-J5
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 20:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbaKHT2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 14:28:53 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:41991 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaKHT2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 14:28:53 -0500
Received: by mail-oi0-f52.google.com with SMTP id u20so3763424oif.25
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WMLu507GLnO1pQ9KDzALDDYyLGk7RHR8I5e7PuZPlMk=;
        b=nTNmataQ5whFHfu7gSrHflxIM3/rYEl99a0XUD9OtjFzQzgOaiBFaDnAs5z0d+mctD
         60ZNbcbbxpsL2SA67fq/1H9BBAmr9UcclrPDmZTVQyWlxjXb0QqMbngWH0qVU/wA7CHs
         Ma2RRGjuvvYzSNUT2OJMEaMOXBk1gMqVyk7KYfgeEFuZh+IX+dm/e9LJskUM/QiztimF
         rSnCooD2i6VnMqmk67G6GbNlz+LYyyRFdd/Bin65V1tsAnSo9tYSaWnXvIm4wRZPKvyv
         UpD6MTi+abE4tj0qOahBj+tmveSCjmGFKcFWjUwRTueswMaLl9jf/l02t5XCYt4SEDDA
         As2w==
X-Received: by 10.60.123.77 with SMTP id ly13mr2329841oeb.79.1415474932557;
 Sat, 08 Nov 2014 11:28:52 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Sat, 8 Nov 2014 11:28:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm on a macbook running a beta of Mac OS Yosemite 10.10.1. I've never
been able to get GETTEXT to work so I have

NO_GETTEXT=1

in my makefile, but other than that I'm using the master branch of the
official github mirror.

When I build and run tests I get

[11:17][michael.blume@tcc-michael-4:~/workspace/git/t(master)]$
./t1410-reflog.sh
ok 1 - setup
ok 2 - rewind
ok 3 - corrupt and check
ok 4 - reflog expire --dry-run should not touch reflog
ok 5 - reflog expire
ok 6 - prune and fsck
ok 7 - recover and check
ok 8 - delete
ok 9 - rewind2
ok 10 - --expire=never
ok 11 - gc.reflogexpire=never
ok 12 - gc.reflogexpire=false
ok 13 - checkout should not delete log for packed ref
not ok 14 - stale dirs do not cause d/f conflicts (reflogs on)
#
# test_when_finished "git branch -d a || git branch -d a/b" &&
#
# git branch a/b master &&
# echo "a/b@{0} branch: Created from master" >expect &&
# git log -g --format="%gd %gs" a/b >actual &&
# test_cmp expect actual &&
# git branch -d a/b &&
#
# # now logs/refs/heads/a is a stale directory, but
# # we should move it out of the way to create "a" reflog
# git branch a master &&
# echo "a@{0} branch: Created from master" >expect &&
# git log -g --format="%gd %gs" a >actual &&
# test_cmp expect actual
#
not ok 15 - stale dirs do not cause d/f conflicts (reflogs off)
#
# test_when_finished "git branch -d a || git branch -d a/b" &&
#
# git branch a/b master &&
# echo "a/b@{0} branch: Created from master" >expect &&
# git log -g --format="%gd %gs" a/b >actual &&
# test_cmp expect actual &&
# git branch -d a/b &&
#
# # same as before, but we only create a reflog for "a" if
# # it already exists, which it does not
# git -c core.logallrefupdates=false branch a master &&
# : >expect &&
# git log -g --format="%gd %gs" a >actual &&
# test_cmp expect actual
#
# failed 2 among 15 test(s)

(I get the same thing with 'make test' but this is me just running the
problematic test)

A quick search seems to indicate the test is pretty new?
http://www.mail-archive.com/git@vger.kernel.org/msg60495.html

Test passes in my ubuntu vm.
