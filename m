From: Bryan Turner <bturner@atlassian.com>
Subject: Pack bitmaps on Git for Windows
Date: Tue, 22 Apr 2014 17:58:10 +1000
Message-ID: <CAGyf7-Go55mJashAi7v5zAdyeUJp2fziwjVHyPxRONZhqr18wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:06:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcViV-0005uw-6i
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbaDVIGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:06:06 -0400
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:45632 "HELO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753409AbaDVIER (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 04:04:17 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2014 04:04:17 EDT
Received: from mail-ob0-f174.google.com ([209.85.214.174]) (using TLSv1) by na3sys009aob122.postini.com ([74.125.148.12]) with SMTP
	ID DSNKU1YigMX7O1metV8A1oyeUavN9Hf0Mpl/@postini.com; Tue, 22 Apr 2014 01:04:17 PDT
Received: by mail-ob0-f174.google.com with SMTP id gq1so5279979obb.5
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=oBFPIxh4jxuVdyvI04rcyypddtUl0psGiJZf6LllI8g=;
        b=exNntcmy+JnCg870YohG5IwzAUzHhm2E35y4Yb8uFnsllOyLm4chgvzx443LkBH1fT
         yvJRRBsZci8QjomSqXYf9GDzKH713T+4kYTYWcq+sBwYIPK7cSDHyfUcKJD+NBChn8QJ
         +7TU64hzAz4dUmJQifsm1yRJhcVxIYSimUOim933rTrK3FNTHMyxehZFMgrVM1U5ofiE
         dH97hgk3UPbmV11jjP6wZXdduTapxEgv4dgNsK1UhZAg73bx73ff9jTDuiqfuwDasdBM
         iRByVzBkYCbk8AH3i2zXZJNtCKPsJ7Ty/aa3sJg9Odw5XQXARMgzWj5X/WkXEShK1O8O
         xHQw==
X-Received: by 10.182.248.131 with SMTP id ym3mr632513obc.58.1398153490172;
        Tue, 22 Apr 2014 00:58:10 -0700 (PDT)
X-Gm-Message-State: ALoCoQm6ix8gwyAMHtlYuT1mOern2qUA+ezFskW8YrBYcqmnHyc57A9+lo+vuuqQuCGvUGnNOs5Nh7vMOYLUsOAB6zJn8E/1Yspp4sQHpwzr20ppWVLH9NHS5sBGFKlTIb5Z0G2zD5Dx
X-Received: by 10.182.248.131 with SMTP id ym3mr632504obc.58.1398153490075;
 Tue, 22 Apr 2014 00:58:10 -0700 (PDT)
Received: by 10.182.40.225 with HTTP; Tue, 22 Apr 2014 00:58:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246711>

It looks like the documentation for bitmaps is being included in the
1.9.2 release of Git for Windows but the functionality itself is not
present. For example, doc\git\html\git-config.html includes settings
like these:

pack.useBitmaps

When true, git will use pack bitmaps (if available) when packing to
stdout (e.g., during the server side of a fetch). Defaults to true.
You should not generally need to turn this off unless you are
debugging pack bitmaps.

pack.writebitmaps

When true, git will write a bitmap index when packing all objects to
disk (e.g., when git repack -a is run). This index can speed up the
"counting objects" phase of subsequent packs created for clones and
fetches, at the cost of some disk space and extra time spent on the
initial repack. Defaults to false.


Repacking repositories with pack.writebitmaps set to true doesn't
write a bitmap, suggesting the functionality is not actually present.

This does not appear to be an issue with "normal" git, per the
documentation for git config at
http://www.git-scm.com/docs/git-config.

Bryan Turner
