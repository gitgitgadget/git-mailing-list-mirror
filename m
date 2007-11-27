From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: QGit: Shrink used memory with custom git log format
Date: Tue, 27 Nov 2007 13:36:24 +0100
Message-ID: <e5bfff550711270436i712d531bge5072e75285c4a4b@mail.gmail.com>
References: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
	 <20071127015248.GK14735@spearce.org>
	 <Pine.LNX.4.64.0711271045430.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 13:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwzgG-0004Ml-Jg
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbXK0MgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 07:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbXK0MgZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:36:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:42836 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbXK0MgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 07:36:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so867240rvb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fknB6fWFH1JX6IeCIXw2Ga6DB9KUl1Jvpzoa4XQEPJ8=;
        b=JzYA0L7+ubjeFKc0yup9sjpEeBs+FPOXmtQU+ssIQaIWhRLCsZq7g3zIPIj4Z1W7wxSVAbXfakPslqat34N2MdWCIa7RAARTjEQSLedp+ng2R4ZOrrCwi7TcyyCvKe6uJRbst4182p1vMv6veIbS0QOzXlj3IhJRnLqB5dtja08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TfZpYHKgScQzan8lZmlwujf47WUzKrspJOLrHRheiATxUWh5fXkybCoJFSY2QzJjHBrNBcTp7RlVg2P3SPs6xsoAkU78UxuTGb6/JZ5TXmNB6flHYP8clITp3NLjJvGfwUqbBK91WMAV5vhOYdHaavnOMbdj8qA9rfSsRGqdykQ=
Received: by 10.141.75.6 with SMTP id c6mr1832522rvl.1196166984039;
        Tue, 27 Nov 2007 04:36:24 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 27 Nov 2007 04:36:24 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711271045430.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66199>

On Nov 27, 2007 11:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> > > Indeed there is a git-rev-list --stdin option but with different
> > > behaviour from git-diff-tree --stdin and not suitable for this.
> >
> > There was a proposed patch for git-cat-file that would let you run
> > it in a --stdin mode; the git-svn folks wanted this to speed up
> > fetching raw objects from the repository.  That may help as you
> > could get commit bodies (in raw format - not reencoded format!)
> > quite efficiently.
>

That would be nice.

> > Otherwise I think what you really want here is a libgit that you can
> > link into your process and that can efficiently inflate an object
> > on demand for you.

I would think libgit is overkilling for this.

You probably would not use libgit to just add a single feature but to
change completely the interface with git because the required work is
heavy both on git side and qgit side (you probably would want to run
the libgit linked part in a separated thread to avoid GUI soft locks
during slow  processing, now, because the executed git command is a
different process from qgit, the OS scheduler takes care of this 'for
free').

Marco
