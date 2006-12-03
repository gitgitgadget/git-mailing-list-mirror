X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn and empty directories in svn
Date: Sat, 02 Dec 2006 20:08:16 -0800
Message-ID: <45724DB0.4060607@midwinter.com>
References: <loom.20061124T143148-286@post.gmane.org> <20061128054448.GA396@soma> <20061128102958.GA5207@soma> <20061128105017.GA20366@soma> <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com> <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com> <m2bqmr1rnw.fsf@ziti.fhcrc.org> <20061128201605.GA1369@localdomain> <m2slg2rzzj.fsf_-_@ziti.fhcrc.org> <20061203014756.GE1369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 04:08:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <20061203014756.GE1369@localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33092>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqieA-0001qb-BD for gcvg-git@gmane.org; Sun, 03 Dec
 2006 05:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936654AbWLCEIG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 23:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936655AbWLCEIG
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 23:08:06 -0500
Received: from tater.midwinter.com ([216.32.86.90]:32173 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S936654AbWLCEIE (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 23:08:04 -0500
Received: (qmail 24244 invoked from network); 3 Dec 2006 04:08:03 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 3 Dec 2006 04:08:03
 -0000
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
> Since git-svn misses some other stuff (many property settings,
> externals) I'll be working on an internal logging format that can help
> track those things.  It'd be nice to have a command like git svn
> checkout which works like git checkout; but empty directories are
> created.

Presumably once the submodule support is worked out, svn externals could 
be represented as git-svn-managed submodules, yes?

In fact, I'd go so far as to say it should be a design goal of the 
submodule support: you should be able to indicate somehow that a 
submodule is a git clone of some non-git resource, and anything that 
iterates through the submodules (e.g. to freshen them from their 
respective origins) should know how to run git-svn or whatever so it's 
all seamlessly integrated. I suppose that's a special case of making 
git-svn and friends more tightly integrated with git in general; if the 
git "push" and "fetch" commands know to run git-svn instead of talking 
to a remote git repository, then it might Just Work for submodules.

Independent of the supermodule being managed by git-svn, the "my 
software depends on externally-managed code" problem that submodules are 
attempting to address would be solved a lot more comprehensively if the 
remote code base could be an svn repository and git knew enough to run 
git-svn as appropriate to keep it fresh. (Not just svn, of course; any 
foreign CM system that has an equivalent of git-svn should work.) It'd 
be pretty cool to have a supermodule that tied together some 
native-git-managed code, a couple of external svn repositories, and a 
CVS tree or two, all under a single umbrella with the details 
automatically taken care of by default.

