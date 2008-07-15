From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Standard "git svn init ; git svn fetch" behavior
Date: Tue, 15 Jul 2008 10:37:32 -0400
Message-ID: <eaa105840807150737u11b02f50xba2c8201ce96eec0@mail.gmail.com>
References: <487C88D0.30609@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 16:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIlfx-0008Pw-39
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 16:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYGOOhq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 10:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYGOOhq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 10:37:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:53044 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYGOOhp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 10:37:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2607661ywe.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=qRObH0jIsffIdvEsrscr4aranjZkbNT4qOkMF9mNCPI=;
        b=HbJWAlg/pU4O5ZnaCtKcksLxMwsZa84HZRDpuH0tmJkML+mS0ZxzgjfxGv9DJw8A3T
         mxOYSBn11A+GojcZfc6VjICNCS/sPRBEpwNYe5r563w+l+ZNZvs5JaLmQfMSCbmA4pu1
         4fa934mMX8Zr2QUBPHFcPAvZCg7B+3yi6RHoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=kBBt7cEbWVKeFa3ELj3HqgLX721cqG6cP6yn6bqdF9BQQCjgXO87K8le/FD/USy4z8
         JL7ASpZZHW/DGEuE9Xg9QLWMdIx7XcS8YD7RETzJgtkH9xcLNz5D2jNvkF5bBfBL4Jp8
         IejXoW5LUGSfkD7S9vK2Z+wvvM4lmQDlD+P6k=
Received: by 10.125.121.18 with SMTP id y18mr3541200mkm.113.1216132657659;
        Tue, 15 Jul 2008 07:37:37 -0700 (PDT)
Received: by 10.125.159.20 with HTTP; Tue, 15 Jul 2008 07:37:32 -0700 (PDT)
In-Reply-To: <487C88D0.30609@sneakemail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b6f59f69bfc71313
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88559>

On Tue, Jul 15, 2008 at 7:24 AM, "Peter Valdemar M=F8rch (Lists)" wrote=
:
>
> 1) It seems the svn tags were converted into git branches such as
> "tags/mytag". Is that normal?

Yes.

Subversion doesn't really have tags. They're just branches with 'tag'
in the name. git-svn wants them to be branches on the git side so that
it can track future commits to the 'tag'.

> Re: 2) Why does master end up being off of tags/mytag instead of off =
of
> trunk?
>
> I would have expected, that "master" ended up tracking "trunk", and n=
ot
> tags/mytag. Why track an obscure tag instead of trunk?

Some projects work on trunk and keep a maint branch. Some projects
work on branches, and only merge bug fixes to trunk. To facilitate
this model, git-svn tries to guess which branch is your working
branch, and picks that one to be master.

In this case, you were unlucky enough to have the most recent commit
be on a tag-branch.

> Is there a smarter way to find out what branchpoint was used to creat=
e
> "master"? (I'm new to git, and find it difficult to see what my branc=
hes
> were "made from")

Git doesn't know what any particular branch was "made from", as the
branch point in question may be an ancestor of any number of other
branches.

git-svn does keep track of the subversion branch you are working on.
"git svn info"

Peter Harris
