From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 16:58:44 +0200
Message-ID: <8c5c35580805160758n3b43c282i48009867b52106bf@mail.gmail.com>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
	 <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
	 <alpine.DEB.1.00.0805161457250.30431@racer>
	 <32541b130805160712m24f24c6aw59b54a0f0ace6269@mail.gmail.com>
	 <alpine.DEB.1.00.0805161521510.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"skillzero@gmail.com" <skillzero@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 17:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx1Pu-00039z-Q2
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 17:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761169AbYEPO6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761264AbYEPO6s
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:58:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:28759 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761094AbYEPO6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:58:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so534088ywe.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ZBv+VrgUO4mbo4ftXU5xOlaMcv6+dlIeaXdEJk7I6bI=;
        b=c7zRMsryJVDn3BQPp285KLg1jWKYq965HOu5lbVr0zYpz9P3Ia/UmFJo8AoyUCtiB0TK8XBkwR6fDn6VVA4YUL58hegY9P7mpb6SiKMGoM9J0jIrXWh49cZ1KZUaHcXFCf3G5arApEF9kQYPkGFZtmKS3QQD6RsYrn/hL/SiojA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dQPCAJ7UdRVZvhzQZFCOyq1rYiRM+PIrYYyr/4hBUCNbjpWdWaiFMjbIFfNixTu1BgXZ1nKIb5nsh/db99/j8pIRFtWRomUwYUCV78nVl6A3Hd/MPZ9C9KS+xUIh7t02rdzGpIFeWbAvq93Fo7IpYCP4LwvjdACV96JbNN8+nhU=
Received: by 10.150.68.41 with SMTP id q41mr3617204yba.107.1210949924193;
        Fri, 16 May 2008 07:58:44 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Fri, 16 May 2008 07:58:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161521510.30431@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 44ebbfbb8bebe928
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82301>

On Fri, May 16, 2008 at 4:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  On Fri, 16 May 2008, Avery Pennarun wrote:
>
>
> > Think of it this way: I can commit, or not commit, my dirty Makefile at
>  > the same time as everything else (in a single project) with a single
>  > "git commit" line, depending on what I want to do.  Things like "git
>  > commit -a" and "git add -u" speed up the common case where I just want
>  > to commit everything.  But with submodules, that common case looks more
>  > like this:
>  >
>  >    cd sub
>  >    git checkout -b manual_branchname_because_there_was_no_default
>  >    git commit -a
>  >    git push etc.
>  >    cd ..
>  >    git commit -a
>  >    git push etc.
>
>  Funny, for me it looks completely different:
>
>  $ cd sub
>  # work, work, work
>  # from time to time commit
>  # from time to time rebase -i to clean up some things
>  # test, test, test
>  # sometimes push
>
>  And then, every once in a while, it is
>
>  $ cd ..
>  $ git add submodule
>  $ git commit -s submodule
>  $ git push

Just to add to the picture, for me it's

$ (cd submodule && git checkout tag)
$ git add submodule
$ git commit -s -m "Use submodule-tag"

If I want to work in/with the submodule, I usually do that by "cd
../submodule", i.e. I've got another clone of the submodule
repository.

--
lh
