From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Fri, 05 Oct 2012 21:55:07 +0200
Message-ID: <op.wlp1lws70aolir@keputer>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Oct 05 21:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKDzX-0003J6-M2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176Ab2JETzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 15:55:13 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60073 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2JETzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 15:55:12 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so1071932wib.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=RGBPMVGigfKrxNJKhg8neiBwnKPGusmKbe5KwNmyS8Y=;
        b=ruD8/ZK/y23YosiCWueFy3YinyNLo6zfdBQsSjKgs4iQrXYKcWVnBcVXlgfB2kutwu
         GlqNZN5kdA5NUfgn3N3WisDGNRXihKxo+rMir+6dLEt4tUAK7xrTxzhHabdbEjgZO5el
         WJhbPrchrFO82zrBPxp3hnLwddDEtZUTzPFF6RW28/PM0d243Pa9vIEA3vAtB16BWtSu
         KTmJFDT7yBMgMumXERBqek516AVA/I6AR5YNdlSnvFd+ZYY8xWoMTNmCVwZZ7sP/hqXM
         eLcJ7Q0KzmpRqk84oYyHtGADRBbmHf+v53rwyhNjI/rd55CRAfiMeg507nXScLkEAzSz
         MQlQ==
Received: by 10.217.1.206 with SMTP id n56mr5581508wes.151.1349466910626;
        Fri, 05 Oct 2012 12:55:10 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id p4sm4566320wix.0.2012.10.05.12.55.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 12:55:09 -0700 (PDT)
In-Reply-To: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207116>

On Fri, 05 Oct 2012 16:20:45 +0200, Horst H. von Brand  
<vonbrand@inf.utfsm.cl> wrote:

> What I did:
>
> - New file images/coins.asy ~~-> 'git add images/coins.asy'
> - Started adding new stuff to fg.tex
> - Noticed a old bug in fg.tex, fixed that one
> - Did 'git -pm "Some message"' and selected just the bugfix
>
> But git created a commit _including_ the new file. Tried to go back:

Exactly what's supposed to happen. "git add" tells git you want to add the  
file to the index. The index is what you're going to commit later on. So  
what you did there was

- Tell git to add images/coins.asy to the next commit
- hack hack hack
- fix old_bug
- Add old_bug chunks of code to next commit && create commit

>
> - 'git reset HEAD^'
>
> Now the new file isn't staged anymore
>
>
> What I expected to happen:
>
> - Only the explicitly selected chunks commited
> - No "losing staged changes"

As explained above, you didn't lose staged changes, you staged more  
changes and committed. Then you use git reset to go back to the state of  
HEAD^, where the file wasn't tracked and therefore not staged either.

So you're back at square one[1], commit the bug fix, then add the bugfixes  
in a commit and stage the new file for inclusion in your next commit.

Hope this helps,
Frans

[1] Arguably two, since you still have changes lying around.
