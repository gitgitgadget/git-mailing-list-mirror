From: Kannan Goundan <kannan@cakoose.com>
Subject: Replicating the default "git log" format with a format string.
Date: Thu, 12 Nov 2015 00:55:53 +0000 (UTC)
Message-ID: <loom.20151112T011419-749@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 01:56:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwgBR-0004sz-5q
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 01:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbbKLA4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 19:56:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:33416 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbbKLA4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 19:56:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZwgBH-0004i6-IU
	for git@vger.kernel.org; Thu, 12 Nov 2015 01:56:04 +0100
Received: from 205.189.0.114 ([205.189.0.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 01:56:03 +0100
Received: from kannan by 205.189.0.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 01:56:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 205.189.0.114 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:42.0) Gecko/20100101 Firefox/42.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281211>

For our workflow, author dates aren't very useful.  I'm looking for a way to
configure Git so that "git log" shows commit dates instead of author dates.
 "--pretty=fuller" gets me almost what I want, but I'd like to avoid the
extra two lines if possible.

I tried achieving this by putting a custom format string in ~/.gitconfig:

[format]
  pretty = "%C(auto,yellow)commit %C(auto)%H\nAuthor: %an <%ae>\nDate:  
%cd\n\n%w(0,4,4)%B"

This works pretty well, but has a few corner cases.  When you do "git log
--decorate", the default format decorates commits with ref names.  I can add
"%d" to my format string, but then the ref names show up all the time, even
without "--decorate".

The "--walk-reflogs" option presents a similar problem.  The %g*
placeholders all become empty strings when "--walk-reflogs" isn't present,
which is sort of what I want, but it leaves extra blank lines in the output.

Is it possible to exactly replicate the default "git log" format with a
format string?
