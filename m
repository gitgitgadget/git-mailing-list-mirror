From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Tue, 30 Oct 2012 13:15:18 +0100
Message-ID: <1674207.s6eW8JjC7x@flomedio>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 14:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTBhG-00045t-CA
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 14:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab2J3NRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 09:17:21 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:35434 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab2J3NRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 09:17:20 -0400
X-Greylist: delayed 3707 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2012 09:17:20 EDT
Received: from flomedio.localnet (91-115-94-157.adsl.highway.telekom.at [91.115.94.157])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q9UCFJcl026008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2012 13:15:19 +0100 (CET)
User-Agent: KMail/4.9.2 (Linux/3.5.0-17-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <7vmx045umh.fsf@alter.siamese.dyndns.org>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208702>

Sorry for reacting so late, I didn't read the list carefully in the last weeks 
and my gmail filter somehow didn't trigger on that.

On Tuesday 02 October 2012 16:20:22 Junio C Hamano wrote:
> * fa/remote-svn (2012-09-19) 16 commits
>  - Add a test script for remote-svn
>  - remote-svn: add marks-file regeneration
>  - Add a svnrdump-simulator replaying a dump file for testing
>  - remote-svn: add incremental import
>  - remote-svn: Activate import/export-marks for fast-import
>  - Create a note for every imported commit containing svn metadata
>  - vcs-svn: add fast_export_note to create notes
>  - Allow reading svn dumps from files via file:// urls
>  - remote-svn, vcs-svn: Enable fetching to private refs
>  - When debug==1, start fast-import with "--stats" instead of "--quiet"
>  - Add documentation for the 'bidi-import' capability of remote-helpers
>  - Connect fast-import to the remote-helper via pipe, adding 'bidi-import'
> capability - Add argv_array_detach and argv_array_free_detached
>  - Add svndump_init_fd to allow reading dumps from arbitrary FDs
>  - Add git-remote-testsvn to Makefile
>  - Implement a remote helper for svn in C
>  (this branch is used by fa/vcs-svn.)
> 
>  A GSoC project.
>  Waiting for comments from mentors and stakeholders.

>From my point of view, this is rather complete. It got eight review cycles on 
the list.
Note that the remote helper can only fetch, pushing is not possible at all.

> 
> 
> * fa/vcs-svn (2012-09-19) 4 commits
>  - vcs-svn: remove repo_tree
>  - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
>  - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
>  - svndump: move struct definitions to .h
>  (this branch uses fa/remote-svn.)
> 
>  A GSoC project.
>  Waiting for comments from mentors and stakeholders.

This is the result of what I did when I wanted to start implementing branch 
detection. I found that the existing code is not suitable and restructured it.

The main goal is to seperate svn revision parsing from git commit creation. 
Because for creating commits, you need to know on which branch to create the 
commit.
While for finding out which branch is the right one, you need to read the 
complete svn revision first to see what dirs are changed and how.

It is rather invasive and it doesn't make sense without using it later on.
So I'm not surprised that you may not like it.
Anyways it passes all existing tests (that doesn't mean it's good of course 
;))

Florian
