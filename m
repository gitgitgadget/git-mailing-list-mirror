Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C821FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbdFOKho (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 06:37:44 -0400
Received: from mail.centricular.com ([50.116.37.142]:39432 "EHLO
        mail.centricular.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdFOKho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 06:37:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.centricular.com (Postfix) with ESMTP id 0E83E58BE2;
        Thu, 15 Jun 2017 20:37:43 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at centricular.com
Received: from mail.centricular.com ([127.0.0.1])
        by localhost (worm-farm.widgetgrove.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 61x7R2eICeJb; Thu, 15 Jun 2017 20:37:42 +1000 (AEST)
Received: from lotus (unknown [188.117.216.123])
        by mail.centricular.com (Postfix) with ESMTPSA id AEE5958BA5;
        Thu, 15 Jun 2017 20:37:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=centricular.com;
        s=201701; t=1497523062;
        bh=LL4X5qH5SCUcPdgjf0tBtCPpoZ6i6cqrlT30Dm2oUaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IL+68aeIXSkMBTQVwxPtq2hXttmZ0UNWFgSqxx5bJkvxdV9J1+9BboSKDR+rATK8G
         qjB6IcDylaVJTTTlPCM8VJ1oBb2eq7S1DjvJ/38TaFIZ9A9khFOwXXqoKbdxLR3ims
         phL3AHo/wOFLQve8ZM3c133P2HRe8mSCY2Jy6uhH6bLafmWCNVsiINpwTVfW/0wYeQ
         fjj8geBkOy2CWE3suUZre9W8b5Myr0LH3TwLAQMrK4vtyNIiZEmRfyzZpM5hT3bOmM
         Ay0aU8BRucJ0a/eKwJxzrKxu+uk9sUynKOA0wmQ+tAr94gLs+zfEEcX6OLObcdhb9d
         Dt6NHcZB9joJw==
Message-ID: <1497523056.2239.107.camel@centricular.com>
Subject: Re: [BUG] git cherry-pick segfaults with local changes in working
 directory
From:   Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian@centricular.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Thu, 15 Jun 2017 13:37:36 +0300
In-Reply-To: <20170615103215.45sp5adzu6zcorct@sigill.intra.peff.net>
References: <1497517910.2239.105.camel@centricular.com>
         <20170615103215.45sp5adzu6zcorct@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-/UHRhOkN6IyPLsu4iDqS"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-/UHRhOkN6IyPLsu4iDqS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Thanks for the fast reply!

On Thu, 2017-06-15 at 06:32 -0400, Jeff King wrote:
> On Thu, Jun 15, 2017 at 12:11:50PM +0300, Sebastian Dr=C3=B6ge wrote:
>=20
> > This is with git 2.11.0 (Debian 2.11.0-4) and can be reproduced with
> > the packed checkout here:
> > =C2=A0 https://people.freedesktop.org/~slomo/git-cherry-pick-segfault_g=
st-plugins-good.tar.xz
> >=20
> > $ tar xf git-cherry-pick-segfault_gst-plugins-good.tar.xz
> > $ cd gst-plugins-good
> > $ git cherry-pick 0421fb04470af90e8810e7e5e69955d3192896ba
> > Segmentation fault (core dumped)
>=20
> Note that the tarball doesn't have all the necessary objects. Its
> .git/objects/info/alternates points to another full clone of
> git://anongit.freedesktop.org/gstreamer/gst-plugins-good.

Ah good to know, I thought this only happens if you clone with
--reference and not otherwise.

> The segfault was fixed in 55e9f0e5c (merge-recursive: handle NULL in
> add_cacheinfo() correctly, 2016-11-26), which is in v2.11.1.

I can confirm that this also fixes my specific problem. Thanks!

--=20
Sebastian Dr=C3=B6ge, Centricular Ltd =C2=B7 http://www.centricular.com
--=-/UHRhOkN6IyPLsu4iDqS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEf0vHzDygb5cza7/rBmjMFIbC17UFAllCY3BfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDdG
NEJDN0NDM0NBMDZGOTczMzZCQkZFQjA2NjhDQzE0ODZDMkQ3QjUACgkQBmjMFIbC
17V9bRAAmAeRzo3XeZ9XAw5Qo+AFTzC25svxr/nnLjc9xyS8KK9r25X8jWyXft3D
AbG6DzJhddHZSekLcviwRKcEGmhx392IJ5NJkvJS3sB/HYz/r+1anjNf305NNaF5
DQ5aAV50zclqwSLhTcLxEoqIe/UzLcfeKeOIr2FSS5ieY2CrhehPTRb6Xla81h9t
O36p+lQdpt+yPkxVRXpmvTXIp9Q43THTiynLriv3UwGseb1TvQaQi+qqpuKboaHm
waftiIORVqGZv3nosk5FzXvBqTny9/Fi0P0Dec6f25Z05FHvOitlxy9YUWUVLbP7
WrXmsvkKBvhT7khI1j33Vzqcx6ZSC/9zwewGFOLrvO5w34aVncYitvu9wPh1eLbw
KaEScRKT5K82oB9sg29ErfISBHizVYN6Rykwh4+56SmLjBPi6HhEbE7ZG0+HD1/N
wuQ1ZTATwqdEgLECMY/ztVFKRO9fjjnuPqsk6KNzcDAXAwTDzR/Ach7tq6GPFGrk
0eBA9rduTC79OMQMAtPOZf33HjNfX4HNVkbcJ+lbKF9RCcR5z1VF2fVdssfQiyVV
Zk29UUXxuyNZFZWSdTDTcUIUEi2VxsqNKyuzW5n25MZNp1YTQAPKz2jFCWm174gf
1xhvpI9SGwiRsYlUV8PrROD+h3sDRGPLtkaDTFN9J3VK4DfGrSI=
=Q3Hi
-----END PGP SIGNATURE-----

--=-/UHRhOkN6IyPLsu4iDqS--

