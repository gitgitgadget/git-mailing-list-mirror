From: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 00/13] Eliminate 'top' and 'bottom' files
Date: Sun, 16 Sep 2007 12:28:55 +0200
Message-ID: <2060EB60-9404-429F-94D8-3739B06BB96E@lysator.liu.se>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070915234244.GD25507@diana.vm.bytemark.co.uk> <b0943d9e0709160028h41a67474g6b379a45c4c88432@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q? "Karl_Hasselstr=F6m" ?= <kha@treskal.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 12:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWrNA-0006Lk-6T
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 12:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbXIPK3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 06:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbXIPK3A
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 06:29:00 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:47074 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbXIPK27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 06:28:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C3BB6200A1FE;
	Sun, 16 Sep 2007 12:28:58 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03489-01-13; Sun, 16 Sep 2007 12:28:57 +0200 (CEST)
Received: from [192.168.1.198] (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	by mail.lysator.liu.se (Postfix) with ESMTP id C7507200A1FC;
	Sun, 16 Sep 2007 12:28:57 +0200 (CEST)
In-Reply-To: <b0943d9e0709160028h41a67474g6b379a45c4c88432@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58311>


16 sep 2007 kl. 09.28 skrev Catalin Marinas:

> On 16/09/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>> On 2007-09-15 00:31:09 +0200, David K=E5gedal wrote:
>>
>>> The following series removes the 'bottom' and 'top' files for each
>>> patch, and instead uses the commit objects to keep track of the
>>> patches.
>>
>> Wonderful! Does this ensure that there's a bijection between patches
>> and commits at _all_ times, or am I missing something?
>
> We should get rid of top.old and bottom.old as well.
>
> My question - does this conflict with the DAG patches in any way? I
> intend to include the them at some point, once I get a chance to test
> the performance penalty with a big tree like the Linux kernel.

My refactoring of the push_patch function will conflict because of =20
refactoring, but it doesn't change how the appliedness is used, so it =20
should be pretty simple to resolve.

Or I could try to redo the patches so it only has the minimal changes =20
to actually remove the top and bottom files.

>> Hmm, wait, no. Right. We also have to create commits for those =20
>> patches
>> that don't have exactly one commit object. Not that there'll be many
>> of them, but better not make assumptions ...
>
> Is there any patch which consists of more than one commit? Maybe only
> uncommit could generate one but I think we put some tests in place.

I haven't seen any such case. Can uncommit create one? Or did it use =20
to do that before? I added checks to detect it, and no test case =20
caught it at least.

--=20
David K=E5gedal
davidk@lysator.liu.se
