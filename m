From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Wed, 09 Aug 2006 00:33:40 +0200
Organization: At home
Message-ID: <ebb3fm$2md$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <ebauq1$kcb$1@sea.gmane.org> <7vu04mucaq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 09 00:33:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAa8y-0000Em-Mc
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 00:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWHHWdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 18:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWHHWdo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 18:33:44 -0400
Received: from main.gmane.org ([80.91.229.2]:20923 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965058AbWHHWdo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 18:33:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAa8l-0000CA-35
	for git@vger.kernel.org; Wed, 09 Aug 2006 00:33:35 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 00:33:35 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 00:33:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25094>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:

>>  - git_blob_plain_mimetype => blob_plain_mimetype
> 
> Does it matter that the function is used in blob-plain?  In
> other words, how would this function, blob-plain-mimetype, be
> different if we were to have another function called blob-mimetype?
> 
> How about calling it "guess-mimetype"?

There are two functions, mimetype_guess_file and mimetype_guess, of which
first one gets mimetype of file based on specified mime.types like file,
second tries $mimetypes_file then '/etc/mime.types', while currently named
git_blob_plain_mimetype subroutine first tries mimetype_guess, then checks
if the file is text file (-T $fd) and if not uses some built in mime.types
rules. Perhaps current mimetype_guess could be embedded into current
git_blob_plain_mimetype.

All those subroutines need better names I think.
 
>>  - git_page_nav => git_print_page_nav
>>  - git_header_div => git_print_header_div
> 
> Both sounds sane (I would have said "git-show-blah" if I were
> doing this myself, though).

They are called among print statements. I'm not sure if some of them
wouldn't be better converted to format_* types subroutines.
 
>>  - read_info_ref => git_read_info_refs => git_get_references
>>  (this one depend too much on implementation, which might be changed to 
>>   parsing 'git ls-remotes .' output instead of relying on info/refs being
>>   up to date thanks to git-update-server-info in post-update hook, 
>>   and on its format).
> 
> I am not worried too much about the format (because clone/fetch
> over http depends on it), but reading from ls-remote self would
> make it unnecessary to run update-server-info if a repo is not
> served over http but is shown over gitweb.

Do the git_get_references for this subroutine, which returns hashref which
keys are ids, and values are refs pointing to the key id, sounds good?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
