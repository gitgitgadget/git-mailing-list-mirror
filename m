From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib/difftool: use a separate config namespace for
	difftool commands
Date: Tue, 17 Mar 2009 21:35:44 -0700
Message-ID: <20090318043543.GB13653@gmail.com>
References: <1236589956-13486-1-git-send-email-davvid@gmail.com> <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com> <20090310070122.GB4523@gmail.com> <200903172054.46063.markus.heidelberg@web.de> <7veiwvpvhp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 05:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjnWE-000718-9v
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 05:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZCREfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 00:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZCREfJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 00:35:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:14148 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbZCREfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 00:35:08 -0400
Received: by yx-out-2324.google.com with SMTP id 31so357088yxl.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 21:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gKX+9LAYJVxIl+X3N1pHgQjjaOXHhJJDoq9Xl+HVxGM=;
        b=EDzTQ23q3Hs0LrYXt7iYGI9wqDjYUoYUKRn740Hil5eDtN/qdYs6vpCJrWiSpD/rah
         gr0X3sYsa/2ktnlWedsK0DR7F8jZgX2FyR+BSwSQUp++XtEjS86rkmKYF/igXA62KRp/
         yk6P7asLlPov+a8/xRw9VZPyj6voPLwTGMvc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GWnFsLM9zxTu3f8neHgp1T1Bxx60gVZi+obarTjiv6tAel8iroxU+D1ltSoP5fhBjP
         gLl5PCuDu6eT+ZKgl7PczhmDp4RPHbF9YC+hxpTFXaThil8r2fiCD2d8Gk86VkuKrfon
         fauobzMcpyUnj127XSLm92Z3rs4FUtfI/r1qI=
Received: by 10.142.163.13 with SMTP id l13mr331929wfe.2.1237350904426;
        Tue, 17 Mar 2009 21:35:04 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 30sm1621773wfg.34.2009.03.17.21.35.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Mar 2009 21:35:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7veiwvpvhp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113572>

Junio C Hamano <gitster@pobox.com> wrote:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > Jay Soffian <jaysoffian@gmail.com> wrote:
> > > 
> > > Aside, (for Junio I guess...), what's the reason this command is in
> > > contrib, and by what criteria might it graduate to being installed
> > > with the rest of the git commands?
> > > 
> > > j.
> >
> > I'd like to see it as a general git tool, too.
> > Maybe it can even share some common functionality with git-mergetool.
> 
> The code was copied and pasted very heavily, and I think (IIRC) the author
> was a bit too ashamed to have it outside contrib/ before it is properly
> refactored or something like that.  Which I happen to agree with, by the
> way.

I'll work on some patches to get the ball rolling on this.


Here's what I see as the steps I would take:

1. move difftool into the root, update Makefile, etc.

2. factor out the similarities between merge/difftool and
put them in maybe git-tool-lib.sh?

Suggestions/places to look for examples are highly appreciated.
I know we have git-sh-setup but this isn't nearly as generic.

3. adjust merge/difftool to use the common functions

I remember someone mentioning that mergetool should use
hard tabs instead of mixing tabs+spaces so a patch
to fix that up would make sense in there somewhere as well
assuming that's in line with the list's sensibilities.


-- 

	David
