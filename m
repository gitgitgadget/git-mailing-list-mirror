From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Wed, 18 Mar 2015 15:23:52 +0700
Message-ID: <CACsJy8Cb1ojc0tS=e4zvy6O=jMVAiVowO6Tp4OWb38_xq3J3HQ@mail.gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com> <5509319D.9070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 09:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY9HC-0004ce-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbbCRIYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 04:24:25 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33748 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbbCRIYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:24:23 -0400
Received: by iecvj10 with SMTP id vj10so32742368iec.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p0vuNscxpNlf795wm0BzPQLf/bb02EHW1FtY8Gnk9KY=;
        b=q9sJ/2dlaAiabWAq8altf0/DYrmTpy1QTyb6M9qA2RPJUf9SOrz/x1sxDb2uOJxUWH
         7571Ch/aFE1EfkMa/DsRaxUMpL0wE4u+MjQ1eQ8k2RSL8ECvJm2SB5WKWqDGrRgAPXp+
         Iyb/bXOr56/+vhnBoPW3tQl+UG7y2lIYSHvbYZRhDARI1nEnsaGV2cyk81/BaQlo2UQH
         UaJ1+7H+uwDw24eMyKRRoLbeJp66YqljPh/fh43au8uNtx4QwZplaDZRjKktGcTQlvFx
         CCxSuXABNXPaYQxbaK9j3in6dnH9kRleN36EG2poT9yNcM5X7rXKqGt8hrUEvICHMzdZ
         h8cg==
X-Received: by 10.50.56.82 with SMTP id y18mr4536106igp.25.1426667062517; Wed,
 18 Mar 2015 01:24:22 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 01:23:52 -0700 (PDT)
In-Reply-To: <5509319D.9070109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265694>

On Wed, Mar 18, 2015 at 3:04 PM, Ephrim Khong <dr.khong@gmail.com> wrote:
> Without having looked into this and nd/multiple-work-trees, but with "make
> multiple checkouts aware of each other" in mind: Could this mechanism be
> re-used to make alternates aware of each other, to mitigate the dangers of
> having  git gc  on an alternate remove objects that are used by a
> referencing repository?

If we can turn on ref namespace and make $GIT_DIR/config and hooks per
worktree, I think it may have a chance of replacing alternate object
mechanism entirely: one object database, one ref database (but refs of
each worktree is namespaced so no conflicts), multiple worktrees,
multiple config files, multiple hooks.

Because some config keys affect object database, having
multiple/conflicting config keys imply that this worktree may change
object database in a way trhat  impacts performance (not correctness)
of another worktree. Later on when we have multiple ref backends, if
config keys can change ref backend behavior (or even choose the
backend), we may run into other problems. This problem might go away
if we define that those "global" config keys can't be per-worktree..

In short, I am good at confusing people.
-- 
Duy
