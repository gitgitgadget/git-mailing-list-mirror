From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Composing git repositories
Date: Tue, 2 Apr 2013 11:54:26 -0700
Message-ID: <20130402185426.GG28148@google.com>
References: <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
 <51597A37.1010301@web.de>
 <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 20:55:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6MH-0008NL-Ad
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 20:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761334Ab3DBSyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 14:54:32 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:40563 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761289Ab3DBSyb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 14:54:31 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so311281dak.39
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=z0JFJ2TWSIrwQChAKKj89tN+dOemuMpALtJUyI/LX/s=;
        b=Q/grkWGS3q8Z7H/NbjuQ9EG943Qa7TT3H1menkrNjFTiiGp/2YmhLT6HqKH6mOXwlw
         edy4awFDqOZer4+ZbQEQ1/A5VVJ5bY+TjVyO1eXAcDVTIoq/RBCWMZG2J4qvt+7WM5EY
         LoFk85xEzMwZJGZtzYuecmg7Ts5DnIiVDnnKUuk40uEUk3kBNXA8/vU1z0Lfd9L1WO3V
         Sc3obbSchbZr4S0141N+Nb1NIuI8oWvhwXGDBmtuc1T/HO4qHerxSE0w7fMwqTSEjycc
         syw83Zwn/ngBdvnMcuapfWaPmn3NczThg3mPnJHIJYp2z0e8O0AY9usEAZ7wwjI1RIVc
         mEow==
X-Received: by 10.66.253.232 with SMTP id ad8mr27146160pad.119.1364928871249;
        Tue, 02 Apr 2013 11:54:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id li15sm3445527pab.2.2013.04.02.11.54.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 11:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219827>

Ramkumar Ramachandra wrote:

>                                                 I should be able to
> add in magit.git into my dotfiles repository

For this, ideally what we'd want is a file that lists repositories
that should be cloned at the same time as cloning the dotfiles
repository, to reconstitute your dotfiles on a new machine.  From then
on, when acting on the dotfiles repository (with "git status", "git
commit", etc) git should not pay attention to the magit subdirectory
at all, because there is no coupling between the two.

Did I get that right?

That sounds similar to what Junio does with the Meta subdirectory in
his git development worktree.  I don't think submodules are a good
fit, but it might make sense to start respecting a .motd file to allow
the following in a hypothetical world where everyone who clones git
uses the same scripts Junio does:

	$ git clone git://repo.or.cz/git.git
	Cloning into 'git'...
	remote: Counting objects: 151283, done.
	remote: Compressing objects: 100% (38546/38546), done.
	remote: Total 151283 (delta 111004), reused 151073 (delta 110797)
	Receiving objects: 100% (151283/151283), 36.39 MiB | 7.66 MiB/s, done.
	Resolving deltas: 100% (111004/111004), done.

	Don't forget to "git clone -b todo git://repo.or.cz/git.git git/Meta"
	for maintenance scripts.
	$

That would allow you to include an arbitrary setup script (including
cloning dependencies as well as running "autoreconf" or whatever) and
give people cloning a quick reminder to inspect it if paranoid and
then run it.

Jonathan
