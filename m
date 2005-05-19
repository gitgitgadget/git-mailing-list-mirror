From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] packed delta git
Date: Thu, 19 May 2005 14:53:21 -0400
Message-ID: <200505191453.21566.mason@suse.com>
References: <200505171857.46370.mason@suse.com> <200505191428.52238.mason@suse.com> <20050519183810.GF8105@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:54:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYq8Q-000290-Di
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVESSxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVESSxa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:53:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48039 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261220AbVESSxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 14:53:25 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A304710BD6;
	Thu, 19 May 2005 20:53:24 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 3B495152D42; Thu, 19 May 2005 20:53:24 +0200 (CEST)
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
User-Agent: KMail/1.8
In-Reply-To: <20050519183810.GF8105@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 19 May 2005 14:38, Thomas Glanzmann wrote:
> Hello Chris,
>
> > size (du -sh .git)              2.5G                  227M
>
> wow that beats bitkeeper in size. What is missing to actual use such a
> approach in a distributed environment?

It's not quite fair to compare with bitkeeper, since my changeset comments are 
only the name of the bk->cvs patch, and I've only got 28k changesets vs bk's 
60k or so.

In terms of actually making use of this, we need to deal with the hard linked 
files during push/pull.  This means using -H on rsync and teaching the 
push/pull code about packed files.

git-pack needs to be able to unpack/undelta files so that people can clean a 
tree.

git-fsck-cache needs to understand packed files and deltas.

-chris
