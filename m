From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] test-lint: detect 'export FOO=bar'
Date: Mon, 08 Jul 2013 21:31:37 +0200
Message-ID: <51DB1399.9020307@web.de>
References: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch> <24ee18d3b06883c4185821f5ffb5faed26e6a436.1373296313.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 08 21:31:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwH9z-0000wU-Bh
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 21:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab3GHTbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 15:31:39 -0400
Received: from mout.web.de ([212.227.17.12]:54729 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab3GHTbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 15:31:39 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MI6JC-1UudWx2UAw-003qs7; Mon, 08 Jul 2013 21:31:37
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <24ee18d3b06883c4185821f5ffb5faed26e6a436.1373296313.git.trast@inf.ethz.ch>
X-Provags-ID: V03:K0:9ELaEzkJPPzs5dWVx0gh9URcz/L4Qzu3QUGIez7Rtw9LtwwtyO4
 g7eyQLe4efh2K0Hlb3opnkcacPw2bYTNHNyQm7IIgfrxZiQzNxu5EuMhO9KGjk1cWyQCvRW
 gn4VFIlichhOvv1hTkRFFpMK65x4gj4/t2oEHnq3OdTn8/jGB+OqqqKDu57b0hCkuicRqwg
 Ox6qFmIJRNMXYirNlmLxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229887>

On 2013-07-08 17.20, Thomas Rast wrote:
> Some shells do not understand the one-line construct, and instead nee=
d
>=20
>   FOO=3Dbar &&
>   export FOO
>=20
> Detect this in the test-lint target.
>=20
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>=20
> I wrote:
>=20
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
> [...]
>>> -		export HARNESS_ACTIVE=3Dt &&
>>> +		HARNESS_ACTIVE=3Dt &&
>>> +		export HARNESS_ACTIVE &&
> [...]
>> Ack.  Sorry for breaking this -- I suppose test-lint would have caug=
ht
>> me out?
>=20
> Well, no, not yet.
Thanks for working on this

>=20
>=20
>  t/check-non-portable-shell.pl | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-she=
ll.pl
> index 8b5a71d..45971f4 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -21,6 +21,7 @@ while (<>) {
>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
>  	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use typ=
e)';
>  	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (=
please use =3D)';
> +	/^\s*export\s+[^=3D]*=3D/ and err '"export FOO=3Dbar" is not portab=
le (please use FOO=3Dbar && export FOO)';
I have a slightly tighter reg exp in my tree, but credits should go to =
Thomas:=20

/^\s*export\s+\S+=3D\S+/

/Torsten
