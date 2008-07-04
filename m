From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: finding deleted file names
Date: Fri, 4 Jul 2008 16:15:01 +0930
Message-ID: <93c3eada0807032345r2ff59d69kca42bc9ea7782f31@mail.gmail.com>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
	 <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
	 <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
	 <20080703104233.GA26162@sigill.intra.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mikael Magnusson" <mikachu@gmail.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEf3V-0002dj-0y
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYGDGpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 02:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYGDGpH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:45:07 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:10336 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbYGDGpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:45:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so218929and.103
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8QJhboKbd34ypHIkuSUod+eLIS00TXRl0RNZ/p/Brdg=;
        b=Cd27tQY5iyMBDdGpFKKGPpRlQfbS9sogyi60aGNt2WorK9F/OIfCYCNXZ/yGL8wmZK
         WtlemjzyvnGvShEz/s1mtrIkReKt3Ag6EvYo3/GFnRjrBcsak7w9xs3rFqqP7EkohO5s
         G4V8SQm3/FqdZy18/Okd7amn4OYH+majxk2RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=eVafAWQQJT4xjZOBt6K5uPXR0FJipljSWUxJ6IFZQ+d+7s1HILb3uLAnMAJeFpexDa
         xdQx/1m3WjgbmzxDsLuXqim/xWkMYbr+O5OD1Ur9MDZQBzCiaHOkQK71F0YLve/1QJCo
         IuHprmpszL5EhBhLOwcCeSq02a9giXHkKOC+Q=
Received: by 10.100.214.3 with SMTP id m3mr166728ang.74.1215153901624;
        Thu, 03 Jul 2008 23:45:01 -0700 (PDT)
Received: by 10.100.232.5 with HTTP; Thu, 3 Jul 2008 23:45:01 -0700 (PDT)
In-Reply-To: <20080703104233.GA26162@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87369>

On 7/3/08, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 03, 2008 at 12:15:37PM +0930, Geoff Russell wrote:
>
>  > >> Is there something that says "since repository creation", ie., go back as far
>  > >> as possible, but no further? Is there a symbolic name for the initial commit?
>  > >
>  > > There's no symbolic name for it, since there might not be only one initial
>  > > commit. git.git for example has at least three root commits. You will
>  > > probably get what you want with $(git rev-list HEAD|tail -1). If your
>  > > history is very large, $(git rev-list --reverse HEAD|head -1) is slightly
>  > > faster, but usually not enough to offset typing --reverse :).
>  >
>  > Thanks for this, but I'm a little confused.
>  >
>  > If I do a "git init", there must be a first commit after this? Isn't
>  > this the first commit, how
>  > can there be more than one first commit?
>
>
> The confusing part is that you two are talking about two slightly
>  different things. If you define "initial commit" as "the commit which
>  has no parents" then there can be many (you get a new one anytime you
>  merge in a project with unrelated history).
>
>  However, what Geoff originally mentioned was HEAD{'7 days ago'}, which
>  actually looks in the reflog. So if you define "initial commit" as "the
>  first commit value that this ref ever had" then there is only one
>  (though of course, your reflog will eventually expire, so it won't be
>  "the oldest value this ref ever had" but rather "the oldest one the
>  reflog ever remembers it having").

You guys are (quite properly) worried about all the edge cases and I
have probably
confused things by using the reflog when they may be a better way of
doing things.

Perhaps if I describe the problem, there may be a better solution than using the
reflog.  I've made a bunch of changes to a repository, a few weeks
later I figure I've
deleted a file I need but am not really sure of its name. So I want to list the
files that I've deleted during the past few weeks. So the aim is to
find the files that
aren't in the current working directory but that are in some commit done since
day X.

Cheers,
Geoff


>
>  -Peff
>


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
