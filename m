From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 19 Jul 2007 01:40:03 +0200
Message-ID: <200707190140.05235.jnareb@gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com> <1184699486.9831.7.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJ1q-0000Tb-NS
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937004AbXGRXdc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Jul 2007 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936792AbXGRXdb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:33:31 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:15751 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936993AbXGRXd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 19:33:29 -0400
Received: by ik-out-1112.google.com with SMTP id b32so354802ika
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:33:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XcRsCmTuHwTU0c+hH8L5z2piwe1nZQl7ZMWJyLBIF3Q7FEv6EncW0bl2Kqgq8mY51dbqTkeu3cRpppSZu1dr8dWIK8NfqnbB3awoCgMbc5wcEA2lturD3NieqwogRALsJ7N+RSNufHy7Fri5lryJZ5cgwi3VSdJV+vjrjlPzF0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ngmq+iaa3K94keruLU7izLvKaamYsauMPvRRaa8/kzz8czy65sUoALeQw2+TqU5CgGbvlJITBJI9VPUR+MsnHtVigG1ZBSOMbB5piofVLFlCIoHOMHkaYV2ifsMqDJfecMW8s6Pho8YklCZDFJxYjxwZug2j5a42MymmnDxgcto=
Received: by 10.86.54.3 with SMTP id c3mr1497812fga.1184801606845;
        Wed, 18 Jul 2007 16:33:26 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p38sm3003795fke.2007.07.18.16.33.23
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Jul 2007 16:33:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1184699486.9831.7.camel@mattlaptop2>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52910>

On Tue, 17 July 2007, Matt McCutchen napisa=B3:
> - Centralize knowledge about snapshot formats (mime types, extensions=
,
>   commands) in %known_snapshot_formats and improve how some of that
>   information is specified.  In particular, zip files are no longer a
>   special case.
>=20
> - Add support for offering multiple snapshot formats to the user so
>   that he/she can download a snapshot in the format he/she prefers.
>   The site-wide or project configuration now gives a list of formats
>   to offer, and if more than one format is offered, the "_snapshot_"
>   link becomes something like "snapshot (_tar.bz2_ _zip_)".
>=20
> - If only one format is offered, a tooltip on the "_snapshot_" link
>   tells the user what it is.

Nice idea.

> - Fix out-of-date "tarball" -> "archive" in comment.
>=20
> Alert for gitweb site administrators: This patch changes the format o=
f
> $feature{'snapshot'}{'default'} in gitweb_config.perl from a list of
> three pieces of information about a single format to a list of one or
> more formats you wish to offer from the set ('tgz', 'tbz2', 'zip').
> Update your gitweb_config.perl appropriately.  The preferred names fo=
r
> gitweb.snapshot in repository configuration have also changed from
> 'gzip' and 'bzip2' to 'tgz' and 'tbz2', but the old names are still
> recognized for compatibility.

This alert/warning should probably be put in RelNotes for when it would
be in git.git

> Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
> ---
>=20
> Changes since the previous revision of the patch:
>=20
> - Added display names.
> - Changed compressor command line to list form.
> - Added compatibility format aliases for repository configuration.
> - Tweaked filtering of unknown formats to apply only to repository
>   configuration.
> - Reformatted format_snapshot_links and added/modified comments to ma=
ke it much
>   easier to understand.
> - When a single snapshot format is offered, added a tooltip showing t=
he format
>   to the "snapshot" link.  This helps Junio's hypothetical end user w=
ithout
>   using additional screen real estate.
>=20
> I thought of another incompatibility: previously bookmarked snapshot
> URLs will no longer work because they lack the new "sf" parameter.  I
> don't care about this; do any of you?

I think either having good error message, or using first format avaiabl=
e
would be good enough.

> +# information about snapshot formats that gitweb is capable of servi=
ng
> +# name =3D> [display name, mime type, filename suffix, --format for =
git-archive,
> +#          [compressor command and arguments] | undef]
> +our %known_snapshot_formats =3D (
> +	'tgz'  =3D> ['tar.gz' , 'application/x-gzip' , '.tar.gz' , 'tar', [=
'gzip' ]],
> +	'tbz2' =3D> ['tar.bz2', 'application/x-bzip2', '.tar.bz2', 'tar', [=
'bzip2']],
> +	'zip'  =3D> ['zip',     'application/x-zip'  , '.zip'    , 'zip', u=
ndef    ],
> +);

=46irst I'm not sure if we want to do the way it had to be done when
those info was in the subfield of %feature hash, or to imitate %feature
hash using instead:

+our %known_snapshot_formats =3D (
+	'tgz'  =3D> {
+		'display'  =3D> 'tar.gz',
+		'mimetype' =3D> 'application/x-gzip',
+		'suffix'   =3D> '.tar.gz',
+		'format'   =3D> 'tar',
+		'compressor' =3D> ['gzip' ]},
=2E..=20

which means that when using %known_snapshot_formats we don't have
to remember for example which of the elements in array is mimetype,
which display name, and which format to be passed to git-archive.


Second, I have thought that we might want to simply use the rest of
array for the compressor and it's arguments instead of adding it as
anonymous array reference (inner array). But this way we could in
princile add more pipelines... although I think it would be not useful.
I'd rather have first option implemented, even if it does not allow for
multiple pipelines.

Third, I think we don't need to say "undef" explicitely, I think.
"defined ('a')[1]" returns the same as "defined ('a', undef)[1]".

> +# Aliases so we understand old gitweb.snapshot values in repository
> +# configuration.
> +our %known_snapshot_format_aliases =3D (
> +	'gzip'  =3D> 'tgz' ,
> +	'bzip2' =3D> 'tbz2',
> +);

Good idea, better than tring to fit it in %known_snapshot_formats.

--=20
Jakub Narebski
Poland
