X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] hooks/pre-commit: add example to add Signed-off-by line to message
Date: Wed, 20 Dec 2006 15:54:51 +0000
Message-ID: <200612201554.52553.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 15:55:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tOfoe1ZYv9lFW+RP//ae1OEz/o8RWZn3/7vOxVBRZCeVHyS3HioTrGSLXNVjvYsYvAF9Sqh7kstNSbm9GAZjE7rhLiEzEkdzEaA6NEQNu2JjELOA30fALTl3QqqdXRW6BMV7/aCjtQJwfzbIr9BZ8FVvhzt2CCFNmdeR8/tzqfM=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34941>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx3mY-0003sy-Bn for gcvg-git@gmane.org; Wed, 20 Dec
 2006 16:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754813AbWLTPy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbWLTPy7
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 10:54:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:16240 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1754813AbWLTPy6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 10:54:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2271767uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 07:54:57 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr9557829ugi.1166630096488; Wed, 20
 Dec 2006 07:54:56 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm12745654ugn.2006.12.20.07.54.55; Wed, 20 Dec 2006 07:54:55 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 29 11:20, Johannes Schindelin wrote:

> +# . git-sh-setup
> +# git var GIT_AUTHOR_IDENT | \
> +# sed -n "s/^\(.*\) [0-9]\+ [-+][0-9]\+$/Signed-off-by: \1/p" \
> +# > $GIT_DIR/SQUASH_MSG

I've been using this; and very useful it is too.  However, I just noticed that 
I was getting "Not a git repository" errors when I tried to commit in a 
subdirectory.  I traced the problem to my use of this fragment.  It seems 
that calling git-sh-setup inside the pre-commit hook was changing GIT_DIR 
(don't know why).  When I changed this to

git var GIT_AUTHOR_IDENT | \
sed -n "s/^\(.*\) [0-9]\+ [-+][0-9]\+$/Signed-off-by: \1/p" \
 >> $(git-rev-parse --git-dir)/SQUASH_MSG

It worked correctly again.


Andy


-- 
Dr Andy Parkins, M Eng (hons), MIEE
