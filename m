From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: git-mv is not able to handle directory with one file in it
Date: Wed, 23 Nov 2005 13:26:27 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511231326.27972.lan@ac-sw.com>
References: <200511231141.57683.lan@ac-sw.com> <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 08:25:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeoyr-0000Pu-8v
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 08:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVKWHXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 02:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVKWHXo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 02:23:44 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:13739 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030344AbVKWHXo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 02:23:44 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 97BE7BD1B; Wed, 23 Nov 2005 13:23:42 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id C696B1962A9; Wed, 23 Nov 2005 13:26:33 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 8F7A91962A3;
	Wed, 23 Nov 2005 13:26:28 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12608>

I have found one error during directory movig: If I move directory with one 
file somewhere in it this script will try to add target directory instead of 
file. Commenting lines starting from 190 solve this error. But I don't 
understand what is the logic behind this case ? Why do target directory 
checked instead of target file ? Should we replace $dst my $destfiles[0] ?

at line 190 in git-mv:
    if (scalar @srcfiles == 1) {
	if ($overwritten{$dst} ==1) {
	    push @changedfiles, $dst;
	} else {
	    push @addedfiles, $dst;
	}
    }
    else {
	push @addedfiles, @dstfiles;
    }
