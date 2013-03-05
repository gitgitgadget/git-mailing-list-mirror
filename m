From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: rebase destroys branches
Date: Mon, 4 Mar 2013 21:21:53 -0500
Message-ID: <20130305022153.GA17878@thunk.org>
References: <C057AC9B02D06A49810E9597C11F55BF14DFE51C9F@dnzwgex2.datacom.co.nz>
 <64FF012BC4AF45C4A5067DE93FD9FE17@PhilipOakley>
 <C057AC9B02D06A49810E9597C11F55BF14DFE5214F@dnzwgex2.datacom.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
X-From: git-owner@vger.kernel.org Tue Mar 05 03:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UChWT-0001tu-9N
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 03:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680Ab3CECWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 21:22:07 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:51313 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758723Ab3CECWG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 21:22:06 -0500
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UChVr-0007Mu-3X; Tue, 05 Mar 2013 02:21:55 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id DEFF224033C; Mon,  4 Mar 2013 21:21:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <C057AC9B02D06A49810E9597C11F55BF14DFE5214F@dnzwgex2.datacom.co.nz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217425>

On Tue, Mar 05, 2013 at 02:05:32PM +1300, Gene Thomas [DATACOM] wrote:
> 
> >The original branch is not 'destroyed', rather the pointer to the previous tip is within the logs. 
> 
> Is that the 'git log' log or internal logs? Are you sure? There doesn't appear to be a way to checkout that tip of see the log back from that tip.

See the dovcumentation for "git reflog"

> >All the content is still available until the logs expire.
> 
> So we will be unable to checkout content after a time?

You need to make a distinction between a user's local repository, and
the team's central repository.  The workflow of the individual user is
one where they can and should be allowed to use rebase and "git commit
--amend" if they like.  Consider this the same thing as the user who
chooses to use "quilt" on their local machine while they are preparing
their patches, so they are carefully honed before they are cast into
concrete.  Whether they use "quilt", or manual patching, or simply
don't bother checking things into the central SCM until things are
cleaned up, the end result is the same.

The team's central repository is one where you don't want to allow
history to be lost, and so there you can enforce rules to prevent
this.  For example, if you use Gerrit, you can limit the ability to
reset branches to administrators only.  Everyone else can only add new
commits, not change older ones.

(If someone accidentally checks in NDA'ed material belonging to
someone else, or some other IP content guaranteed to cause your
general counsel to have heart palpitations, trust me, you'll want to
allow administrators to rewind a git branch.  :-)

You can also use Gerrit to enforce code reviews, so that no change
goes in until a second engineer reviews the commit and gives it a
thumbs up (with a permanent record of the code review kept in Gerrit,
something which can be important for pointy-haired corporate types who
worry about Sarbanes Oxley controls --- although from your e-mail
address, you may be lucky enough to be exempt from needing to worry
about SOX controls :-).

Regards,

						- Ted
