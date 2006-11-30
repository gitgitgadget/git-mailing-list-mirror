X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 20:32:23 +0700
Message-ID: <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com>
References: <ekmlar$ask$2@sea.gmane.org>
	 <200611301324.04993.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:33:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sSCb62rg0EkNCrl/ni23Oh0j/wr2NE4lGMT4PNsER6pxs1QHTlHS1+DMiG/qnnI7fxzS4CGz+IJwulEfsDBtKYS4kLK38ixyKTxOYCu0devx5TEXrPWvID6PHfNhonjdkv79geJJNof2UfOuCBd8PvAR6VMEQfVGfHvnDhlM14A=
In-Reply-To: <200611301324.04993.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32743>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpm1g-0004B1-BG for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936233AbWK3Nc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936359AbWK3Nc2
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:32:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:171 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936233AbWK3Nc1
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:32:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2110897uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 05:32:26 -0800 (PST)
Received: by 10.78.149.13 with SMTP id w13mr3507660hud.1164893543965; Thu, 30
 Nov 2006 05:32:23 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 30 Nov 2006 05:32:23 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

> diff --git a/git-commit.sh b/git-commit.sh
> index 81c3a0c..fabfeae 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -265,6 +265,14 @@ $1"
>  done
>  case "$edit_flag" in t) no_edit= ;; esac
>
> +# Clever commit - if this commit would do nothing, then make it an "all"
> +# commit
> +if [ -z "$(git-diff-index --cached --name-only HEAD)" \
> +       -a -z "$amend" -a -z "$only" -a -z "$also" ]; then
> +       echo "Nothing to commit but changes in working tree. Assuming 'git commit -a'"

This is hardly seen as the editor will immediately pop up. Better
pause a second or put it in commit template (I'd prefer the latter).

> +       all=t
> +fi
> +
>  ################################################################
>  # Sanity check options
>
> --
> 1.4.4.1.g3ece-dirty
-- 
