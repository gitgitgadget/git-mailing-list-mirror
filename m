From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 12:46:39 +0100
Message-ID: <201001251246.40237.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <f4660e9c7ffdb4a62da0c56703de002c9df3b598.1264198194.git.jnareb@gmail.com> <20100124222417.GC9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZNP9-0001JX-1w
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab0AYLqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 06:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128Ab0AYLqq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:46:46 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49823 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab0AYLqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 06:46:46 -0500
Received: by bwz19 with SMTP id 19so2617713bwz.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RIhye9s7ko9cvZ3DNSPUrKeFQE0laSJd/GXmBfgMfMA=;
        b=m/5NADdETE8XU0H0+MpMWq6zY98QnSJT/lSBWW5U3yZDRa4FBDDJn34GJBmD2mZbkl
         bW+orrs/Mr9awX51yeo61FdlffEtg9y4j91oqtesigJGyN9iNViz8fCd9jLbhblVR6jY
         /HmDqIcsifs63B5Mn1zzmg93ctlahcxNRoJlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tjwOVPS/rsZ4AjjpXAngD7ZgktBY0hLMUdpvGP8aLUfFitVr32sBtxI5DIakxywA5z
         N0G2dW7h9CANa9E1KalSyDKxJ0X2KJ7owECizA0ro42Fobbwg+PMpVCAQb0Fflu+5uy4
         y7RVfPMJswhUAMAXQwJGxNBtrEpPWBt19mnIw=
Received: by 10.204.32.72 with SMTP id b8mr468967bkd.203.1264420004428;
        Mon, 25 Jan 2010 03:46:44 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id 15sm2095912bwz.4.2010.01.25.03.46.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 03:46:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100124222417.GC9553@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137955>

On Sun, 24 Jan 2010, Petr Baudis wrote:
>   I have stupid question, common to both the original patch and this
> RFC.
> 
> > [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
> > regenerating cache (WIP)
> 
>   Just why is a "Generating..." page appropriate?
> 
>   I have to admit I hate it; can you please at least make it
> configurable? Why is it needed at all? It [...] confuses
> non-interactive HTTP clients [...]

First, if I understand the code correctly HTTP clients which do not 
honor metaredirect (http-equiv refresh) would get page which looks
the following

  <html>
  Generating...
  </html>
  <html>
  Gitweb page
  </html>


Second, gitweb can always check User-Agent header, and serve 
"Generating..." page only to web browsers:

  unless (defined $cgi->user_agent() &&
          $cgi->user_agent() =~ /\b(Mozilla|Opera)\b/i) {
  	return;
  }

or something like that.

-- 
Jakub Narebski
Poland
