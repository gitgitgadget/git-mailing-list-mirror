From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 07/48] lockfile.c: make lock_file return a meaningful
 errno on failurei
Date: Wed, 18 Jun 2014 22:30:04 +0200
Message-ID: <53A1F6CC.4020601@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com> <1403020442-31049-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:30:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMUo-00081n-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbaFRUaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:30:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45159 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754876AbaFRUaH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 16:30:07 -0400
X-AuditID: 12074414-f79f86d000000b9f-be-53a1f6cfebf0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.6B.02975.FC6F1A35; Wed, 18 Jun 2014 16:30:07 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IKU4SJ027941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 16:30:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403020442-31049-8-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqHv+28Jgg5lr2Cy6rnQzWfybUOPA
	5LFgU6nH501yAUxR3DZJiSVlwZnpefp2CdwZPy61shS8l6yYsrGTvYGxWaSLkZNDQsBE4tWF
	RlYIW0ziwr31bF2MXBxCApcZJf73n2OCcM4zSey+3s0CUsUroC2x8+s1dhCbRUBVovHDZzCb
	TUBXYlFPMxOILSoQJDH78zx2iHpBiZMzn4D1igjYSay/tZAZxBYWSJRoP3IezBYSqJY43N8J
	VsMp4CLx8MofIJsD6CJxiZ7GIJAws4COxLu+B8wQtrzE9rdzmCcwCsxCsmEWkrJZSMoWMDKv
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJUpEdjEdOyh1iFOBgVOLhXXB5
	YbAQa2JZcWXuIUZJDiYlUV6PL0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxOD4ByvCmJlVWp
	RfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvBzAaBQSLEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB0VqfDEwVkFSPEB7V30F2VtckJgLFIVoPcWoy3HqzrE2JiGWvPy8
	VClx3jaQIgGQoozSPLgVsJT0ilEc6GNh3l0gVTzAdAY36RXQEiagJSoT54EsKUlESEk1MFad
	MTUXuxf59H/VcxHH1XL8IZzRr5+ZzLdYy1+esbl7a5zfH1cZ5x4J7Xo2fhGb3h3H1uRd5ali
	e8Hq7pHwOozFTODZ6lnt3R9Nu0xvXZoqPO3Ot4QfjrdrNi0qEZL7Kt0QVXlSoaKV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252059>

There's a typo in the subject line of this commit.

Michael

On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
> Making errno when returning from lock_file() meaningful, which should
> fix
> 
>  * an existing almost-bug in lock_ref_sha1_basic where it assumes
>    errno==ENOENT is meaningful and could waste some work on retries
> 
>  * an existing bug in repack_without_refs where it prints
>    strerror(errno) and picks advice based on errno, despite errno
>    potentially being zero and potentially having been clobbered by
>    that point
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  lockfile.c | 17 ++++++++++++-----
>  refs.c     |  1 +
>  refs.h     |  1 +
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/lockfile.c b/lockfile.c
> index 464031b..a921d77 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -121,7 +121,7 @@ static char *resolve_symlink(char *p, size_t s)
>  	return p;
>  }
>  
> -
> +/* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
>  	/*
> @@ -130,8 +130,10 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	 */
>  	static const size_t max_path_len = sizeof(lk->filename) - 5;
>  
> -	if (strlen(path) >= max_path_len)
> +	if (strlen(path) >= max_path_len) {
> +		errno = ENAMETOOLONG;
>  		return -1;
> +	}
>  	strcpy(lk->filename, path);
>  	if (!(flags & LOCK_NODEREF))
>  		resolve_symlink(lk->filename, max_path_len);
> @@ -148,9 +150,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  			lock_file_list = lk;
>  			lk->on_list = 1;
>  		}
> -		if (adjust_shared_perm(lk->filename))
> -			return error("cannot fix permission bits on %s",
> -				     lk->filename);
> +		if (adjust_shared_perm(lk->filename)) {
> +			int save_errno = errno;
> +			error("cannot fix permission bits on %s",
> +			      lk->filename);
> +			errno = save_errno;
> +			return -1;
> +		}
>  	}
>  	else
>  		lk->filename[0] = 0;
> @@ -188,6 +194,7 @@ NORETURN void unable_to_lock_index_die(const char *path, int err)
>  	die("%s", buf.buf);
>  }
>  
> +/* This should return a meaningful errno on failure */
>  int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
>  {
>  	int fd = lock_file(lk, path, flags);
> diff --git a/refs.c b/refs.c
> index db05602..e9d53e4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2212,6 +2212,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> +/* This should return a meaningful errno on failure */
>  int lock_packed_refs(int flags)
>  {
>  	struct packed_ref_cache *packed_ref_cache;
> diff --git a/refs.h b/refs.h
> index 09d3564..64f25d9 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -82,6 +82,7 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
>  /*
>   * Lock the packed-refs file for writing.  Flags is passed to
>   * hold_lock_file_for_update().  Return 0 on success.
> + * Errno is set to something meaningful on error.
>   */
>  extern int lock_packed_refs(int flags);
>  
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
