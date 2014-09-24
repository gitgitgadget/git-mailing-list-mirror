From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] add macro REALLOC_ARRAY
Date: Wed, 24 Sep 2014 09:32:09 +0200
Message-ID: <54227379.5010708@alum.mit.edu>
References: <5415C89C.4090509@web.de> <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com> <541886D5.8060202@web.de> <541887F0.1050007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 09:32:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWh3p-0007W1-8x
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 09:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaIXHcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2014 03:32:15 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45427 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772AbaIXHcN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Sep 2014 03:32:13 -0400
X-AuditID: 12074412-f792e6d000005517-34-5422737cad24
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F9.E4.21783.C7372245; Wed, 24 Sep 2014 03:32:12 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1F5D.dip0.t-ipconnect.de [93.219.31.93])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8O7WApo008100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 24 Sep 2014 03:32:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <541887F0.1050007@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqFtTrBRicOOFhEXXlW4mi4beK8wW
	Z7b2Mzswe1y8pOzxeZOcx+1n21gCmKO4bZISS8qCM9Pz9O0SuDMmHD7OVvCOs+LfuU7WBsY/
	7F2MnBwSAiYSJ97dY4WwxSQu3FvP1sXIxSEkcJlR4t2HnVDOOSaJz1OvMINU8QpoS8z70AOU
	4OBgEVCV6O2VAgmzCehKLOppZgKxRQUCJD50PmCEKBeUODnzCQuILSKQIPHt7w+wGmYBLYk7
	l+6C1QgLGEi8bdnLArFrHqPE8TuT2UASnAJqElNv/GCEaFCX+DPvEjOELS/RvHU28wRGgVlI
	dsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCHBK7SDcf1J
	uUOMAhyMSjy8E8SVQoRYE8uKK3MPMUpyMCmJ8j5NBwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS
	4S0oBMrxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwRhUBNQoWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL0ZIO28xQWJuUBRiNZTjLoc
	6zq/9TMJseTl56VKifMGgxwnAFKUUZoHtwKWql4xigN9LMybCTKKB5jm4Ca9AlrCBLTk/nF5
	kCUliQgpqQZGla3Nea+71GSKOjkllW8W/D+WrNjDt6/ISK25pLyeL3BZ7oIwzs/sjxxr1Bc5
	hs5h//0g8Pfqs9/fCn49GOD1qXK/y0Sn/91r1b8GbIjbcj19zybOOVnX4s88a9qi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257452>

On 09/16/2014 08:56 PM, Ren=C3=A9 Scharfe wrote:
> The macro ALLOC_GROW manages several aspects of dynamic memory
> allocations for arrays: It performs overprovisioning in order to avoi=
d
> reallocations in future calls, updates the allocation size variable,
> multiplies the item size and thus allows users to simply specify the
> item count, performs the reallocation and updates the array pointer.
>=20
> Sometimes this is too much.  Add the macro REALLOC_ARRAY, which only
> takes care of the latter three points and allows users to specfiy the
> number of items the array can store.  It can increase and also decrea=
se
> the size.  Using the macro avoid duplicating the variable name and
> takes care of the item sizes automatically.

Is there a reason that ALLOC_GROW and REALLOC_ARRAY are defined in two
separate header files (cache.h and git-compat-util.h, respectively)? It
seems to me that they are close siblings and therefore I find it
surprising that they are not defined right next to each other.

It's true that ALLOC_GROW contains a *tiny* bit of application logic in
the form of the alloc_nr macro used to compute the new size of the
array, but it's still pretty generic.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
