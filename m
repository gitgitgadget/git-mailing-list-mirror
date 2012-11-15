From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Wed, 14 Nov 2012 20:50:43 -0500
Message-ID: <50A44A73.8020007@gmail.com>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de> <50A2F17D.4010907@gmail.com> <20121114190228.GA3860@sigill.intra.peff.net> <50A40978.2060504@web.de> <20121115001635.GA17370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:51:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoc1-0007kA-32
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992603Ab2KOBvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 20:51:11 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60524 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992580Ab2KOBvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:51:10 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1197910vbb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vS9I8JlotQur/rNnK714GVdw3IlyC37Jq7Al7miY3MM=;
        b=akBCjqHlhd0PkI8iIeX3WUKDDj37Jov+FBw3aeLgLug7ET0h+FHJEeNz7lFoP45OxU
         5wQpafkDQzxrIAmsSacy6TmzdTquTwxUCglh5g0nbQXurlRtp+7euvy0KMUwI2cVoYBW
         idvf/+9ulpIyHSQHU7K2iKiqjFvyGY+B/c2vaWPs6JKuu/BVcAvw8yYd9QQq/u8WwK+5
         7J1K3rkV4oMzfwA76XQN5+yjj6k1vnyW2f2mJZ9OMyxKQaZMMR8GgtmntIQv0wCDTWOE
         EkPASiGVDXwqUzkgYlb+iaX+kgTgn7AqzJpTVRkzj1wcbmzGXhIF5vcRLfK9Ako/96tA
         ftzA==
Received: by 10.52.180.225 with SMTP id dr1mr4388020vdc.2.1352944269421;
        Wed, 14 Nov 2012 17:51:09 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-107-139.washdc.fios.verizon.net. [173.79.107.139])
        by mx.google.com with ESMTPS id y15sm12877458vdt.9.2012.11.14.17.50.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:50:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <20121115001635.GA17370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209789>

On 11/14/2012 07:16 PM, Jeff King wrote:
> On Wed, Nov 14, 2012 at 10:13:28PM +0100, Torsten B=C3=B6gershausen w=
rote:
> b) Autodetection:
>    (Just loud thinking), running
> $grep mingw /usr/include/w32api/winsock2.h
>   * This file is part of the mingw-w64 runtime package.
> #include <_mingw_unicode.h>
>
> on cygwin 1.7.17 indicates that we can use grep in the Makefile to
> autodetect the "mingw headers"
> Hmm. Can we rely on the /usr/include bit, though?
>
> I assume a test-compile would be sufficient, but currently we do not =
do
> anything more magic than "uname" in the Makefile itself to determine
> defaults.  Maybe it would be better to do the detection in the config=
ure
> script? And then eventually flip the default in the Makefile once
> sufficient time has passed for most people to want the new format (wh=
ich
> would not be necessary for people using autoconf, but would help peop=
le
> who do not).
>
> -Peff
>

Cygwin changed the win32api implementation, and the old is not just no=20
longer supported for the current release series, but virtually=20
impossible to even install (several new packages are now installed, the=
=20
old package is in the "obsolete" category, i.e., not available). The=20
older cygwin 1.5 dll + utilities can be installed afresh, so that is wh=
y=20
I set up to switch based upon dll version - the proposed test(s) and=20
configuration would be to have git maintain compatibility with an=20
unsupported Cygwin configuration. I just don't think this is worth the=20
maintenance burden, but of course I am not the maintainer, just=20
expressing my opinion.

I have no trouble renaming the macro to whatever seems to clarify thing=
s.

Mark
