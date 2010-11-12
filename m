From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Fri, 12 Nov 2010 14:16:40 -0600
Message-ID: <20101112201640.GB25248@burratino>
References: <4CDB3063.5010801@web.de>
 <4CDB30D6.5040302@web.de>
 <20101111000216.GA14189@burratino>
 <4CDBA5FD.20802@web.de>
 <20101111082748.GA15525@burratino>
 <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
 <20101111190053.GH16972@burratino>
 <4CDD2AF9.6040403@web.de>
 <20101112155210.GA15141@burratino>
 <4CDD9A02.6000507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 12 21:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH03r-0000fC-Ki
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 21:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790Ab0KLURN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 15:17:13 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64948 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526Ab0KLURJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 15:17:09 -0500
Received: by qyk32 with SMTP id 32so327510qyk.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 12:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7YZtsI2mdigEZpfI7dYqlsCIv5yx3IDcl+Oc1YybP3U=;
        b=EFVgiJmTher2cAtBSUVWteSEwe3S47Ehr4bgj6lcV88uZHRCU136/OiEJUQAt7IHD7
         k457IOnqkPlC7kQ+0FSFlqDs6U7qqjmj/Wg1f3Yjg1F8WICFcOAipQJSwNmrmclqR1WD
         gO0D3b5aJv/wz25gof/3+xmJT4MOuYRa36yU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LORQjE31mDRv0prwU8HBozrhiUcmTc4XOKPZVgbMIFYfQr9ZuErjif2v38MefVbnK9
         2+qQt2wflfeTIiMBaK+M27RPF/CbXioXOg6F36hOWcY8bv7P2w5B0HYlgzY0KzXQjC9x
         G1SdYMUmanVPnGgJVNO8Ds584/uLqyHgw6aPM=
Received: by 10.229.75.3 with SMTP id w3mr2228645qcj.296.1289593028557;
        Fri, 12 Nov 2010 12:17:08 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm3341841qcb.15.2010.11.12.12.17.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 12:17:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDD9A02.6000507@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161359>

Jens Lehmann wrote:

> No, I think these concepts aren't conflated at all:
> 
> - Category A is handled by .git/config
> 
> - Category B is handled by the .gitmodules file

I meant that the two files currently support the same submodule.*
options.

> There are people putting lots of large files in submodules for better
> performance and they almost always never want to fetch (or even stat)
> them, so (1) is for them and it's cool that their upstream can configure
> that, avoiding to have every developer to repeat their "obvious" choice
> after each clone again (and that might only be needed for some submodules,
> so a repo-wide config doesn't necessarily help them).

Wouldn't (3) work for these people, too?

I think we are getting closer to an explanation.  I can look into
adding documentation for this on top when finished.

> And when you are on a superproject branch actively developing inside a
> submodule, you may want to increase fetch-activity to fetch all new
> commits in the submodule even if they aren't referenced in the
> superproject (yet), as that might be just what your fellow developers
> are about to do. And the person setting up that branch could do that
> once for all users so they don't have to repeat it in every clone.

This one seems less reasonable to me.  It seems like a way to
remotely help developers get a nice setup, rather than a declaration
about the content.

Let me take an unrelated example to illustrate what I mean.  Some
projects might want all their developers to use branch.autosetuprebase,
to avoid confusion since the update hook is going to reject mergy
history anyway.  That seems like a perfectly reasonable desire to me,
and I'd encourage them to add a script that sets everything up
following the policies of their project.

Now git could even learn to read a .gitconfig file including settings
like that one that do not have a security impact.  It would make lots
of people happy, and individuals could override settings they really
dislike in ~/.gitconfig.  Should we do it?

I think no, for reasons of intuitiveness and predictability.

On the other hand, scenarios like (1) might mean we have to support
such things despite that downside.

> And
> when switching away from that branch all those developers cannot forget
> to reconfigure to fetch-on-demand, so not having that in .git/config is
> a plus here too.

Yes, the "read .gitmodules first and then .git/config" is a very nice
enhancement --- thanks!

> You have no other choice for hooks because of security concerns. But I
> can't see any downsides in leaving upstream *the choice* to configure
> default submodule behavior. Lots of people - including me - want that for
> clone and checkout.

There is one setting that it is obvious to me for upstream should be
able to set:

	"these submodules are a necessary part of the project;
	 always (at clone time, fetch time, checkout, etc) make
	 sure they are available"

I could easily be convinced about others, but there ought to be a use
case to outweigh the "subtle behavior changing behind my back" syndrome.

And again: thanks for doing all this work.  It's inspiring.  (Next step
recursive push?)
Jonathan
