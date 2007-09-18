From: Andreas Ericsson <ae@op5.se>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 09:19:19 +0200
Message-ID: <46EF7BF7.3070107@op5.se>
References: <20070917112136.GA30201@glandium.org> <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXMl-0006n3-36
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbXIRHTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbXIRHTW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:19:22 -0400
Received: from mail.op5.se ([193.201.96.20]:54889 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511AbXIRHTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:19:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A904119446F;
	Tue, 18 Sep 2007 09:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akIB0gD+cJnD; Tue, 18 Sep 2007 09:19:20 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 3351719443B;
	Tue, 18 Sep 2007 09:19:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58531>

Benoit SIGOURE wrote:
> 
> My opinion is that it would be better to keep the first line and never 
> ever rewrite the commit messages.
> 

I've had reason to ponder this quite a lot, as I've imported 15 repos from
CVS and SVN where the commit authors did not follow the git-recommended way
of doing things, but rather put everything as one paragraph, usually without
linebreaks, in the commit message.

>From what I've read from those rather horrid commit-messages so far, it's
usually correct to grab the first sentence in case the empty line isn't
there, so:

const char *find_commit_subject_end(const char *commit_msg)
{
	const char *dot, *paragraph_end;
	
	paragraph_end = strstr(commit_msg, "\n\n");
	dot = strchr(commit_msg, '.');
	
	return min_non_null(dot, paragraph_end); 
}

would probably get it right very nearly always.

I'll submit a patch in 3 hours when I get my lunch, unless someone
beats me to it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
