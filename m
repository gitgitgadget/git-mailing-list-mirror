From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Finding a branch point in git
Date: Sun, 27 May 2012 14:37:32 +0200
Message-ID: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 14:37:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYcj4-0001yM-90
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 14:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2E0Mhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 08:37:34 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60423 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750975Ab2E0Mhd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 08:37:33 -0400
Received: by lahd3 with SMTP id d3so1447153lah.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=W7q6hZ2JFxSkI8aSih229MUiyt5T/YbTcJpG/baHZmg=;
        b=W2YF504qSbq+NvQL1b4dL2tKicwxqHNkp7drgA3dGNsmHZcYBSSYrk3Tg2WP9FjUUo
         x1n6O6MoTB2bSxXY5uk1n/fk1hR74ph8RANs9X5UE+yZvxC0Bt0LN0Qh8R/o8uao4v9g
         s1rSBBNdjDa8YpB1pySt7d4c6+/L5PwgjUbWsPYBLL/i3pBNUfqSQv6sLnX5ahUiMSRD
         jEPvaz9CoBwcdXmLlUpCIgO6jRv7E3qEgZszR/wWLfqdwlV/3Ldur3X+AXC4RwgcvNIO
         v6ZkIzZ5jyIQaaMRZCtu7UPOavAyUsUEbsVjGRyivfusXgO70o1tUsF4uhQCYbVYTiUj
         45xQ==
Received: by 10.112.98.225 with SMTP id el1mr2203064lbb.30.1338122252264; Sun,
 27 May 2012 05:37:32 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sun, 27 May 2012 05:37:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198587>

Hi,

When discussing git vs. mercurial, and what can mercurial do that git
can't, I inevitably see somebody mention that mercurial branches can
be used to find the branch point (the point at which a branch started;
even if it's a long-lived one that has been merged to 'master'
multiple times).

There have been a few solutions in stackoverflow[1], but none that
work in all cases.

But I think I've found an ad-hoc one that uses the commit messages to
find the first merge of a branch, and then the merge-base.

For reference, if somebody is interested:

---
[alias]
    branch-point = !sh -c 'merge=$(git rev-list --min-parents=2
--grep="Merge.*$1" --all | tail -1) && git merge-base $merge^1
$merge^2'
---

Cheers.

[1] http://stackoverflow.com/questions/1527234/finding-a-branch-point-with-git/

-- 
Felipe Contreras
