From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 29/30] create_dir_entry(): allow the flag value to be passed as an argument
Date: Wed, 25 Apr 2012 11:31:45 -0700
Message-ID: <xmqqfwbrd5ny.fsf@junio.mtv.corp.google.com>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
	<1335307536-26914-30-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 25 20:31:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN70O-0006aD-CU
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 20:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab2DYSbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 14:31:48 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:51889 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab2DYSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 14:31:47 -0400
Received: by qcsp5 with SMTP id p5so50870qcs.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 11:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=gp9o+1u9IDweoHDqa0bWtwDTsBOXKQQSjxlu+pNF7rM=;
        b=fEC2aSBVnjYwyvEYnNoO/XJfvkZanrbx3OKvIPt79H2Ln9r1QWH0GAC86qkZgo5xjh
         SNL8siiUnmj/mMvOe1Mnr5obVlnWZ9hKRd5J9+u30b+5fT8abwBHQpcOd26KdJc5EBiR
         SYqlaR10S4FJTTWg6x3BQt+7U9Qsg67EeXS4e7IX9vgF++5F/eTJ34R8TZr7/3kJsMSN
         mandcGRLrBIYEYxyixT6vdVBO2LT3U7NozDPkfblVSJmZsZlIJ/S0Xm3aq8PHP9esabl
         9PKEvKTTvJ3Y3afJVyhXqBcYjFVdkq//UWUyxEQ28zaQ000JBXAXfEdeGQLfDLhU702N
         wbBg==
Received: by 10.236.125.170 with SMTP id z30mr4445470yhh.4.1335378706781;
        Wed, 25 Apr 2012 11:31:46 -0700 (PDT)
Received: by 10.236.125.170 with SMTP id z30mr4445441yhh.4.1335378706614;
        Wed, 25 Apr 2012 11:31:46 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id b69si453832yhe.0.2012.04.25.11.31.46
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 11:31:46 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 7F7961E004D;
	Wed, 25 Apr 2012 11:31:46 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 12A59E125C; Wed, 25 Apr 2012 11:31:45 -0700 (PDT)
In-Reply-To: <1335307536-26914-30-git-send-email-mhagger@alum.mit.edu>
	(mhagger@alum.mit.edu's message of "Wed, 25 Apr 2012 00:45:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn8czDBlBqesPqD/cS51OBaDPohJ5BLqDoVRr4B4Zpi7a5TNMKcQRUndrnbQGcHuvHHAX+y3+TAgrLV0aU44oDENFGbR4iRMjoyM0XPdQavVXvB3bH9jcKP7BzSt6pmIz0Y/E/E+mxG4/uqS52fTUvVZTY168uJ3J0LdWICJnQkEHvww4E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196328>

mhagger@alum.mit.edu writes:

> diff --git a/refs.c b/refs.c
> index 4eca965..869c9a7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -231,18 +231,18 @@ static void clear_ref_dir(struct ref_dir *dir)
>  }
>  
>  /*
> + * Create a struct ref_entry object for the specified dirname and flag.
>   * dirname is the name of the directory with a trailing slash (e.g.,
>   * "refs/heads/") or "" for the top-level directory.
>   */
>  static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
> -					  const char *dirname)
> +					  const char *dirname, int flag)
>  {
>  	struct ref_entry *direntry;
>  	int len = strlen(dirname);
>  	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
>  	memcpy(direntry->name, dirname, len + 1);
> -	direntry->flag = REF_DIR;
> +	direntry->flag = flag;
>  	direntry->u.subdir.ref_cache = ref_cache;

As the returned structure will always represent a subdirectory and not a
leaf node, i.e. you use u.subdir, I do not think it makes any sense to
make it responsibility for the caller of this function to include
REF_DIR in the value of the flag.

Also shouldn't flag be of type "unsigned", not "int"?
