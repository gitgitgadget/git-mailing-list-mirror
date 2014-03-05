From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: New directory lost by git am
Date: Tue, 04 Mar 2014 22:22:16 -0500
Message-ID: <53169868.3010401@ubuntu.com>
References: <531690A3.3040509@ubuntu.com> <53169549.10309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Chris Packham <judge.packham@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 04:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL2PW-0002PG-PE
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 04:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937AbaCEDWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 22:22:18 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63247 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbaCEDWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 22:22:17 -0500
X-Authority-Analysis: v=2.0 cv=MODiabll c=1 sm=0 a=S/gQ7PeTrZbCJAhh99lbaw==:17 a=cs1xLa0W9aIA:10 a=JbtRu-yXPzkA:10 a=S1A5HrydsesA:10 a=ossw24rp0ecA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=QfKxxUxMAAAA:8 a=wqbv2UUBpcEZqcfQXsUA:9 a=wPNLvfGTeEIA:10 a=K60eEpc38zYA:10 a=S/gQ7PeTrZbCJAhh99lbaw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 72.238.67.160
Received: from [72.238.67.160] ([72.238.67.160:57105] helo=[192.168.1.107])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 02/D9-23887-66896135; Wed, 05 Mar 2014 03:22:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <53169549.10309@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243416>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 03/04/2014 10:08 PM, Chris Packham wrote:
> Could you provide a few more details such as your git version (git 
> --version) and an example of the failure. I've tried to reproduce
> the problem based on the description provided but everything seems
> to work as expected for me.

Version 1.8.3.2.

> git --version git version 1.9.0 mkdir test && cd test && git init 
> echo "hello world" >a.txt git add a.txt git commit -m"Initial
> commit" git checkout -b temp mkdir b echo "lorem ipsum" >b/b.txt 
> git add b/b.txt git commit -m"Add b/b.txt" ls -R .: a.txt  b
> 
> ./b: b.txt git checkout master git format-patch temp -1 --stdout |
> git am ls -R .: a.txt  b
> 
> ./b: b.txt
> 

You are reapplying the patch while it is already applied.  Do a reset
HEAD~1 --hard, and git clean -x -f -d before git am.  I didn't notice
the missing file myself for some time because it is left in the
working tree, just not added to the index and included in the commit.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTFphoAAoJEI5FoCIzSKrwx78H/iTLvtMVb2hmn2g2YDQuJWe3
nENrqlRNDF11YHpA9c7chxepcuP2CZaZjoXv45aCQG9Wx9XJyKPIbauhwqIIVUjR
VYDORdtpn8u3Pf3WWyHYW+MEoupYyni4VYENVSjKnV6sLT951TuYI+4paHWat3lq
/at9UkLy4d39hj2P/6M+voBbKWzblBZzP31lH6OY/Mno2zhh4eQChhsnZYPQ/Hfn
REAeyB4WsLCjnPz+uEkOcWaEVVh+BwNU1UmK/tX+rzhBsaRzhDY5IIWTL9dfkD/z
Af86IUSKdTjnMq7CTmVAmlxAfHXF0bgtlybrVY2Sdc8R/CqmWCz6USyKdUxgLIk=
=Z3Z/
-----END PGP SIGNATURE-----
