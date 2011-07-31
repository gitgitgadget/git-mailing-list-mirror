From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Automatically identifying the "split" point of a merged branch.
Date: Sat, 30 Jul 2011 17:54:59 -0700
Message-ID: <CAOTq_ptov+6ixvyVvK3iuDp4L-=9PtKES14O93kL9n6hUz0JHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 02:55:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnKJ7-0004oQ-Vt
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 02:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab1GaAzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 20:55:02 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42354 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1GaAzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 20:55:00 -0400
Received: by gyh3 with SMTP id 3so3043683gyh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=bh6MIpN+Ji+PZlhqUu49+Tkwj3F1kOKCgaOYbWDkDyU=;
        b=dWxJGatUx01Mc3nQLLRRPNfvddqoKIM/hbUWcxX+lyeU7Lwg8GgTTfW3U/Dp5OfPDg
         yfg4GIypFtLSC3sg1Q7F/WtL5QnMYxfWKTo5e/LdG//5BigEWVy4AiWeFLhZ15DeQryV
         Feco4y35RBmlo7eCArY4ajv3o1894bKn8xNRQ=
Received: by 10.236.161.10 with SMTP id v10mr1614532yhk.502.1312073699390;
 Sat, 30 Jul 2011 17:54:59 -0700 (PDT)
Received: by 10.236.109.131 with HTTP; Sat, 30 Jul 2011 17:54:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178227>

Hello Gitters,

I wonder if I might pick your brains on the best way to handle a
situation I found myself in recently:

We have an integration branch, and a master branch, and a topic branch
that was based on the integration branch. Graphically:

A-o-o-o-o-o-o-o-o-o-E-(master)
 \
  o-o-B-o-o-o-o-M-o-o(integration)
       \       /
        C-o-o-D (topic)

I wanted to introduce this branch onto master to end up with:

A-o-o-o-o-o-o-o-o-o-E-----------N (master)
 \                   \         /
  \                   C'-o-o-D' (topic-rebased)
   \
    o-o-B-o-o-o-o-M-o-o(integration)
         \       /
          C-o-o-D (topic)

(ASCII art reproduced at http://dpaste.org/GUmM/ lest it be munged)

While it's easy to create comit N once I have commit D' (with git
merge --no-ff), I found that it's not at all easy to work out where
commit B is in order to do do a rebase --onto master B.

My usual approach would be to try and use git merge-base, but because
the topic branch is already merged into the integration branch, that
doesn't give useful output.

Is there a good way around this?

Conrad
