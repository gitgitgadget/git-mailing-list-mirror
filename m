From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn: multiple fetch lines
Date: Sat, 17 Dec 2011 04:05:21 -0600
Message-ID: <20111217100521.GA12610@elie.hsd1.il.comcast.net>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 11:05:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbr9K-0006nv-3A
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab1LQKFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:05:30 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63182 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab1LQKF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:05:28 -0500
Received: by iaeh11 with SMTP id h11so5659734iae.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8LBvQ2Kr25eBEqRTViZ5pSZ/7droNU6rJbVjcT2lkf8=;
        b=rD4bDoG6OEn9VONyMu+6FakeGpMX6zL/T5Jbc1cP2w3eMpqYOT4bQ1oxE9s5c9+ofK
         mEmJ9YPIkSED6Ix+SzeDlwIniaCvOqxo7ZHk4QwHdz1qqZ/9krg3jlbep0k2Ri357phj
         OHQZtoxA6+24wxkcBsDz5+u8qeiALUcRGQ9UY=
Received: by 10.50.154.228 with SMTP id vr4mr14076380igb.65.1324116328078;
        Sat, 17 Dec 2011 02:05:28 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wo4sm19589985igc.5.2011.12.17.02.05.27
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 02:05:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187364>

Hi Nathan,

Nathan Gray wrote:

> I'm in a conversation with the support fellow of the very nice Tower
> git interface for OS X and we need clarification on a point.  Does
> git-svn explicitly support multiple "fetch =" lines in an svn-remote
> section or is it just an accident that it works?  My belief is that
> such support is intended and his is that it is accidental.

It's true that the documentation is not as clear about this as one
might like.  Documentation/git-svn.txt leaves it to the reader to
infer that this is supported by analogy with "fetch =" lines in native
git [remote] sections:

	'git svn' stores [svn-remote] configuration information in the
	repository .git/config file.  It is similar the core git
	[remote] sections except 'fetch' keys do not accept glob
	arguments; but they are instead handled by the 'branches'
	and 'tags' keys.

The change description for the patch that introduced that functionality
is more helpful.

	$ git log -S'Could not find a \"svn-remote.*.fetch\" key' git-svn.perl
	commit 706587fc
	Author: Eric Wong <normalperson@yhbt.net>
	Date:   Thu Jan 18 17:50:01 2007 -0800

	    git-svn: add support for metadata in .git/config
	    
	    Of course, we handle metadata migrations from previous versions
	    and we have added unit tests.
	    
	    The new .git/config remotes resemble non-SVN remotes.  Below
	    is an example with comments:
[example using multiple 'fetch' keys snipped]

Perhaps such an example would be useful for the git-svn(1) manpage,
too.  Any ideas for where to add such a note, and how it should be
worded?  (Of course, if you can phrase such an idea in patch form,
that would be the most convenient.)

Hope that helps,
Jonathan
