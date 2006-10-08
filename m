From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does GIT require property like Subversion?
Date: Sun, 08 Oct 2006 12:16:26 +0200
Organization: At home
Message-ID: <egaj49$424$1@sea.gmane.org>
References: <4528C09B.3030004@gmail.com> <20061008091900.GG30283@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 08 12:16:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWVhY-0007Rr-BT
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 12:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWJHKQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 06:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWJHKQE
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 06:16:04 -0400
Received: from main.gmane.org ([80.91.229.2]:31424 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751038AbWJHKQB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 06:16:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWVhE-0007Mh-Qo
	for git@vger.kernel.org; Sun, 08 Oct 2006 12:15:49 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 12:15:48 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 12:15:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28531>

Jan-Benedict Glaw wrote:

> On Sun, 2006-10-08 17:10:51 +0800, Liu Yubao <yubao.liu@gmail.com> wrote:
>> I want to know whether there is a plan to add this feature, or GIT doesn't
>> require it at all.
>> 
>> Properties like encoding (path name, file content), eol-style, mime-type
>> are useful for editing.
> 
> GIT is a content tracker. It won't ever fiddle with your line
> endings. You put data in there and it'll be conserved bit-by-bit. So
> if you need to store file encodings, MIME types, automatic CR/CRLF/LF
> converstion etc, you have to put this metadata into some additional
> files, but GIT won't specifically handle that in any way.

Mimetype has no place (I think) in SCM. We could in pronciple "borrow"
Mercurial idea of input/output filters
  http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilter
which would (among others) enable to use constant eol-style in the shared
part of repository i.e. object database, while using OS native eol-style
(UNIX vs. Microsoft Windows vs. MacOS). eol-style doesn't matter much:
you can find good editors which are able to use any eol-style for any OS
nowadays.

File content encoding is something (if it is outside US-ASCII of course)
that you would want either to have some default convention, or have it
embedded in the file itself (like XML, HTML, or Emacs' file variables)
to be able to read file _outside_ SCM.

Path name encoding is something that is global property of a repository,
I think. We have i18n.commitEncoding configuration variable; we could
add i18n.pathnameEncoding quite easily I think (and some way for Git to
detect current filesystem pathname encoding, if possible). Although
BTW I think that i18n.commitEncoding information should be made persistent,
and copied when cloning repository.


But in fact the philosophy of Git _prohibits_ I think property bits.
Unless we add ability (which can be done fairly easy even now, but will
not be automatic) to save some metainfo (ACL, extended attributes,
Subversion-like properties) along with the file (blob) and/or tree
(directory).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
