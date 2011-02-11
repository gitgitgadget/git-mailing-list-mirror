From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: grep --no-index and pathspec
Date: Fri, 11 Feb 2011 16:04:43 +0100
Message-ID: <4D55500B.1070603@drmicha.warpmail.net>
References: <20110211095938.360726y1zinab9gk@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Fri Feb 11 16:08:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnubN-0001oa-DV
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 16:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026Ab1BKPHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 10:07:50 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33304 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756787Ab1BKPHt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 10:07:49 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B1B882099E;
	Fri, 11 Feb 2011 10:07:48 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 11 Feb 2011 10:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=eUOTre5n0vM8g++PknNvYFhBdRQ=; b=rCmvUJdvz9XxWnzdZ42E25bI53q5gTBjcotIOIF1/jqxvEoKVLr7ua5LOjZXikW4PGYfG3h/1PXlTgrd/t3jtzpYK1+Gf5by8yvL6LD2OEjO83ZQP+q5eulYDQsFpGTRTiynf+bKocmidu13s/EWmlEAtH+S62A1/SGHW8GKUbI=
X-Sasl-enc: 0G7t+6SdKOanyBjZWVsZU0n4R4KiE+E10a41rzQ4ks+J 1297436868
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 05438401EE8;
	Fri, 11 Feb 2011 10:07:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110211095938.360726y1zinab9gk@webmail.df.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166559>

Lars Noschinski venit, vidit, dixit 11.02.2011 09:59:
> Hi everyone,
> 
> I encountered some strange behaviour with grep when using both the  
> --no-index option and a pathspec. Glob patterns seem to be ignored:
> 
> ----------
> $ git grep -l --no-index . -- '*.bib'
> paper.bib
> paper.tex
> ex1.tex
> ----------
> 
> But on the other hands, leading path matches work:
> ----------
> $ git grep -l --no-index . -- 'paper'
> paper.bib
> paper.tex
> ----------
> 
> Without the --no-index option, everything works fine:
> ----------
> $ git grep -l --no-index . -- '*.bib'
> paper.bib
> ----------
> 
> This is with git version 1.7.4, but I encountered it also with the  
> 1.7.2.3 Debian package.

"grep --no-index" and "grep" have different codepaths for looking up the
files/blobs. If I read that correctly then "grep --no-index -- pathspec"
only does a literal match at the left boundary, whereas for the normal
mode glob patterns are allowed.

CC'ing Junio who created "--no-index".

Michael
