From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git svn clone terminating prematurely (I think)
Date: Wed, 11 Jan 2012 16:48:33 -0600
Message-ID: <20120111224833.GA29654@burratino>
References: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com>
 <CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Line <sline00@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 23:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl6tm-0000y3-SQ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 23:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab2AKWn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 17:43:58 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44651 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751005Ab2AKWno (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 17:43:44 -0500
Received: by obbup16 with SMTP id up16so1452281obb.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PZLZi9pJPM0WlYBhsSsAMVBLLw2WiEofRFsUHN6d79A=;
        b=Lv8b6JAnnquPRCeAEFsO4a4b9yAzTDBsEelh2ZmTTcjgat27iIDbZdvxtKX/qYUGlf
         AZ287WNn9eXnPT0cbNEFcwPOcZsdZrbZeee+a9EcQlyVU+2y1xr/dvuKD+0HlC+gq8pX
         nCFCgGK/7LSLgpzl+07eRIF/oJyQlVi6N8UyI=
Received: by 10.50.222.193 with SMTP id qo1mr948139igc.22.1326321821930;
        Wed, 11 Jan 2012 14:43:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id aq5sm11193416igc.5.2012.01.11.14.43.41
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 14:43:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188397>

Ramkumar Ramachandra wrote:

> Interesting.  From the git-svn-id of the most recent commit, can you
> tell if there's anything especially fishy about the revision where
> git-svn stops?  Your Subversion repository is probably broken in some
> way,

I wouldn't necessarily assume that.  My first hunch would have been
that this is some variation on the SIGPIPE bug[1].  The usual
workaround for that[2] is to get git-svn to continue by running "git
svn fetch" again.  Nobody's fixed it because nobody's stared at the
SVN perl bindings for long enough to find the cause.

Modern git versions produce a message in that case, though:

	error: git-svn died of signal 13

So you are probably running into something else.  I only mention this
for context.

Does svnsync work for making a local copy of whatever subset of the
repository is relevant?  Alternatively (this is basically the same),
is the network connection stable enough for e.g. svnrdump[3] to get a
dump?

Sorry for the trouble, and hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/134936/focus=134940
[2] Maybe it deserves a note in the manpage.
[3] http://repo.or.cz/w/svnrdump.git
