From: Mike Kasprzak <mike@sykhronics.com>
Subject: Can we get a git clone flag to override the "required empty
 directory" behaviour?
Date: Fri, 24 Jul 2015 14:04:27 -0400
Message-ID: <CACjsLYAPqCujmR0wQM-CD=qrPJz1zrC11Pe=C07DUBdEsG2r7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 20:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIhL2-0003x5-0p
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 20:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbbGXSEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 14:04:48 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34918 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbbGXSEr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 14:04:47 -0400
Received: by pabkd10 with SMTP id kd10so17838033pab.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=wZYnSjSgQnkErl42e9IMROdshpkmzcAuaw6+3744jgw=;
        b=fYhMKLhKloHPL9nJvr4IMep2Q74apwj2btsWNzq2rgAK1igJtadQstllIX3IIKyvmN
         Mce91oMJXbdxLyjqfwkkxn4qgKDlb+iDNFbkV1hXYI+P94ATPxiMQ7/jT4Naj4Cx7Dcc
         7c98r8Se+yNoZaArGobU71WJ6glLVZKDgBaZL9kPGAZpnZIlrQmuAxRPN7sFRY+NaSvo
         w7axu08BwQMqA4MYVxJPYU3MnXqdHkCyAe6J+rVSMhuQRbSSYb3zyKA9Fnu/9WP0uzT5
         V6IwsuFwnZ969yOMyU9jg20xMr+h7MyOWpbeNpNIow2WgyxWQroUXdKuAy4EA5PJupO8
         H1KA==
X-Received: by 10.70.119.41 with SMTP id kr9mr34074653pdb.0.1437761086631;
 Fri, 24 Jul 2015 11:04:46 -0700 (PDT)
Received: by 10.67.1.33 with HTTP; Fri, 24 Jul 2015 11:04:27 -0700 (PDT)
X-Google-Sender-Auth: lleVoqSyuupkEKniDhQ5ZNadqBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274576>

Hi,

I run a project with 2 repositories. One is a vagrant based toolchain
(a VM that runs a LAMP server), and the other is the source code.
Because I want my users to keep and make their changes to a clone of
the source repository, we can't use submodules. They make their
changes, test locally, and push them at me when they're done.

The source code goes in a 'www' subdirectory, but for an improved user
experience, I include a pre-configured version of the config file in
that 'www' directory. That way, after they check out the code and
start their local server, it just works. Easy.

What I would like to do is git clone inside that directory. Alas, git
will not let you clone in any directory containing a file.

Today we use `the workaround`, which involves doing a git init, adding
a remote origin, fetching, and finally checking it out.

http://stackoverflow.com/a/18999726

This is `fine`, but it's not a good user experience. All we really
want is a clone, and there just happens to be a configuration file
pre-installed in the same directory.

Can we please get a flag (say -f or --force) for git clone that
overrides the default behavior of not allowing you to clone in to a
non-empty directory. If there already was a .git directory in that
directory, sure that's a no-go scenario. An with a name like --force,
it should be aggressive, overwriting anything it sees. Again, git can
already do this, it's just a lot more long winded that it should be.

Thanks,

Mike Kasprzak
