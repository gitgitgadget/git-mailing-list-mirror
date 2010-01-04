From: "Christian C. Schouten" <info@zark3.net>
Subject: RE: Beginner's question on how to use git for multiple parallel versions
Date: Mon, 4 Jan 2010 14:35:25 +0100
Message-ID: <22D57EF90F8E4A2799F739FC14F8BA63@Duthler.local>
References: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com> <19265.60728.17437.665860@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 14:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRn6q-0007NY-Im
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 14:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab0ADNfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 08:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122Ab0ADNfb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 08:35:31 -0500
Received: from ns1.sohosted19.com ([195.8.208.62]:4883 "EHLO sohosted19.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab0ADNfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 08:35:30 -0500
Received: from spamfilter.sohosted.com ([127.0.0.1]) by sohosted19.com with MailEnable ESMTP; Mon, 04 Jan 2010 14:35:25 +0100
Received: from hp6735b1 ([195.86.221.234] helo=hp6735b1) with IPv4:25 by
	spamfilter.sohosted.com; 4 Jan 2010 14:35:25 +0100
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
In-Reply-To: <19265.60728.17437.665860@blake.zopyra.com>
Thread-Index: AcqNQfNu1qgCNtDtRp2xhIA/ts8aRgAADrUA
X-Assp-ID: spamfilter.sohosted.com ()
X-Assp-Version: 1.5.1.8(1.0.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136113>

Dear Bill,

Thanks for your prompt reply. It may very well be exactly what I need, but
I'm afraid that I don't understand the syntax just yet (am still in the
phase orienting on what version management is and how it should be set up).

Could you please add to your answer whether I am using branches or another
git technique (terminology?) and whether these are instructions that I can
use to commit a change once the system has already been set up or if these
actually are the instructions for defining the multiplicity of my project
versions?

Sorry for the newbie-ness and thanks in advance,

Best,

Chris


-----Original Message-----
From: Bill Lear [mailto:rael@zopyra.com] 
Sent: maandag 4 januari 2010 14:29
To: Christian C. Schouten
Cc: git@vger.kernel.org
Subject: Re: Beginner's question on how to use git for multiple parallel
versions

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
