From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote prune"?
Date: Thu, 19 Mar 2015 15:49:08 +0100
Message-ID: <550AE1E4.7020407@alum.mit.edu>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com> <20150306225917.GA1589@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?B?b24=?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 15:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYblJ-00056R-SB
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 15:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbbCSOtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2015 10:49:24 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56696 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475AbbCSOtX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 10:49:23 -0400
X-AuditID: 12074414-f797f6d000004084-b6-550ae1e7cfc7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 23.94.16516.7E1EA055; Thu, 19 Mar 2015 10:49:11 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9661B.dip0.t-ipconnect.de [79.201.102.27])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2JEn99W022059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 19 Mar 2015 10:49:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <20150306225917.GA1589@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqPv8IVeowZx/vBZrn91hsph/bDGz
	RdeVbiaLhg/OFj9aepgtNm9uZ3Fg89g56y67x4JNpR7PevcwenzeJBfAEsVtk5RYUhacmZ6n
	b5fAnfHjgVBBO1/FsV2vmRsYF3J3MXJySAiYSCy7dpIRwhaTuHBvPVsXIxeHkMBlRoldbYtZ
	IJzzTBK7j2wCq+IV0Ja4s3kWK4jNIqAq0fpmCRuIzSagK7Gop5kJxBYVCJJ4eesvVL2gxMmZ
	T1hAbBGBKolzh/vAhjILHGGUWPnrCliRsIC/xPYbZ8GKhAQKJX7tPAVmcwINnfTnMthQZgF1
	iT/zLjFD2PISzVtnM09gFJiFZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRr
	oZebWaKXmlK6iRES4iI7GI+clDvEKMDBqMTDK+DKFSrEmlhWXJl7iFGSg0lJlJdrBVCILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCG/IbaAcb0piZVVqUT5MSpqDRUmc99tidT8hgfTEktTs1NSC
	1CKYrAwHh5IEryAwloUEi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQbEaXwyMVpAU
	D9Dekw9A9hYXJOYCRSFaTzEqSonzsoLMFQBJZJTmwY2FJa5XjOJAXwrzvgRp5wEmPbjuV0CD
	mYAG/6sFG1ySiJCSamBskvPKfa8083mVbJbFot9L309N2JN52Oi+9qv29W/2+Nmci7BMjryS
	dWRF/OfPr5dsu/UxsXXT5KR3DDF92+y33D4pwRXmY/5oUZXnZ/aLOx7MZ1x867tL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265805>

On 03/06/2015 11:59 PM, Jeff King wrote:
> On Fri, Mar 06, 2015 at 05:48:39PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>=20
>> The --prune option to fetch added in v1.6.5-8-gf360d84 seems to be
>> around 20-30x slower than the equivalent operation with git remote
>> prune. I'm wondering if I'm missing something and fetch does somethi=
ng
>> more, but it doesn't seem so.
>=20
> [...]
> We spend a lot of time checking refs here. Probably this comes from
> writing the `packed-refs` file out 1000 times in your example, becaus=
e
> fetch handles each ref individually. Whereas since c9e768b (remote:
> repack packed-refs once when deleting multiple refs, 2014-05-23),
> git-remote does it in one pass.
>=20
> Now that we have ref_transaction_*, I think if git-fetch fed all of t=
he
> deletes (along with the updates) into a single transaction, we would =
get
> the same optimization for free. Maybe that is even part of some of th=
e
> pending ref_transaction work from Stefan or Michael (both cc'd). I
> haven't kept up very well with what is cooking in pu.

I am looking into this now.

=46or pruning, we can't use a ref_transaction as it is currently
implemented because it would fail if any of the reference deletions
failed. But in this case I think if any deletions fail, we would prefer
to emit a warning but keep going.

I'm trying to decide whether to have a separate function in the refs AP=
I
to "delete as many of the following refs as possible", or whether to ad=
d
a flag to ref_transaction_update() that says "try this update, but don'=
t
fail the transaction if it fails". The latter would probably be more
work because we would need to invent a way to return multiple error
messages from a single transaction.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
