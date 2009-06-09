From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 15:52:46 -0400
Message-ID: <32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME7Nk-0004ez-Dp
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbZFITxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbZFITxG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:53:06 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:62421 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZFITxE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 15:53:04 -0400
Received: by gxk10 with SMTP id 10so295267gxk.13
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zg2k7LBqnbmqiWYfHyrKEOPJusmTFb3wD5D+/6gK8LE=;
        b=QT4hYA6TDxmKH6Cx1x18lCTM0Nt/wns12nFzxQEMkD6eSsNco772rlr99XxRA9AO8W
         SDSMXBrDebMmJL0D3B9/UY9ubT16BzbHEAh263wb37H+XjBXFA1FAoE8UmFSGH2zfCwp
         BXO0zIrZE3TFI3WiMzcoKYq3urlI3Y4OjI6WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gJe3A7lwqn+l2VhWAKv3Sa0MdipOAFo1h5sW+hGC1CVJKWKkmXKzWQQRUPk5syAhIN
         c4d3h2Y7aB5rN7NOK0FvodD+cHEwi2wAt5K2Pu1RZsStlzofjZi1BCxCosAh0KvO62Jg
         2rSrZyFDjPh4paGs42G9v29txN0kracsGETM4=
Received: by 10.151.68.2 with SMTP id v2mr1090954ybk.30.1244577186085; Tue, 09 
	Jun 2009 12:53:06 -0700 (PDT)
In-Reply-To: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121215>

On Tue, Jun 9, 2009 at 2:59 PM, Scott Chacon<schacon@gmail.com> wrote:
> * breaks the various things that 'checkout' does into separate
> commands - moves 'revert' to doing what 'checkout -- path' does, move=
s
> current 'revert' to 'cherry-pick --revert' (which someone mentioned
> was a good idea at the last GitTogether), and adds 'unstage' for
> 'reset HEAD file'. =A0also adds a '-s' option to 'branch' to switch t=
o
> the branch after you create it, which many people expect rather than
> 'checkout -b'.

This would definitely make it easier to explain things to svn users.
To be honest, I'm not convinced svn's use of the word "revert" is
really right, though.  Git's isn't *really* right either, since it
actually makes a new commit, it doesn't remove the old one like it
sounds like it does.  Maybe 'reverse' would be a better name for what
git does, and we should just introduce another word for what svn does.
 (With CVS, you just deleted the file and then did a checkout/update
on it again, which made sense to me.  That works in git too.)

Crazy idea: we could actually make 'git revert' do both: given a
commit, it applies the reverse as it does now.  Given filenames, it
simply brings them back to HEAD.  But maybe that's too crazy.

> * adds 'git resolved' for 'git add', which I hear all the time as
> being confusing

This one doesn't really do it for me.  svn's need to "resolve" a file
after removing its conflicts always annoyed me.  Look, you can see
I've screwed around with the file.  The file contains no more
conflicts.  It's resolved, already!

Maybe it's heresy, but I really liked CVS's way of dealing with this:
if the file still has conflict markers in it, it's not resolved.  If
it doesn't, then it's resolved.  Very hard to mess up.  And I've
definitely messed up (and known other people to mess up) with both
svn's method and git's method, both of which allow you to commit files
with conflict markers without getting warned.

> * adds 'git publish' for creating a bare repo from your current repo
> and scp/rsync-ing it to a server (which is nice if you're not using
> GitHub/repo.or.cz where remote repo seeding is easier)

Very cool, and this has been seriously hard to explain to people.  I'm
not even sure there *is* a good way to do this without running a
series of several commands.

> * adds 'git info' which shows a bunch of basic information about the
> repo, which is actually pretty cool

Less important to me, but sounds fine just due to svn compatibility.

> * 'git push origin --delete <branch>' for 'git push origin :branch'

This would help a lot of people too, I think.  Although some might
argue that "helping" them to delete branches is maybe not a great
idea.

Have fun,

Avery
