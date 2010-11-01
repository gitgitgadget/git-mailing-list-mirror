From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn clone --stdlayout causes "fatal: refs/remotes/trunk: not
 a valid SHA1"
Date: Mon, 1 Nov 2010 13:14:59 -0500
Message-ID: <20101101181459.GA9387@burratino>
References: <225342.86075.qm@web24105.mail.ird.yahoo.com>
 <20101101171141.GA8853@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Klaus <klaus3b-gu@yahoo.de>
X-From: git-owner@vger.kernel.org Mon Nov 01 19:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCyuh-0005dH-B2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 19:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0KASPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 14:15:17 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59083 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab0KASPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 14:15:15 -0400
Received: by gxk23 with SMTP id 23so3402726gxk.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SYOwwH7QxgTwi4wjlrKf8G8Ql2GZG5FrcmDoutW3bac=;
        b=oI9mr4Gr/xuY52iEjH2ugM1bgd7BEj6nfKBv70rCb9L7Nhh2N00pUhh4wMgTRNbHP1
         x1UGEHDk8k38Q0X0JD8uS5sy8VUw8Zp9OiNMHgqv2hPkSrhYYicN2ErBkFQbsSfz1xK4
         ocSm+N+kfTEA3Qv4A7xtqWEDd2DdQePyw6eP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ixdzl30x3K2gLZjOOPwOF1Zi2tafGODW/uOY4cxWW6RFLrgT5bgXwczPyJ7KV1exxm
         p2AvJsN/qUdQwuIjGPsran1MMiw4Rjx6FXadT0awC7/kKX6hbU6W29bZPWRSGwUQA2hk
         cGSpB4xdjT3yUbiqfjAoTqQOd+nfTghEmrcf8=
Received: by 10.220.186.11 with SMTP id cq11mr2494885vcb.3.1288635314434;
        Mon, 01 Nov 2010 11:15:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s12sm3191267vbp.14.2010.11.01.11.15.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 11:15:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101101171141.GA8853@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160491>

Jonathan Nieder wrote:

> Is your repository public?  If not, could you give a sketch of the project
> history, for example by running
>
>  $ git log --oneline --name-status
>
> from a successful (non-stdlayout) clone?

Since your trunk directory is called "trunc" rather than "trunk", it seems
stdlayout is not appropriate for the import.

There is also a tag named "trunc".  Not sure how that will work out. :(

Anyway, hopefully that information can help interested people to reproduce
this problem, document it, and make it fail with a better error message.

For your import, perhaps

	--trunk=<trunk dir> \
	--tags=<tags dir>

would give better results?

If this is a one-time conversion (i.e., it will not need to be updated with
later changes from svn), then you might also find some of the methods
described in

 http://thread.gmane.org/gmane.comp.version-control.git/158940/focus=159054

helpful (especially use of "git filter-branch" to extract subdirectories
from a simple whole-tree import).

Hope that helps,
Jonathan
