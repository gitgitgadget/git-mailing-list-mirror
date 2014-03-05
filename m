From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: New directory lost by git am
Date: Wed, 05 Mar 2014 13:29:27 -0500
Message-ID: <53176D07.3020206@ubuntu.com>
References: <531690A3.3040509@ubuntu.com> <53169549.10309@gmail.com> <53169868.3010401@ubuntu.com> <5316DBEC.3020208@gmail.com> <53173423.6050708@ubuntu.com> <20140305163415.GA28908@sigill.intra.peff.net> <53175510.7020000@ubuntu.com> <20140305171334.GA31252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:29:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGZU-0002ep-LS
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbaCES3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:29:32 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59705 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbaCES3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:29:31 -0500
X-Authority-Analysis: v=2.0 cv=S8pbMfQP c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=JipEcVzqA9wA:10 a=JbtRu-yXPzkA:10 a=S1A5HrydsesA:10 a=Qsx_du5GiBkA:10 a=IkcTkHD0fZMA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=QfKxxUxMAAAA:8 a=M_dgDDc6FE9TJqProYsA:9 a=QEXdDO2ut3YA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:61003] helo=[10.1.1.236])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 39/AD-17312-60D67135; Wed, 05 Mar 2014 18:29:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140305171334.GA31252@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243457>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 3/5/2014 12:13 PM, Jeff King wrote:
> We apply the changes to "modified" and "new" to the working tree,
> but we do not stage anything in the index. I suspect this is
> because our invocation of "apply --index" (which is what is doing
> the real work with "--reject" here) bails before touching the
> index. In theory it should be able to update the index for files
> that applied cleanly and leave the other ones alone.

Yikes, that's really bad.

> But I have not thought hard about it, so maybe there is a good
> reason not to (it is a little weird just because the resulting
> index is a partial application of the patch).  The "am -3" path
> does what you want here, but it is much simpler: it knows it can
> represent the 3-way conflict in the index. So the index represents
> the complete state of the patch application at the end, including
> conflicts.

yes, but -3 fails if it can't find the parent blobs.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTF20HAAoJEI5FoCIzSKrwFfQIAJfPmplu7zskercvjnuZGCle
ccTzK0rYtrwQn/78Vrbc6kqcrQvbvtrqUMN4/ILJ5xeaO80Gzzz8pchBPNN8khhY
VBQiWUOrKzBH1vszveneva+gFUrLIWk2KI6T8lGTnYulvRVe38WRAwr/8qEClPX6
hUnYChM17WE+KTV39ezA6ww9ZAyOX7EHq87PJp5nVgBB4HkmkDmccfxYTFNB4FGg
PPqun8g0Fyytd+Qrsk2M5L6NsPUXi32wIt8EWcyPwU6QrQgKbuWK7QlVkcPPzecM
eHifKm8V1V0VKudm3S8jbaUDG2KnLIdMveXu/e9Hn7+YgDQh9zM1m7f+NVJDvjk=
=NAe9
-----END PGP SIGNATURE-----
