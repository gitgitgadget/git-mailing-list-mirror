From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] completion: zsh: nice stuff
Date: Sat, 27 Apr 2013 15:34:04 -0500
Message-ID: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:35:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBqO-00062U-En
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811Ab3D0UfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:35:25 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:51326 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3D0UfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:35:25 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so4974429oah.28
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=AyN2TpcZXqFYoYElKjvUtdjaGu7qopN3k2fBosf9IJQ=;
        b=SYrBQqaQmJfUbA0CEc7ys9FmwQ4nDiPmXQ9bjx5dljMFyuo/L+OYmzFyQlmNzQyb/N
         EOuA17EC4HjngayBiwCNuR6186JFWpashHEjOHM4PBl/tldFipi7lRINRcmuygEnamMu
         Zb89nSHVFsJbP2sehusXP3kQUVs9ZkS6Wkctsbbc2+RR3yTgEprHKmKy7sf6vxSvVHnd
         2OPBA6v+kubrS10h+olqsFkH4oBnMjC+3e+id6rIGZYEKz8j4z/UMsmNI566OAonmE9f
         kmZmnK5KZxo80DdLeBZJLk01qh6Pyqlge2RDQreJXinnv7vwb4Psl4do1442fvctZh+6
         6HHQ==
X-Received: by 10.60.29.161 with SMTP id l1mr8909070oeh.111.1367094924537;
        Sat, 27 Apr 2013 13:35:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dt3sm13407000obb.12.2013.04.27.13.35.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:35:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222695>

Hi,

Our thin wrapper seems to be doing a good job of providing all the bash
functionality, to zsh, however, we can do more.

This patch enables zsh-specific functionality to list the main commands, and
general options. So we get:

  % git <tab>
  add       -- add file contents to the index
  bisect    -- find by binary search the change that introduced a bug
  branch    -- list, create, or delete branches
  checkout  -- checkout a branch or paths to the working tree
  clone     -- clone a repository into a new directory
  ...

And:

  % git --
  --bare      -- treat the repository as a bare repository
  --exec-path -- path to where your core git programs are ...
  --git-dir   -- set the path to the repository
  --help      -- prints the synopsis and a list of the ..
  --html-path -- print the path where gits HTML ...
  --info-path -- print the path where the Info files are ...
  --man-path  -- print the manpath (see `man(1)`) for the ...

And:

  % git --git-dir<tab>

Automatically adds the space, and then lists only directories.

Plus a lot of very specific argument idioms that are only possible in zsh.

In addition, you can complete commands that are not shown in the list, like
'git rerere'.

Plus, the user can configure the main output of commands:

  zstyle ':completion:*:*:git:*' tag-order '*'

Or:

  zstyle ':completion:*:*:git:*' tag-order 'alias-commands common-commands'

In short, pure awesomeness :)

Felipe Contreras (2):
  complete: zsh: trivial simplification
  complete: zsh: use zsh completion for the main cmd

 contrib/completion/git-completion.zsh | 134 ++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 8 deletions(-)

-- 
1.8.2.1.1031.g2ee5873
