From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtin/merge_recursive.c: Add a usage string and make
 use of it.
Date: Sun, 29 Aug 2010 16:46:48 -0500
Message-ID: <20100829214648.GE1890@burratino>
References: <c9d88eb8cbd5b025b0c0112be05d3c0fe993de25.1283103426.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 23:48:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oppjy-0003ZG-2N
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab0H2Vsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 17:48:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47794 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0H2Vsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 17:48:32 -0400
Received: by gxk23 with SMTP id 23so1753705gxk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AUIu67tX/kydWknvmdBVMbczvnOZqTBjyfLgSkuGDx0=;
        b=A6GOg/C3CSE5tlsrYOohpFCrjWtxF/N0xkocmLVdtU5mCLeN7WCQlBtynU6INdhTnI
         49d3RwBqcaf/Q9YZG1HYaDrJ6zSlNwEgyLp1fsxUy9JhYFQWCBnfvfvoTojHTKWWstoC
         8u2ppyVgCsiauGoSXf9u2Z5r0W3xglrzfBfIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pp4IPoazOUCRpuu92/z4JqGPy1AGF6JOFa3DVMAZutpQrXtKKrQPgMRqwSf5SuRcbe
         327jx8KhpPDLe+3q5nemZbl+YuQqDp8RKDNCD9xOmB5qQwXVlHIb9nTXXygjVtczhnl9
         Q2zlDdGb+f98hZ8Tj3rIE2R6HDNZ3isNdsgg8=
Received: by 10.100.112.20 with SMTP id k20mr3592044anc.234.1283118511698;
        Sun, 29 Aug 2010 14:48:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm6620619ibk.3.2010.08.29.14.48.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 14:48:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c9d88eb8cbd5b025b0c0112be05d3c0fe993de25.1283103426.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154722>

Hi Thiago,

Thiago Farina wrote:

> This improves the usage output by adding builtin_merge_recursive_usage string
> that follows the same pattern used by the other builtin commands.
> 
> Also it uses usage() function instead of the usagef() function.

FWIW cmd_merge_recursive is used to handle four different commands.

$ git grep -F -e cmd_merge_recursive
builtin.h:extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
builtin/merge-recursive.c:int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
git.c:          { "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
git.c:          { "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
git.c:          { "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
git.c:          { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },

What will be the output from

 $ git merge-subtree -h

after this change?

> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -37,19 +40,19 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  		if (!prefixcmp(arg, "--")) {
>  			if (!arg[2])
>  				break;
> -			if (!strcmp(arg+2, "ours"))
> +			if (!strcmp(arg + 2, "ours"))

Changes like these, while nice, would make more sense as a separate
patch.

Hope that helps,
Jonathan
