From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 05/44] refs.c: move update_ref to refs.c
Date: Tue, 13 Oct 2015 05:41:47 +0200
Message-ID: <561C7D7B.8020807@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-6-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 05:49:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlqaC-0003mF-Il
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 05:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbbJMDs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 23:48:56 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50814 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbbJMDsz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 23:48:55 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2015 23:48:55 EDT
X-AuditID: 12074411-f797e6d000007df3-97-561c7d7ddbfb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E0.4E.32243.D7D7C165; Mon, 12 Oct 2015 23:41:49 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D3flvI007246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 Oct 2015 23:41:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-6-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqFtbKxNmMG+ujMX8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzlhyZhFjwUvpiu0bV7I0ME4U
	62Lk5JAQMJFoP3ecHcIWk7hwbz1bFyMXh5DAZUaJiVd3skA4Z5kkvl1eCVbFK6AtsbRjG5jN
	IqAqsWfqOzCbTUBXYlFPMxOILSoQJLFi+QtGiHpBiZMzn7CA2CICDhKXdx1lBrGZBTQlNm14
	wdrFyMEhLGAv8b1fCWJXK6NE65XjrCA1nAKeEs+2T4Gq15PYcf0XK4QtL9G8dTbzBEaBWUhW
	zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIaEruINxxkm5
	Q4wCHIxKPLwvImXChFgTy4orcw8xSnIwKYny1mUChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	nssCyvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHj1a4AaBYtS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGxGl8MjFaQFA/QXkuQdt7igsRcoChE6ylGRSlx
	3haQhABIIqM0D24sLCG9YhQH+lKY1w+kigeYzOC6XwENZgIabMQuBTK4JBEhJdXAuEVAcdau
	p9umirL/ejmBQUfCu23VUi8W6X13Txz7PZP73JQykyyHULXzdisO1oue36IjrpRcltXXu+PV
	kp6DkxUFBTbx1/6R4w+XfJsxr7+hm0HyqwRv7azdCu4lW4Rt1N8UHu0+96Q/Lkje 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279477>

On 10/12/2015 11:51 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Move update_ref() to the refs.c file since this function does not
> contain any backend specific code.  Move the ref classifier functions
> as well, since update_ref depends on them.
> 
> Based on Ronnie Sahlberg's patch
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 117 +-------------------------------------------------------
>  refs.c          | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 116 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index d0dfdfc..7fe4931 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> [...]
> @@ -2879,77 +2877,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
> [...]
> -static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
> -			   const unsigned char *old_sha1, struct strbuf *err)
> -{
> -	const char *filename;
> -	int fd;
> -	static struct lock_file lock;
> -	struct strbuf buf = STRBUF_INIT;
> -	int ret = -1;
> -
> -	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
> -
> -	filename = git_path("%s", pseudoref);
> -	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
> -	if (fd < 0) {
> -		strbuf_addf(err, "Could not open '%s' for writing: %s",
> -			    filename, strerror(errno));
> -		return -1;
> -	}
> -
> -	if (old_sha1) {
> -		unsigned char actual_old_sha1[20];
> -
> -		if (read_ref(pseudoref, actual_old_sha1))
> -			die("could not read ref '%s'", pseudoref);
> -		if (hashcmp(actual_old_sha1, old_sha1)) {
> -			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
> -			rollback_lock_file(&lock);
> -			goto done;
> -		}
> -	}
> -
> -	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
> -		strbuf_addf(err, "Could not write to '%s'", filename);
> -		rollback_lock_file(&lock);
> -		goto done;
> -	}
> -
> -	commit_lock_file(&lock);
> -	ret = 0;
> -done:
> -	strbuf_release(&buf);
> -	return ret;
> -}
> -
> [...]
> diff --git a/refs.c b/refs.c
> index 77492ff..2d10708 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1,3 +1,118 @@
> [...]
> +static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
> +			   const unsigned char *old_sha1, struct strbuf *err)
> +{
> +	const char *filename;
> +	int fd;
> +	static struct lock_file lock;
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret = -1;
> +
> +	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
> +
> +	filename = git_path("%s", pseudoref);
> +	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
> +	if (fd < 0) {
> +		strbuf_addf(err, "Could not open '%s' for writing: %s",
> +			    filename, strerror(errno));
> +		return -1;
> +	}
> +
> +	if (old_sha1) {
> +		unsigned char actual_old_sha1[20];
> +		read_ref(pseudoref, actual_old_sha1);

The original read

		if (read_ref(pseudoref, actual_old_sha1))
			die("could not read ref '%s'", pseudoref);

This seems like an important test. What happened to it?

If its removal was intentional, it deserves a careful explanation (and
should probably be done as a separate commit). If it was an accident,
please consider how this accident arose and try to think about whether
similar accidents might have happened elsewhere in this series.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
