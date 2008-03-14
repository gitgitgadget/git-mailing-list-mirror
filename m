From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS to git: parsing ChangeLog entries?
Date: Fri, 14 Mar 2008 19:40:33 +0100
Message-ID: <47DAC6A1.7070400@alum.mit.edu>
References: <20080312190827.GE3198@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 19:42:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaEqw-00087i-Bl
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 19:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbYCNSlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbYCNSlK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 14:41:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47211 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbYCNSlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 14:41:09 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.142])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m2EIf6Nr012742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Mar 2008 19:41:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20080312190827.GE3198@ins.uni-bonn.de>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77271>

I'll answer your questions from the point of view of cvs2git, a.k.a.
cvs2svn (http://cvs2svn.tigris.org).

Ralf Wildenhues wrote:
> when migrating a project that uses GNU-style ChangeLogs from CVS
> to git, is it possible to extract patch author information from
> the ChangeLog entries rather than from the CVS commit logs?
> For simplicity let's first assume the project used only one
> ChangeLog file.
> 
> Asking because it is not uncommon that patches are committed on
> behalf of other people, and it would be nice to credit them.

There is no builtin support for this in cvs2git.  But the place where
the author is determined knows about the whole changeset, including any
simultaneous changes to the changelog.  So it should be possible to add
this functionality without too much work.

> Related question: when CVS commit logs have varying encoding,
> say, some latin1 and some UTF-8, is it possible to have uniformly
> encoded git log entries?

cvs2git allows you to specify multiple encodings.  It tries one after
the other until one works successfully.  It also has hooks where you can
add your own decoder using arbitrary Python code.

That reminds me that there is a Python universal decoder that uses
heuristics to determine the encoding of an arbitrary octet stream.  That
might be a nice thing to add support for....

Michael
