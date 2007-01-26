From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Fri, 26 Jan 2007 11:54:19 +0000
Message-ID: <200701261154.20723.andyparkins@gmail.com>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl> <20070125230302.GB13677@moooo.ath.cx> <7vr6ti659k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 12:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPf4-0006O1-D8
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbXAZLy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 06:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965320AbXAZLy0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:54:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:33724 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965273AbXAZLyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:54:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so697017uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 03:54:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=io2G3YsX3aixf0F/eMjFE1pVFOgv0uLMMm1e80LQOLrVEoLzUgoChie6T8dDC8lTBOgVnlc32PGQsJo0rfm4ylJE/nfCDtQP6rlEHC0A6j0WrilPPktsg1jsJpbxwImsejM4ViJe7uSIgnzmT6lGvphNVdtX2BWU8QR1X6z5PDs=
Received: by 10.66.244.11 with SMTP id r11mr4207279ugh.1169812463538;
        Fri, 26 Jan 2007 03:54:23 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id 53sm4259261ugn.2007.01.26.03.54.22;
        Fri, 26 Jan 2007 03:54:23 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vr6ti659k.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37846>

On Thursday 2007 January 25 23:44, Junio C Hamano wrote:

> I do agree the original patch conflates many different things,
> and it would be nicer to do this clean-up as separate pieces.

FYI:

As you know I've got some patches that fix use of literal numbers for the hash 
sizes instead of SOME_CONSTANT.  I've further got one that does the same for 
the literal uses of "refs/" et al.  I'm holding off on these until after 1.5 
so as to minimise big changes.

> * The official name of these 40-hexdigit thingy we use to name
>   objects is "object name" (see Documentation/glossary.txt).

As a further to the above cleanups, I'm also planning to fix all the sha1 
named variables to be "hash" or "object" or something.  It strikes me that 
this plan is related to this cleanup and might fix some of the issues like:

> +       "git-read-tree (<sha> | "
> +       "[[-m [--aggressive] | --reset | --prefix=<prefix>] "
> +       "[-u | -i]] [--exclude-per-directory=<gitignore>] "
> +       "<sha1> [<sha2> [<sha3>]])";

The reasons for wanting this are, I hope, obvious.  The variables (and 
parameters) accept object-names not SHA-1 hashes.   The fact that the objects 
are named after a SHA-1 isn't relevant to users; and shouldn't be relevant 
for the variable names, simply to promote abstraction from what the actual 
hash function is.

I mention it here because it seems to fit with this cleanup theme.  Am I still 
correct that you would want this sort of thing post-1.5?  Is it even a 
reasonable goal to have?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
