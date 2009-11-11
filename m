From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 22:55:40 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AFB32DC.50505@obry.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> <4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net> <20091111203413.GA9648@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:55:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8LA5-0003NJ-QH
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759321AbZKKVzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759299AbZKKVzW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:55:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:60201 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759291AbZKKVzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:55:20 -0500
Received: by ey-out-2122.google.com with SMTP id 9so378840eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:55:24 -0800 (PST)
Received: by 10.213.0.131 with SMTP id 3mr3001632ebb.68.1257976524385;
        Wed, 11 Nov 2009 13:55:24 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 10sm1481741eyd.47.2009.11.11.13.55.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 13:55:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091111203413.GA9648@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132708>


Eric,

> Also, any chance you have multiple refs with "trunk" in the basename?
>
>   git rev-parse --symbolic --all | grep '/trunk'

This reports:

$ git rev-parse --symbolic --all | grep '/trunk'
refs/remotes/svn/trunk

> It could be a backwards compatibility issue with git svn looking
> in multiple places for trunk.

But I have multiple trunk:

$ ls .git/svn/svn/trunk/
./  ../  .rev_map.936e1b1b-40f2-da11-902a-00137254ae57  unhandled.log

$ ls  .git/svn/refs/remotes/svn/trunk/
./  ../  .rev_map.936e1b1b-40f2-da11-902a-00137254ae57  unhandled.log

Removing all the .rev_map* fix the problem.

Removing only the one in .git/svn/refs/remotes/svn/trunk/ fix the 
problem too.

> With Adam's commit, it'll try $GIT_DIR/svn/refs/remotes/trunk/* first
> Then it'll try $GIT_DIR/svn/trunk/* as a fallback.

Does this means that it was looking first in $GIT_DIR/svn/trunk/* 
before? And the confusion come because now it is looking in 
$GIT_DIR/svn/refs/remotes/trunk/* first?

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
