From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 19 Jul 2007 11:05:19 +0200
Message-ID: <200707191105.19735.jnareb@gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com> <200707190140.05235.jnareb@gmail.com> <7vvech42nb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt McCutchen <hashproduct@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 14:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVPc-0002iq-OS
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133AbXGSMrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 08:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757995AbXGSMrR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:47:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:61741 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391AbXGSMrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:47:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so398111ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 05:47:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EnDIaf0v4sT8sOOwmGSMjUVPiCsl9GGquEI4G1RqmKoiLyxRnwd7YpS/IpqFXekPvqsOsrJY+0t7P/cWrS+Op6PaeOU3RDoPR1eTRZsMJrNAAE1jVHkGSk0HTT+Hg1AWTpjyvZ+bw3rChAuSGPIbqotPxocSz8JPn329Sqbvvqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SammmcKC3vwhiC4vw/PBtSDMwDa6Dng23+iOVnrLv0MAcSdDqB8wmJxBLZUVnx6oFLtNSocA3HtEZLg6HxPSuynM8Dgh06EQrVgUYqjKAerZJ7tGu0N64FwDR/+eja1mjuKx+ude3eri24ScKoy0z28h9K5WgzH3AvuEsmGJi54=
Received: by 10.86.51.2 with SMTP id y2mr1901934fgy.1184849235077;
        Thu, 19 Jul 2007 05:47:15 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id m1sm4372321fke.2007.07.19.05.47.10
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 05:47:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvech42nb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52987>

On Thu, 19 July 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> On Tue, 17 July 2007, Matt McCutchen napisa=C5=82:
>> ...
>>> Alert for gitweb site administrators: This patch changes the format=
 of
>>> $feature{'snapshot'}{'default'} in gitweb_config.perl from a list o=
f
>>> three pieces of information about a single format to a list of one =
or
>>> more formats you wish to offer from the set ('tgz', 'tbz2', 'zip').
>>> Update your gitweb_config.perl appropriately.  The preferred names =
for
>>> gitweb.snapshot in repository configuration have also changed from
>>> 'gzip' and 'bzip2' to 'tgz' and 'tbz2', but the old names are still
>>> recognized for compatibility.
>>
>> This alert/warning should probably be put in RelNotes for when it wo=
uld
>> be in git.git
>=20
> Does anybody else worry about the backward imcompatibility, I
> wonder...  List?
>=20
> I really hate to having to say something like that in the
> RelNotes.  I do not think this is a good enough reason to break
> existing configurations; I would not want to be defending that
> change.
[...]
> I am wondering if something like this patch (totally untested,
> mind you) to convert the old style %feature in configuration at
> the site at runtime would be sufficient.

Would it be sufficient to put above alert/warning in commit message,
RelNotes and gitweb/INSTALL (or gitweb/README), and add rule to Makefil=
e
to convert old configuration, or at least check if GITWEB_CONFIG uses
old snapshot configuration? This way if somebody is installing/upgradin=
g
gitweb by hand he/she would know what needs possibly to be changes, and
if somebody uses "make gitweb/gitweb.cgi" he would get big fat warning,
and info how to convert gitweb config.

By the way, I think it was a mistake to use different syntax in the
%feature hash ([content-encoding, suffix, program]) than in repo config
override (name).


Besides the proposed patch incurs performance penalty for all feature
checks, not only for snapshot. I think it could be solved by using
a hack of providing more aliases, so that 'gzip' (repo config) but
also 'x-gzip', 'gz' and 'gzip' (gitweb config) would be aliases to
'tgz' snapshot, and we would perform "uniq" on the list of snapshot
formats (assuming it is sorted). Or make 'x-gzip' and 'gz' aliases
into undef, so 'gzip' from old configuration would be aliased to the
new format name 'tgz'. What do you think about this?

Ooops, this has disadvantage of having to guess what could be put
in the gitweb config regarding snapshot configuration, but I think we
could assume that only the values enumerated in the old feature_snapsho=
t
would be used.


All said, I think it is a good change. I guess that gitweb admins would
want to provide both tgz/tar.gz archives for the Unix crowd, and zip
archives for MS Windows users...


P.S. I wonder why git-archive does not support tgz format. Git is linke=
d
to zlib, so...
--=20
Jakub Narebski
Poland
