From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Allowing weak references to blobs and strong references to
 commits
Date: Tue, 31 Mar 2015 16:18:07 -0700
Message-ID: <20150331231807.GG22844@google.com>
References: <20150331100756.GA13377@glandium.org>
 <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
 <20150331223919.GA24362@glandium.org>
 <20150331231449.GF22844@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5QG-00086t-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbbCaXSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:18:12 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33546 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbCaXSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:18:10 -0400
Received: by ignm3 with SMTP id m3so21410549ign.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Zz7oOGNi/aZcB9FD+zYsi85xUGKLNLllD9Y3wAVoHvs=;
        b=ckjlJ6Qo3NtwKCft/6MXnrgdzc6AMKasRNOmQvn+OSIvUOhVtXxWn2GDc30hC0bEhr
         aUyeCIkOODtPkG26rQxj04uBr9MQg+gNY07oJKP8ewdl3t7qPasF8X3V1+4tD0iue/3J
         ju9IhtdBmIGWjC8pHU5c0s+6Rr61Xp5ZRUFZnkrxhi+6PWF/rVSGCcBHon3yBEXEvleC
         znflCajDmx4+oWODJ8ZpLRwp+J1RXIZQH1CV6wqEScDOcKoAc/Zw2iJ6JhgYQ08njAO0
         5aXPp09Kcn4r53whuBfZOGeeXlLaNQfAcrN/ySOgheTF8U31JYgldc7qHjB5L5LQdsiy
         gE4g==
X-Received: by 10.42.41.148 with SMTP id p20mr69827343ice.62.1427843890136;
        Tue, 31 Mar 2015 16:18:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:dcc8:cc5b:3d3e:d0a6])
        by mx.google.com with ESMTPSA id 192sm57125ioo.38.2015.03.31.16.18.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 16:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150331231449.GF22844@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266579>

Jonathan Nieder wrote:

>                                                                 How
> about this patch?

I think I botched the wording.  Here's a second try.

-- >8 --
Subject: fast-import doc: remove suggested 16-parent limit

Merges with an absurd number of parents are still a bad idea because
they do not render well in tools like gitk, but if they are present
in the repository being imported into git then there's no need to
avoid reproducing them faithfully.

In olden times, before v1.6.0-rc0~194 (2008-06-27), git commit-tree
and higher-level tools built on top of it were limited to writing 16
parents for a commit.  Nowadays normal git operations are happy to
write more parents when asked, so the motivation for this note in the
fast-import documentation is gone and we can remove it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f71fb01..690fed3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -507,10 +507,6 @@ omitted when creating a new branch, the first `merge` commit will be
 the first ancestor of the current commit, and the branch will start
 out with no files.  An unlimited number of `merge` commands per
 commit are permitted by fast-import, thereby establishing an n-way merge.
-However Git's other tools never create commits with more than 15
-additional ancestors (forming a 16-way merge).  For this reason
-it is suggested that frontends do not use more than 15 `merge`
-commands per commit; 16, if starting a new, empty branch.
 
 Here `<commit-ish>` is any of the commit specification expressions
 also accepted by `from` (see above).
-- 
