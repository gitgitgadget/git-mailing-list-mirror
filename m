From: Phil Hord <phil.hord@gmail.com>
Subject: Confusing error message
Date: Thu, 14 Jun 2012 18:54:57 -0400
Message-ID: <CABURp0qE+qJjyrhRFb8-gWucM0=3TpYwDBsnbCPrZNVe3QGQBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 00:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfIwq-00006L-4P
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 00:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab2FNWzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 18:55:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38915 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2FNWzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 18:55:18 -0400
Received: by yenl2 with SMTP id l2so1426519yen.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=bp1DYevjXn/fcwelNfDNd7wC6dPn7Hy+tkLR0WykLz4=;
        b=uU9chUbeYLAFKAlJjo6dG8salmOeHsAWwOZU4kTD7LH+d1JhBMkVupB/IJciWqoOTL
         mIS1+pWvjhouEDxgQfNI5T9QyJ8Sm07Gpr9skym0iBPbbTXTN5CEMC5dw7cW/6kgHEjl
         m0XUP9II70nBRUus3glZITETBGY/tVzsvUjpglgk/7gZdlkn9xDFvKGYGurky82idmm5
         3B/e6VwhLJgrbGXBOWwS+9wHRbhtw7hJNabC/Ts5Eu3gVdFbriuaDWIVt4xCI/fBw1+y
         gO+cC3BtlHSfm6yMBs+7P8DnvlK+gav5WjdtOePYUIR/PHFaR7jR/K4dVtYNdzWuqlRV
         TWzA==
Received: by 10.236.75.40 with SMTP id y28mr5688279yhd.65.1339714517934; Thu,
 14 Jun 2012 15:55:17 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Thu, 14 Jun 2012 15:54:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200033>

I messed something up during a rebase in a moved file (probably
because I had rename detection turned off).  So now I want to fix it.

I think I have the commit amended right, but to be sure I want to diff
the old file and the new file.

  $ git diff newfile HEAD^:oldfile
  fatal: Path 'oldfile' exists, but not 'oldfile'.
  Did you mean 'HEAD^:oldfile' aka 'HEAD^:./oldfile'?

This was confusing, so I tried different variants. This one produced
no output, suggesting no differences:

  $ git diff -- newfile HEAD^:oldfile

But this one shows me that there are differences:

  $ git diff HEAD^:oldfile newfile

And so did this one:

  $ git show HEAD -M

Am I spelling the syntax wrong?  Is the <ref>:<path> syntax not
allowed on diff?  If so, why all the inconsistency?

In case I am misreading something here, here is the unmolested command
and output I am using:

$ git diff Tasker_Servers/Server_Common/GuiConfig.h
HEAD^:./Tasker_Servers/Server_CommonGui/GuiConfig.h
fatal: Path 'Tasker_Servers/Server_CommonGui/GuiConfig.h' exists, but
not 'Tasker_Servers/Server_CommonGui/GuiConfig.h'.
Did you mean 'HEAD^:Tasker_Servers/Server_CommonGui/GuiConfig.h' aka
'HEAD^:./Tasker_Servers/Server_CommonGui/GuiConfig.h'?
$ git --version
git version 1.7.11.rc3.219.g94bee05

Phil
