From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Question about handling of heterogeneous repositories
Date: Wed, 30 Nov 2005 17:49:17 +0100
Message-ID: <200511301749.18073.Josef.Weidendorfer@gmx.de>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com> <200511301540.34776.Josef.Weidendorfer@gmx.de> <81b0412b0511300701w71da125am2dcc896b4693f37f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 30 18:13:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhV92-0007Uu-IK
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 17:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVK3QtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVK3QtV
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 11:49:21 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:6864 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751452AbVK3QtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 11:49:21 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 0059A23DB;
	Wed, 30 Nov 2005 17:49:19 +0100 (MET)
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: KMail/1.9
In-Reply-To: <81b0412b0511300701w71da125am2dcc896b4693f37f@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13008>

On Wednesday 30 November 2005 16:01, Alex Riesen wrote:
> On 11/30/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > git-mv could support this. Additional to deleting from
> > one repository and adding to the new, it could generate a remark for
> > the commit message, like:
> >
> >  Added file xxx is from remote repo '/path/myrepo' with name 'yyy'
> >  (file SHA1: 123445... from remote commit SHA1: 345667...)
> 
> That's sounds very tempting to special-case for nested repos :)

If the repo path is an URL, this works quite general. I tried
to avoid adding local head names to this remark...

> Maybe use .git/objects/info/alternates in top-level repo?

Or better the .git/remotes namespace...
Still, this is misusing repo-local config for multiple repos.
Seems quite confusing for me.

> It may 
> have side-effects of the new objects ending up in top-level repo
> if commited from top-level directory. Even then, the tools can
> be tought to stop looking for GIT_DIR in the directory closest
> to the file being commited:
>   $ pwd
>   .../top
>   $ git-commit sub1/dir/file
>   ... uses repo in .../top/sub1 instead of $(pwd)/../top/.git
> 
> Looks very messy, with a potential for lots of corner cases and
> not that tempting anymore :(

git-mv would have to do exactly something like this to detect
inter-repo renames at all ;-)
But in general, this is really messy.

See my suggestion in a previous thread with similar topic
 http://www.gelato.unsw.edu.au/archives/git/0511/12028.html

Josef
