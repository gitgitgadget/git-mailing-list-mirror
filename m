From: Josef Wolf <jw@raven.inka.de>
Subject: git-svn with multiple remote repositories?
Date: Tue, 2 Dec 2008 22:39:30 +0100
Message-ID: <20081202213930.GD12716@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 22:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7czq-00075d-O3
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYLBVkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYLBVkM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:40:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:39818 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYLBVkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:40:11 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1L7cyX-0007Hh-F9; Tue, 02 Dec 2008 22:40:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id BB94B3A72C; Tue,  2 Dec 2008 22:39:30 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102179>

Hello,

I am trying to create a git repository with two remote svn repositories
so that I can merge/move patch-sets back and forth between the svn
repositories.

This is what I have tried so far:

  mkdir -p project
  cd project
  git-svn init -R private -s https://foo.bar/repos/private

Then I go and edit .git/config too look like this:

  [core]
          repositoryformatversion = 0
          filemode = true
          bare = false
          logallrefupdates = true
  [svn-remote "private"]
          url       =   https://foo.bar/repos/private
          fetch     =      trunk:refs/remotes/private/trunk
          branches  = branches/*:refs/remotes/private/*
          tags      =     tags/*:refs/remotes/private/tags/*
  [svn-remote "public"]
          url       =   https://foo.bar/repos/public
          fetch     =      trunk:refs/remotes/public/trunk
          branches  = branches/*:refs/remotes/public/*
          tags      =     tags/*:refs/remotes/public/tags/*

And finally, I do

  git-svn fetch -R private
  git-svn fetch -R public

Both commands seem to fetch the contents from their origins.  But
git-branch shows me only the local master branch with contents from
the "private" svn repository.  When I do

  git checkout public/trunk

the contents actually change to reflect the "public" svn repository,
but git-branch says I am on "(no branch)" at all.

As a newbie to git, I am somewhat confused now.  Any hints how I can
get a hold on the remote branches merge between them?
