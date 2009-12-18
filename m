From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: repo corruption - Egit's fault?
Date: Fri, 18 Dec 2009 10:16:13 -0800
Message-ID: <20091218181613.GA10687@spearce.org>
References: <76c5b8580912181006p2aef9d2fj95bb4c8456d965b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:16:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLhNe-000642-U0
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 19:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbZLRSQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 13:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbZLRSQ0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 13:16:26 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59502 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbZLRSQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 13:16:22 -0500
Received: by yxe17 with SMTP id 17so3144774yxe.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 10:16:21 -0800 (PST)
Received: by 10.91.163.28 with SMTP id q28mr2457165ago.95.1261160179143;
        Fri, 18 Dec 2009 10:16:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm1193397ywg.4.2009.12.18.10.16.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 10:16:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <76c5b8580912181006p2aef9d2fj95bb4c8456d965b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135424>

Eugene Sajine <euguess@gmail.com> wrote:
> When I???m looking at the bare repo in CGit ??it shows me ??Bad object:
> and object SHA-1 instead of ??the tree.
> 
> As the only difference between this project and about 30 others was
> that there was an additional branch pushed via Egit I suspect that
> this is what screwed up things, but I ???m not sure??? I???m in progress of
> testing it I don???t know if I will be able to reproduce.

Its a somewhat known problem, but thus far has only shown up in
contexts where I'm unable to get enough data to debug the problem.

  https://bugs.eclipse.org/bugs/show_bug.cgi?id=286653

> Please, advise if this can be fixed and which options I have if it
> will happen again (how to properly and quickly restore bare repo)

Delete the branch and repush it.  The bug is that EGit didn't push
all of the objects needed by the branch.  If you put the missing
objects from the source client into the server repository, it'll
be fine.

To prevent this in the future, you can force a server to check during
push by enabling receive.fsckObjects in the server repository's
configuration file.  A broken EGit client will have the push
rejected immediately.

-- 
Shawn.
