From: David Reitter <david.reitter@gmail.com>
Subject: relative path specs not understood
Date: Tue, 10 Nov 2009 13:13:55 -0500
Message-ID: <9D4D6466-59BB-427D-97E5-C4E963CB769B@gmail.com>
Reply-To: David Reitter <david.reitter@gmail.com>, git@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 19:14:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7vED-0008Lh-CS
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 19:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbZKJSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZKJSNx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 13:13:53 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:56121 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZKJSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 13:13:53 -0500
Received: by qyk32 with SMTP id 32so135693qyk.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:reply-to:subject:date:message-id:to
         :mime-version:x-mailer;
        bh=Wyt4e4CwMW05k69SgSqI7Zh/FLW/9uNcaBTEKLMB75M=;
        b=v7/wk/h1Zbz/NDMqQQcXDUMV5q6spAeQWyiwT3O6yZKxpfcQqTSJEL0pUOvPK/mJOr
         PXl7FLXCxj0ggdxkrTlLid5n7QJHblV5NDuP6njuq+0rFT5wv0KJlEHJpcy2T1pyUqJc
         t/e4hFsK2+3aVVEYtrvWk7uGWqAo/ehGRVkmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:reply-to:subject:date
         :message-id:to:mime-version:x-mailer;
        b=Df7eVPLqE7sangj7oTV46d787p1kqfDbP5ZnFgQIG5DcKoTiqHQLbPUWJXdbbMPQ7e
         K5qMT8VseK7g4DBIrw8vz9dYn1L5f8tT/JaBm4Fko/HpbqYCqUxw6GZmB3y5kcgIIsPG
         E1GV8oPR1Kw30KCu9GTJg/pdE4haojtpzUi6s=
Received: by 10.224.69.84 with SMTP id y20mr209438qai.353.1257876838576;
        Tue, 10 Nov 2009 10:13:58 -0800 (PST)
Received: from scarlett.psy.cmu.edu (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id 23sm715307qyk.7.2009.11.10.10.13.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 10:13:57 -0800 (PST)
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132583>

I'm troubled by a repository in which I can access certain files only  
using the full path specification, but not from within the directory.   
The protocol below should explain this.
I have a hunch this may have to do with certain symlinks (stored in  
the repository), or maybe with renaming.  Any help on debugging this  
would be great.  Perhaps I've just misunderstood something here...

- David


~/ae.git$ git --version
git version 1.6.5.2
~/ae.git$ cd etc
~/ae.git/etc$ git ls-files DISTRIB
DISTRIB
~/ae.git$ cd ..
~/ae.git$ git ls-files -t -- aquamacs/TODO
H aquamacs/TODO
~/ae.git$ cd aquamacs/
~/ae.git/aquamacs$ git ls-files -t -- TODO
~/ae.git/aquamacs$ git ls-files -vmo -- TODO
? TODO
~/ae.git/aquamacs$ git status TODO
error: pathspec 'TODO' did not match any file(s) known to git.
~/ae.git/aquamacs$ git add TODO
~/ae.git/aquamacs$ git status TODO
error: pathspec 'TODO' did not match any file(s) known to git.
~/ae.git/aquamacs$ cd ../lisp/
~/ae.git/lisp$ ls -la aquamacs
lrwxr-xr-x  1 dr  dr  25 Oct  7 22:30 aquamacs -> ../aquamacs/src/site- 
lisp

~/ae.git/.git$ cat config
[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
         ignorecase = true
(...)
