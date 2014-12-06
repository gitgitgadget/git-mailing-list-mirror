From: Alfred Perlstein <alfred@freebsd.org>
Subject: [PATCH] git-svn: propset support v2
Date: Sat, 6 Dec 2014 14:29:18 -0800
Message-ID: <20141206222918.GA91825@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 23:29:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxNr0-0007Uh-Ru
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 23:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaLFW30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 17:29:26 -0500
Received: from elvis.mu.org ([192.203.228.196]:33533 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbaLFW3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 17:29:25 -0500
Received: by elvis.mu.org (Postfix, from userid 1192)
	id A0BC3341F884; Sat,  6 Dec 2014 14:29:18 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260965>

I have incorporated Eric Wong's feedback into the git-svn propset support patch.

Issues resolved:
1) Test-case written.
2) Remove dead code.
3) Use shorter vars for formatting.
4) Fix bool comparisons.
5) Check for filesystem errors on write to .gitattribute file.
6) Use command_output_pipe() instead of open my $fh, '-|', ...
7) Refactor check for existing props.

There is a nit that I want to point out.  The code does not support adding props
unless there are also content changes to the files as well.  You can see this in
the testcase.

That is still sufficient for many people's workflows (FreeBSD at
least).  So I am wondering if this is OK. 

I would gladly take any pointers to making it work with unchanged
files either for a later diff or to wrap this up.

Thank you.

Alfred Perlstein (1):
  git-svn: Support for git-svn propset

 git-svn.perl               | 49 +++++++++++++++++++++++++++++++-
 perl/Git/SVN/Editor.pm     | 43 ++++++++++++++++++++++++++++
 t/t9148-git-svn-propset.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100755 t/t9148-git-svn-propset.sh

-- 
2.1.2
