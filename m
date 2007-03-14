From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 13:26:33 +0100
Message-ID: <81b0412b0703140526p454ee85fk74dcd76fb684217c@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com>
	 <Pine.LNX.4.63.0703141301210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRSZ5-0002w1-81
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 13:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbXCNM0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 08:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161212AbXCNM0g
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 08:26:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60022 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161222AbXCNM0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 08:26:35 -0400
Received: by nf-out-0910.google.com with SMTP id o25so190564nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 05:26:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=awLH0/7inFYfTT9DsShhCEEXWmVFk8hTDxcUVqpleIDug5nANZdlmO2LfGE46obdBhbbLPb17IHMw0bmmJf1eycohHEGFITsolOzkkcxxnTW2+PbW6Xyi3zCCy4hAbA6j4bTdior2cl0DE0/n3O00r3sepZKTTuT+1w5mI6v/aA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S8BQJORmiQGh9iWjQFQzsiM0mlXi0UlmewMRc4hF68xKNZ0fmsK+4xo6yO9Mh6gXhrZBJYzhz+MOFGkT/jLIGgGZ24peW1UEPxi5Xn6dhnE5RT+OOH943X4RILWbFoWd+fKYfWMjW3kVFvRccuAiM+lBfvx1eNffVm3AfyjrHVk=
Received: by 10.78.200.3 with SMTP id x3mr1141588huf.1173875193352;
        Wed, 14 Mar 2007 05:26:33 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 05:26:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703141301210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42204>

On 3/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > But we have isatty in setup_pager, so this works properly.
>
> The problem is test cases. I think that we pipe the output of the test
> case _anyway_, so the isatty() call is helping us there.
>
> If we did not (this applies to test cases _outside_ of Git, too), then a
> simple
>
>         git diff bla || exit
>
> would not work as expected. Even worse, as long as it is piped somewhere,
> even cat, it works. But once you no longer pipe it (to get the nice pager,
> for example), it stops working.

We have "PAGER=cat" in test-lib.sh which just disables pager,
so gits tests do not have the problem (maybe it was disabled just
because of this?). And if someone has own tests _with_ pager active
the one better be aware of what the one doing.
