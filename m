From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Rename edge case...
Date: Fri, 09 Nov 2012 09:27:23 +0000
Message-ID: <1352453243-ner-1164@calvin>
References: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 10:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWkuR-0001uW-OV
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 10:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab2KIJ3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 04:29:42 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62489 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab2KIJ3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 04:29:25 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so2034851eek.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=x0Tl/JLcjTG/5CjYoPz5I9WZrk13e0pGFRi0ZbghbFs=;
        b=xq8+xoAwqEHGCqpEIU5+zRM3RcspDxN5gL6JWF/vw3FwwpujQQqomG2c2TaVg/1GIC
         8VCiiw0skVL88bjubFER+foEMARxUhw9g7JKtvXj6rnfhyoqK95vtx4Qv7OCxLajmAJ6
         WYKf1H54DXYBj5y8Aph3txngJ8TdOc21sx41gKbLnF6id89aSP4cMd2vypBKsK678/5B
         reV7WYXowrYgrILGngRr2nmJYTWkXpwii1CM9zu7Jk14D2A1JdysYh26LQKrBvwjMa3D
         PKZIAEJUkggGB6z/07x75IT7GFyPOr0BOVoALw8fVIs+CufcIEz/lFYvvvfstA/B9ngX
         1fgg==
Received: by 10.14.194.2 with SMTP id l2mr36182719een.12.1352453363779;
        Fri, 09 Nov 2012 01:29:23 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id d44sm75429508eeo.10.2012.11.09.01.29.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Nov 2012 01:29:23 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id B06AC158481; Fri,  9 Nov 2012 09:27:23 +0000 (UTC)
In-Reply-To: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209210>

On Fri, 09 Nov 2012 04:10:31 -0500, John Szakmeister <john@szakmeister.net> wrote:
> I've been browsing StackOverflow answering git-related questions, and
> ran across this one:
>     <http://stackoverflow.com/questions/13300675/git-merge-rename-conflict>
> 
> It's a bit of an interesting situation.  The user did a couple of
> renames in a branch:
>     foo.txt => fooOld.txt
>     fooNew.txt => foo.txt
> 
> Meanwhile, master had an update to fooNew.txt.  When the user tried to
> merge master to the branch, it gave a merge conflict saying fooNew.txt
> was deleted, but master tried to update it.
> 
> I was a bit surprised that git didn't follow the rename here, though I
> do understand why: git only sees it as a rename if the source
> disappears completely.  So I played locally with a few ideas, and was
> surprised to find out that even breaking up the two renames into two
> separate commits git still didn't follow it.
> 
> I'm just curious--I don't run into this often myself--but is there a
> good strategy for dealing with this that avoids the conflict?

When merging two branches, git only looks at the tips. It doesn't inspect
their histories to see how the files were moved around. So i doesn't matter
whether you rename the files in a single commit or multiple commits. The
resulting tree is always the same.

tom
