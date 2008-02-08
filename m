From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: read_branches_file ()
Date: Fri, 8 Feb 2008 12:18:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802081213340.13593@iabervon.org>
References: <20080208165008.52630d36@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWtN-0003Tb-3d
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 18:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935727AbYBHRSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 12:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935725AbYBHRSx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 12:18:53 -0500
Received: from iabervon.org ([66.92.72.58]:60943 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935715AbYBHRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 12:18:52 -0500
Received: (qmail 13647 invoked by uid 1000); 8 Feb 2008 17:18:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Feb 2008 17:18:50 -0000
In-Reply-To: <20080208165008.52630d36@pc09.procura.nl>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73115>

On Fri, 8 Feb 2008, H.Merijn Brand wrote:

> I'm (again) trying to port git-1.5.4 to HP-UX, and I've already got rather
> far, but I'm hitting some stuff I cannot explain.
> 
> t5405-send-pack-rewind.sh fails the 'git fetch .. master:master' part in
> the setup, as deep down, read_branches_file () is called with in remote
> the name "..".
> 
> The file that it tries to open using git_path () is ".git/branches/.."
> That is weird. That is not a file, but a dir. "../.git/branches" would
> be more logical, but whatever. HP-UX 11.00 will gladly return a valid
> FILE * for opening a directory with fopen (), which, when read, will
> return anything but what is expected. So, maybe read_branches_file ()
> should be protected against opening anything but files. Maybe with some
> stat () and S_ISREG ()'s.
> 
> Or has something gone wrong earlier on?

It's doing this because it thinks you might have a remote configured with 
the name "..", which should probably be blocked at a higher level, if only 
for general sanity.

	-Daniel
*This .sig left intentionally blank*
