X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Loeffler <miloeffler@googlemail.com>
Subject: Re: [PATCH 3/3] git-fetch: allow glob pattern in refspec
Date: Mon, 27 Nov 2006 19:14:21 +0100
Message-ID: <1164651262.13153.31.camel@ibook.zvpunry.de>
References: <7vzmaik4mi.fsf@assigned-by-dhcp.cox.net>
Reply-To: miloeffler@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 18:14:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:subject:from:reply-to:to:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=h5k/+YYxdLC0vdrGPZG+FE6ZiqaBZYnmtIi+uOjR2dPzV0YUS0VCKKTWY3zqBJy9dfIzHafg4K6GaS+UgtPRVSEvjewtOsVtez2kp2J80vLSNwjDf1fQ5P30Ofs2LCOMFhmABCa7wIfnVCW84/7GycXM4hAJm9THvBSqfnMP6f8=
In-Reply-To: <7vzmaik4mi.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32435>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gokzu-0005YI-Qq for gcvg-git@gmane.org; Mon, 27 Nov
 2006 19:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758502AbWK0SO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758504AbWK0SO1
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 13:14:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:5312 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758502AbWK0SO1
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 13:14:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1221343uga for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 10:14:25 -0800 (PST)
Received: by 10.67.19.20 with SMTP id w20mr12927285ugi.1164651265457; Mon, 27
 Nov 2006 10:14:25 -0800 (PST)
Received: from ?192.168.17.101? ( [217.224.101.164]) by mx.google.com with
 ESMTP id m1sm18158230ugc.2006.11.27.10.14.24; Mon, 27 Nov 2006 10:14:25 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

hi,

Am Mittwoch, den 22.11.2006, 23:24 -0800 schrieb Junio C Hamano: 
> This adds Andy's refspec glob.  You can have a single line:
> 
> 	Pull: refs/heads/*:refs/remotes/origin/*
How about using extended regex for this, something like this:
Pull: refs/heads/master:refs/remotes/origin/master
Pull: refs/tags/v(.*):refs/tags/origin/v\1

... 
> +expand_refs_wildcard () {
> +	for ref
> +	do
...
How about using something like:
echo "$ls_remote_result" | sed -n -r -e "s:$ref: p"

Using $ref as a part of the sed expression is not a good idea (.* should
not match past the ':'), but something like this maybe. What do you
think?

bye
