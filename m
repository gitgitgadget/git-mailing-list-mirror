From: DavidLeeCrites <lee@critesclan.com>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Fri, 27 Nov 2015 14:37:33 -0700 (MST)
Message-ID: <1448660253143-7643470.post@n2.nabble.com>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com> <20100513005218.GA20655@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 22:37:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2Qi1-0003QP-1s
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 22:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbbK0Vhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 16:37:37 -0500
Received: from mwork.nabble.com ([162.253.133.43]:59288 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187AbbK0Vhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 16:37:35 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id D28732EA9E35
	for <git@vger.kernel.org>; Fri, 27 Nov 2015 13:38:41 -0800 (PST)
In-Reply-To: <20100513005218.GA20655@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281780>

I am getting the same kinds of errors, but the resolutions offered here did
not work. After using the ideas (that there was a tmp_* file I did not have
perms to write to, I started doing some global searches. 

One such was this (from inside .git/objects):
# ls -alR | grep tmp
ls: reading directory ./97: Input/output error

So I tried:
# cd 97
# ls -l
ls: reading directory .: Input/output error
total 0K

To fix it, I did this:
# cd ..
# rm -fr ./97

The git push then worked fine.

I'll add a few more pieces to the puzzle. I have some of my git repositories
on a USB drive (the ones I get this issue with). I move it from system to
system. When git works, it works okay. But this irritant hits me about once
a week. My previous solution was to blow away the repo and rebuild it
(something suggested several times here). This is the first time I have
found a workaround.

These are my private repositories that hold my private files. I have a
github account I use for my public ones, plus my company has both a public
github and their own privately hosted github. So the same exact computer
systems (laptops and VMs) use all four with impunity. Almost all of them are
linux based -- a mix of CentOS 7.x and Linux Mint 14.x; all using git
v1.9.1. The one exception is osx. Thus the (brand new Toshiba 4T) USB drive
is built with the exFAT filesystem. When it works, it works okay; but as I
said, one of my dozen git repos will fail like this on a weekly basis. 

None of the items in my dockerhub or artifactory fail, nor do my rsnapshot
processes, or VLC/Banshee, etc. 

I've pretty much isolated it down to git. It is the ONLY app that fails. I
have noted in the past few months that the frequency of errors tells me I
cannot be using the USB drive for anything else while git is accessing the
drive. [mac specific: it is better when I use a USB 2.0 hub to plug the
drive in; we all are probably aware that the mac seems to have more issues
with USB 3.0...]

Anyway, I figured I'd toss this into the mix. Since it only happens once a
week or so, I cannot guarantee I'll have an update soon, but if someone is
curious, ping me, and I'll let you know when it happens again.

DL





--
View this message in context: http://git.661346.n2.nabble.com/remote-rejected-master-master-n-a-unpacker-error-tp5043046p7643470.html
Sent from the git mailing list archive at Nabble.com.
