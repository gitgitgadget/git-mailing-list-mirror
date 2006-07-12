From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.cgi: Teach tree->raw to not require the hash of the blob
Date: Wed, 12 Jul 2006 10:32:23 +0200
Organization: At home
Message-ID: <e92c1e$lvk$1@sea.gmane.org>
References: <20060712034345.14009.qmail@web31802.mail.mud.yahoo.com> <7v64i31h6f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jul 12 10:32:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0a8d-0003Di-9d
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 10:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWGLIcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 04:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWGLIcE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 04:32:04 -0400
Received: from main.gmane.org ([80.91.229.2]:54754 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750954AbWGLIcD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 04:32:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G0a8N-0003Ao-1n
	for git@vger.kernel.org; Wed, 12 Jul 2006 10:31:51 +0200
Received: from host-81-190-20-193.torun.mm.pl ([81.190.20.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 10:31:51 +0200
Received: from jnareb by host-81-190-20-193.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 10:31:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-193.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23771>

Junio C Hamano wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
>> Teach tree->raw to not require the hash of the blob, but to
>> figure it out from the file name.  This allows to externally
>> link to files into the repository, such that the hash is not
>> required.  I.e. the file obtained would be as of the HEAD
>> commit.
>>
>> In contrast tree->blob for binary files passes the hash, as
>> does tree->blob->plain for "text/*" files.

> I think _allowing_ to accept filename not hash is a sane change,
> and would be useful if you want to allow linking to always the
> HEAD version from external sites, but I do not think listing the
> raw link in the tree view without the hash is a good idea.  It
> makes things quite confusing that "blob" link in its
> neighbourhood gives the blob from that specific version, but
> "raw" gives the version from HEAD, even when you are browsing
> something other than HEAD.
> 
> BTW, can somebody volunteer to be a gitweb/ "subsystem
> maintainer"?

I think the change to raw aka. blob_plain and not to plain is because in
plain view you have this HEAD link which takes us to HEAD revision of the
file (even if we are on different branch IIRC).

Workaround for either format is to remove 'h' (hash) parameter entirely, and  
put in 'hb' (hashbase aka headref aka branch) the branch name. Gitweb then
shows the contents of latest version of the file.

BTW. sometimes you want to link to specific version of the file, and
sometimes to newest. I think it would be best (if possible, feasible, and
not too much resource consuming) that links from tree specified by hash be
to specified by hash version of file, while links from tree specified by
headref and name only would have links to latest version of the file.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
