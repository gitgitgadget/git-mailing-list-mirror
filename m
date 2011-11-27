From: Jakub Turski <yacoob@gmail.com>
Subject: [BUG] difftool falls back to normal diff when used during merge resolution
Date: Sun, 27 Nov 2011 18:09:14 +0000
Message-ID: <CAHWJSOSB768hWsNqrR559wef3-k_yZ=TjS_mxfj3TxXdgwm5iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 19:09:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUjAb-0005hP-9B
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 19:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab1K0SJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 13:09:36 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46616 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab1K0SJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 13:09:36 -0500
Received: by ggnr5 with SMTP id r5so4588923ggn.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=LVqaA+NtF+U/eO4XTcd15oLE7o6y3XD50Gm2kGNTZpo=;
        b=Ypi2LXfGY+dT5BGV1GBIuNgvYjGINty2PMJR96W9kP5ArocYq24ob3gNseBRcbcxsJ
         267ctXn7sV8CqLOQGZTdLEwmvelA9crXSxD9I8DTkC1ow2TYOU9p5drWQ9Is65DfZ1dN
         D3snQJHrAygvvp7ARVvQpsbiB4eY+ZKqgLOXU=
Received: by 10.236.124.39 with SMTP id w27mr7461115yhh.125.1322417375062;
 Sun, 27 Nov 2011 10:09:35 -0800 (PST)
Received: by 10.100.239.14 with HTTP; Sun, 27 Nov 2011 10:09:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185990>

Hello there,

Just found this behavior, and after a chat on IRC it looks to me like
an actual bug. I have 'git difftool' configured to use vimdiff - and
it worked fine. Despite that config, git still falls back to plain
diff when I launch difftool mid-way through merge conflict resolution.

Here's a reproducable testcase (w/ version 1.7.7.3)

$ mkdir a; cd a; git init; echo A>A; git add A; git commit -m A; git
branch alt; echo AA>A; git commit -am AA; git checkout alt; echo B>A;
git commit -m B; git commit -am B; git checkout master; git merge alt;
git difftool -t vimdiff A

Results:
http://pastie.org/2929336

KT.
