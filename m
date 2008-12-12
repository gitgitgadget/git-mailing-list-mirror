From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] gitweb: Optional grouping of projects by category
Date: Fri, 12 Dec 2008 01:13:45 +0100
Message-ID: <200812120113.47051.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <200812051145.09732.jnareb@gmail.com> <878wqmz3pl.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-1?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 01:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAvge-0007Gi-6J
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 01:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbYLLANw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2008 19:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbYLLANw
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 19:13:52 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:53778 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349AbYLLANv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 19:13:51 -0500
Received: by ewy10 with SMTP id 10so1525489ewy.13
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 16:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yD4teGJiKFSsDVnkYNKpID5RbomIiwTWLmbao0gIr90=;
        b=Pmc0kYhckeK/WhWE6aW7BSO3qnjQ4Kq9hU1qCzqNw+IvauD7WXFzINfj7siFL2uNvP
         m5mO+2nZYS2fW/3zi3E/1uk8TR+c1sXM6AA2/HfwJKtgf/2gL580tB2rNF3TGGa5EtIn
         8utiRLfEQw1i8+/A0twiZxLH04ZrJOAbcmbTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VD8NrpMBfIocfjAdgfhD9eQPdRANF+iYkl1aYGbGY677Lxp9vgttaSn2ZweESPRI/L
         NCCV6jYy8vt5PtdY3/E3OnkOMPhsSM1imG6vAAmpkue8j5c5V7cOdo/78bBiPPxGkorG
         iz3Fztgi6bDO8jziS5410OzcM9YeqH8tkCYoc=
Received: by 10.210.139.15 with SMTP id m15mr3410253ebd.118.1229040828997;
        Thu, 11 Dec 2008 16:13:48 -0800 (PST)
Received: from ?192.168.1.11? (abvq79.neoplus.adsl.tpnet.pl [83.8.214.79])
        by mx.google.com with ESMTPS id 20sm8084eyc.43.2008.12.11.16.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Dec 2008 16:13:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <878wqmz3pl.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102849>

On Fri, 12 Dec 2008, S=E9bastien Cevey wrote:
> At Fri, 5 Dec 2008 11:45:08 +0100, Jakub Narebski wrote:
>=20
>>>> Nice... but perhaps it would be better to simply pass $from / $to =
to
>>>> build_projlist_by_category function, and have in %categories only
>>>> projects which are shown...
>>>=20
>>> Ah you're right, we could do that, I hadn't thought of it.  Sounds
>>> cleaner than the $from/$to dance I did in this patch.
>>
>> [...] we can simply pass $from and $to to
>> build_projlist_by_category(), and use loop $from..$to there.
>=20
> I just tried, it works but we first need to sort @projects by
> category.

I don't understand. You have the following code:

+# returns a hash of categories, containing the list of project
+# belonging to each category
+sub build_projlist_by_category {
+=A0=A0=A0=A0=A0=A0=A0my $projlist =3D shift;
+=A0=A0=A0=A0=A0=A0=A0my %categories;
+
+=A0=A0=A0=A0=A0=A0=A0for my $pr (@$projlist) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0push @{$categories{ $pr->=
{'category'} }}, $pr;
+=A0=A0=A0=A0=A0=A0=A0}
+
+=A0=A0=A0=A0=A0=A0=A0return %categories;
+}

I propose to change it to:

+# returns a hash of categories, containing the list of project
+# belonging to each category
+sub build_projlist_by_category {
+       my ($projlist, $from, $to) =3D shift;                       # <=
<<<<<<<<<<<<<<<<<<<<<<
+	$from =3D 0 unless defined $from;                           # +++++++=
++++++++++++++++
+	$to =3D $#$projlist if (!defined $to || $#$projlist < $to); # +++++++=
++++++++++++++++
+       my %categories;
+
+       for (my $i =3D $from; $i <=3D $to; $i++) {                    #=
 <<<<<<<<<<<<<<<<<<<<<<<
+		$pr =3D $projlist->[$i];                            # ++++++++++++++=
+++++++++
+               push @{$categories{ $pr->{'category'} }}, $pr;
+       }
+
+       return %categories;
+}

And of course update callers to pass $from and $to parameters.

This code doesn't change _anything_ beside the fact that it can operate
only on part of @$projlist.


But as you have noticed some kinds of limiting shown project list size
make sense only if done _after_ dividing into categories. Some but not
all. For example page length limiting after sorting by name,=20
description, owner or age (sorting which takes place before dividing
into categories) makes sense if it is done _before_ categorization:
we want to show e.g. 100 freshest projects, and not up to 100 projects
from first categories, with last category showing maybe only freshest
projects in this category.


Besides making selection of projects to show operate on list of project=
s
instead of being done just before display is IMHO better, more flexible=
,
and more robust solution.

> I'm gonna re-send the three patches as a new version.

Thanks in advance.

--=20
Jakub Narebski
Poland
