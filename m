From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC] checkout --rebase
Date: Fri, 19 Jul 2013 15:51:41 +0530
Message-ID: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 19 12:22:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V07pT-0003Zz-F2
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 12:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759675Ab3GSKWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 06:22:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:53654 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3GSKWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 06:22:22 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so9367234ied.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=digj9DSfAwRrccke8s86eIci11Mm7fZvknlKS/n31PM=;
        b=ymaILUvMvivfYsJWNIsaF2GAmZmQiT6rUlOWLJMhSbVILF62Dn4iQU9XwZKf8j4x+R
         Z+AJ8b5sgyTLnOTxuX5e3tXkhdiXhSAzAlfwf6LlL76OdacNoVBvoixfOytO1Dkd7Pch
         RWQo2N72DByUp2fjqQTrmml8MVo2Au85Y0HiQe/tpEVxIWZQoLuTSPYo3DQkxjA3QUrl
         N3o75rADLuXIduvF9AvM3PqXnXhfL9kXN+LIy01vjh1wHYXJ5UtTHavGf3/X8nYEX/aI
         3Mt6V8CTKsQbRke+HLq/4ccLJeA5OUjMc5LhHDYd5+qcDPEWzGNDrPrGAvLuIPU0sL+1
         EUFA==
X-Received: by 10.43.9.4 with SMTP id ou4mr9650209icb.53.1374229341704; Fri,
 19 Jul 2013 03:22:21 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 03:21:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230788>

Hi,

I'm often work on small topic branches, and find myself doing this quite often:

  # on branch master
  $ git checkout um-build
  $ git rebase master

This is horribly inefficient; the first operation takes a _really_
long time to complete, since master updates itself very often and I
have to check out an old worktree.  So, I work around this issue by
doing:

  # on branch master
  $ git checkout -b um-build-2
  $ git cherry-pick ..um-build
  $ git branch -M um-build

... and I scripted it.  Perhaps we should get this functionality in
core, as `git checkout --rebase` (or something)?

Thanks.
