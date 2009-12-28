From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 14:22:34 -0800 (PST)
Message-ID: <m38wcmd9is.fsf@localhost.localdomain>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos Santana <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 23:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPNzH-0006I4-UC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 23:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbZL1WWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 17:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZL1WWh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 17:22:37 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48373 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbZL1WWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 17:22:36 -0500
Received: by fxm25 with SMTP id 25so4885136fxm.21
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Rd6Un/fBCd4KQZStA5bzVPsNY/Y/cmcYr+x4nHMW9L0=;
        b=g1oFuMey+UH74miOpaQV9WkXpiBxTL6F5Tnokz9xFSNGA+C2fB6J1TKLPZLw3dOs+O
         KPtBui5k57zYdmU4cjaoqeqUrk8LRcj+C8rHrN5/1qoNDuQR5q8xkBwQLiffIwG08MGL
         BCeOGFvVAvBbXqB4hMW6c2lbVWw1vjzh8ClqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=uRl0p/AHwiYziDzOjHfRs165YrrFODlTNxIP1wN37pFVt7Ndob6S4I9C6GqjmEQ5SY
         c3aXxyP169urZUbaEmpvMLR2wYoBv9g3IlzP1ISvitNZFypieBGgEsO5BVsg8AyWChfi
         P7ojJJwM2vz01CGtC+zg14AzFcdiyWhYjno8U=
Received: by 10.223.27.79 with SMTP id h15mr15018873fac.23.1262038955181;
        Mon, 28 Dec 2009 14:22:35 -0800 (PST)
Received: from localhost.localdomain (abvx64.neoplus.adsl.tpnet.pl [83.8.221.64])
        by mx.google.com with ESMTPS id 13sm4112978fxm.9.2009.12.28.14.22.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 14:22:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBSMMETn017009;
	Mon, 28 Dec 2009 23:22:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBSMM323017005;
	Mon, 28 Dec 2009 23:22:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135768>

Carlos Santana <neubyr@gmail.com> writes:

> I would like to know if there is any difference between branches and
> tags. Is it only conceptual - convention to be followed by a developer
> or some technical difference?  e.g. : Is it possible to create
> immutable tags so that nothing can be checked in to that 'tagged
> directory'?

There is difference.  You can commit only on top of local branches, in
the refs/heads/* namespace (or on top of detached HEAD).

For branches:

  $ git checkout A   # switches current branch, HEAD points to A
  $ git commit       # creates new commit on branch A, A advances (changes)

  * by default fetch gets all branches
  * by default push transfers matching branches
  * default refspec is refs/heads/*:refs/remotes/origin/*

For tags:

  $ git checkout B   # detaches HEAD, HEAD points directly to B^{} commit
                     # you are on 'no branch'
  $ git commit       # advances HEAD, tag B does not change

  * by default fetch autofollows tags (gets tags that point to commits
    you have)
  * you need to push tags explicitely
  * default refspec is refs/tags/*:refs/tags/* (mirror 1:1)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
