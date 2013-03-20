From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 19:40:32 +0100
Message-ID: <20130320184032.GC32426@paksenarrion.iveqy.com>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <20130320164806.GA10752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, spearce@spearce.org,
	git@vger.kernel.org, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:39:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINva-0000Ns-G6
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab3CTSje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 14:39:34 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:60460 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3CTSjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:39:16 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so3510442lab.25
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZE/nmVLiU53CgaNDb2Lrezljn4VIvtdz7Qzg9lKstj4=;
        b=Nbkdd1adED323P6lPbg1IhHxF/4bM+Rh+lHd5pzYESh278//5kSapJE1XWfxd9WAOR
         2vSypgnhPJUZatkglG9FPVrn6iowf1kBRKew2EMgpeaMa3ORxfP8rWJ61Fx8F3y+dS4k
         hAmYg6AAVQ1hUdFaIWtgiSxIFV4nGBisb0MojnP+NE68zGCAq5gfLrpzu/wi0+HKDNeD
         MyelnnR72KVBXyfBkVUvWBRHi0fjLznIcyjjaGojzVBqP+cuuCdM1IOeOw7T7kbkCBLN
         LpyOs2V0HVpq0TS5MdxcVZ19WHeRsCC1tfGEqRo0M25UOwa5Vc8zggSziLtUZH38PnIO
         7mgQ==
X-Received: by 10.152.111.5 with SMTP id ie5mr6057074lab.31.1363804755301;
        Wed, 20 Mar 2013 11:39:15 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id fm8sm929763lbb.17.2013.03.20.11.39.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:39:14 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UINw8-0001ZC-SM; Wed, 20 Mar 2013 19:40:32 +0100
Content-Disposition: inline
In-Reply-To: <20130320164806.GA10752@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218647>

On Wed, Mar 20, 2013 at 12:48:06PM -0400, Jeff King wrote:
> Kind of gross, but I guess it is useful to some people.

Yes it is. The questions is if it's gross enough to never
leave my computer, or if someone else can find this useful.

>=20
> > +__git_recursive_stat ()
> > +{
> > +	if test ! -e /tmp/gitbash.lock
> > +	then
> > +		touch /tmp/gitbash.lock
>=20
> This is a tmp-race security hole. E.g., do:
>=20
>   ln -s /etc/nologin /tmp/gitbash.lock
>=20
> as a user; when root runs __git_recursive_stat, it will create
> /etc/nologin. It's not quite as bad as some other holes, because we o=
nly
> "touch" the file, not overwrite its contents, but you can see that it=
's
> possible to do some mischief.
>=20
> Should this maybe just be ~/.gitbash.lock or something?

Thank you! I totally missed that.

I guess a new solution would be to keep an access time-stamp in each
repository and with certain intervall run git status on that repository=
=2E

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
