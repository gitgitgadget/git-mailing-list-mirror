From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Porcelain/Plumbing
Date: Wed, 11 Jun 2008 13:42:37 -0700 (PDT)
Message-ID: <m3zlprr9fu.fsf@localhost.localdomain>
References: <bd6139dc0806111250y53cfbdbdj9f00e38bf6e1c912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Sverre Rabbelier" <sverre@rabbelier.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 22:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XAN-0004ho-O9
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYFKUml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbYFKUmk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:42:40 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:39047 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYFKUmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:42:39 -0400
Received: by py-out-1112.google.com with SMTP id p76so1553256pyb.10
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=VSN79ir6g6eNaKjiB65Gp4g3iIAnW3ew28h0vh8RCI8=;
        b=ilUHBgaDuGpP280MhLt8mWeT2YhYz0mlIWetau1ERjYnuOWZMYOKkT5dqN33DwXo9A
         0YSDrhkreqIZQPyTR1DNx3md5sY9R01XjSHZOpV2E6nmnOJLukR6wCHuIJA1/UQMvDev
         S1Z1kfZMR/ypp3sm9I/ODAQqNW/QvZBzg1xzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=SPzm6q5F6wD7DPnUXKhi+RSDcc58Kqflj2OhFLp/N5Q1r9dssIbkDqA50TuzhRtI2n
         Gej3ylH+fHKvblGTOr4Nw0OpXOQi9NtAjC6cjGp0LlXUHTRBONywyqbIvUlAUBL464Uv
         wuP/JdONYcBvF6CA0+G1RAv13fkNHxjwWKrHw=
Received: by 10.115.91.2 with SMTP id t2mr496056wal.62.1213216958073;
        Wed, 11 Jun 2008 13:42:38 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.226.105])
        by mx.google.com with ESMTPS id i12sm833260wxd.11.2008.06.11.13.42.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 13:42:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5BKfpYg026037;
	Wed, 11 Jun 2008 22:42:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5BKfPUD026032;
	Wed, 11 Jun 2008 22:41:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <bd6139dc0806111250y53cfbdbdj9f00e38bf6e1c912@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84649>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> During my efforts gsoc efforts, I stumbled across (or actually, was
> pointed at) 'git branch --contains' to list only branches that contain
> a specific commit. The problem here is that 'git branch' is listed as
> porcelain, and that there seems to be no plumbing equivalent of this
> feature. 

I think there isn't.  If there were, its place probably would be
either in git-show-ref, or in git-for-each-ref, or in both.

> I have the same problem with 'git log -S', although 'git log'
> is pretty sturdy output wise (if you specify the output with
> '--pretty=format:' that is), the idea is the same.

log = rev-list + diff-tree.  The -S (aka. pickaxe) option is option to
git-diff-tree (and friends).  You would have to pipe output of
rev-list to diff-tree (via --stdin) to use -S in porcelain.

> My question is, is it intentional that there is no plumbing equivalent
> forsome functionality, and, in such cases, is it 'ok' to use the
> porcelain from a script? (I think it is not.) I've been recommended to
> stick with the plumbing as much as possible from my code, but with the
> above two cases I've been unsure on what to do.
> What is the advised course of action here?

I think using git-log from scripts is O.K., for example qgit uses
git-log to parse revisions, and IIRC it was recommended on git mailing
list to do that (IIRC it was around adding --encoding=<encoding> and
logOutputEncoding to git).

git-branch I think is too much a porcelain...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
