From: Jeremy Morton <jeremy@configit.com>
Subject: git's behaviour during a 'both added' merge conflict
Date: Thu, 22 Mar 2012 14:23:24 +0000
Message-ID: <CAFsnPqrqz+HZGJHWp6YEWKJeXO2jYDw-qYfAdtHhDvYVmeTD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 15:23:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAivM-0001Kk-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 15:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936Ab2CVOX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 10:23:27 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34243 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab2CVOX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 10:23:26 -0400
Received: by lbbgm6 with SMTP id gm6so1780816lbb.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 07:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=hdcmBBjeeebnonfGbGjf1PsLU7q4XaD8KqDS1gLsWqQ=;
        b=Kd9B6luyy7ilg7+DctiY4cNzQBwZzlArue7eTIXROdRj91ssy6kDTC37K8lnFCOnRU
         F2tfHTqySoiFB/WYSQ4SlLA6xYUzm6xRcbi49D4R6alTvokQBWoKMb0daDXyqolWYFi8
         QYegh6CfcYFinJT2YcPWyGL01FxUVSBakuWOiN0Kaju31lEJkoWYgD7wO6beNf35xM/x
         9jkbVEEMFqvD/fxkJTH+yh7jNqo8ERM42CzfO5LdnydqMHttv7kOZZL9slI4Uo9pbCgx
         KKm7YD5Gzpdl21VswC8pW9jmPkFkFe4kmj4jfWDvmpNarPP9uj/O251GjXd81dcPk1A+
         q0OQ==
Received: by 10.152.105.241 with SMTP id gp17mr6591062lab.21.1332426204518;
 Thu, 22 Mar 2012 07:23:24 -0700 (PDT)
Received: by 10.112.83.100 with HTTP; Thu, 22 Mar 2012 07:23:24 -0700 (PDT)
X-Gm-Message-State: ALoCoQltGr6tpJlP+DtOXGb8G/62tg77xB1WBy1E0LQIGvryKWwIQAtj9tRzeqTsdC8b8nmXejZ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193660>

I've noticed that when you're merging and there is a 'both added'
merge conflict, git creates the .LOCAL and .REMOTE files for the
merge, but not the .BASE file.  Now, there isn't an actual base file
because the file has been added anew in both branches, but wouldn't it
make sense for git to just create an empty .BASE file anyway?
Conceptually, new content is being added on both sides to an empty
container - the fact that it didn't exist as a file on the filesystem
before is something git isn't meant to care about.  It also makes
things easier for merge tools which are expecting a .BASE file; in
practice, scripts just usually create the empty .BASE file anyway.
Why not have git do this itself without a script?

Best regards,
Jeremy Morton (Jez)
