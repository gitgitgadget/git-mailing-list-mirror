From: =?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
Subject: Confusing --graph --all output with detached branches
Date: Thu, 19 May 2016 15:45:46 +0200
Message-ID: <CA+cck7FPzK-zccBVzphY_N41acOvqjwmDmgQH7ZE3SHG2k1rFw@mail.gmail.com>
Reply-To: bjornar@snoksrud.no
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 15:45:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3OGu-00061U-9w
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 15:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbcESNps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 09:45:48 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36118 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbcESNpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 09:45:47 -0400
Received: by mail-vk0-f43.google.com with SMTP id y2so32530265vka.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to;
        bh=mQUFXEZw9559ZV33olq6T+c1GPI5BDS+4WC2ex5pJH8=;
        b=Hb9tSTmUGcU8IGUKaCt8bD5+0yL9XjVLDEduzNzEosclty+9vYBAWCJd3wuI5S/zrw
         fCrpinvsDNwm9LOPC8R7JAos87pVY+2NQ0dVfOWuL32ot1bZNIsXD5eEatu9IWzn1fdA
         fY/RsrS2iGfMjsfqYyYs8JbWht2lIv1Px9rcC2NMlYcxtJOQ/OrbqBBVyXbPOddJa1H7
         Pr62GMSc+5MUAFzCVKjGd4GE3J91clM5eVK2/djlc0ZPMrgTe09J6+2pYJcHWVOLj2N4
         /ibZCm+EhT+0sCX2XhJGGfvCug2GCHb4eReA2reCDoZ3k40Zri5wt3CymMKAn/z1R2zf
         FpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:date:message-id:subject
         :from:to;
        bh=mQUFXEZw9559ZV33olq6T+c1GPI5BDS+4WC2ex5pJH8=;
        b=GY9cp+JV8woLM82jStqm6U4+pzSbP0ev2/TDv7olNOOJmRIC1J+V8hZap+uYmgd5C9
         qOund/3zTulvF/I+k837hTACo3iE0+a76UCbSFiyaLClU+FUj9NNkmJzvyDeOivVYZMZ
         yhlvJghyPyMDIkCrT8+QdXB49GInlOg4IfzM47dT325crAq+wtoOZt6FNIdlY2uzALmo
         bYsGE2Jw8tXeAvF6cWopG4QhO+6uLdymhbxaSSUqgj+9bMr7TYykV3qwYHxhNLZJAkFZ
         s9w7ur0mfq750DF4VE5DHmfa4pMEMSMR8tq4XnyVcOsWKiPOxk5/oZUx1W+9R6h1oquV
         tKHQ==
X-Gm-Message-State: AOPr4FUh+6Tkc8mlES67i65xzV1WkuNIUHj3ycBRiVPsa+AGukXMVhWKgsTcqcIkXzTLRxKonxiuuLHXHyQZMQ==
X-Received: by 10.31.193.71 with SMTP id r68mr7209141vkf.4.1463665546466; Thu,
 19 May 2016 06:45:46 -0700 (PDT)
Received: by 10.176.1.22 with HTTP; Thu, 19 May 2016 06:45:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295059>

If you end up with a history containing commit A with parent B, where
a detached branch is merged into A while an unrelated branch branches
off of B, you will get the following output:

$ git log --graph --all
*   commit ff4265fcbfe94a2abe93c97d86e0d9f0e0a136cb
|\  Merge: 8b62de9 0bbc311
| | Author: XXX
| | Date:   Thu May 19 15:31:46 2016 +0200
| |
| |     Merge branch 'bar'
| |
| * commit 0bbc3115caa089d8578eb52ba6c12c1b43153dad
| | Author: XXX
| | Date:   Thu May 19 15:31:40 2016 +0200
| |
| |     5
| |
| * commit b1c9c491a05d9ffeca2e1d7b5cbd392cd90eef82
|   Author: XXX
|   Date:   Thu May 19 15:31:39 2016 +0200
|
|       4
|
| * commit ce053f92a9290f5472aac3319ddadbaf5bf62371
|/  Author: XXX
|   Date:   Thu May 19 15:31:31 2016 +0200
|
|       3
|
* commit 8b62de9f421c0be46300a3e68f85c6e7608c24f6
| Author: XXX
| Date:   Thu May 19 15:31:02 2016 +0200
|
|     2
|
* commit cb7e7e2662f1477f030a889cab135ed5a19ba43e
  Author: XXX
  Date:   Thu May 19 15:31:00 2016 +0200

      1

-

Which is pretty informative  - after '2' we branched out for commit 3,
and the branch containing 4 and 5 was merged into master.

However, if you use the pretty common `one line` git log alias, you get this:

*   ff4265f  (HEAD -> master) Merge branch 'bar'
|\
| * 0bbc311  (bar) 5
| * b1c9c49  4
| * ce053f9  (foo) 3
|/
* 8b62de9  2
* cb7e7e2  1

.. which indicates that `foo` is contained within `bar`. Maybe

*   ff4265f  (HEAD -> master) Merge branch 'bar'
|\
| * 0bbc311  (bar) 5
| * b1c9c49  4
|
| * ce053f9  (foo) 3
|/
* 8b62de9  2
* cb7e7e2  1

.. would be better?

Reproduction steps:

git init
git commit --allow-empty -m 1
git commit --allow-empty -m 2
git checkout --branch foo
git checkout -b foo
git commit --allow-empty -m 3
git checkout --orphan bar
git commit --allow-empty -m 4
git commit --allow-empty -m 5
git checkout master
git merge bar -m merge
git log --graph --all  --pretty=format:'%Cred%h %C(yellow)%-d%Creset %s '


-- 
bjornar@snoksrud.no
