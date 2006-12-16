X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 10:57:36 +0100
Organization: At home
Message-ID: <em0fpq$45b$1@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612150007.44331.Josef.Weidendorfer@gmx.de> <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com> <200612152242.50472.Josef.Weidendorfer@gmx.de> <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com> <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com> <e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com> <elviac$63t$1@sea.gmane.org> <e7bda7770612160040v1a769153p909a8cd40e5ea991@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 16 Dec 2006 09:55:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 67
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34602>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvWGQ-0003Z8-9B for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965391AbWLPJz1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006 04:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbWLPJz0
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:55:26 -0500
Received: from main.gmane.org ([80.91.229.2]:53583 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S965393AbWLPJzZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 04:55:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvWGC-0006fb-9B for git@vger.kernel.org; Sat, 16 Dec 2006 10:55:16 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 10:55:16 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 16 Dec 2006
 10:55:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

<opublikowany i wys=B3any>

Torgil Svensson wrote:

> On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:

>>> Now it doesn't looks like trees/blobs anymore so maybe a link objec=
t
>>> is handy:
>>>  README
>>> 100644 blob <sha1 of blob>    REPORTING-BUGS
>>> 100644 link <sha1 of link>      AUTHORS
>>> 040000 tree <sha1 of tree>    arch
>>> 040000 tree <sha1 of tree>    block
>>> 040000 link <sha1 of link>     misc

This would be (using the submodule original proposal)

    140000 link <sha1 of link>     misc

>>> link-object:
>>> <sha1 of commit>
>>> <sha1 of tree/blob>
>>
>> What do you need <sha1 of tree/blob> for in link-object? Wouldn't yo=
u
>> use usually the sha1 of top tree of a commit, which is uniquely defi=
ned
>> by commit object, so you need only <sha1 of commit>?
>>
>=20
> 1. "Sparse" repository's - In my example, I want to cherry-pick
> header-files or binary-files from different projects without fetching
> all, potentially huge, submodules in their entirety. Imaging having X=
,
> kernel, gcc, gtk and libc6 as sub-projects and you really only care
> about some header files.
>=20
> 2. Super-module directory-hierarchy independent from submodules.
> Super-project want to have the header-files and binaries it's own way=
=2E
> This also gives version controlled file-collections, the "release
> case" in my example - collecting different binaries and header-files
> from different submodules together in a new directory-structure, add
> some documentation and configuration files and get the whole thing
> under strong version-control down to the beginning of time for each
> little component.

All fine, but this does not and I think cannot protect us from the
fact that we can have <sha1 of tree/blob> which doesn't match
<sha1 of commit>.

I think it would be better to have sparse/partial checkout first.
But that is just my idea. Because with <sha1 of tree/blob> which
is not sha1 of commit tree you might loose (I think) the ability
to merge, for example your changes to submodule with upstream.

> 3. Super-module development independent of submodules - If we have th=
e
> tree/blob-object with all it contents in the database many
> git-operations can act as the link (commit) wasn't there since we hav=
e
> access to all relevant data to work with. This makes it easy to clone
> the super-project and work on it seamlessly without having to care
> about submodules or mapping up submodule repository's (unless you wan=
t
> to modify the links or the data underneath it of course).

This is I think irrelevant to the fact if we have only <sha1 of commit>=
,
or link object and also <sha1 of tree/blob>
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

