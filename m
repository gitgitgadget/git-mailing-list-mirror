From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] vcs-svn: Start working on the dumpfile producer
Date: Sat, 15 Jan 2011 13:41:30 +0530
Message-ID: <20110115081128.GB9277@kytes>
References: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
 <1295074272-19559-3-git-send-email-artagnon@gmail.com>
 <20110115073925.GA21744@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 15 09:11:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe1Dv-0007Q9-LX
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 09:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab1AOIKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 03:10:51 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51133 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab1AOIKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 03:10:43 -0500
Received: by iwn9 with SMTP id 9so3236407iwn.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 00:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cF3F1ibNv9prIYltKZ6C8l8av2FbDmbVAoxqluerk3c=;
        b=kWqY9hcDYOoSUBmQfRrZqn6fK/IXlwZnvysr7lVCz8GmTDIcvan3AIfmePi6q28ILt
         /lXh0y1H3o8juXTF291FyjJAdVzJ/dm/fTQ+aEVQJDdoPGzg9/eEJHbMKkrJDI6RtAMO
         /lMPaGaKcakUHNPW0jyynBDq5A/ndqkSjMKdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=noCkDKZNZNcmZu0geFv8oVgagqT23IfgkZcNYPpwwo3zt+PTyHVPqrGz3JjhrYToFg
         FzVNwuiiblJP+W/OEyRLLdOsxg8V2MiINBaPGGTrHRi7UUO+nKbYLAsIKnwTvYP8jBs2
         gwiHIF1Ay7bQzMOl+CiUm+25afoJZMJCnejwM=
Received: by 10.42.170.199 with SMTP id g7mr1899050icz.149.1295079042934;
        Sat, 15 Jan 2011 00:10:42 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i16sm1720526ibl.0.2011.01.15.00.10.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 00:10:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110115073925.GA21744@m62s10.vlinux.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165144>

Hi Peter,

Peter Baumann writes:
> > +	while ((t = buffer_read_line(&input))) {
> > +		val = strchr(t, ' ');
> > +		if (!val) {
> > +			if (!memcmp(t, "blob", 4))
> > +				active_ctx = BLOB_CTX;
> > +			else if (!memcmp(t, "deleteall", 9))
> > +				;
> > +			continue;
> 
> Having actually no idea what the input you are reading from might look like, but
> seeing those two memcmp compares above makes me wonder if 't' might ever be smaller
> than 4 (or 9 for the else part). Which obviously would lead to a SEGFAULT. 
> In the code below there are also memcmp class which might step out of the
> buffer.

Right. Silly mistake on my part. Thanks for pointing it out.

There are probably many more trivial mistakes- I was in a hurry to get
/something/ working, and didn't have a chance to clean up the code.

-- Ram
