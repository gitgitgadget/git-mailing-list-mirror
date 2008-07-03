From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 05:18:18 +0200
Message-ID: <237967ef0807022018t31912870gf0490acf5ccef5eb@mail.gmail.com>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
	 <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
	 <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7g-0002yW-JL
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYGCG73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYGCG5o
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:16033 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbYGCDSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 23:18:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so767671rvb.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=g4r+JwHCgE87i16tGkSbTiIqisnPx2+eAwBF58NvUDo=;
        b=k7+RkPw0U6bcQ65ZS8InNCNqqjVViakHhb7gaW+I5cug1Vl12g7jQ1PilRWk56psrt
         S8ifsObguP8vFA12SZjIkv97grj+plLEvjXbX3ZttEDc1uu2j9eXlfQ/0cZFTnomdJan
         F4eW0IEBZP8NgnhWsfhMXry10xJkjbKQFP6BA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O/1n6Ft7lUYRTWlTgI4ZcmqxW2zfQ2q6aVszNwhowZLYEiOPJrfaQfSXIV2Zc5BbwL
         6XYB2dCiGu7SAiUmUI4sXmSWTGL+rgd4IJ25ViCi+jcM/C7XG0JBMsoJ877o4++FFMwD
         2xhA1zTKo+EIhcYOc1FHkZSkFhSRe9V4KXaj8=
Received: by 10.141.20.7 with SMTP id x7mr4826739rvi.61.1215055098871;
        Wed, 02 Jul 2008 20:18:18 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Wed, 2 Jul 2008 20:18:18 -0700 (PDT)
In-Reply-To: <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87248>

2008/7/3 Geoff Russell <geoffrey.russell@gmail.com>:
> On Thu, Jul 3, 2008 at 10:42 AM, Mikael Magnusson <mikachu@gmail.com> wrote:
>> 2008/7/3 Geoff Russell <geoffrey.russell@gmail.com>:
>>> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
>>>
>>> finds files deleted during the last 7 days, but if my repository is
>>> only 6 days old I get a
>>> fatal error.
>>>
>>> fatal: bad object HEAD@{7 days ago}
>>>
>>> Is there something that says "since repository creation", ie., go back as far
>>> as possible, but no further? Is there a symbolic name for the initial commit?
>>
>> There's no symbolic name for it, since there might not be only one initial
>> commit. git.git for example has at least three root commits. You will
>> probably get what you want with $(git rev-list HEAD|tail -1). If your
>> history is very large, $(git rev-list --reverse HEAD|head -1) is slightly
>> faster, but usually not enough to offset typing --reverse :).
>
> Thanks for this, but I'm a little confused.
>
> If I do a "git init", there must be a first commit after this? Isn't
> this the first commit, how
> can there be more than one first commit?

In git.git, the gitk subdirectory has a separate root because it was merged
with the subtree merge strategy, so if you go down the second parent of that
merge commit, you'll end up not at the start of the git history. You can
see this if you just fetch any other repo into your current one and merge it.
Just add everything with conflict markers in if it conflicts and commit,
then look at gitk :). (and obviously then revert the merge or whatever).

Btw, after you git init, there are 0 commits, the first commit is created
when you run git commit the first time.

-- 
Mikael Magnusson
