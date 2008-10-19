From: Maciej Pasternacki <maciej@pasternacki.net>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Sun, 19 Oct 2008 17:24:37 +0200
Message-ID: <81E9D278-4851-4B1E-BE7D-D8563CEDA6F9@pasternacki.net>
References: <20081019000227.GA9423@charybdis.dreamhost.com> <20081019131745.GA8643@coredump.intra.peff.net> <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net> <20081019141634.GA8997@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 00:01:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KraAG-00084V-NG
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 17:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbYJSPYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbYJSPYp
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 11:24:45 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:35680 "EHLO
	jankymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751318AbYJSPYo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2008 11:24:44 -0400
X-Greylist: delayed 5847 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Oct 2008 11:24:44 EDT
Received: from [192.168.11.248] (vide-sat.pl [213.192.64.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jankymail-a2.g.dreamhost.com (Postfix) with ESMTP id 072E8B6A6A;
	Sun, 19 Oct 2008 08:24:41 -0700 (PDT)
In-Reply-To: <20081019141634.GA8997@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98604>

On 2008-10-19, at 16:16, Jeff King wrote:

> Though I am not clear from your original description if that is even
> what you want. It sounds like you might be doing:
>
>  git -C /chdir/path --git-dir=/back/to/where/I/was
>
> in which case I think work-tree _is_ a better fit.

No.  I have a regular "git clone"'d work tree inside some "shelf"  
directory containing many repos (not only from git), and I'd like to  
pull changes into this work tree.  As simple as "cvs up".  But -- I  
don't want to chdir() there myself, and I had no problem with cvs, svn  
and darcs (didn't do other VC systems yet).  So, -C would do exactly  
what I need.

>>> Also, the envchanged flag should probably be set, as for the git-dir
>>> and work-tree options.
>>
>> OK.  I thought it means literally environment change, as in setenv().
>
> It is really used to tell the options parser for aliases that some
> options which change the operating environment should not be used in  
> an
> alias. I.e., something like:
>
>  git config alias.foo "--git-dir=/path/to/whatever log"
>
> isn't allowed, because we have already done some work on setting up  
> the
> git-dir at this point. IMHO, this is a limitation of the current
> approach to setting up the environment, but fixing it would be
> nontrivial.
>
> I'm not 100% sure that doing a chdir should be disallowed in this
> instance, but I suspect it would cause problems. I think it is  
> better in
> this instance to be conservative and disallow it in aliases.

In this case, I think envchanged should not be set -- I would expect - 
C dir to work *exactly* like "cd dir && git ...", including  
configuration, environment variables and so on.  OTOH, option like "-- 
no-env" may be useful in my case -- I want git to behave consistently  
on users' machines, regardless of their configuration.  This, however,  
is only a minor issue.

Regards,
Maciej.

-- 
-><- Maciej Pasternacki -><- http://www.pasternacki.net/ -><-
