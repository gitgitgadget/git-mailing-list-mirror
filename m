From: Johan Herland <johan@herland.net>
Subject: Re: git notes and git-commit
Date: Fri, 10 Dec 2010 15:13:43 +0100
Message-ID: <201012101513.43890.johan@herland.net>
References: <AANLkTi=q1F7WEgH+dLKTHOKhsNVuhU=OeyJ2AsP7oW2G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 15:13:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR3jL-0001SM-TW
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 15:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0LJONr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 09:13:47 -0500
Received: from smtp.opera.com ([213.236.208.81]:34298 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab0LJONq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 09:13:46 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBAEDidw025706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Dec 2010 14:13:44 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTi=q1F7WEgH+dLKTHOKhsNVuhU=OeyJ2AsP7oW2G@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163416>

On Friday 10 December 2010, Nguyen Thai Ngoc Duy wrote:
> Hi,
>
> I have never used git-notes before, just have had a quick look over
> git-notes.txt so this may have already been discussed.
>
> Isn't it more convenient to write/update notes when editing commit
> message? Jakub mentioned of "---" in the archive elsewhere. There's
> notes.rewriteRef for commit --amend. But if I amend a commit, I might
> as well change my notes. rewriteRef would not work with "git commit
> -c" either.

It seems your notes data is very much tied to your commit messages. If 
your notes needs editing every time you edit the commit message, I have 
to ask why you simply don't fold the notes into the commit message.

The same goes for rewriteRef vs. "git commit -c". If the notes should 
follow the commit message around, I have to ask why the notes are 
separate from the commit message in the first place.

That said, there might well be good use cases for this (e.g. using notes 
to store data types - e.g. binary data - that cannot be part of the 
commit message), so I will not advise against implementing this, but if 
you do, please also consider that there are notes use cases where the 
notes are tied to the actual contents of the commit, and not the commit 
message (e.g. notes-cache).

> Another (probably silly) thing. Can I temporarily attach notes to
> HEAD? I could add up notes while working, the notes show up when I
> edit for commit message. I could make revise the notes a bit and
> commit. Then the notes are attached to a commit.

Currently, this does not exist. However, a co-worker of mine suggested a 
feature recently that would benefit from what you describe above:

<digression>
When cherry-picking, instead of using -x to store "(cherry picked from 
commit 1234567...)" in the commit message, it would be nice to use 
(e.g.) -X to store that message in a note. Storing these annotations in 
notes instead of in the commit message allows us to clean them up (i.e. 
removing references to now-unreachable commits) at a later date, 
without rewriting history.

However, in order for this to work together 
with "cherry-pick --no-commit", we need somewhere to store the note 
until the subsequent 'git commit' (i.e. something similar 
to .git/MERGE_MSG, but for notes).
</digression>

Implementing something for notes analogous to .git/MERGE_MSG for commit 
messages would indeed be interesting. AFAICS, that also solves your 
request for editing notes for commits-in-progress.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
