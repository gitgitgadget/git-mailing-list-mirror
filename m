From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Sun, 08 Jun 2008 20:19:43 +0200
Message-ID: <484C22BF.7040700@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031445.23002.jnareb@gmail.com> <48455433.8080500@gmail.com> <200806032224.08714.jnareb@gmail.com> <4845CF9F.10604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 20:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5PVS-0000cp-JY
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbYFHSTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbYFHSTs
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:19:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:42661 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbYFHSTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:19:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1262214fgg.17
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=FQMvyRTxd4lFPH+T3BHARYl7Aa9Pbt4M4+XldFDiFA0=;
        b=DtzpyABfwP/js6yLcnluN18UwpDDwgUbG9SL0YlswYy9CZA+hAz10ANXpBJiZxy6GG
         lr7kmKvif++GbPffuy5PfDLZxZtPRwI/in3Vb+ldqB3I+FQw+8y+OJC4Oz7hHcyPXak3
         VBjYAFSBIm/Fnl0UrwNaZhYlDyN0rnXACVGKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=Yw6ysjJ5nPVioalsOKt1FggaeDXCXgOlu+LcYdijBbdAKtsdpznQeXtzaAdr3b0raI
         CqN0VSUzXIYdNcmh0crlbaG+WNRWz/qKzARqn5IUHdc+ICuJmiltUtjzUtEfRI3xZvxV
         zLmpIDhGBWtO1b/75fnkSX30hZM8ai/XQSfWs=
Received: by 10.86.82.16 with SMTP id f16mr3290054fgb.9.1212949186552;
        Sun, 08 Jun 2008 11:19:46 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.232.240])
        by mx.google.com with ESMTPS id e11sm9655681fga.4.2008.06.08.11.19.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 11:19:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <4845CF9F.10604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84305>

Lea Wiemann wrote:
> Blame first calculates the whole blame and then dumps it out in
> zero-time [so] there's no performance difference in getting all  blame
> output and then dumping it out vs. reading and outputting it line-by-line.

I haven't been following the recent discussion in detail, but here's 
another thought: If you want to look up the parents, it's usually faster 
(at least when caching is enabled) to get them all in a single call. 
IOW, don't look up the parent for each hash as it appears, but collect 
all hashes and then get a list of all parents with a single call.

-- Lea
