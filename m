From: "frnchfrgg.jr" <frnchfrgg.jr@gmail.com>
Subject: Importing a subversion repository where some branches come from trunk subtrees
Date: Sat, 31 Mar 2012 11:28:42 +0200
Message-ID: <CABaB1pJNs1FL6=CbJ97pq7O=jKK=G_4t-vsx-2c4vHXsuzr40g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 11:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDuc6-0004Gu-JF
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 11:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab2CaJ2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 05:28:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45220 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab2CaJ2o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 05:28:44 -0400
Received: by eaaq12 with SMTP id q12so400898eaa.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=k2Qgjp/akB4na92Bk73jnCqBg0tsChM7H6n3EU7g2IY=;
        b=aR3axnfpkUZK3jBtay4k9aGMPV7x2QkgKi9L7+yBadM45sRyrRalKrGqbNf9UHmwwp
         BDTAcql/H3ssMsJrC2E5JtbaLuO+pYMU5PSZX/EsrREu4hWJ8aswM3e1fnWyDMc2gm4z
         tGoJ7cNgTHL6xABCX8TX81Ecy1q5V9q3hK+aT9o0HkF2lvVx7CnXgPFFiATAH31aGzEk
         psHKrllf0bPR8Es3FRAmH3SRP1w1q0hA/kD8fonApCEX2KuXjt3tf0Qd88OXwc3ZqS/S
         nGdISRGFwh02qJzHzlB3kD8uwEm+ZPFDdlsoSBen8tjJkiVAJaB5vkOGiYUIYN8Rc9I1
         hv6Q==
Received: by 10.213.19.196 with SMTP id c4mr105064ebb.96.1333186122729; Sat,
 31 Mar 2012 02:28:42 -0700 (PDT)
Received: by 10.213.30.12 with HTTP; Sat, 31 Mar 2012 02:28:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194442>

Hello,

I noticed that a svn branch made out of a subtree of trunk confuses
git-svn which fetches the whole history a second time (restricted to
that subtree). Unfortunately this kind of strange branching has been
repeatedly made in the Blender svn repository and I can end up with 5
or 6 times the full history from rev1 to rev20000, which makes the
conversion even slower, the mirror bigger and loooong to clone and
bisects completely unuseful.

Is this expected ? Or when git-svn identified the svn revision number
of the parent and there already is a git commit imported from this
revision, should it use that commit as the parent ? This would make
the branch creation commit have a big "mangling paths" diff with its
parent but I think it is logical.

That also means that when importing a revision, git-svn should always
import the state of the whole tree (up to the branch, tag, or trunk
root) and not only a part of it.

I have made a 4-revision sample svn repo which exhibits the problem,
but it is quite simple to reproduce.

Is there a good reason for this behaviour (in other cases I can't think of) ?


Julien "_FrnchFrgg_" Rivaud
