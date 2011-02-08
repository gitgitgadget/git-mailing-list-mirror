From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Tue, 8 Feb 2011 04:06:48 +0300
Message-ID: <20110208010648.GA3132@dpotapov.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102062312.51655.johan@herland.net>
 <AANLkTi=A-rh+wfg7O4KryydxVuorM8nkuGYmpbgVfVJp@mail.gmail.com>
 <201102070429.05033.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 02:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmc2n-0005tJ-0M
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 02:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab1BHBGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 20:06:55 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55637 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab1BHBGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 20:06:54 -0500
Received: by bwz15 with SMTP id 15so5524045bwz.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 17:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Hyz+soHyXfEnKK9ZZawY/4iVIqm9UjTMYQYWNj53Jdc=;
        b=dNSe5Rbb0+fHbggckhY/Rwr7eoFEiDRGTmmr73phkK6H6huoaMJvchoNKJHdvxtxWQ
         xzVaToUv8by4dGg1c3kHG+B0xmkpRURxhv0rnxGcufzeMyMQR6ZUQlkk/C/7fROAN99Q
         dT0g9DB8eg/DsnmJSoE6xNuZXGYkwZhepZnS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GK3Ar56cOi05eTwL3Le+QxcdW+TzJ2X0YpYTI1AFXOsw1wxZXpKKKdByOHLHRSVqN7
         C4Y8RMjm+PUXDDe8hTbIAbpbwcrxoEd4nR2Ah21M3ftB7Msaxknu4M9uDxjoczi8DYTu
         IuGIPHmFv6C0dGyz76dADYpUB0ZKRI2LQ8B7Q=
Received: by 10.204.72.20 with SMTP id k20mr16177371bkj.184.1297127213317;
        Mon, 07 Feb 2011 17:06:53 -0800 (PST)
Received: from localhost (ppp91-77-227-18.pppoe.mtu-net.ru [91.77.227.18])
        by mx.google.com with ESMTPS id x38sm2410085bkj.13.2011.02.07.17.06.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 17:06:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102070429.05033.johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166323>

On Mon, Feb 07, 2011 at 04:29:04AM +0100, Johan Herland wrote:
> 
> As I understand your view (I do apologize if I somehow misrepresent it), you 
> want Git to assume that the common practice of one semantic namespace is 
> followed. Furthermore, you also want to enforce that practice where 
> possible, while still improving the handling of the uncommon (but 
> theoretically inevitable) case (warning and presumably guiding the user when 
> a tag conflict occurs).

Yes, you are correct. I consider a single tag namespace as the common
case, but it should be possible to have more than one namespace for
those who needs that. I think our disagreement is due to the fact that
you believe that if someone added another remote, he or she wants
another namespace for tags, but I think it depends on whether you treat
different remotes as one project or different semi-related projects.

There is a fundamental difference between branches and tags is that
branches are often different (like each co-worker can publish each own
master that he or she tested), but tags should have same tags as long as
we work on the same project, otherwise it will lead to confusion.

> 
> > 2. It complicates things for users (as Matthieu wrote above).
> 
> I guess this depends on your POV. Fundamentally, I do NOT want to change how 
> people refer to tags. I only want to provide them the possibility of doing 
> so when ambiguity is present.

IMHO, there are two fundamentally two different use cases:
- one project with many remotes
- two (probably semi-related) projects in the same repo

In the first case, having two tags pointing to different commits is an
obvious mistake that should be fixed as soon as possible. I do not think
that different namespaces are necessary to fix that (or at least I do
not see how it helps), but my main concern was that resolution of a tag
conflict may be postponed (because they appear in different namespaces),
but that does not resolve the confusion and may only prolong it.

> 
> > 3. git fetch cannot report a tag clash if it happens
> 
> Yes it can: For each tag fetched from the remote, if resolving its shorthand 
> name ("v1.7.4") results in ambiguity (i.e. there exists a conflicting tag 
> elsewhere in this repo), then warn the user about this conflict, and explain 
> how to refer to each tag candidate using the full ref name. Also explain how 
> the user may resolve the ambiguity by creating a local tag 
> ("refs/tags/v1.7.4") pointing to the preferred target.

It it is possible then I do not have any serious objection here...

> > So, IMHO, the proper solution should be ability to specify the desired
> > namespace for any remote repository, like this:
> > 
> > remote.<name>.tagNameSpace = foo
> 
> Interesting. I'm not sure what "foo" means in this context. Would I use it 
> like this?:
> 
>     remote.origin.tagNameSpace = refs/tags

I was not sure about the specific when I wrote this, so I just put "foo",
but it could be something like you wrote above.

> 
> (to place origin's tags in refs/tags/*)
> 
> If so, what's the difference between this option, and using this?:
> 
>     remote.origin.fetch = refs/tags/*:refs/tags/*

I have not tried that, but I suspect that it will cause that all tags
will be fetched even if they are not belong to tracked branches, i.e.
"git fetch" will work as "git fetch -t". But maybe I am wrong here.


Dmitry
