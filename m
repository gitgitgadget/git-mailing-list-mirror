From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [Bug report] 'git status' always says "Your branch is
 up-to-date with 'origin/master'"
Date: Mon, 6 Jan 2014 09:24:29 +0100 (CET)
Message-ID: <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: worldhello.net@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 06 09:24:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W05US-0008Gn-49
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 09:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbaAFIYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 03:24:33 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:39620 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752708AbaAFIYb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 03:24:31 -0500
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 7D4AC82EF;
	Mon,  6 Jan 2014 09:24:29 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 798C0718798;
	Mon,  6 Jan 2014 09:24:29 +0100 (CET)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 717BD9BE3F;
	Mon,  6 Jan 2014 09:24:29 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 717BD9BE3F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1388996669; bh=XlLbmRU/kNK2dlNM77oYt4RV6jkJw5oJb4VLXO3mAIs=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=sZ6nwEq256c3XBipR2lKwS/kQFErwKii82xFklc7d44wJImgujyg3IRL+qFfIrFqS
	 hlhgAvhWHT+vxY0ESHiTtIPXcy5ZVvrfAMyvxCRQqIux04GtDImrUdNz07zMxP/lf6
	 HWuFldGy3UkhJtAyL/36FLIt2+H3PcQH5W5k7LBk=
Received: from [178.7.31.225] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Mon, 6 Jan 2014 09:24:29 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.31.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239988>

 
Hi Jiang,

this happens with all of my repo clones (I am using V1.8.5.2
on Windows and on Linux). Steps to reproduce:

mkdir repo_a && cd repo_a && git init .
echo "1">foo && git add foo && git commit -m "1"
cd ..
git clone repo_a repo_b
cd repo_a
echo "2">foo && git add foo && git commit -m "2"
cd ../repo_b
git status
git checkout -b "branch"
git checkout master

'git status' and 'git checkout master' in repo_b are now 
reporting "Your branch is up-to-date with 'origin/master'"
which is obviously wrong.

---
Thomas

----- Original Nachricht ----
Von:     Jiang Xin <worldhello.net@gmail.com>
An:      Thomas Ackermann <th.acker@arcor.de>
Datum:   06.01.2014 06:31
Betreff: Re: [Bug report] 'git status' always says "Your branch is up-to-date
 with 'origin/master'"

> 2014/1/5 Thomas Ackermann <th.acker@arcor.de>:
> > Since f223459 "status: always show tracking branch even no change"
> > 'git status' (and 'git checkout master' always says
> > "Your branch is up-to-date with 'origin/master'"
> > even if 'origin/master' is way ahead from local 'master'.
> 
> Hi, Thomas
> 
> Can you provide your operations so that I can reproduce this issue?
> 
> In the commit you mentioned above, there was a new test case named
> 'checkout (up-to-date with upstream)' added in 't6040'. I also add two
> test-cases locally in order to reproduce the issue you report, and run
> them in arbitrary orders, but they all look fine:
> 
>     ok 4 - checkout (behind upstream)
>     ok 5 - checkout (ahead upstream)
>     ok 6 - checkout (diverged from upstream)
>     ok 7 - checkout with local tracked branch
>     ok 8 - checkout (upstream is gone)
>     ok 9 - checkout (up-to-date with upstream)
>     ok 10 - checkout (upstream is gone)
>     ok 11 - checkout with local tracked branch
>     ok 12 - checkout (diverged from upstream)
>     ok 13 - checkout (ahead upstream)
>     ok 14 - checkout (behind upstream)
>     ok 15 - checkout (diverged from upstream)
>     ok 16 - checkout (upstream is gone)
>     ok 17 - checkout (ahead upstream)
>     ok 18 - checkout with local tracked branch
>     ok 19 - checkout (behind upstream)
> 
> 
> The two additional test cases I used locally are:
> 
>     checkout_test1() {
>     test_expect_success 'checkout (behind upstream)' '
>             (
>                     cd test && git checkout b3
>             ) >actual &&
>             test_i18ngrep "is behind .* by 1 commit, and can be
> fast-forwarded" actual
>     '
>     }
> 
>     checkout_test_2() {
>     test_expect_success 'checkout (ahead upstream)' '
>             (
>                     cd test && git checkout b4
>             ) >actual &&
>             test_i18ngrep "is ahead of .* by 2 commits" actual
>     '
>     }
> 
> -- 
> Jiang Xin
> 

---
Thomas
