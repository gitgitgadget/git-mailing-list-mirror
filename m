From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 0/2] fixes to gitweb feature check code
Date: Sat, 29 Nov 2008 11:48:13 +0100
Message-ID: <200811291148.15182.jnareb@gmail.com>
References: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 11:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6NOn-000166-AQ
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 11:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757065AbYK2Ksa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Nov 2008 05:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757064AbYK2Ks3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 05:48:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:42490 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049AbYK2Ks1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 05:48:27 -0500
Received: by nf-out-0910.google.com with SMTP id d3so929057nfc.21
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QxIH34WqPmMa4i7h+ssdsaNsY8SL7ZESXpe2qGji2Xc=;
        b=NM5Z0rE8Aui7sP+huQLn/tMGbHJDQvFvTs0HZQ8EMbKaON+rb1jMMZFRv/wndUE1OL
         VW78uCayv5sU2mp6h9K4DtAebTPCg/QuTBc5AzykNAVHvpV/R0uaTk3e3men5/F+kHe5
         Dk98H4/Zke/1tRW9dE8kgVOCRqzK4UU2Qml3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fS5O59i2tjOGYa2Vz8DllW6ArRqIh0w/xtM6ope4HjeIWUf4/q7A75Q8Nae5+frlBR
         0CseuWc+AlsvcvJ13LNv+H2DenLmfSrJzq+oOG3UzgtGiSyVe9o7kQ0w9cEkpICj9Y5g
         9Po20Kr3h0uCpPRIDyJsLvez6pPd3qnybL4b4=
Received: by 10.210.42.13 with SMTP id p13mr10062202ebp.10.1227955704668;
        Sat, 29 Nov 2008 02:48:24 -0800 (PST)
Received: from ?192.168.1.11? (abvh10.neoplus.adsl.tpnet.pl [83.8.205.10])
        by mx.google.com with ESMTPS id 7sm4631301eyg.42.2008.11.29.02.48.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 02:48:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101903>

Dnia pi=B1tek 28. listopada 2008 21:39, Giuseppe Bilotta napisa=B3:
> This is v2 of the gitweb feature check fix patch, which has now been
> split into into a code patch and cleanup patch.
>=20
> The first patch introduces git_get_feature() to clearly distinguish t=
he
> feature retrieval from the boolean feature check (which is kept at
> git_check_feature()). The new function is used where appropriate.
>=20
> The second patch cleans up use of git_check_feature(): since the
> function now returns a boolean instead of an array, the often-used
> construct
>   my ($somevar) =3D git_check_feature('somefeat');
> although still valid, becomes a rather clumsy stylistic choice, as it
> introduces an unnecessary ambiguity. Make it clear that we're now
> dealing with scalars by using scalar assignment.

It is gitweb_get_feature() (for retrieval) and gitweb_check_feature()
(for checking), not git_get_feature() and git_check_feature().

I really like this series; making coding easier by removing need to
use special construct, and making it easier to avoid mistakes is always
a good thing.

> Giuseppe Bilotta (2):
>   gitweb: fixes to gitweb feature check code
>   gitweb: clean up git_check_feature() calls
>=20
>  gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++-------=
----------
>  1 files changed, 35 insertions(+), 17 deletions(-)

I also like the split, as it separates improvement (much easier to use
and less error prone gitweb_check_feature()) from style cleanup.

--=20
Jakub Narebski
Poland
