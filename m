From: Daniele Segato <daniele.segato@gmail.com>
Subject: git tag usability issue: Lightweight vs Annotated confusion for the
 end user (ex. git describe default)
Date: Wed, 24 Jul 2013 12:17:13 +0200
Message-ID: <51EFA9A9.4010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 24 12:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1w8I-0007lF-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 12:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab3GXKRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 06:17:18 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:61373 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3GXKRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 06:17:17 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so95748bkb.36
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=km8UJ9EUiMhu1XnY8HCTlgFV4JUZ7iczRV67GhWSUOk=;
        b=qaIozNjXXQgdrkPo0bLEfbnOR4YekZDzGL8E0sVisad3/rV+TMpQtUWDc5Gp/Rcf8C
         xD7OI9ZiaOLFXhc/NId94C/g0GVXxNSA2l5LAbGW7ZBP3WNikz8UO07eiGioeO50/dbz
         em/XAFsq5E3F+Jkt8K/FTbTNQUWqDvfAQCcbREMD+YOgdEBSKtlO7fwweiM/EuNVFEU1
         qjqkUVvqza0gj3BUfSWC0FoktO92NU0ajQJ4Q4Y309kUwhb0n6xsHNsNYimWcrJ1mnh1
         Tgi6zq18h2WTN52aRW3r47KUP9yCGgKDuXc7OyDk/KPP7nbnrjitExz5KjfyoQfKL8+I
         n5Ng==
X-Received: by 10.204.26.6 with SMTP id b6mr5359574bkc.111.1374661036738;
        Wed, 24 Jul 2013 03:17:16 -0700 (PDT)
Received: from [192.168.1.16] (host22-75-dynamic.4-87-r.retail.telecomitalia.it. [87.4.75.22])
        by mx.google.com with ESMTPSA id qw6sm9353580bkb.4.2013.07.24.03.17.14
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 03:17:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231091>

Hi,

I think there is an issue with the documentation of git tag, or with the 
default being chosen for tags.

the git tag documentation say:

*****
        If one of -a, -s, or -u <key-id> is passed, the command creates 
a tag object, and requires a tag message. Unless -m <msg> or -F <file> 
is given, an editor is started for the user to type in the tag
        message.

        If -m <msg> or -F <file> is given and -a, -s, and -u <key-id> 
are absent, -a is implied.

        Otherwise just a tag reference for the SHA1 object name of the 
commit object is created (i.e. a lightweight tag).
******

And no options below is provided to list annotated tags only or 
lightweight tags only (is there a way to do so?)

I initially didn't get git cared too much on this difference: I've been 
using both annotated and lightweight tags without distinctions, 
annotated when I want to write something about the tag and non-annotated 
when I do not need it.

Since no option is given to show annotated only tags these made sense to me.



Recently I started using submodules and I noticed that:
git submodule status

sometimes gave me the tag name of the submodule between parentesis and 
sometimes it gave me something like this:
+6903774653de52d0206e0e6026ca6914def8a333 submodule (1.0-2-g6903774)

even if the 6903774653de52d0206e0e6026ca6914def8a333 was actually a tag 
(1.1)

the git help submodule say status use git describe, so I've entered the 
submodule directory and tried:

$ git describe
1.0-2-g6903774

$ git describe --tags
1.1

reading the git help describe I discovered the git describe made an 
assumption and default to just show annotated tags.


To me, this assumption should have been documented very clearly in the 
git tag help page, something like this:

*****
        If one of -a, -s, or -u <key-id> is passed, the command creates 
a tag object, and requires a tag message. Unless -m <msg> or -F <file> 
is given, an editor is started for the user to type in the tag
        message.

        If -m <msg> or -F <file> is given and -a, -s, and -u <key-id> 
are absent, -a is implied.

        Otherwise just a tag reference for the SHA1 object name of the 
commit object is created (i.e. a lightweight tag).


        ANNOTATED vs LIGHTWEIGHT tags

        Some git command (ex. git describe) by default only consider 
annotated tags. Annotated and Lightweight tags are not the same thing 
for git and you shouldn't mix them up. Annotated tags are meant for 
release while lightweight tags are meant to tag random commits.
******

And I think an option in git tag to only show annotated tags (or only 
show lightweight tags) is needed.



Finally, now that I discovered this I can't replace the lightweights 
tags with annotated tags without a public announcement requiring all 
developers to delete their local tags.

I'm not aware of any discussion you did about this matter but I think 
there's something wrong here that should be fixed.

Regards,
Daniele Segato
