From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 10:18:27 +0100
Message-ID: <320075ff0807180218k7cfd4b07l67a1c82af0d61653@mail.gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	 <m363r3y42v.fsf@localhost.localdomain>
	 <7vwsjj8t3s.fsf@gitster.siamese.dyndns.org>
	 <200807181107.18098.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJm7r-0000cK-Mj
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbYGRJSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbYGRJSb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:18:31 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:3755 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbYGRJSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:18:30 -0400
Received: by gv-out-0910.google.com with SMTP id e6so60173gvc.37
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HU2gKMQjFGP6BsqUsuOnq77HLm4vVToMJLBoE88IDo0=;
        b=gRAEYtKE0cHiOX9mtORP+mI4cb1gUQJkHmUCJpRAEhcR1watnBaiInMC4OvEw1tk1d
         EOmyQUVNzuVw+M85TxGUX8GE8i627kNt7KDSNUi77oczld/Z9Kxco147IbLBtqQlTYsd
         BQRUk+RYcag6rk7IFRsUjnU1HCcFikgf6RwXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OJT1DEdYWqg+DB0gjtFMO7Z4llL5fX9R/9mfRUx2PhMrnZkNLam4jv6cgA5YN0ddpn
         1+j4al5tugM0BoC7JvBP1JfmKhGRdB3PCaXO5BTgTvPLDwFJtJdo9ayxtICPaiWE9SXx
         DeDhHTun3/B9RqZua3ZiYuyOmC39x8FIdRnA0=
Received: by 10.103.172.9 with SMTP id z9mr2774323muo.122.1216372708085;
        Fri, 18 Jul 2008 02:18:28 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Fri, 18 Jul 2008 02:18:27 -0700 (PDT)
In-Reply-To: <200807181107.18098.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89017>

On Fri, Jul 18, 2008 at 10:07 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
>
>> [...] It is understandable that you would
>> want to script something that recurses into the submodules that you have
>> checked out (or submodules that Fred wants you to look at), do the
>> equivalent of "git fetch ../fred" you did at the toplevel to automate that
>> step, but I very much agree with Pasky here in that it feels very wrong to
>> hijack "submodule update" for it.
>
> There were two proposals how to deal with fetching all submodules:
> (a) git-submodule recursing into submodules, IIRC even with some
> implementation (b) new "git submodule fetch" command.
>

Yes - I think there's a few more options and possible combinations

a. git submodule update having <repository> <refspec> to recurse into
submodules (a)(original patch)
b. git submodule fetch
c. git fetch --submodules
d. git fetch (automatically recurse if there are submodules)
e. git fetch (automatically recurse if there is some setting in .git/config)

I started at (a) and agree that it's a bad choice.
Any of b-e would work for me.
My (personal) preferences would be for d/e, then c, then b - but -
that's based on my belief that submodules are a pretty fundamental
thing and having a separate UI is bad.
