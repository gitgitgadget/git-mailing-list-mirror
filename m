From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 22:47:18 +0300
Message-ID: <f19298770901111147t625a2161t779bfcfc0317225c@mail.gmail.com>
References: <200901111602.53082.borntraeger@de.ibm.com>
	 <200901111607.59054.borntraeger@de.ibm.com>
	 <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>
	 <200901111620.03345.borntraeger@de.ibm.com>
	 <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain>
	 <20090111194258.GA4840@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Christian Borntraeger" <borntraeger@de.ibm.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
To: "Sam Ravnborg" <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6Ie-00018C-Fy
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZAKTrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbZAKTrW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:47:22 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:52704 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZAKTrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:47:21 -0500
Received: by bwz14 with SMTP id 14so31260405bwz.13
        for <multiple recipients>; Sun, 11 Jan 2009 11:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=znSxrBCjSD6dXKlbeUp6PxoC+iMqaJyf2IwgIgwdFZI=;
        b=mCsaPrJA+GpifZUNKV8gbXAN3l5j1/XTfNnQWJjE6ZVizEM4JMDHTXhM4ZEik4sKTe
         /KMYRhEc9bXZpIK7XbW5zMCs4Ujqwh5p/lTsH9GB18qxu47GkH36Jt3DmAIO9fNYGkJk
         SDiuEbDWDrt+Ix3iDKyrLBK4wmMCk3jen5QUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NCxBa3JksZcEPQsfnO4IsYKKHpVuZsRq1KtivbvnZajPwHXQr+fveJs/WLrI2Jb0yN
         KJL1kQDUmlnpGtlVPhpyjQX6XsBHLTwiP+Qxja+IMyTvt+5qL2ekDEBnDUbp5KpW+jZI
         yp8OKY4Hw8jAFFx4ZwAwP6dO7ugLt+pxHcX2A=
Received: by 10.223.105.208 with SMTP id u16mr1726230fao.14.1231703238830;
        Sun, 11 Jan 2009 11:47:18 -0800 (PST)
Received: by 10.223.121.211 with HTTP; Sun, 11 Jan 2009 11:47:18 -0800 (PST)
In-Reply-To: <20090111194258.GA4840@uranus.ravnborg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105203>

On Sun, Jan 11, 2009 at 22:42, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> For bisect, it's indeed somewhat annoying, and we could have perhaps done
>> some things a bit differently, but it's about the closest you can get to
>> "real history" without making the first btrfs merge-point a _total_
>> disaster.
>>
>> For bisect purposes, if you know you're not chasing down a btrfs issue,
>> you can do
>>
>>       git bisect good 34353029534a08e41cfb8be647d734b9ce9ebff8
>>
>> where that commit 34353029 is the last one which has _just_ the btrfs
>> files. The next commit is when it does "Merge Btrfs into fs/btrfs", and
>> that one has the whole kernel tree again.
>
> The cost of moving this piece of history from one git tree to another
> git tree is that we make it harder to debug the kernel for the advanced user
> that knows how to do bisect.

And wasn't is trivial to avoid? Just exporting the commits as
patches and importing them into the kernel tree would preserve
the history, and not break bisection.
