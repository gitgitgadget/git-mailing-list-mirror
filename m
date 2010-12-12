From: Sam Vilain <sam@vilain.net>
Subject: Re: fast-import tweaks for remote helpers (Re: Status of the svn
 remote helper project (Dec 2010, #1))
Date: Sun, 12 Dec 2010 22:53:41 +1300
Message-ID: <4D049BA5.1060509@vilain.net>
References: <20101107112129.GA30042@burratino> <20101121063149.GA15449@burratino> <20101205113717.GH4332@burratino> <4CFFCDCD.9060602@dbservice.com> <20101212061437.GA17185@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 11:04:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRinV-0008On-3i
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 11:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0LLKBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 05:01:33 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:53950 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab0LLKBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 05:01:32 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2010 05:01:32 EST
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3F96621C0B5; Sun, 12 Dec 2010 22:53:46 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.7] (unknown [60.234.254.246])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 2D5F421C0B3;
	Sun, 12 Dec 2010 22:53:41 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101212061437.GA17185@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163476>

On 12/12/10 19:14, Jonathan Nieder wrote:
> That's good to hear. What should be the syntax for asking fast-import
> not to write to a ref?  Something like this?
>
> 	commit
> 	mark :1
> 	committer c o mitter<committer@example.com>  now
> 	data<<END
> 	...
>
> Writing the sha1 as each commit is written: how early does the
> frontend need access to the sha1?  Would a facility to report marks
> back to the frontend at the end of the stream take care of it?

What happened to --report-fd ?

> (In the back of my mind, I have the idea of using a
> file that allows O(1) access, perhaps of the form
>
> 	<commit name for rev 1>  NL
> 	<commit name for rev 2>  NL
> 	...

This doesn't scale to many branches; git-svn started with that and had 
to use a b-tree in the end.  Eg, consider a repository with 10,000 
branches and 600,000 revisions.

Thanks for continuing this work, it is most interesting to follow.

Cheers,
Sam
