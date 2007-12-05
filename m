From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Wed, 5 Dec 2007 22:39:08 +0700
Message-ID: <fcaeb9bf0712050739m6524b059of09b0ca741acb6f7@mail.gmail.com>
References: <20071128165837.GA5903@laptop> <20071205132514.GA5580@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwLX-0000PF-K8
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXLEPjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 10:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbXLEPjO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:39:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:52159 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbXLEPjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:39:13 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3162099nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5QI38mzyIjGosbvnI/NEW0iHDrnOO15vqh2hes/pKtk=;
        b=t3cfQMMatvx2WdFKFLmW7NGf/hTEEQFln53+J5C6cVyhw40oI5r70COa5ovo0wt9SUqkRFr1KywyOv2UCd+OS+WgKDh70RVbNvRU1B6VkTSnlYRzJuVTD6XkXrfPtCIp7PbBY0pDllBM4nfiQ0XcF97wOoUVoKVmoeEWlieyKUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mVc+MmjIZMMQFy+GjujXoQoFw2So/pdthlhhl8yLBKnE58VEbJeXG47koHK5FOFiquQIdq7pVXVfANWzmrS/WDM7t73sF2Z2MLAjxjoJGXugJuOcSQAOTTbIDO/NrlPXBofGf6qNV7vHm+EggAPfS8UhLltpvrx1JxFbXGaQ+oI=
Received: by 10.86.82.16 with SMTP id f16mr575634fgb.1196869148396;
        Wed, 05 Dec 2007 07:39:08 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 5 Dec 2007 07:39:08 -0800 (PST)
In-Reply-To: <20071205132514.GA5580@laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67161>

On Dec 5, 2007 8:33 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> @@ -287,6 +310,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                         if (!work_tree_env)
>                                 inside_work_tree = 0;
>                         setenv(GIT_DIR_ENVIRONMENT, ".", 1);
> +                       if (check_repository_format_gently(nongit_ok))
> +                               return NULL;
>                         return NULL;
>                 }
>                 chdir("..");

This part better be as follow (patch may be damaged as I'm editing it in gmail)

 @@ -287,6 +310,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
                         if (!work_tree_env)
                                 inside_work_tree = 0;
                         setenv(GIT_DIR_ENVIRONMENT, ".", 1);
 +                       check_repository_format_gently(nongit_ok);
                         return NULL;
                 }
                 chdir("..");
-- 
Duy
