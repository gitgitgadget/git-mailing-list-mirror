From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sun, 6 Sep 2009 20:28:55 +0200
Message-ID: <20090906182855.GB23412@localhost>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905072017.GA5152@coredump.intra.peff.net> <7v3a717rgl.fsf@alter.siamese.dyndns.org> <20090905080249.GA8801@coredump.intra.peff.net> <7vy6ot4x61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 20:29:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkMUD-0007dH-Gc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119AbZIFS3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758116AbZIFS3C
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 14:29:02 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56302 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114AbZIFS3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 14:29:01 -0400
Received: by fxm17 with SMTP id 17so1608224fxm.37
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=LH/UCP7FzL/Qt1FhmDLXsxNbhE997zekhphLbeaVc/4=;
        b=CAiW+MBMGhkabjRU6HCyimh7ONxlLN5+Pcj60wosRbppSOpiEeYqS1V6DlgFqmUAnp
         3Ox/ZyWTqhlrXBf6ceBcBStaAaW42v1FojL1TGUf5Nk4FaU5Lv4OQBZAH4AmvnPABXdI
         61mlnP4MO+bYgWGFfkimKTNjpo2JP19aBcpD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=JvCzah+MMn7BIu6fjf/7TY41QPeWmYIhsSBLZTkxQxq1gkINeQE3Jhsx5LfrKiU+Sh
         S/dOxtQswBbhNp1JkalbJpSCkA6v5xgIefIz3jOtPTGdGe3uK9dJa32nCXdbIrBeL12i
         eyMODuEl/amt0kUGooZ3HCWuMSFeFjcuCG+b4=
Received: by 10.204.19.142 with SMTP id a14mr11303002bkb.1.1252261742850;
        Sun, 06 Sep 2009 11:29:02 -0700 (PDT)
Received: from darc.lan (p549A55B4.dip.t-dialin.net [84.154.85.180])
        by mx.google.com with ESMTPS id 7sm3796471bwz.53.2009.09.06.11.29.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 11:29:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MkMTv-0008Bt-To; Sun, 06 Sep 2009 20:28:55 +0200
Content-Disposition: inline
In-Reply-To: <7vy6ot4x61.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127864>

On Sat, Sep 05, 2009 at 01:23:50AM -0700, Junio C Hamano wrote:

>  #1 What are the commands that will be affected, other than "add -u" and
>     "grep"?  Are there others?

There are "ls-tree", "ls-files" and "clean". I can't find anything else.

>  #2 Do all the commands in the answer to #1 currently behave exactly the
>     same when run without any path parameter and when run with a single
>     '.'?

Yes. But "ls-tree" and "ls-files" do not accept superdirectories in their
path specs.

>  #3 Do all the commands that are already relative to the root currently
>     limit their action to the cwd when run with a single '.'?

I can't think of one that doesn't.

Clemens
