From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 12:43:04 +1300
Message-ID: <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com>
References: <E1EZKOB-0002j5-VY@jdl.com>
	 <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	 <20051108210332.GB23265@c165.ib.student.liu.se>
	 <20051109112452.GD30496@pasky.or.cz>
	 <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
	 <20051109231248.GL16061@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:46:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzaw-0006ge-44
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbVKIXnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbVKIXnG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:43:06 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:38252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751609AbVKIXnE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:43:04 -0500
Received: by zproxy.gmail.com with SMTP id j2so280610nzf
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 15:43:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p8tFlbC19zqpLhz7Wb0fv0RIIBK9UQAkjPQb5ZtpQXj7MW6xcti451CS61z5aibw+q+nCtb8nJXA7SXLQ/7w1hoA51bJtOlQem+z+LZOwr6WJFmrOcChqoAeH1VzsY4fnHdj+z+w891jRvf5HyEq7VZH4FyMtEBRn1xxUw8V6N0=
Received: by 10.64.201.20 with SMTP id y20mr101489qbf;
        Wed, 09 Nov 2005 15:43:04 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Wed, 9 Nov 2005 15:43:03 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109231248.GL16061@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11445>

On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> what mechanism are you talking about?

I suspect you haven't seen the git-merge mechanism in action -- or
perhaps I'm a bit lost and we're talking about different things. At
least last time I merged with git-merge.sh, it tried several
strategies in order in a temporary index. Actually, it tried in order:
stupid, resolve, recursive... It shortcuts if one merges cleanly, but
it'll definitely work through them. It's very nice to see this in
action.

> All the scripts have it hardcoded

Well, no. git-merge -s 'foo' works pretty well and isn't hardcoded.
Even if we agree on defaulting to only one relatively smart merger for
simplicity's sake, the mechanism we have in git-merge.sh (thanks to
Junio I think) is excellent, and should be kept. Linus will probably
do his merges with "stupid resolve" or just "stupid" and the rest of
us will use something else.

The mergers and things like git-merge-base are probably the areas of
git that need the most focus and polish -- that's why I'm
uncomfortable with cg-merge doing its own thing, as it gets a lot less
review than git-merge-XX resolvers.

Right now I am seeing some slightly abnormal things (*) in how some
our our merges are going, so I' ll have to roll up my sleeves at some
point and try and figure out what's going on. And as I look into
cg-merge and cg-Xmergefile, not many eyes have been through it...

* - (nothing serious, just an annoying tendency to show spurious
conflicts with the mergebase commit itself)

cheers,


martin
