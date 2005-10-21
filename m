From: eschvoca <eschvoca@gmail.com>
Subject: Re: How do I clear the directory cache
Date: Thu, 20 Oct 2005 23:23:28 -0400
Message-ID: <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
	 <20051020085931.GW30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 05:25:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESnWA-0002bd-Ct
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 05:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVJUDXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 23:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVJUDXa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 23:23:30 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:52891 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964852AbVJUDX3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 23:23:29 -0400
Received: by qproxy.gmail.com with SMTP id z1so253193qbc
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 20:23:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ju5AesyhXDOZNxW8DZeznAIA8ofOqymhlWMY1ZjtjKJhzFW/BonWjU441e6T78RFSyoyP3Wmr7Zs9WOIU6bJHzwXJMnBNos90KVJePOjtqBJnFlfJyDVTtbYCS3K6Rv+mVP3BagBjvGTdlRf+KZ5VvIotOVkGFmc901KXH8Ut7w=
Received: by 10.64.204.6 with SMTP id b6mr733447qbg;
        Thu, 20 Oct 2005 20:23:28 -0700 (PDT)
Received: by 10.65.44.2 with HTTP; Thu, 20 Oct 2005 20:23:28 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051020085931.GW30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10411>

Yes, "cg-reset --adds-removals" is what I want (how do I do this with
pure git?).

I would like to clear/reset the index because I've screwed it all up. 
I don't think I can do as you suggested because of the way I got into
this mess.

I'm using git/cogito to version control my hard drive and I've been
gradually adding more entries into the .gitignore file because some
files change too frequently or I don't want them backed up.  The OS
modified a bunch of files, I cg-rm'd 1/4 of them, then I changed my
mind and added them back, also did some genuine cg-adds, etc. and now
I'm all confused (it's a whole hard drive).  If other people are
interested in doing this I can pass on the lessons I learned.

What I found it git is amazingly fast!  cg-status only takes a few
seconds.  I think there are some problems if you try to do:

cd /
cg-add -r usr
cg-commit -m "take a long break"

It seems that cg-add-ing and cg-commit-ing smaller chunks is faster
than one big chunk.

I think commands for the following should be added to cogito:

cg-status -<status_flag>  # list files with given status flag (without
status flag in column 1)
  git-ls-files [--others|--deleted|etc] --exclude-per-directory=/.gitignore

cg-add [-r] -<status_flag> # add files with a given status flag
  git-ls-files [--others|--deleted|etc]
--exclude-per-directory=/.gitignore | while read i; do cg-add "$i;
done

cg-rm [-r] -<status_flag> # you get the idea.

cg-addremove  # recursively add new files, remove deleted files

I use "while read i" so it will work with spaces in filenames.
