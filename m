From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/44] refs.c: move delete_ref and delete_refs to the
 common code
Date: Tue, 13 Oct 2015 05:51:10 +0200
Message-ID: <561C7FAE.5010500@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 05:51:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlqcQ-000649-J3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 05:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbJMDvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 23:51:13 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50820 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008AbbJMDvN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 23:51:13 -0400
X-AuditID: 12074411-f797e6d000007df3-89-561c7fb0b815
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 83.5E.32243.0BF7C165; Mon, 12 Oct 2015 23:51:12 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D3pAp8007658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 Oct 2015 23:51:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-7-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLuhXibMoHWvqsX8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzljaeou9YJNExfue66wNjLOF
	uxg5OSQETCQO3DnFDmGLSVy4t56ti5GLQ0jgMqPEtxuLWSGcs0wSy3f1soBU8QpoS3x4NYkR
	xGYRUJXY8mM5E4jNJqArsainGcwWFQiSWLH8BSNEvaDEyZlPwHpFBBwkLu86ygxiMwtoSmza
	8IIVxBYWiJI4uOUU1OZWRom+fZ/AijgFPCXmPb3MDtGgJ7Hj+i9WCFteYvvbOcwTGAVmIdkx
	C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEBK/gDsYZJ+UO
	MQpwMCrx8L6IlAkTYk0sK67MPcQoycGkJMpblwkU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7
	Lgsox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4G2vA2oULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VrfDEwXkFSPEB7ZUDaeYsLEnOBohCtpxgVpcR5
	00ASAiCJjNI8uLGwlPSKURzoS2HeFSBVPMB0Btf9CmgwE9BgI3YpkMEliQgpqQbGKT/C8urc
	WOZ8Mn3kkCreKDk7pu30yTPzOcPFtRz/tj2dnX2/e6GZPvOUx2vy75zYXfBzouL+pNu84rvd
	X2oFJDGotWUx7FNZcjAtgFt6Klflhurn/6SW3YspK4haKDRn6fujTuliRw72ilXW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279478>

On 10/12/2015 11:51 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Move delete_pseudoref, delete_ref() and delete_refs() to the refs.c
> file since these functions do not contain any backend specific code.
> 
> Based on a patch by Ronnie Sahlberg.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs-be-files.c | 94 ---------------------------------------------------------
>  refs.c          | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 94 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 7fe4931..099df75 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -2877,100 +2877,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  	return 0;
>  }
>  
> -static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
> -{
> -	static struct lock_file lock;
> -	const char *filename;
> -
> -	filename = git_path("%s", pseudoref);
> -
> -	if (old_sha1 && !is_null_sha1(old_sha1)) {
> -		int fd;
> -		unsigned char actual_old_sha1[20];
> -
> -		fd = hold_lock_file_for_update(&lock, filename,
> -					       LOCK_DIE_ON_ERROR);
> -		if (fd < 0)
> -			die_errno(_("Could not open '%s' for writing"), filename);
> -		if (read_ref(pseudoref, actual_old_sha1))
> -			die("could not read ref '%s'", pseudoref);
> -		if (hashcmp(actual_old_sha1, old_sha1)) {
> -			warning("Unexpected sha1 when deleting %s", pseudoref);
> -			rollback_lock_file(&lock);
> -			return -1;
> -		}
> -
> -		unlink(filename);
> -		rollback_lock_file(&lock);
> -	} else {
> -		unlink(filename);
> -	}
> -
> -	return 0;
> -}
> -
> [...]
> diff --git a/refs.c b/refs.c
> index 2d10708..205a899 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -116,3 +116,97 @@ int update_ref(const char *msg, const char *refname,
>  		ref_transaction_free(t);
>  	return 0;
>  }
> +
> +
> +static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
> +{
> +	static struct lock_file lock;
> +	const char *filename;
> +
> +	filename = git_path("%s", pseudoref);
> +
> +	if (old_sha1 && !is_null_sha1(old_sha1)) {
> +		int fd;
> +		unsigned char actual_old_sha1[20];
> +
> +		fd = hold_lock_file_for_update(&lock, filename,
> +					       LOCK_DIE_ON_ERROR);
> +		if (fd < 0)
> +			die_errno(_("Could not open '%s' for writing"), filename);
> +		read_ref(pseudoref, actual_old_sha1);

The same test vanishes here as in the previous patch. The original was

		if (read_ref(pseudoref, actual_old_sha1))
			die("could not read ref '%s'", pseudoref);

> +		if (hashcmp(actual_old_sha1, old_sha1)) {
> +			warning("Unexpected sha1 when deleting %s", pseudoref);
> +			rollback_lock_file(&lock);
> +			return -1;
> +		}
> +
> +		unlink(filename);
> +		rollback_lock_file(&lock);
> +	} else {
> +		unlink(filename);
> +	}
> +
> +	return 0;
> +}
> +
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
