From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP
 files.
Date: Mon, 30 Aug 2010 11:33:02 -0500
Message-ID: <20100830163302.GA13336@burratino>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
 <4C7B8E1E.6050708@drmicha.warpmail.net>
 <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
 <20100830141602.GF2315@burratino>
 <AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7Jw-0002lP-1k
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0H3Qeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 12:34:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41320 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862Ab0H3Qet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 12:34:49 -0400
Received: by qyk33 with SMTP id 33so5304432qyk.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JwfCRhRg6DorfdDdr2/XT0wIpQ+20j7WK39ocXuGBcY=;
        b=xmyGI2gkALfOtEtD14+ol+vN85zPwXQclZho8DM9lHNtQTisswjLRP/pD4rwOGWJZR
         EFOwx6u//5OcJ51/wy/luXECuOsFVJHtynW6vMYmkNs17H7Y5oT+Sh96EoJ/fNHlSvE1
         DXA0Gx/9qWZ3M+ZI95YZ+vjZuVlHzLRLjGz7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I6eDGSocMycdInA+wekD3U/nDLjBitxGajoL/xi5Onzde0HZWR+LGSKlM6h3FmkKYT
         ILQNBB1TV0MB1h2JK3oAx1BAAmw2O8Mfq7DfXoLXoQWomClfQbkbfMb/qDYAXlEQY4Io
         n+IRZ18hvuiEZUDAdtMdlydLuArF/uevCIYI0=
Received: by 10.229.80.15 with SMTP id r15mr3272692qck.95.1283186088981;
        Mon, 30 Aug 2010 09:34:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm8499547qcq.46.2010.08.30.09.34.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 09:34:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154830>

Chris Patti wrote:

> What if this is the
> first time a new ref is being pushed?  Then, old-ref is 000000 and git
> diff --raw throws up a hairball :)

Can't you check for 0{40} and use $(git hash-object -t tree </dev/null)
in its place?

In general, the "LOW-LEVEL COMMANDS (PLUMBING)" listed on the git man
page are meant to be useful for scripts.  They have simple input and
output formats, they don't try to introduce weird exceptions for user
convenience, the git developers are more conservative about changing
them, and so on.
