From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5] commit.c: use skip_prefix() instead of starts_with()
Date: Fri, 21 Mar 2014 16:48:23 +0100
Message-ID: <532C5F47.3020801@alum.mit.edu>
References: <1393970831-3558-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, max@quendi.de
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 16:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR1gO-0007ME-Or
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 16:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbaCUPs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 11:48:28 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56958 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbaCUPs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 11:48:27 -0400
X-AuditID: 1207440f-f79326d000003c9f-56-532c5f4aeab3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 39.D2.15519.A4F5C235; Fri, 21 Mar 2014 11:48:26 -0400 (EDT)
Received: from [192.168.69.148] (p57A25836.dip0.t-ipconnect.de [87.162.88.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2LFmNKt020178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Mar 2014 11:48:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393970831-3558-1-git-send-email-tanayabh@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqOsVrxNssPmLrEXXlW4mi4beK8wW
	n/9dZ7P4deE9swOLx85Zd9k9Ll5S9piwfS+zx+dNcgEsUdw2SYklZcGZ6Xn6dgncGUeW3WIu
	mC5XsenoKaYGxuPiXYycHBICJhKzH69mhLDFJC7cW8/WxcjFISRwmVHix8zHTBDOOSaJc88v
	sIJU8QpoS3x72wVUxcHBIqAqsXqZG0iYTUBXYlFPMxOILSoQLLH68gMWiHJBiZMzn4DZIgIq
	Ej933WYGsZkFLCVaXn4DiwsL+Ei8nbCFHcQWEnCUuPj/PNhBnAJOEoen32cGWSUhIC7R0xgE
	0aoj8a7vAdQYeYntb+cwT2AUnIVk2ywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5da
	pGuil5tZopeaUrqJERLk/DsYu9bLHGIU4GBU4uGt4NQOFmJNLCuuzD3EKMnBpCTK6xmpEyzE
	l5SfUpmRWJwRX1Sak1p8iFGCg1lJhLc5FijHm5JYWZValA+TkuZgURLnVV+i7ickkJ5Ykpqd
	mlqQWgSTleHgUJLgtYoDahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxW98MTCC
	QVI8QHtZQdp5iwsSc4GiEK2nGHU5Nmxb08gkxJKXn5cqJc7rCFIkAFKUUZoHtwKW0l4xigN9
	LMzrA1LFA0yHcJNeAS1hAlrCP1ULZElJIkJKqoHRsTpol0sjy/9Vv/Y9i3+RdrFv7cFrRlFK
	fveEA4JLHvseNu6L5xISnX/jmMcVoRM526WKLgtedLnTu1VsHcvKmh/nXs8pbhQ9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244692>

On 03/04/2014 11:07 PM, Tanay Abhra wrote:
> In record_author_date() & parse_gpg_output(), the callers of
> starts_with() not just want to know if the string starts with the
> prefix, but also can benefit from knowing the string that follows
> the prefix.
> 
> By using skip_prefix(), we can do both at the same time.
> 
> Helped-by: Max Horn <max@quendi.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> Patch V5 Minor revision of indentation
> Patch V4  Identation improved, removed useless comment. [1]
> 		Thanks to Junio C Hamano and Max Horn.
> [1] http://article.gmane.org/gmane.comp.version-control.git/243388
> 
> Patch V3 Variable naming improved, removed assignments inside conditionals.
>         Thanks to Junio C Hamano and Max Horn.
> 
> Patch V2 Corrected email formatting ,reapplied the implementation according to suggestions.
>         Thanks to Michael Haggerty.
> 
> This is in respect to GSoC microproject #10.
> 
> In record_author_date(), extra and useless calls to strlen due to using starts_with()
> were removed by using skip_prefix(). Extra variable "ident_line" was used as "buf" is used in
> for loop update check.
> 
> Other usages of starts_with() in the same file can be found with,
> 
> $ grep -n starts_with commit.c
> 
> 1116:           else if (starts_with(line, gpg_sig_header) &&
> 1196:           if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> 
> The starts_with() in line 1116 was left as it is, as strlen values were pre computed as
> global variables, and replacing may hamper the clarity.
> The starts_with() in line 1196 was replaced as it abstracts way the skip_prefix part by
> directly using the function.
> Also skip_prefix() is inline when compared to starts_with().
> 
> ---
>  commit.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..d37675c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -548,7 +548,7 @@ define_commit_slab(author_date_slab, unsigned long);
>  static void record_author_date(struct author_date_slab *author_date,
>  			       struct commit *commit)
>  {
> -	const char *buf, *line_end;
> +	const char *buf, *line_end, *ident_line;
>  	char *buffer = NULL;
>  	struct ident_split ident;
>  	char *date_end;
> @@ -566,14 +566,14 @@ static void record_author_date(struct author_date_slab *author_date,
>  	     buf;
>  	     buf = line_end + 1) {
>  		line_end = strchrnul(buf, '\n');
> -		if (!starts_with(buf, "author ")) {
> +		ident_line = skip_prefix(buf, "author ");
> +		if (!ident_line) {
>  			if (!line_end[0] || line_end[1] == '\n')
>  				return; /* end of header */
>  			continue;
>  		}
>  		if (split_ident_line(&ident,
> -				     buf + strlen("author "),
> -				     line_end - (buf + strlen("author "))) ||
> +				     ident_line, line_end - ident_line) ||
>  		    !ident.date_begin || !ident.date_end)
>  			goto fail_exit; /* malformed "author" line */
>  		break;
> @@ -1193,10 +1193,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>  	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>  		const char *found, *next;
>  
> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> -			/* At the very beginning of the buffer */
> -			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> -		} else {
> +		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> +		if(!found) {

Nit: There should be a space between "if" and the opening parenthesis.

>  			found = strstr(buf, sigcheck_gpg_status[i].check);
>  			if (!found)
>  				continue;
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
