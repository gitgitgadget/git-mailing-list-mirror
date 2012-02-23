From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 12:14:23 +0300
Message-ID: <4F46036F.3040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 10:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Ul5-00036G-OK
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2BWJOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:14:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52258 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2BWJOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:14:31 -0500
Received: by bkcjm19 with SMTP id jm19so822220bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 01:14:30 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.204.9.205 as permitted sender) client-ip=10.204.9.205;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.204.9.205 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.204.9.205])
        by 10.204.9.205 with SMTP id m13mr258948bkm.68.1329988470630 (num_hops = 1);
        Thu, 23 Feb 2012 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=qSQF7Z5ws+pv4sbF61jlqum9mE2Gm/bF2Xx9UeRl/uI=;
        b=CHrWncXcv1ZYVzEBNcy8ln3Ez0xgwqV1UAZQJqGQTsIdQ+CQRVe4AzRTjeKWgogBcm
         y+zbcLUPdMMkzZQP7+FFj+zWT+MtZwh/DuQrgluwTW1HgjZuA6EMPaeH+UgPnKnz1wUL
         2Sok60AUAC7BuJU6d9t9CJcIi02EKfuEMlXJE=
Received: by 10.204.9.205 with SMTP id m13mr218269bkm.68.1329988470535;
        Thu, 23 Feb 2012 01:14:30 -0800 (PST)
Received: from [192.168.1.130] ([80.249.81.45])
        by mx.google.com with ESMTPS id bw9sm1358564bkb.8.2012.02.23.01.14.28
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 01:14:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191336>

Hello all.

I wanted to generate several files with some statistics using "git log 
-z" command.
I did something like this:
git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0 
--max-chars=1000000 ~/1.sh

If I put
echo "started"
into the file  ~/1.sh I see that the file is called only once instead of 
multiple times.

I'm newbie to xargs, thus I tested with and that worked as I expected.
find . -type f -print0 | xargs -0  ./1.sh
That produced a lost of "started" lines.

Thus I suspect there is a but in git log -z command and that doesn't 
"Separate the commits with NULs instead of with new newlines." as 
promised in the documents.
Is my understanding correct or I don't understand the documentation or 
somehow pass wrong parameters into git log?

Thank you.
Best regards,
Nikolaj
