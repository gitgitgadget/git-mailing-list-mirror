From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 18:51:05 +1200
Message-ID: <444F1859.8040504@vilain.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net> <444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 08:51:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYdru-0002sC-Tx
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 08:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWDZGvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 02:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWDZGvU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 02:51:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:9345 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750980AbWDZGvT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 02:51:19 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id A78347164; Wed, 26 Apr 2006 18:51:16 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id E0A3E4FA5;
	Wed, 26 Apr 2006 18:51:09 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2mv30$k08$1@sea.gmane.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19189>

Jakub Narebski wrote:

>>It would still support that. Each commit to the sub-project involves a
>>change to the tree of the "main" commit line (a copy of the commit into
>>a sub-directory of it). The advantage is that the "tree" in the main
>>commit is the combined tree, you don't need to treat the case specially
>>to just get the contents out.
>>    
>>
>
>As far as I understand, for subproject commit "bind" link (and perhaps the
>keyword/name "link" or "ref" would be better than "related") point to other
>subprojects commits (trees), while the Sam's "prior (3)" example link would
>point to the toplevel project (gathering all subprojects) commit, and it
>would probably be named/noted "toplevel", not "prior".
>
>Am I correct?
>  
>

I don't think you quite get my meaning.

What I'm saying is that with the right kind of general purpose relation
between commits, you don't need "bind" at all.

Firstly, you would have your sub-project as its own commit line. That is
a fairly straightforward thing.

Secondly, the project that includes it has a corresponding commit for
each commit on the sub-project. This commit changes the portion of the
outer project's tree where the sub-project is bound.

This means that you don't need to understand this "bind" relation to be
able to extract the tree, and keeps the model simple at the expense of
an extra tree object or three per commit. It also does not restrict the
manner of the "binding", porcelains or users are free to do it
selectively, for instance.

Actually there is large similarity to this and cherry-picking. In
essence you're cherry picking every single commit from a different
commit heirarchy, except that you are applying the patches into a
sub-directory.

Sam.
