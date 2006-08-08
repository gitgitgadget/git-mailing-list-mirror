From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 11:48:41 +0200
Organization: At home
Message-ID: <eb9mlg$68v$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 08 11:49:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAOCl-0003Q3-M9
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 11:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWHHJst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 05:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWHHJst
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 05:48:49 -0400
Received: from main.gmane.org ([80.91.229.2]:64158 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932289AbWHHJss (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 05:48:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAOCZ-0003P9-8L
	for git@vger.kernel.org; Tue, 08 Aug 2006 11:48:43 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 11:48:43 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 11:48:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25064>

Jakub Narebski wrote:

> With two scripts attached to the first post in this thread it would be
> simple to apply pre-rename patch, by converting gitweb to pre-rename using
> gitweb-unrename.sh script, then applying patch, then restoring new names
> using gitweb-rename.sh script, and finally comitting changes (or amending
> commit).

Or just apply corrected gitweb-rename.sh script (see below) to patch (mbox),
and then apply and commit the "after rename" patch.

#!/bin/sh

if test -z "$1"; then
        FILE=`git rev-parse --show-cdup`gitweb/gitweb.perl
else
        FILE=$1
fi

echo "Great subroutine renaming: $FILE"
perl -s -p -i.re~ \
        -e 's/\bgit_get_referencing\b/format_mark_referencing/;' \
        -e 's/\bgit_read_head\b/git_get_head/;' \
        -e 's/\bread_info_ref\b/git_read_info_refs/;' \
        -e 's/\bdate_str\b/parse_date/;' \
        -e 's/\bgit_read_tag\b/parse_tag/;' \
        -e 's/\bgit_read_commit\b/parse_commit/;' \
        -e 's/\bgit_blob_plain_mimetype\b/blob_plain_mimetype/;' \
        -e 's/\bgit_page_nav\b/git_print_page_nav/;' \
        -e 's/\bgit_header_div\b/git_print_header_div/;' \
        "$FILE"

# end of gitweb-rename.sh

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
