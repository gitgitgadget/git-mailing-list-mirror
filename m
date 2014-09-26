From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] strbuf.c: keep errno in strbuf_read_file()
Date: Fri, 26 Sep 2014 12:30:38 +0200
Message-ID: <5425404E.7050100@alum.mit.edu>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com> <1406285039-22469-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 12:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSnb-000836-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbaIZKaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2014 06:30:46 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63230 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754886AbaIZKap (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:30:45 -0400
X-AuditID: 1207440c-f79036d000005e77-66-54254054b2a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FD.C5.24183.45045245; Fri, 26 Sep 2014 06:30:44 -0400 (EDT)
Received: from [172.16.46.16] ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QAUd3Y014861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:30:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <1406285039-22469-2-git-send-email-pclouds@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqBvioBpi8Oq6vEXXlW4mi4beK8wW
	3VPeMjowe+ycdZfd4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNWLj7NXrCKp+LBhKAGxqOc
	XYycHBICJhIvnv1mgrDFJC7cW88GYgsJXGaUmDU9rIuRC8jewCQxtecOO0iCV0Bb4uLKWcwg
	NouAqsSqhafAGtgEdCUW9TSDDRIVCJD40PmAEaJeUOLkzCcsILaIQJrE4snvwXqZBdQkDi15
	BFYjLOAs8fTsN2aIxeUSjc0zweKcAk4SPzu+skPUq0v8mXcJqldeonnrbOYJjAKzkKyYhaRs
	FpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCApdnB+O3dTKHGAU4
	GJV4eBvWqIQIsSaWFVfmHmKU5GBSEuX9YqEaIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE944R
	UI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrZA/UKFiUmp5akZaZ
	U4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0/hiYKSCpHiA9v61A9lbXJCYCxSFaD3FaMzx4dfL
	XiaOdZ3f+pmEWPLy81KlxHk1QTYJgJRmlObBLYKlrFeM4kB/C/PagFTxANMd3LxXQKuYgFYp
	HVEGWVWSiJCSamBUYzRanMexvCreTbWgqn6Gq6D2bZ20S5m/DuTeFrTsnH03J+pCw0Hdzm0f
	lRjXhpfmC6ZteT4vMT2g/aDmz2UrFwRVp+g9aMkzvBNq7NcdtMvkzHd2H7mSj3LT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257544>

On 07/25/2014 12:43 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> This function is used to replaced some code in the next patch that
> does this (i.e. keep the errno when read() fails)
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  strbuf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/strbuf.c b/strbuf.c
> index 33018d8..61d685d 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -454,15 +454,18 @@ int strbuf_getwholeline_fd(struct strbuf *sb, i=
nt fd, int term)
> =20
>  int strbuf_read_file(struct strbuf *sb, const char *path, size_t hin=
t)
>  {
> -	int fd, len;
> +	int fd, len, saved_errno;
> =20
>  	fd =3D open(path, O_RDONLY);
>  	if (fd < 0)
>  		return -1;
>  	len =3D strbuf_read(sb, fd, hint);
> +	saved_errno =3D errno;
>  	close(fd);

Theoretically close() can fail, though it seems a little far-fetched
(and also uninteresting) if it fails for a file opened read-only. But i=
f
it did, you would not notice the error.

So I grepped through our code to see whether we typically bother to
check the return value when close()ing a read-only file. And I found
that we rarely even check its return value when *writing* to a file.
(Many of those places are probably bugs.)

So, carry on and forget I said anything :-)

> -	if (len < 0)
> +	if (len < 0) {
> +		errno =3D saved_errno;
>  		return -1;
> +	}
> =20
>  	return len;
>  }
>=20

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
