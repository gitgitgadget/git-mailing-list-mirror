From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: fetch and pull
Date: Mon, 16 Mar 2009 20:09:31 -0400
Message-ID: <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
	 <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com>
	 <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 01:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjMue-0004eB-Q9
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 01:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbZCQAJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 20:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761511AbZCQAJe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 20:09:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:32155 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761696AbZCQAJd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 20:09:33 -0400
Received: by rv-out-0506.google.com with SMTP id g9so2300873rvb.5
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xPrFyc05ONvuM7tBulaZW021v3eStp7KwTzIajQJM3Y=;
        b=QVSicwhNLOQn0q+bHxxXDYJokivrY8yqHFiEZOUdpot72+A6Xh6nezipJDjaQc2Q3x
         D6eQNjrLK+B5SWSof2SFUprtoqndwoAUneFbY7PhbyCFSNoStVuTN7ltjbLAeNWhnp3J
         F5PEEOGxmfRpcQXckCF3PEtigc1S9jav15x64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RE2TAEQv7apmQ1y/XUH0dY09x6PTAoimTOVNcJiqIyCshKbQu5SHEVLWcu2mX5W30m
         LCR5djY0XR7XVAUp6drGhA5jhE4aH5uo26acmmzE0Lw1WgkZ1yNTeEF+yKP2ffo+l7Uc
         3KZtH/QpxbbhuF0euXwRE7mwEa0eTbahIKi2w=
Received: by 10.141.10.1 with SMTP id n1mr2571491rvi.252.1237248571211; Mon, 
	16 Mar 2009 17:09:31 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113406>

On Mon, Mar 16, 2009 at 6:33 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:

> I think the difference is because you mail in your changes to master,
> and I'm having developers cooperate in advancing that branch. The only
> thing I need a local copy of dev for is to checkout during the "work
> completed" phase, in which case the topic's result is added to the top
> of dev for all to see, either as a single amalgamated checkin or a
> non-ff merge.

Why is the topic a non-ff merge? Here's a normal non-email workflow:

$ git clone git://central/repo.git
$ cd repo
$ edit, commit, edit, commit, looks good
$ git fetch origin
$ git log -p master..origin/master # (1)
$ git merge origin/master
$ compile, test, etc
$ git push origin master # (2)

(1) inspect changes in origin/master, make sure you want to merge
(2) this fast-forwards git://central/repo.git/refs/heads/master from
    local master

Or, if you prefer topic branches:

$ git clone git://central/repo.git
$ cd repo
$ git checkout -b topic origin/master
$ edit, commit, edit, commit, looks good
$ git checkout master
$ git pull # (1)
$ git merge topic
$ compile, test, etc
$ git push origin master (2)
$ git branch -d topic

(1) this fast-forwards local master since local development is
    on topic.
(2) as above, this fast-forwards
    git://central/repo.git/refs/heads/master from local master

So this way git://central/repo.git/refs/heads/master is never reset.

But, if you do have a valid reason for resetting, then what I said in
my previous message still applies.

j.
