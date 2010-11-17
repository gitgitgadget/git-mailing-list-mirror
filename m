From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.2 4/4] gitweb: Minimal testing of gitweb caching
Date: Thu, 18 Nov 2010 00:12:22 +0100
Message-ID: <201011180012.23294.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201011130101.51116.jnareb@gmail.com> <7vk4kbefv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 00:12:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIrBA-0001Km-Po
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 00:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806Ab0KQXMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 18:12:37 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36809 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935679Ab0KQXMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 18:12:34 -0500
Received: by bwz15 with SMTP id 15so2145209bwz.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 15:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=35E9UEkFU85a9+wUUaYq2cVj+YiEnN42pWyFSyXIU24=;
        b=nKf01qUVqM6V1qHbsjgLAHRkvxMlIbJcbLnBNIziWSd+LMAbM6EFEHcDzZ3ov7kB14
         RHQ7xg9QsUjX/uRIKcm1PwOayyImjpAMrY2gzJMtZxUl3w/snOEtNL+lKIfaCo/PtA7r
         13BCeJ6ToM4nL+XdLcwJYfbbjP8EPwRZm6mtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IoJ+5xYv2YOtPwy+/XWSW63kw72GCao8ftWbyfPJzqrTm/7bydiiXC4LwEAcfhxQ90
         izIVkHwZPe0nz8LXcnZiaWLNfy9kwpFJiVWhcd6nknoTwfjE0WvrMDYTfx/hEJgOCJ6M
         R+ErNhVYvaPr44F6Jhl74EntI+fOv3tEQ4xZM=
Received: by 10.204.27.20 with SMTP id g20mr9996906bkc.114.1290035553372;
        Wed, 17 Nov 2010 15:12:33 -0800 (PST)
Received: from [192.168.1.13] (abva140.neoplus.adsl.tpnet.pl [83.8.198.140])
        by mx.google.com with ESMTPS id a25sm1653715bks.20.2010.11.17.15.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 15:12:31 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk4kbefv8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161638>

Dnia =B6roda 17. listopada 2010 23:37, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > +gitweb_enable_caching () {
> > +	test_expect_success 'enable caching' '
> > +		cat >>gitweb_config.perl <<-\EOF &&
> > +		our $caching_enabled =3D 1;
> > +		our $minCacheTime =3D 60*60*24*7*30;     # very long expiration =
time for tests (a month)
>=20
> Does your month have 210 days in it?
>=20
> > +		our $maxCacheTime =3D 60*60*24*7*30*365; # upper bound for dynam=
ic (adaptive) caching
>=20
> Likewise, is this 210 years?  Does this bust 32-bit time_t somewhere?

Ooops.

Still, fixing this doesn't fix tests.  I think I'd have to make another
extra commit, adding configure knob to turn off cacheWaitForUpdate()...


Or perhaps I did something wrong when simplifying, but I have checked
diff between full and simplified version (in comments in v7.1 series),
and it doesn't look like it...

--=20
Jakub Narebski
Poland
