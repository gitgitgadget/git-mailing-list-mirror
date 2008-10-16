From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git and filesystem problems (ext3 and vfat)
Date: Thu, 16 Oct 2008 18:17:58 +0200
Message-ID: <48F76936.3010801@drmicha.warpmail.net>
References: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Brown <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:19:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqVZI-0002ps-LY
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 18:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbYJPQSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbYJPQSG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 12:18:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57767 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753529AbYJPQSF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2008 12:18:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B093618023F;
	Thu, 16 Oct 2008 12:18:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 16 Oct 2008 12:18:02 -0400
X-Sasl-enc: i+SpFPxd4seiYCw3Zz8VudjSbNJpZwzgkvYSNUwWfAMt 1224173882
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19E0B28431;
	Thu, 16 Oct 2008 12:18:01 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98396>

Ian Brown venit, vidit, dixit 16.10.2008 18:03:
> Hello, ]
> 
>  I have a diskOnKey which has a vfat filesystem.
> I ran there:
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> the I copied all the wireless-2.6 folder to an ext3 partition.

How did you copy it?

> There I ran git diff.
> 
> I get many messages like these (probably on all files of the repository):
> 
> diff --git a/COPYING b/COPYING
> deleted file mode 100644
> index ca442d3..0000000
> --- a/COPYING
> +++ /dev/null
> @@ -1,356 +0,0 @@
> -
> 
> and then all the lines of the file with "-" in the beginning, as if
> they are empty.
> 
> Why is it so ?
> Is there any way to overcome it ?
> Must I run "git clone" on an ext3 DiskOnKey only ?

git diff gives you the difference between the index and the work tree.
The index is the one you copied from vfat; git doesn't see the files on
the ext3 work tree. Do you see them with ls?

One by one I would try

git status
git reset
git reset --hard

in order to reconcile your index with your checkout. You probably need
the last one.

Michael
