From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn very slow on fetch (shared git-svn repo)
Date: Sun, 11 Oct 2009 02:03:38 -0700
Message-ID: <20091011090338.GA27480@dcvr.yhbt.net>
References: <4AD04F95.7050603@obry.net> <20091011070136.GB16264@dcvr.yhbt.net> <4AD19E9F.8010302@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 11:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwuRQ-0003L8-8u
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 11:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZJKJEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 05:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbZJKJEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 05:04:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43334 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbZJKJEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 05:04:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id B8A9A1F78E;
	Sun, 11 Oct 2009 09:03:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AD19E9F.8010302@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129909>

Pascal Obry <pascal@obry.net> wrote:
> Hi Eric,
>
>> For globs (branches and tags) the $GIT_DIR/svn/.metadata
>> config file, under the svn-remote.svn.{branches,tags}-maxRev keys.
>
> Right. I found out that copying the .metadata solve this problem.
>
>> For explicitly specified refs (e.g. "trunk"), then it's in the last
>> record of the corresponding rev_map (e.g.
>> $GIT_DIR/svn/trunk/.rev_map.$UUID) as a 4-byte revision number + 20
>> bytes of zeroes.
>
> Seems like we do not need to copy this one as it is reconstructed by a  
> simple rebase on the trunk branch. This is quite fast as reconstructed  
> from the embedded git-svn-id if I'm not mistaken.
>
> So you confirm that copying the .metadata is the solution?

Yes, copying .metadata should be enough.  The .rev_map rebuild should
be fast.

-- 
Eric Wong
