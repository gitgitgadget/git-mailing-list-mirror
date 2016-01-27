From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 12/19] mingw: skip test in t1508 that fails due to
 path conversion
Date: Wed, 27 Jan 2016 09:50:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601270943390.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de> <5aea04c3f348e3891a01b6908bf6562a26f9dd1e.1453818790.git.johannes.schindelin@gmx.de> <xmqqk2mwatjd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:51:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOLo0-0004JT-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 09:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbcA0IuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 03:50:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:60636 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbcA0IuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 03:50:14 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MfW5D-1aj4WJ45xT-00P6E9; Wed, 27 Jan 2016 09:50:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqk2mwatjd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:R4Y9k+KSEqzyhO1ip/abxUW/YqFKG6wViSwLydBUCevBDrCrKIp
 ZR8oaOWibxwWJlUWoGDJBuTBjBDA14neVooGafz5d2PctvUGXOTWOqQhLmbCKSLxGfxndAz
 1HW9JgV4Yhy7Sq6Arjk6OdbbI1pj0/4dgspsMYsi3mr7ig0J3nSYKdm4Cjvv5P5ZJEkAP4K
 pe/oi+73+32Z/6aTHk9wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lVKHXb22vms=:aWzJbV33l2+Ok+GDB7Chkz
 LFIRJDtuxsioEsRqMyXncwL42s78lrDHbB6C0h5kdQq3OATc0hsJzsHTE2SfivPtr/cSndIeE
 tgeKFEZdSSdROtT59OoAbTU37PrL9egun74U5b9kEgjjdOnRycxlOdBSU39f7TCtp3J5GRais
 766XFKaicp4I9IGKNLU+MNXtiGarERK+M6whO2Br8QLvpc+a9TAewgjAK7GSD9VllQ/1CXL8A
 Gt88/Ngpc2cx9a3hlVEVgEQPRmnfEmncJeRqluTiHlH5TBB0G60/yGhocZ3AOSyN8VOiGAAgo
 OH8K8r6P9xJOIQV9LoCKWy8IjqxtlsJIuXBLu6XZkx+aH75MhsWszz2EyoZf3Opy6VnehaCIa
 O0O8Mm6ogjgvYupU8mOG6L7XG7SE+q9aCaHA8QB4wZHQxLwgDuEw3+EAMmmDGbE4s3nH2nMDU
 rU5UyEfVBOPH9nGrkigJo+7y9jwHOpEnee9F2LO2wxw19PEnSqylXiUzsmyejA98aFTFgpQPn
 77n8rO78Eh9VV3O2EauzIxQPoArhJlAoJmGvUcd/XvgOkdtkt4lS3Ylj9LCQPP7164Cljg2Ez
 j+pX5LWGMAahHnF3RzIO694w7qGFqcAnaQl8CVqz/gnKolKb5PZ7D/SAdgcXYeFGzh4LzV4Kg
 ixdWcyOt4IlaJeGaeYPXoIstsZrPqneg7IQ5GG02kcIY1LAL+WUEdUx7cszR7MzpoRS7idc46
 CB4+x57iuWeAEcHBfuOAUeTgutVMx9D4AVvlMDP1sIcQSCXtcqSfeXI8sJhnYl2nBAgyjbCQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284897>

Hi Junio,

On Tue, 26 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -35,7 +35,10 @@ test_expect_success 'setup' '
> >  	git checkout -b upstream-branch &&
> >  	test_commit upstream-one &&
> >  	test_commit upstream-two &&
> > -	git checkout -b @/at-test &&
> > +	if ! test_have_prereq MINGW
> > +	then
> > +		git checkout -b @/at-slash
> 
> I presume that this is meant to be "@/at-test", not "@/at-slash".

Oh my. That's what you get for redoing patches from scratch. Sorry about
that!

Ciao,
Dscho
