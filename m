From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log and utf-u in filenames
Date: Fri, 26 Sep 2008 09:31:20 +0200
Message-ID: <200809260931.21883.jnareb@gmail.com>
References: <20080925215002.GA30810@kodama.kitenet.net> <m3fxnn3ji6.fsf@localhost.localdomain> <20080926063311.GA4939@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 09:32:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj7oc-0001px-Jb
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 09:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYIZHb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 03:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbYIZHb3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 03:31:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:55592 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbYIZHb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 03:31:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so559673fgg.17
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6mi8OXW7/5VyVH3pE0nJi/r7eReUSYr1s679izoQVkU=;
        b=ODxP6TzpG6SlpGMtt3Ga45RE4LeEBxcOikYqlYU769RFRvsb3mrwFuGrGWLj6Tx2Ah
         SPdBbhqxXEzN5in7S13+K9Ii7fFTlbdqN6u7LXMv5BbdddvwNAiJO+hOTFlcs1D9mrr9
         RVi0cdi/3kPXxs8BPmHgxZjUFUYY7FEYrJZRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qmt4Kc2Qz62pHmzIf+0ty2WOxEBb1lQjjAjv7Il0yNtD9cmkIIVDFIBJsSXFspvmt4
         oOeJtxWA5f04KCFcj4XB1Z7SWi0w7JeX5iPHblbygP6B690tiSr82NFI3mWKk4AkOUeq
         C7b4snskXVgs+8exEKW3mPA5ibbHBbv/z8ZNE=
Received: by 10.86.27.19 with SMTP id a19mr980675fga.56.1222414287602;
        Fri, 26 Sep 2008 00:31:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.233.191])
        by mx.google.com with ESMTPS id 4sm3686929fge.8.2008.09.26.00.31.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Sep 2008 00:31:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080926063311.GA4939@blimp.localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96835>

On Fri, 26 Sep 2008, Alex Riesen wrote:
> Jakub Narebski, Fri, Sep 26, 2008 01:15:58 +0200:
> > 
> > Well, in gitweb we could use '-z' option for git-diff-tree and git-ls-tree,
> > but it has its disadvantages, like having to do actual parsing record after
> > record instead of simplys splitting outout on end of line ("\n") characters.
> > 
> 
> How about simply splitting output on end of line ("\0" NUL) characters?
> The "\n" NL you refer to is just as EOR as NUL.

Doesn't work for "git diff-tree -z [...]" output. When there is rename
or copy detected, NUL is used as separator between fields (beetween
source and destination unquoted filename), not only between records:

  git diff-tree
      .... <src qfilename> TAB <dst qfilename> LF

  git diff-tree -z
      .... <src filename>  NUL <dst filename>  NUL

-- 
Jakub Narebski
Poland
