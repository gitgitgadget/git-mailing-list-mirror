From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/8] Add a utility function to make parsing hex values
 easier.
Date: Thu, 11 Jun 2015 18:09:23 +0200
Message-ID: <5579B2B3.8030805@alum.mit.edu>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net> <1433867316-663554-5-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?B?eQ==?= 
	<pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3531-0005sQ-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbFKQJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:09:39 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48453 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754342AbbFKQJi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 12:09:38 -0400
X-AuditID: 12074412-f79066d000000bc5-b9-5579b2b5d407
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.1E.03013.5B2B9755; Thu, 11 Jun 2015 12:09:25 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97261.dip0.t-ipconnect.de [79.201.114.97])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5BG9Ntf002120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Jun 2015 12:09:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1433867316-663554-5-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqLt1U2WowfGbJhZdV7qZLLqnvGW0
	+NHSw2zRNvMHkwOLx/Kbf5k8ds66y+7xrHcPo8fnTXIBLFHcNkmJJWXBmel5+nYJ3BlTbl9n
	L3goU7F+a20D4yWxLkZODgkBE4n5F28wQthiEhfurWfrYuTiEBK4zChx59pNJgjnPJNE37Jv
	QBkODl4BbYnV711AGlgEVCWauzqYQGw2AV2JRT3NTCAlogJBEq9f5oKEeQUEJU7OfMICYosI
	eEnMfzSDFcRmFqiW+HftK9hEYYEQibM30yE29TNK/N7wjBmkhlPAT2LRnItgI5kF1CXWzxOC
	aJWXaN46m3kCo8AsJBtmIVTNQlK1gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZole
	akrpJkZIIAvtYFx/Uu4QowAHoxIPb8WJilAh1sSy4srcQ4ySHExKorzZrpWhQnxJ+SmVGYnF
	GfFFpTmpxYcYJTiYlUR4Ny8DyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnK
	cHAoSfCu3AjUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0PhiYIyCpHiA9haB
	tPMWFyTmAkUhWk8xKkqJ83aAJARAEhmleXBjYenpFaM40JfCvHdBqniAqQ2u+xXQYCagwQuZ
	y0EGlyQipKQaGO1MztsWOn1kq5CqT73zJPftKvt1PV8vPcmKPnhexTbvp2ny+6TN1/YpR+h+
	u2BYwt3DxVheLqS1Q8926Wc/lUqdQm7jeYbzNt48fnrX6e3TC2s09vvY+zBM1uf0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271424>

On 06/09/2015 06:28 PM, brian m. carlson wrote:
> get_oid_hex is already available for parsing hex object IDs into struct
> object_id, but parsing code still must hard-code the number of bytes
> read.  Introduce parse_oid_hex, which accepts an optional length, and
> also returns the number of bytes parsed on success, or 0 on failure.
> This makes it easier for code not to assume fixed values when parsing,
> and to move to larger hash functions in the future.

I have an open mind, but I have the feeling that this will not be a very
handy interface:

* It will usually require a new int variable to catch the return value.

* We don't put assignments within conditional expressions. So often this
will require one line of code to call the function and a second one to
test the return value.

For example, consider how awkward it will be to rewrite code that now
looks like

    if (hex && !get_sha1_hex(hex, sha1) && hex[40] == '\n')


You might instead consider the style of interface used by skip_prefix(),
which I've really come to like:

int parse_oid_hex(const char *hex, struct object_id *oid,
                  const char **out)
{
	if (get_sha1_hex(hex, oid->hash))
		return -1; /* failure */

	if (out)
		*out = hex + GIT_SHA1_HEXSZ;
	return 0;
}

This function could of course take a "len" parameter too. Note that it
uses our usual convention that success is denoted by returning 0.

With this definition, the above code could be rewritten to (if the old
value of hex is not needed again)

    if (hex && !parse_oid_hex(hex, &oid, &hex) && *hex == '\n')

> ---
>  cache.h | 9 +++++++++
>  hex.c   | 7 +++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index fa1f067..f3b829f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1012,6 +1012,15 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
>  extern int get_sha1_hex(const char *hex, unsigned char *sha1);
>  extern int get_oid_hex(const char *hex, struct object_id *sha1);
>  
> +/*
> + * Like get_oid_hex, but accepts an optional length argument, which may be -1
> + * if the string is terminated by a non-hex character.  As with get_oid_hex,
> + * reading stops if a NUL is encountered.  Returns the number of characters
> + * read (40) on success and 0 on failure.  This is designed to be easier to
> + * use for parsing data than get_oid_hex.
> + */
> +extern int parse_oid_hex(const char *hex, int len, struct object_id *oid);
> +
>  extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
>  extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
>  extern int read_ref_full(const char *refname, int resolve_flags,
> diff --git a/hex.c b/hex.c
> index 899b74a..ba196d7 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -61,6 +61,13 @@ int get_oid_hex(const char *hex, struct object_id *oid)
>  	return get_sha1_hex(hex, oid->hash);
>  }
>  
> +int parse_oid_hex(const char *hex, int len, struct object_id *oid)
> +{
> +	if (len != -1 && len < GIT_SHA1_HEXSZ)
> +		return 0;
> +	return get_sha1_hex(hex, oid->hash) ? GIT_SHA1_HEXSZ : 0;
> +}
> +

Isn't this return-statement logic backwards? get_sha1_hex() returns 0 on
success, which you would want to convert to 40. This function would want
to return 0 on *error*.

Which is another disadvantage of this style. All the code that called
get_sha1_hex() had to treat 0 as success. With your function they would
have to be inverted to treat 0 as failure. I think this would cause
confusion.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
