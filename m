From: Eric Frederich <eric.frederich@gmail.com>
Subject: Git as a backup system?
Date: Mon, 8 Nov 2010 13:01:29 -0500
Message-ID: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 19:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW2C-0004Bd-7F
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0KHSBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:01:32 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60093 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126Ab0KHSBb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:01:31 -0500
Received: by wwb18 with SMTP id 18so195663wwb.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=4EHGJMrj47QoAOXhisnNWkn6t5LQKL52y1ZFtaCxpdo=;
        b=JFMy27zgTTM1pmqeEIwXSBtk0PFjPVPor5yl4PcpXJCYY/yCIG9zGPvBuD6VSWDrVa
         nH628MJq0UhlajTHFpIj7PkqFN9UnlFohQbkhgrq665LYdH2mLbT4hbrSjpgdqwECE6X
         018RF2pFCgQpY6VNjMwPyYOFxTP6cEI7q94qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=c7TC+pt+2mLyD4yQAB3Zm2AwS2QP6+UZDm3jfDvkChwxmQVugRzNYLiqZtv7GdiFzY
         71mvPx3TUZNU9jlZFXMIbrivGtsAIoogkW2E2M8c0F9AG8dFXvkNsrO7vvDNvgCPD6Ci
         4YKmPBHMcjai1IqQAvSGIu/XrX/ucw48zxnUY=
Received: by 10.227.127.142 with SMTP id g14mr5644975wbs.200.1289239289100;
 Mon, 08 Nov 2010 10:01:29 -0800 (PST)
Received: by 10.227.154.210 with HTTP; Mon, 8 Nov 2010 10:01:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160955>

I maintain a corporate MediaWiki installation.
Currently I have a cron job that runs daily and tar's up the contents
of the installation directory and runs a mysqldump.
I keep backups of the past 45 days.
Each backup is about 200M, so all in all I always have about 9.0G of backups.
Most of the changes are in the database, so the mysqldump file is
changed every day.
Other than that, there can be new files uploaded but they never
change, just get added.
All configuration files stay the same.

I wrote a script that untar'd the contents each backup, gunziped the
mysql dump, and made a git commit.
The resulting .git directory wound up being 837M, but after running a
long (8 minute) "git gc" command, it went down to 204M.

== Questions ==
What mysqldump options would be good to use for storage in git?
Right now I'm not passing any parameters to mysqldump and its doing
all inserts for each table on a single huge line.
Would git handle it better if each insert was on its own line?

Lets say that the repo gets too big and I want to throw away history.
I'd have a linear history with a single commit every day.
Is there a way to take just the last 30 commits and throw away everything else?

Am I insane?  Are there other tools more suited toward this?
I just thought of using Git since I looked at my 9G worth of data out
there in my backup directory that is almost exactly the same and said
"git could handle this well".

Are any of you using git for a backup system?  Have any tips, words of wisdom?

Thanks,
~Eric
