From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv3 2/2] read-tree: migrate to parse-options
Date: Thu, 25 Jun 2009 22:29:20 -0700
Message-ID: <4A445CB0.4010506@gmail.com>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com> <1245993250-8213-1-git-send-email-bebarino@gmail.com> <1245993250-8213-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 07:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK40B-0004d9-99
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 07:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZFZF3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 01:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZFZF3V
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 01:29:21 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:60128 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbZFZF3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 01:29:20 -0400
Received: by pzk40 with SMTP id 40so21720pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 22:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=L4ALiopxYaTZM9ELgYV+zsOy0XQLkmM8oZsvLEMfcJI=;
        b=QkspPY+bFqGVaY4x32kUUCIauoeGPHqduxdQKb63H5P8tM+Zgn/U/dgyLc7GoWzYhb
         kZEhLcov9uGj7UMv+mBsNEtH0GXnslUHbDYVn4MPAYWxc8Bk1xAvWz2DDk+WgQosMPRD
         H6HyTxnun5oQ2X9rvMBM9Dm9qm5qcU+oVoQnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=F4xhuGvOTJDcFZHJACinATHqSxziGl+OOxsXxTfjATG0AqcR1b9HLmT6fogF5NY0LI
         iyL5KMkOvsQi8uSE04rAbI334dGlb1KR5wuBfujvfwHzuyCEpGfF5Xtj/8ZWVbxG49oK
         qx2ONohUfrc7UhX1LITAzcUNTXC1YcM40D8hI=
Received: by 10.114.193.1 with SMTP id q1mr5214368waf.42.1245994164037;
        Thu, 25 Jun 2009 22:29:24 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id v25sm5216646wah.11.2009.06.25.22.29.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 22:29:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1245993250-8213-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122280>

Stephen Boyd wrote:
>  struct unpack_trees_options {
> -	unsigned int reset:1,
> -		     merge:1,
> -		     update:1,
> -		     index_only:1,
> -		     nontrivial_merge:1,
> -		     trivial_merges_only:1,
> -		     verbose_update:1,
> -		     aggressive:1,
> -		     skip_unmerged:1,
> -		     initial_checkout:1,
> -		     diff_index_cached:1,
> -		     gently:1;
> +	unsigned int reset,
> +		     merge,
> +		     update,
> +		     index_only,
> +		     nontrivial_merge,
> +		     trivial_merges_only,
> +		     verbose_update,
> +		     aggressive,
> +		     skip_unmerged,
> +		     initial_checkout,
> +		     diff_index_cached,
> +		     gently;

Sorry I went a little overboard with s/:1// on unpack_tree_options.
You'll probably want to squash this on top.

diff --git a/unpack-trees.h b/unpack-trees.h
index d19df44..f344679 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -21,14 +21,14 @@ struct unpack_trees_options {
                     merge,
                     update,
                     index_only,
-                    nontrivial_merge,
+                    nontrivial_merge:1,
                     trivial_merges_only,
                     verbose_update,
                     aggressive,
-                    skip_unmerged,
-                    initial_checkout,
-                    diff_index_cached,
-                    gently;
+                    skip_unmerged:1,
+                    initial_checkout:1,
+                    diff_index_cached:1,
+                    gently:1;
        const char *prefix;
        int pos;
        struct dir_struct *dir;
