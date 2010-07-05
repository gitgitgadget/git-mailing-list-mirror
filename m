From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] Spurious leading '/' in filename in "git diff --raw --relative=<subdirectory>"
Date: Mon, 5 Jul 2010 17:44:50 +0200
Message-ID: <201007051744.54266.jnareb@gmail.com>
References: <201007051015.26995.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 17:45:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVnr6-0002ti-7y
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 17:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab0GEPpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 11:45:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59499 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab0GEPpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 11:45:01 -0400
Received: by fxm14 with SMTP id 14so3821701fxm.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C11mKQb3nIsmUFCsNbpc8ZDtrinJXgq92fpqs+ZC/QA=;
        b=T3NiduDDlap/08YBoK/dZaYDO9zTXzcSLD02Q6OhK0u0EnId5o4E7cNErRaUXbUhTm
         TDbshFFKL2buNTEvKTlpnXIL9Sd8/mB5LFGXwvt4V1TYRT2Vp45mSTDfbrVNnMRy7Ieq
         si/6H5fuJchscCmT58o+h3iWNn1ARs2s+8YKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qZBXwS+k9gY500MaD96ABGJmVmSmCCXEAlGrTkFKNKOcXcJVRGKdwd1EP/C9WqPTf6
         c4s/IjL6PJk92ku8EmIMyNYVXp9OcQsZySVj39u9Mjvce5UF1dNj/CVPKpbsXzlwnP85
         XmylBbCwCYtwq7flhQx+fD0KwsxGvmC3iaiCw=
Received: by 10.86.79.10 with SMTP id c10mr2239233fgb.26.1278344700075;
        Mon, 05 Jul 2010 08:45:00 -0700 (PDT)
Received: from [192.168.1.15] (abvy158.neoplus.adsl.tpnet.pl [83.8.222.158])
        by mx.google.com with ESMTPS id b14sm9453128fab.19.2010.07.05.08.44.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 08:44:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007051015.26995.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150273>

Jakub Narebski wrote:

> The output without '-r' (recurse into sub-trees) is even more strange
> 
>   $ git diff-tree --abbrev --raw HEAD --relative=sub
>   a3a8425fe5496c61921010cb1e7b455a1f52bb86
>   :040000 040000 e62aa6e... b5d4a43... M	
> 
> (that's a trailing TAB, and no filename).
> 
> What I expected was the following output:
> 
>   $ git diff-tree --abbrev --raw HEAD --relative=sub
>   a3a8425fe5496c61921010cb1e7b455a1f52bb86
>   :040000 040000 e62aa6e... b5d4a43... M	quux

If I change directory to 'sub', and use '--relative', it works
correctly with '-r' (and doesn't show any output without '-r'):

    $ ( cd sub &&  git diff-tree --abbrev -r --raw HEAD --relative )
    a3a8425fe5496c61921010cb1e7b455a1f52bb86
    :100644 100644 d90bda0... cefcae0... M	quux

-- 
Jakub Narebski
Poland
