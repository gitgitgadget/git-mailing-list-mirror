From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-mv is not able to handle directory with one file in it
Date: Wed, 23 Nov 2005 15:47:51 +0100
Message-ID: <200511231547.51988.Josef.Weidendorfer@gmx.de>
References: <200511231141.57683.lan@ac-sw.com> <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net> <200511231326.27972.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 15:49:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eevuo-0003Xh-B4
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVKWOr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVKWOr6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:47:58 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:65444 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750858AbVKWOr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:47:58 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 47B77272D
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 15:47:54 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <200511231326.27972.lan@ac-sw.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12629>

On Wednesday 23 November 2005 08:26, Alexander Litvinov wrote:
> I have found one error during directory movig: If I move directory with one 
> file somewhere in it this script will try to add target directory instead of 
> file. Commenting lines starting from 190 solve this error. But I don't 
> understand what is the logic behind this case ? Why do target directory 
> checked instead of target file ?

$src/$dst pairs match the arguments given on the command line of git-mv,
And git-mv (as was git-rename) is able to move directory trees around.

It is simplier to keep the granularity at directories, as multiple moves
of directories can not overlap each other. If you do it at file level, you
have to remote and create directories yourself.

Of course, for git it is done at file level (that are the @srcfiles/@dstfiles
arrays), but this is quite trivial as git does not work with directories, but
only with files.

> Should we replace $dst my $destfiles[0] ?

Yes, that was part of my patch.

Josef
