From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Question about 'branch -d' safety
Date: Wed, 30 Dec 2009 22:08:37 +0100
Message-ID: <20091230210837.GA12935@vidovic>
References: <20091230065442.6117@nanako3.lavabit.com> <20091229223123.GA12965@vidovic> <20091230121238.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ5mh-00086D-Tk
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 22:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbZL3VIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 16:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZL3VIn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 16:08:43 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55244 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbZL3VIm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 16:08:42 -0500
Received: by ewy19 with SMTP id 19so4079561ewy.21
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 13:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=QQvXf6w0BNpnPwt5uqURaWmGt7Iq0tNKe8mDdpnn6EY=;
        b=eFl7iQH/YpEZxbrxAwsXMSLWeOhohpSLcqAOvYQS3qNju2iLuvDQWq3VLqIbDJ+2+Q
         Agx+DOMa4Hc/XrcbsFNENM0AbDHUtGbP+E7TSqgbTnHgANMcWag8fdoldbKktWP5pHom
         rajr5G0Ns4bvWIvhrj1PizY3ppcOPx79+7WbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DyqHhQz21TlG+aGhfKxCiqgXUYmjFJxLKQj4OFSbbsw9rNdhKDVvVC+CSjX4OlB54b
         HmJGN5r1XQbhBrJ1UV2SIydk4AhGfjkGE/XNr3nnkXVvnvuVnVsaXlhAAP9i2hJ/rQw0
         U2K7q/+CpI2oC3yenuFvMqh9cy0WsCGZQj+q8=
Received: by 10.213.107.8 with SMTP id z8mr23160776ebo.32.1262207321169;
        Wed, 30 Dec 2009 13:08:41 -0800 (PST)
Received: from @ (83-154-173-109.rev.libertysurf.net [83.154.173.109])
        by mx.google.com with ESMTPS id 23sm28839557eya.27.2009.12.30.13.08.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 13:08:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091230121238.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135924>

The 30/12/09, Nanako Shiraishi wrote:
> Quoting Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> 
> > But even with it, we would hit some foreign workflow. Think: Bob
> > directly push to Alice and Alice does the same to Bob. I don't use this
> > kind of workflow myself but I consider them to be sensible enough to
> > have our attention.
> 
> Here is what I think about your scenario.
> 
> Bob directly pushes to Alice and Alice does the same to Bob, both to their refs/remotes/<other person>/ tracking branches

We can't say. They both may have refs/remotes/<same_id> .

Bob:
  $ git branch -d a_branch

Now, Bob has the "I don't want to loose" commit known in
refs/remotes/<same_id> only.

Alice, some time later:
  $ git push -f <same_id> <foo>:<a_branch>

Bob "lose" his commit.


I admit it is a very uncommon use case and Bob can still use the reflog.

-- 
Nicolas Sebrecht
