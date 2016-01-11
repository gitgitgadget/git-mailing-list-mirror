From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git repository modified after migration
Date: Mon, 11 Jan 2016 16:04:42 +0100
Message-ID: <5693C48A.7060801@drmicha.warpmail.net>
References: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Yang Yu <yang.yu.list@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 16:04:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIe1e-00069J-C0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 16:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759323AbcAKPEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 10:04:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54492 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751825AbcAKPEo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2016 10:04:44 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E395F20A1D
	for <git@vger.kernel.org>; Mon, 11 Jan 2016 10:04:43 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 11 Jan 2016 10:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=y9rkqChVcplAqu4AdZLtgqlQoS8=; b=CkuXik
	nbcCskNNz4nwOjMuqn5arY7Zs2PTvSDF9z4kNpANqu3xTSZsb7M+2TsxVQtdpsw7
	PAFrnfeFpMgz1dDbp1HF6NcNBy6/7bEw9p3TlqTlMa2UTV6ZTDKcdR3BXoPrhGOT
	QmIqE7KtH+mpokNlCFLgwLdQAVumRdIoumLNk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=y9rkqChVcplAqu4
	AdZLtgqlQoS8=; b=UHGIjG7f+Ls5wQUbZamqSDTKZNXSrKlgkVP1F+OKmPkOEHa
	tYE1Spo2IULvYTJlFU5d+iU4eN4lMXTCYTZHOHdyNMJ3srp1TF6AB7w8GPFFeOwo
	GCPCNlruPNXp2ROF/RdoVF42K3KqWnJ2L1e541eSo/cyLCf3kd1cTI3jYSyU=
X-Sasl-enc: AKRqR5LdjfmjP++6NMMOJ+1o4z+5cTYvYcOnSq0p0k4A 1452524683
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 75620C016F3;
	Mon, 11 Jan 2016 10:04:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283656>

Yang Yu venit, vidit, dixit 25.12.2015 21:49:
> I migrated a 11G git repository converted from svn on a host with
> Debian 8.2, reiserfs, git 2.1.4 to a host with Ubuntu 12.04.5 LTS,
> xfs, git 2.6.4. After the migration, `git status` showing a good
> amount of files modified.
> 
> I did the transfer with
> 1) `rsync -azP`, after noticing the modified files I ran `rsync -avH
> --delete` but it did not correct the problem
> 2) tar zcf, then on the destination download the tar.gz (served by
> nginx) with wget
> 
> Both had the same result. But the original repository was still clean.
> 
> I did some comparison between "modified" and original files
> a) same hash (md5sum, shasum)
> b) same permission (-rw-r--r-- 1 )
> c) same encoding and line termination (UTF-8 Unicode (with BOM) text,
> with CRLF line terminators)
> d) no git attributes for either
> 
> 
> On the destination host, I ran `git checkout` on each of those
> modified files. After one pass I got less modified files. Repeating
> `git checkout` on remaining files for a few more times, finally I got
> a clean repository on the destination host.
> 
> What could have caused git to consider those files as modified? And
> why multiple `git checkout` again the same file was necessary?
> 
> Thanks.
> 
> 
> Yang

This happens whenever the "stat" information changes, e.g. due to
changed device numbering and such. "git reset --hard" would have been
the quickiest way to reset the stat cache/index - after git diff, of
course ;)

Michael
