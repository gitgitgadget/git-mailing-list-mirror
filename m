From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 22:32:05 +0100
Organization: At home
Message-ID: <eqldhe$h7i$1@sea.gmane.org>
References: <1170933407.15431.38.camel@okra.transitives.com> <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com> <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org> <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 22:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFzo3-0001mO-E5
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 22:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXBJVan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXBJVan
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 16:30:43 -0500
Received: from main.gmane.org ([80.91.229.2]:39125 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbXBJVam (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 16:30:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFznj-0008RU-7f
	for git@vger.kernel.org; Sat, 10 Feb 2007 22:30:31 +0100
Received: from host-81-190-18-64.torun.mm.pl ([81.190.18.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 22:30:31 +0100
Received: from jnareb by host-81-190-18-64.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 22:30:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-64.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39260>

Linus Torvalds wrote:
 
> On Sat, 10 Feb 2007, Theodore Tso wrote:

>> 3) The git-tag man page talks about GPG signing tags, but it doesn't
>> talk about how a GPG-signed tag is validated.  Does this happen
>> manually or automatically?
> 
> Use "git verify-tag X" to see something like this:
> 
>       [torvalds@woody linux]$ git-verify-tag v2.6.17
>       gpg: Signature made Sat 17 Jun 2006 06:49:59 PM PDT using DSA key ID 76E21CBB
>       gpg: Good signature from "Linus Torvalds (tag signing key) <torvalds@osdl.org>"
> 
> but you obviously need to have the public key in question available to 
> you.

One of the solutions, used in git.git repository, is to put public key
as a out-of-tree blob using git-hash-object, then tag it using singed tag
with instruction about how to extract key in the tag message (tag comment).

 $ git cat-file -p junio-gpg-pub
 object 0246401b5d117e01717149c413aa2f8702a83d4f
 type blob
 tag junio-gpg-pub
 tagger Junio C Hamano <junkio@cox.net> Tue Dec 13 16:33:29 2005 -0800

 GPG key to sign git.git archive.

 This blob object contains the GPG public key I use to sign git.git
 archive.

 To use it to verify tags I signed, do:

   $ git-cat-file blob junio-gpg-pub | gpg --import

 to import it into your keyring, and then

   $ git-verify-tag $tag_to_be_verified

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
