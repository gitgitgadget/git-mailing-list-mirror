From: Jack Nagel <jacknagel@gmail.com>
Subject: [BUG] remote.pushdefault and branch.<name>.pushremote definition order
Date: Mon, 24 Feb 2014 00:10:04 -0500
Message-ID: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 06:10:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHnob-0000IJ-EE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 06:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbaBXFKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 00:10:25 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44196 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaBXFKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 00:10:24 -0500
Received: by mail-ie0-f175.google.com with SMTP id at1so3086146iec.20
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3ZJgpEUaSEqsL/zNN/ybzYIeLmiQ5MDWFpqUcu7svOc=;
        b=oJUvENzPzF9249pBYY6aDqSIgFpfJl/wDNllO26JTcLBksThsQZpXxhHm4rxyRDEFY
         rj/nsiCnNm+VgO2c2hriP1wQMp1klYIIUTaj+8GUTFTksTsyQxth8gj3l9V2K+ylnf8X
         jjMGX3V6MQYymJplqgoHcgmUrAxQMmhcKszjTisqbhNQwge9n/ykpjbh6Mt1qlR+B64E
         A0mVXqFHExV79v7+dZ4dSy20AuZLcE8JWT2w4rj9boPM17e13YsL0QDnPtFoQ9UGpcHO
         11BQ0kKNnjmpAI5gpQo9PhAQJc9lZ9azj/kwA37u37c7EFnZTKH7VCikuLNcjwdXdCoJ
         1EyA==
X-Received: by 10.43.171.134 with SMTP id nu6mr12660253icc.92.1393218624311;
 Sun, 23 Feb 2014 21:10:24 -0800 (PST)
Received: by 10.64.6.34 with HTTP; Sun, 23 Feb 2014 21:10:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242558>

There seems to be a difference in the behavior of "git push" depending
on whether remote.pushdefault is defined before or after
branch.<name>.pushremote in .git/config.

If remote.pushdefault is defined to be "origin", and later in the
file, branch.master.pushremote is defined to be "upstream", then a
plain "git push" from master errors out because I haven't provided a
refspec or configured push.default. This makes sense.

However, if the order of the two in the file is reversed, then a plain
"git push" pushes to the "origin" repository, even though I have set
the pushremote for master to "upstream". This appears to be a bug.

I would expect the order that things are defined in the config file to
have no effect on the behavior of "git push".

I have reproduced this using git 1.9.0 and 1.8.3.4.

Thanks,
Jack
