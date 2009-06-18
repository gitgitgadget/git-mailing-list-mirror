From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for 
	the given branches
Date: Thu, 18 Jun 2009 21:01:55 +0200
Message-ID: <adf1fd3d0906181201r5f3b2f55t8427e7be5ba07e9a@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <m3iqithd24.fsf@localhost.localdomain>
	 <adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
	 <200906181617.07802.jnareb@gmail.com>
	 <adf1fd3d0906180740t637da9braea02deb3cba2680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:02:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHMsB-0004OW-Jz
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZFRTBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbZFRTBy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 15:01:54 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:38536 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZFRTBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 15:01:53 -0400
Received: by fxm8 with SMTP id 8so1295322fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 12:01:55 -0700 (PDT)
Received: by 10.204.71.134 with SMTP id h6mr1646326bkj.70.1245351715429; Thu, 
	18 Jun 2009 12:01:55 -0700 (PDT)
In-Reply-To: <adf1fd3d0906180740t637da9braea02deb3cba2680@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121868>

One thing it just occurred to me is to return the explicit refspec
instead of the tracking branch. So with the default config (after a
clone):

$ git remote tracking origin refs/heads/master
refs/heads/master:refs/remotes/origin/master

this makes a difference in case we want to allow returning all the
matching tracking branch and not the first one with more than one
branch, as:

$ git config remote.origin.fetch --add +refs/heads/*:refs/remote/another/*

$ git remote tracking origin refs/heads/master
refs/heads/master:refs/remotes/origin/master
refs/heads/next:refs/remotes/origin/next

$ git remote tracking origin refs/heads/master refs/heads/next
refs/heads/master:refs/remotes/origin/master
refs/heads/master:refs/remotes/another/master
refs/heads/next:refs/remotes/origin/next
refs/heads/next:refs/remotes/another/next

Thoughts?
