From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Thu, 15 Oct 2009 09:39:04 -0700
Message-ID: <20091015163904.GN10505@spearce.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> <1255065768-10428-2-git-send-email-spearce@spearce.org> <loom.20091009T104530-586@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Blewitt <Alex.Blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 18:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyTU0-00033m-R4
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 18:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933930AbZJOQjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933480AbZJOQjl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 12:39:41 -0400
Received: from george.spearce.org ([209.20.77.23]:37323 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933445AbZJOQjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 12:39:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 71EBD381FE; Thu, 15 Oct 2009 16:39:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20091009T104530-586@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130401>

Alex Blewitt <Alex.Blewitt@gmail.com> wrote:
> Shawn O. Pearce <spearce <at> spearce.org> writes:
> 
> > +URL Format
> > +----------
> 
> It's worth making clear here that $GIT_URL will be the path to the repository,
...

Thanks, noted.

> > HEX = [0-9a-f]
> 
> Is there any reason not to support A-F as well in the hex spec, even if they
> SHOULD use a-f?

Consistency.  I'd rather be strict and say HEX is [0-9a-f] and
demand that everyone try to standardize on the lower case form.

> This may limit the appeal for some case-insensitive systems.

Given that this particular notation of HEX is *only* used within
the protocol body to describe SHA-1 IDs, it won't make it to the
file system as-is.

A conforming Git implementation would first validate that this is in
fact a SHA-1 ID, likely translate it into a binary representation
(that is collapse the 40 byte hex to a 20 byte binary), and then
reformat it as a file system path if its looking for a loose object.
 
> It would also be good to document, like with the git daemon, whether all
> repositories under a path are exported or only those that have the magic
> setting in the config like git-daemon-export-ok.

This isn't something that matters to the protocol specification.
Its a server access control, not protocol detail.

Really, its an implementation detail of git-http-backend in git.git,
or of the RepositoryResolver and UploadPackFactory in JGit.

Therefore, its not going to be documented in this document.
 
> Lastly, it would be good to clarify when the result of this GET/POST exchange
> is a text-based (and encoded in UTF-8) vs when binary data is returned; we 
> don't want to get into the state where we're returning binary data and 
> pretending that it's UTF-8.

Oh, right.

-- 
Shawn.
