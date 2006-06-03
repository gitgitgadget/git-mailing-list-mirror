From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 3 Jun 2006 13:16:45 +0200
Message-ID: <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 03 13:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmU7f-0002sU-Gr
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 13:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWFCLQq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 07:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWFCLQq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 07:16:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:26729 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932609AbWFCLQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 07:16:46 -0400
Received: by wr-out-0506.google.com with SMTP id 69so903964wri
        for <git@vger.kernel.org>; Sat, 03 Jun 2006 04:16:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agsk75D0xIO/RHAXq5iCv+49P+k7cdBwGsF9QwmyMzKkTDVXQvyTXPY3qaxgCrUAN0q+yu1jmERDtsKVyp3oUaRb1/ilBGSE0NfwyeP4oJfKFJkD+MUTfcB4re+lC7xXLKOHJwwPf+eJqDXlW1rI7e/BssJLQDnKM/AMNh0hnQM=
Received: by 10.64.156.10 with SMTP id d10mr2329478qbe;
        Sat, 03 Jun 2006 04:16:45 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sat, 3 Jun 2006 04:16:45 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21193>

On 6/3/06, Junio C Hamano <junkio@cox.net> wrote:
> Paul Mackerras <paulus@samba.org> writes:
>
> > I just pushed out an update to the "new" branch of the gitk.git
> > repository, which adds a feature that I have often wished for: it will
> > now show the nearest preceding and following tags when you select a
> > commit.  This is very useful if you need to identify which release was
> > the first to incorporate a particular patch, or if you need to know
> > which release a patch might have been based on.
>
> Another thing that would equally be useful is to show which
> branch a particular commit is on, so for example I can pick one
> commit while doing "gitk next" to view the next branch and see
> which topic it belongs to, and "gitk this-topic" to see which
> commits on that topic, if any, are not yet in the "next" branch.
>

If I have understood correctly the patch runs a 'git rev-list --all
--topo-order --parents'
and then does a tree walking.

I am wandering if there exist any native git way to found the previous tag.

As example given a selected revision with id <sha> is it possible to
do something like this to fond the ancestor?

1) get the tag list with git-peek-remote or something similar if tags
are not already loaded

2) given the tagList vector with n elements run

    git-rev-list  --topo-order <sha> ^tagList[0]  ^tagList[1]   ....
  ^tagList[n-1]

3) take the last sha spit out by git-rev-list, be it <lastSha>.

4) Previous nearest tag is the parent of lastSha

I've missed something?

      Marco
