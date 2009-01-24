From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate() 
	instead of unsigned
Date: Sat, 24 Jan 2009 11:13:18 -0500
Message-ID: <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
	 <alpine.DEB.1.00.0901240726070.13232@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 17:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQl9x-0005d6-JR
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 17:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZAXQNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 11:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbZAXQNV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 11:13:21 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:10012 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbZAXQNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 11:13:20 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1753639fkf.5
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 08:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z8kVNaiV4Cx2B+ui200QYAMOEyn7BMuVJodsJzDwe7Y=;
        b=nCneYrXT6RhAF9tMGv/y8b3roUkLwrYM7D1pzzGhVwXOpeHQkB3uqXSFSlXCvRBf64
         eVtPyFBgVsEd/0xgxWYn7RFoZvoViAEdnPM3aUAjiYfOKjZHvIQSBSCkJbUVd3UzvzvC
         Xx0e/f6sWGqjLVjiUALMImCnwe9nTdwkZ+kPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LaRY6iFiFpmqTqoVaFzRgrAJuFwsABOLF0sz1FTII5ylzhySVVgV8DF/bCPeyLOnS8
         L9QUcxgXPajB8yqw+6AfIi7e3dJ1d0xE9rVqpAIf4LV/jvSQtzpIubQXc6cnW5cG/Xr9
         bcUoiAcVFaHsTjIin+bEu82rjT9uWiaAApa+Y=
Received: by 10.103.90.17 with SMTP id s17mr993072mul.73.1232813598381; Sat, 
	24 Jan 2009 08:13:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901240726070.13232@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106973>

On Sat, Jan 24, 2009 at 1:27 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 22 Jan 2009, Tim Henigan wrote:
>
> > Use time_t for timestamps returned by approxidate() instead of unsigned
> > long.  All references to approxidate were checked as well as references
> > to OPT_DATE.
>
> Hmm.  I vaguely remember Linus mentioning recently that unsigned long is
> the appropriate data type for the Unix Epoch...

You are correct. I just found a post on this list where Linus
specifically rejected a similar patch from another contributor.  A
quote from https://kerneltrap.org/mailarchive/git/2008/11/6/4014124:

    " "time_t" is one of those totally broken unix types. The
standards say that
    it's an "arithmetic" type, but leaves it open to be just about anything.
    Traditionally, it's a signed integer (bad), and in theory it could even be
    a floating point value, I think.

    And in _all_ such cases, it's actually better to cast it to "unsigned
    long" than keep time in a system-dependent format that is most likely
    either _already_ "unsigned long", or alternatively broken."

Should I update the GitWiki page to remove this Janitor task or do you
keep it as a test to see if people are properly searching the mail
archives?

Sorry to waste your time on the patch review.

Thanks,
Tim
