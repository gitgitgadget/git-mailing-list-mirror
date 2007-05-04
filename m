From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 09:57:12 -0700
Message-ID: <56b7f5510705040957v4580b6c1xbe767892ada3bcde@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
	 <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com>
	 <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com>
	 <81b0412b0705040246r5a2726b8g4323cadeacee3aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 18:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk15u-0004cD-Ja
	for gcvg-git@gmane.org; Fri, 04 May 2007 18:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031394AbXEDQ5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 12:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031392AbXEDQ5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 12:57:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:36788 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031391AbXEDQ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 12:57:13 -0400
Received: by wr-out-0506.google.com with SMTP id 71so961493wri
        for <git@vger.kernel.org>; Fri, 04 May 2007 09:57:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IkjebpIs9Cgg0nzmxWcnmhLd/NNva6dwUNiSCRIX8Eppd2oOFgilshSBNjWIc0Ghlvmr6rTqYKwaPWpvq6xabUooBU9aAZ1F0dK7HVcMLlbWuRydFl3NcwUhtvo08it1P/qbQURpGp3jwljFpgc+RCRIHksqceSpGnt07IRyins=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cKGTxhaMLNkInbdNUD+UmmTtyYdbF7IZAEiePMGZl0R7RMZ9AVTQC8i0I0NwMZZdKOotq6nIxbZ4/zaKxmddjsjC9fvj9a5aQ5WkKLvS+AHKxkSD8MhABq4cedW3eP2H55rSawB37BYy28lftfidbhxy4RdOH9iAQZEZjPKdGMM=
Received: by 10.114.151.13 with SMTP id y13mr1205872wad.1178297832386;
        Fri, 04 May 2007 09:57:12 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 09:57:12 -0700 (PDT)
In-Reply-To: <81b0412b0705040246r5a2726b8g4323cadeacee3aa7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46190>

On 5/4/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/4/07, Dana How <danahow@gmail.com> wrote:
> > > I'd suggest to define a special character for _top_ level. Real pity
> > > ":/" is taken.
> > We could use ://fullpath for top level,
>
> No good. How'd you find a commit starting with "/" than? (without
> changing ":/" syntax).
Oh blechh.  get_sha1_oneline uses prefixcmp(), not strstr().
Are there are any commits in git or the kernel starting with "/" ?

> > and :relpath for relative. Then "string" in :/string couldn't start with /,
> > which shouldn't be a problem (right?).  I've certainly seen double
> > slashes before;
> > perforce in fact uses them for the root of the repository (depot).
>
> And I really hate perforce for its stupid redundancy (and changing of
> meaning of well-known idioms: why should // be anything special
> but plain top level or root?! Why the hell do they need them at if
> you cannot use relative paths in client specs at all?! Why can't the
> p4 command-line tool figure the fact from context or request the
> context be provided by user?! IOW, Perforce is a real bad example
> of how you do version control).
Whoa!  I'm stuck using perforce too; I'm not holding it up as a *big*
example.  I originally saw // meaning root in the Apollo DOMAIN
system,  so for that reason it makes sense to me.  I think it also
means network root in Windoze (well, \\ does ;-) )..

> > This all depends on deciding that :relpath should be the (incompatible)
> > new default, and I'm not sure that's going to happen.
>
> If we are to stay that compatible, maybe ":./" for relative paths and the
> old syntax left to mean top-level would the best choice for now.

Let's summarize so far:  I think everyone's convinced me we need
to be careful,  so this email will be more tedious than I'd like.

(a) :./relpath clearly inidicates relative path. [Also take :../relpath .]
(b) I'd like a more natural way to do :./relpath (e.g. :relpath),
     or at least a future path to such.
(c) We would like to avoid new special characters beyond ":".
     This means everything has to be done with "." and "/".
(d) We are left with the following patterns:
     1. :string
     2. :/string
     3. ://string

[ We need a clear way to say relative, a clear way to say absolute,
and the current :string can change from absolute to relative some time
in the future if we so decide. ]

Ideas for (d) 2&3:
I. Make :/string actually match the RE ^[/]*string,  and ://string a full path.
   The leading [/]* is a very small change to get_sha1_oneline().
   [Or change prefixcmp() to strstr() in get_sha1_oneline().]
   How often do commit messages start with / ?
II. Make :/string a full path, and ://string match ^string .
   Is changing the current :/string to ://string less painful/dangerous?
III. Make :/string match ^string when string has no slashes,
    :/string a full path when string does have slashes,
    and ://string match ^string . Hmm,  seems confusing.
Do you use :/string now?  Since it's a case-sensitive exact match,
I don't think I'd even use it.
I find idea (II) most natural: absolute paths have one /,
and string matches have 2 suggesting an RE.

Concerning the current :string , perhaps we could do the following.
There would be 2 internal fixed mode variables (NOT config variables) which
do the following.  The first controls whether this means an absolute
or relative path.  The second controls whether a warning message
is printed whenever the first is consulted to make a decision.  The
interpretation of :string is left as-is, but motivated janitors (like me
in this case) can use the second mode variable to change all
:string patterns to :/string or ://string in scripts,   letting us
switch over later
by changing one mode variable.

Someone mentioned DWIM for :string -- check both absolute and relative,
in that order for compatibility probably.  This seems a messy
definition to me.  Comments?

Anyway,  this is more involved than I'd hoped,
but it's good to think about consequences.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
