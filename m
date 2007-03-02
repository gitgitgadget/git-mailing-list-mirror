From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 15:22:43 +0000
Message-ID: <200703021522.44592.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <200703021005.13620.andyparkins@gmail.com> <es9d7l$egh$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 16:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9ax-0001jg-BV
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbXCBPWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbXCBPWw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:22:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:49925 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965389AbXCBPWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:22:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1319154nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 07:22:50 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XRB6D6Ean72lsiGI4mXfaefE2yGPeFGGo9khDDcjr6zU7hQarZ+4KLBrPonjdsRUsUbopQVirlr3OqQbqY7BCvfPaKl56397nitCErWD4loeoa0mavrTNEUBPmW70w8smF14wg7/FBHDiW78yK79rjX+AFDmz17CH+/b41SW2RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fBYVbozW+A2i6nPHFnF24AkA4X1Fa4dcuE9+gArCYouLaoxs13eWBX9bXGHbL5J/TMU/cRMo/y1yD3LHo6RjL13tedsSHH/4cQ4C/vLqLCpGqxs3ZLg1PDb37kVc4V6KzC3BzueYjIgInyjp4dg/raPcRZZh5B2eZdmpJC6z4zM=
Received: by 10.48.210.20 with SMTP id i20mr7948533nfg.1172848970050;
        Fri, 02 Mar 2007 07:22:50 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id y23sm12534489nfb.2007.03.02.07.22.47;
        Fri, 02 Mar 2007 07:22:48 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <es9d7l$egh$2@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41216>

On Friday 2007 March 02 14:46, Jakub Narebski wrote:

> What about this (that is roughtly what git and Linux kernel use):
>  * Tag a release
>  * Issue "make dist" which would automatically replace @@STH_VERSION@@
>    (or ++STH_VERSION++ for example in Perl files) with result of
>    "git describe" (although I think that plain old "make" also does this)
>    _and_ create proper STH_VERSION file
>  * tar it up using "git archive --format=tar" which would add version
>    as a tar comment
>  * Release

Yep; you've improved the workflow for my example.  However, it's not quite the 
same because in git the tokens in the ".perl" files are substituted into 
files without the suffix.  This means that those files aren't the real source 
files.  You can't put that token in the source files themselves because that 
would change their content and would then show up to git as changes.

Therefore git itself has to be involved with the keyword substitution, because 
you want it to be blind to that substitution when it's checking for changes.

Of course that's all predicated on you actually wanting keywords.  For people 
that don't want them, I can see why the point is moot.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
