From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Mon, 12 May 2008 09:03:24 +0200
Message-ID: <200805120903.25040.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <1210485210.11526.145.camel@localhost.localdomain> <8c5c35580805102356p7e5532aah319af921f9b19392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 09:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvS5B-0004Xc-MZ
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 09:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbYELHDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2008 03:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbYELHDg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 03:03:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8360 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbYELHDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 03:03:35 -0400
Received: by ug-out-1314.google.com with SMTP id h2so629718ugf.16
        for <git@vger.kernel.org>; Mon, 12 May 2008 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=+g0GwOi3G5ewpbmsFIewBoM3ahJ3kj8+1KYaj/P9CwI=;
        b=qvPzpEFi0o5WZ1sjOSzfNvCpGlp0/GRna0l886RWZPfgEElbJJxdh6E3t7XrBXjtlIIjBOxFUNNlS0TH9GtPUbB5iENc+AOx+wtt/OshLw64uK89JelyOAqPXbi5dmZUls1TlAbyn2DNuMatM5TGX/ApW72j+TmuRfD3yT07f88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=x+skH1cNOkGAlaP9I5d2A7BwXdQrZtm5IwP9t+/Z0yQzFQ9T09KQfnjdbCvCYcDn9Krj/3EAVGfFQB2AsQ2SLsHlibrbSHUiz+SuFi+EmH7B+uuHjzigpZSgGwo1o8HOCtxuaTXlVj+YECG9k6M5PEfBKuy69/hde/yHnUpCZUk=
Received: by 10.66.249.8 with SMTP id w8mr5171362ugh.75.1210575811926;
        Mon, 12 May 2008 00:03:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.242.178])
        by mx.google.com with ESMTPS id e33sm9402073ugd.83.2008.05.12.00.03.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 00:03:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580805102356p7e5532aah319af921f9b19392@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81838>

[The original email by Lars didn't get to git mailing list because of
 lack of quotes around J.H. in "J.H." <warthog19@eaglescrag.net>
 email address in Cc:]

Dnia niedziela 11. maja 2008 08:56, Lars Hjemli napisa=C5=82:
> On 5/11/08, J.H. <warthog19@eaglescrag.net> wrote:
>>  On Sun, 2008-05-11 at 00:32 +0200, Jakub Narebski wrote:
>>>
>>> First, when using $projectslist file with new (second patch in seri=
es,
>>> "gitweb: Allow project description in project_index file" most of d=
ata
>>> (well, all except age) would be filled by parsing single file.
>>>
>>> Second, the idea is to cache results of filled in @$projlist e.g. u=
sing
>>> Storable, i.e. cache Perl data and not final HTML output.
>>
>> I approve of that plan, caching all the html is kinda expensive *hid=
es
>>  the 20G of gitweb cache he has*
>=20
> It seems to me that "projectlist in a single file" and "cache results
> of filled in @$projlist" are different solutions to the same problem:
> rapidly filling a perl datastructure.

Well, yes and no.  "Projectlist in single file" is about _static_ data
(which changes only if projects are added, deleted, its description
changed; those are usually rare events), and avoiding mainly I/O and
not CPU (scanning filesystem for repositories, reading config and
description, etc.).

"Cache data" is about caching _variable_ data, such as "Last changed"
information for project.  Caching data instead of caching output
(caching HTML) allows to share cache for different presentation of
the very same data (e.g. 'history'/'shortlog' vs 'rss').  And for some
pages, like project search results, caching HTML output doesn't make
much sense, while caching data has it.

> In cgit I've chosen "projectlist in a single file" and "cache html
> output". This makes it cheap (in terms of cpu and io) to both generat=
e
> and serve the cached page (and the cache works for all pages).

As I said, for some pages, like for search results, caching output
doesn't make sense, while caching data has.

> This used to be expensive in terms of cache size (similar to k.orgs
> 20G), but current cgit solves this by treating the cache as a hash
> table; cgitrc has an option to set the cache size (number of files),
> each filename is generated as `hash(url) % cachesize` and each file
> contains the full url (to detect hash collisions) followed by the
> cached content for that url (see
> http://hjemli.net/git/cgit/tree/cache.c for the details).

I guess that is the simplest solution, but I don't think that is
the best solution to have size-limited cache.  For example CPAN Perl
module Cache::SizeAwareCache and its derivatives use the following
algorithm

  The default cache size limiting algorithm works by removing cache
  objects in the following order until the desired limit is reached:

    1) objects that have expired
    2) objects that are least recently accessed
    3) objects that that expire next


BTW. if majority of your clients support transparent compression
(J.H., could you check it for kernel.org; Pasky, could you check
it for repo.or.cz?) then you can reduce cache size by storing pages
compressed.

> Btw: gitweb and cgit seems to aquire the same features these days:
> cgit recently got pagination + search on the project list.

I haven't checked what features cgit has lately...

Gitweb development seems a bit stalled; I got no response to latest
turn od gitweb TODO and wishlist list...
--=20
Jakub Narebski
Poland
