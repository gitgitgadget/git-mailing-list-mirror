From: David Turner <dturner@twopensource.com>
Subject: Re: [RFC PATCH] lmdb: restrict the visibility of some symbols
Date: Mon, 22 Feb 2016 15:56:48 -0500
Organization: Twitter
Message-ID: <1456174608.7528.99.camel@twopensource.com>
References: <56CB3A48.2070904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 21:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXxXN-0008MT-2s
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 21:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbcBVU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 15:56:53 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34778 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbcBVU4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 15:56:51 -0500
Received: by mail-qg0-f46.google.com with SMTP id b67so121585822qgb.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=Pj26Z7wLg1CMH+mXUhfe4q1nJeM7MoNyN6sGC045SgM=;
        b=UvcHla/MBgNNCpOjz7N5wErSBtNJPHwuhoAQIvu8sAvhlA7Q0QU3oWIm8dWlT6nkrD
         +qlYDF5oaYS7+GbQW7uDfoSCDd8pqmQ73q8e41n5qP031TttSeBGY2gaUY7Kdm92lWPj
         mXSW0e3Fw1zQTrOMEcX579rIHfKDOdr3veOmslcpzD/DiCnrlssHL1DLm2Fr9hiNCvKm
         0oFy81emk/6NEdgrIH1OWMh2aKjyabz90gUofIfC+NLTuMYHBt2Rw5adTC3oyIyfQykO
         ZSNE3rrbAMeAlfdxnMeQuXNXAF+L3Fg+eRBGWSI6SA+7MQkYaVC8IufrY2haXgvdUhQ7
         2cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Pj26Z7wLg1CMH+mXUhfe4q1nJeM7MoNyN6sGC045SgM=;
        b=UY0mwhTmx6VuUEo9/BIzVXMcwXADIlwtpI0DWpW4fjKQC8p+lLlU+fL5rqkfZHOqCs
         xP753l7fDdE8nhZgRIPDDgNRWUuZEWNgQ4ZH1anxG4yv9M1P6NWvzJdx0lRZ89hnn/BV
         Pxl7qa1vub+iaqNsgvLHm6djv4aiL7KCFAZamEtJv7vWGilEKoXstEcUXctavMhvVL/7
         IAkOyGdBvZR+LFSKkjV0RblbFWUA+Rmn9T6aiym8FpC8HE3bmJAPg8W15qEa9EC6F5IS
         JzVUNQPgTMYG/eVPSA4OD1j9i0qITmbEAzKPndaqHm6ObHTS4xcFoz9yny8gkABWczRL
         +ErQ==
X-Gm-Message-State: AG10YORRCXs2QWVzOSNiufVQHEU/QuDWgEscRHAaznT/MoifmLa3HArypaE/I6XSpuzfsA==
X-Received: by 10.140.232.15 with SMTP id d15mr39916240qhc.87.1456174610360;
        Mon, 22 Feb 2016 12:56:50 -0800 (PST)
Received: from ubuntu ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id a129sm11028236qkb.45.2016.02.22.12.56.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 12:56:49 -0800 (PST)
In-Reply-To: <56CB3A48.2070904@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286949>

Instead of directly applying this patch, I rearranged the code a bit,
but hopefully now have reduced the non-static surface area.  Thanks for
the suggestions.

On Mon, 2016-02-22 at 16:41 +0000, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi David,
> 
> If you need to re-roll your 'dt/refs-backend-lmdb' branch, please
> consider squashing something like this into the relevant patches.
> Note that I marked this as RFC, because I haven't got lmdb
> installed, so I can't actually test it! ;-)
> 
> So, I've just eyeballed it and, hopefully, it will actually work.
> 
> Let me know.
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  refs.c                   | 2 +-
>  refs.h                   | 5 ----- 
>  refs/refs-internal.h     | 3 +++
>  test-refs-lmdb-backend.c | 5 +++--
>  4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 56960b5..337f110 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -22,7 +22,7 @@ static struct ref_storage_be *refs_backends = NULL;
>  
>  const char *ref_storage_backend = "files";
>  
> -void register_ref_storage_backend(struct ref_storage_be *be)
> +static void register_ref_storage_backend(struct ref_storage_be *be)
>  {
>  	be->next = refs_backends;
>  	refs_backends = be;
> diff --git a/refs.h b/refs.h
> index ad6d097..9cc3a37 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -515,9 +515,6 @@ extern int reflog_expire(const char *refname,
> const unsigned char *sha1,
>   */
>  int ref_storage_backend_config(const char *var, const char *value,
> void *ptr);
>  
> -struct ref_storage_be;
> -
> -extern struct ref_storage_be refs_be_lmdb;
>  /*
>   * Switch to an alternate ref storage backend.
>   */
> @@ -525,8 +522,6 @@ int set_ref_storage_backend(const char *name);
>  
>  int ref_storage_backend_exists(const char *name);
>  
> -void register_ref_storage_backend(struct ref_storage_be *be);
> -
>  void register_ref_storage_backends(void);
>  
>  #endif /* REFS_H */
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 0337d2e..ced6af4 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -308,5 +308,8 @@ struct ref_storage_be {
>  };
>  
>  extern struct ref_storage_be refs_be_files;
> +#ifdef USE_LIBLMDB
> +extern struct ref_storage_be refs_be_lmdb;
> +#endif
>  
>  #endif /* REFS_REFS_INTERNAL_H */
> diff --git a/test-refs-lmdb-backend.c b/test-refs-lmdb-backend.c
> index 5cf61e6..9703e5a 100644
> --- a/test-refs-lmdb-backend.c
> +++ b/test-refs-lmdb-backend.c
> @@ -43,8 +43,9 @@ int main(int argc, const char **argv)
>  
>  	git_config(git_default_config, NULL);
>  
> -	register_ref_storage_backend(&refs_be_lmdb);
> -	set_ref_storage_backend("lmdb");
> +	register_ref_storage_backends();
> +	if (!set_ref_storage_backend("lmdb"))
> +		die("could not set lmdb reference backend");
>  
>  	if (clear_reflog) {
>  		test_refdb_raw_delete_reflog(argv[0]);
