From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] vcs-svn: use strchr to find RFC822 delimiter
Date: Sat, 19 Mar 2011 04:10:03 -0500
Message-ID: <20110319091003.GE6706@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300518231-20008-10-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 10:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0sAv-00086E-K3
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 10:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab1CSJKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 05:10:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49518 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab1CSJKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 05:10:14 -0400
Received: by iwn34 with SMTP id 34so4792122iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=w8HPXT7gwChGQhqVqXSvln6YseJkrLZB6mZhRX2ASOw=;
        b=aXd1g4X2beHhvUmXP9q4sSxNiEDF0JMy8FwIP+mjgh/I9IePiXDQ+vctIeCCAs80R8
         PAnzrUnzTl44a+ZFrzxTnrNH/yLDn0XZLrp25cLpe8/JUTwh6iTj0gt+5fixVxnuJc2e
         srFSbHNqjZaIzwIRc3iNux7GYbcjm3khk7sXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dz1Go3BrZWu3/041SYlJOg3xImQjYEseN4HO9Yg057gaIMEhejZESTtuj+FMOSDIUc
         3XAAeyJ9WwdAYhTq1ofvKvr7bxUHUwfYgXFsqQGmFg6Zp3YA1uKPub6vYgccR3iXv5lz
         nR8Gq82p/yLN98FEnplrCsG1v5Yd6DBc2yW6U=
Received: by 10.43.54.66 with SMTP id vt2mr3365822icb.111.1300525814039;
        Sat, 19 Mar 2011 02:10:14 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id vr5sm241514icb.0.2011.03.19.02.10.09
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 02:10:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300518231-20008-10-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169420>

David Barr wrote:

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -296,10 +296,12 @@ void svndump_read(const char *url)
>  
>  	reset_dump_ctx(url);
>  	while ((t = buffer_read_line(&input))) {
> -		val = strstr(t, ": ");
> +		val = strchr(t, ':');
>  		if (!val)
>  			continue;
>  		*val++ = '\0';
> +		if (*val != ' ')
> +			continue;

This one and the three preceding it (removing sublibraries)
make sense.  Thanks for a pleasant read.

Good night,
Jonathan
