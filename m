From: Bill Lear <rael@zopyra.com>
Subject: Re: Beginner's question on how to use git for multiple parallel versions
Date: Mon, 4 Jan 2010 07:29:28 -0600
Message-ID: <19265.60728.17437.665860@blake.zopyra.com>
References: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Christian C. Schouten" <info@zark3.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 14:30:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRn05-0004Yb-Nl
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 14:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab0ADN3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 08:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941Ab0ADN3d
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 08:29:33 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:34920
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751551Ab0ADN3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 08:29:33 -0500
Received: (qmail 31964 invoked by uid 500); 4 Jan 2010 13:29:32 -0000
In-Reply-To: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136112>

On Monday, January 4, 2010 at 12:29:52 (+0100) Christian C. Schouten writes:
>Hello all,
>
>I've got a project that I want to do version management on with
>git but being a beginner in cvs/svn/dvcs etc. terminology I
>don't know yet how to set it up.  My project needs to exist as
>several parallel copies, i.e. there is a "main version" in
>which I do my development but it needs to end up being available as a
>couple of different configurations.  For instance, say there is a file
>table.xml then this needs to contain different rows for versions A and
>B. Likewise, a file process.bpel needs to be named identical for each
>version but contain different content depending on whether it is
>distributed as version A or version B. Any changes made in non-version
>specific files should be visible in all copies, but changes made to
>version-specific files need to remain isolated to that particular
>version.

What you are asking for is this, I think:

% git checkout A
% cat table.xml
<table A>
% echo "<table A v2>" > table.xml
% git commit -a -m "fix table on Branch A"

% git checkout B
% cat table.xml
<table B>
% echo "<table B v2>" > table.xml
% git commit -a -m "fix table on Branch B"

% git checkout master
% cat table.xml
<non-version-specific table info>
% cat process.bpel
main line process stuff
% echo "add more process stuff" >> process.bpel
% git commit -a -m "fix process stuff on mainline"

% git checkout A
% git merge master
% cat process.bpel
main line process stuff
add more process stuff

% git checkout B
% git merge master
% cat process.bpel
main line process stuff
add more process stuff

Is that not it?


Bill
