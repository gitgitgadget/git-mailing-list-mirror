X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 14:38:24 +0100
Message-ID: <200612081438.25493.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 13:36:33 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sq3m5lLc0TrREplf1dEfd7H2i5Zd9vmTDBjIwuEr5NQ8Xh3lMDF/JzYR+YnrUJm3xIfyoW8+cTJEqrmIcw0CR6R+LQXV2B2sFqNrYWrZtpRNnjqgT+d8JvbJrO6QIIGqfs+vYbEtx27kxMerCcLXFilKGzMi78cMCxM2KyWqH54=
User-Agent: KMail/1.9.3
In-Reply-To: <4579611F.5010303@dawes.za.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33695>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsftl-0006iP-GE for gcvg-git@gmane.org; Fri, 08 Dec
 2006 14:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758466AbWLHNgS convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 08:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758606AbWLHNgS
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 08:36:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:46286 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758466AbWLHNgR (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 08:36:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so762943uga for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 05:36:16 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr5181613ugi.1165584976140; Fri, 08
 Dec 2006 05:36:16 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id z40sm2263826ugc.2006.12.08.05.36.15; Fri, 08 Dec
 2006 05:36:15 -0800 (PST)
To: Rogan Dawes <discard@dawes.za.net>
Sender: git-owner@vger.kernel.org

Dnia pi=B1tek 8. grudnia 2006 13:57, Rogan Dawes napisa=B3:
> H. Peter Anvin wrote:
>> Olivier Galibert wrote:
>>> On Thu, Dec 07, 2006 at 11:16:58AM -0800, H. Peter Anvin wrote:
>>>> Unfortunately, the most common queries are also extremely expensiv=
e.

With newer gitweb, which tries to do the same using less git commands,
some of queries (summary, heads, tags pages) should be less expensive.

>>> Do you have a top-ten of queries ?  That would be the ones to optim=
ize
>>> for.
>>=20
>> The front page, summary page of each project, and the RSS feed for e=
ach=20
>> project.
>=20
> How about extending gitweb to check to see if there already exists a=20
> cached version of these pages, before recreating them?
>=20
> e.g. structure the temp dir in such a way that each project has a pla=
ce=20
> for cached pages. Then, before performing expensive operations, check=
 to=20
> see if a file corresponding to the requested page already exists. If =
it=20
> does, simply return the contents of the file, otherwise go ahead and=20
> create the page dynamically, and return it to the user. Do not create=
=20
> cached pages in gitweb dynamically.

This would add the need for directory for temporary files... well,
it would be optional now...

> Then, in a post-update hook, for each of the expensive pages, invoke=20
> something like:
>=20
> # delete the cached copy of the file, to force gitweb to recreate it
> rm -f $git_temp/$project/rss
> # get gitweb to recreate the page appropriately
> # use a tmp file to prevent gitweb from getting confused
> wget -O $git_temp/$project/rss.tmp \
>    http://kernel.org/gitweb.cgi?p=3D$project;a=3Drss
> # move the tmp file into place
> mv $git_temp/$project/rss.tmp $git_temp/$project/rss

Good idea... although there are some page views which shouldn't change
at all... well, with the possible exception of changes in gitweb output=
,
and even then there are some (blob_plain and snapshot views) which
doesn't change at all.

It would be good to avoid removing them on push, and only remove
them using some tmpwatch-like removal.
=20
> This way, we get the exact output returned from the usual gitweb=20
> invocation, but we can now cache the result, and only update it when=20
> there is a new commit that would affect the page output.
>=20
> This would also not affect those who do not wish to use this mechanis=
m.=20
> If the file does not exist, gitweb.cgi will simply revert to its usua=
l=20
> behaviour.

Good idea. Perhaps I should add it to gitweb TODO file.

Hmmm... perhaps it is time for next "[RFC] gitweb wishlist and TODO lis=
t"
thread?
=20
> Possible complications are the content-type headers, etc, but you cou=
ld=20
> use the -s flag to wget, and store the server headers as well in the=20
> file, and get the necessary headers from the file as you stream it.
>=20
> i.e. read the headers looking for ones that are "interesting"=20
> (Content-Type, charset, expires) until you get a blank line, print ou=
t=20
> the interesting headers using $cgi->header(), then just dump the=20
> remainder of the file to the caller via stdout.

No need for that. $cgi->header() is to _generate_ the headers, so if
a file is saved with headers, we can just dump it to STDOUT; the possib=
le
exception is a need to rewrite 'expires' header, if it is used.

Perhaps gitweb should generate it's own ETag instead of messing with
'expires' header?
--=20
Jakub Narebski
