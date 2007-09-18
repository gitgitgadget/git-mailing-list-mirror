From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Latest builtin-commit series
Date: Tue, 18 Sep 2007 11:23:29 -0400
Message-ID: <1190129009.23692.24.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXfKL-0003sz-RR
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267AbXIRPtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759255AbXIRPtR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:49:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37833 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757457AbXIRPtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:49:15 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8IFmQ0E026411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 11:48:43 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IFNZAI002586;
	Tue, 18 Sep 2007 11:23:35 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IFNYWK030852;
	Tue, 18 Sep 2007 11:23:34 -0400
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58622>

Hi,

I sent out a new builtin-commit patch series last night, and figured I
should have written a cover letter to describe the changes there.
Better late than never:

      * rebase to Pierres strbuf changes.  Note, there is still some
        strbuf tweaking required, to let stripspace work on a strbuf.
        Also, I changed the semantics of stripspace to always add a
        newline if the last line doesn't have one.  I believe the
        current odd semantics (always remove the last newline) comes
        from not being able to easily add a newline, but now that it's a
        strbuf, that's easy.

      * Fixing the last bug that caused trouble in the test suite: even
        if run_status says there's nothing to commit, proceed if we're
        doing a merge.

      * Set the test suite default editor to '/bin/true' instead of ':'.
        Since we're not exec'ing the editor from shell anymore, ':'
        won't work.  Maybe we should special case ':' in launch_editor
        or perhaps make launch_editor use system(3).  Not sure.

      * The first few patches are good to go, and if we can get them
        committed to next, we can focus on the builtin-commit patch.
        Specifically:

                0001-Enable-wt-status-output-to-a-given-FILE-pointer.patch
                0002-Enable-wt-status-to-run-against-non-standard-index-f.patch
                0003-Introduce-entry-point-for-launching-add-interactive.patch
                0004-Clean-up-stripspace-a-bit-use-strbuf-even-more.patch
                0005-Add-strbuf_read_file.patch
                0006-Export-rerere-and-launch_editor.patch
                        (edit our "and launch_editor" from the title)
                
        should all be fine and easy to review, whereas 
        
                0007-Implement-git-commit-as-a-builtin-command.patch
                
        will probably need some careful reviewing.  That said, it is
        feature complete, the code is nice enough and it passes the test
        suite.  It's just a very important part of git :)

cheers,
Kristian

(sorry about the duplicate mail)
