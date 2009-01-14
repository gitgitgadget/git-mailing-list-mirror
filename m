From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes? (a solution)
Date: Wed, 14 Jan 2009 14:55:20 +0100
Message-ID: <200901141455.23935.jnareb@gmail.com>
References: <200901120246.28364.jnareb@gmail.com> <20090112122337.GA7262@glandium.org> <200901130043.04772.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Asheesh Laroia <asheesh@asheesh.org>,
	Luciano Rocha <luciano@eurotux.com>,
	"J.H." <warthog19@eaglescrag.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN6F1-0005El-2a
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbZANNzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756132AbZANNzn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:55:43 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:50049 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbZANNzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:55:41 -0500
Received: by ewy10 with SMTP id 10so659659ewy.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ieQezI21ORlmxUB/0UH5JXE9ovIhceR9phSA+VVm32M=;
        b=Co19Sq46TZqz/c6Gt+esGirOk7oVYtG2kv/1U933IEvtS2x8SNq2Pzfzs1cb84dAhQ
         iYysMY7EjNmORP2xYS0W0cjmMbI5mjktUVZHrT3XFTMInuaYOMhsufqTrd9jBeX9d9/U
         DeyjkIDSa+GQMpIVwyyZ4+U1+ZeqmjSPd3XQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JhU9Y7w6DywFKEsqOt1eJM/OgLtxbCV6ULb+ZTEjplbtsi7WhDIe6qGocl1ZgzKXqL
         ate4Hgo/2SPwAtzx2r+FZjM0CDc4M36R1o3kPBaLwHFXSDQ4m8mneZ5PKL2DmNgX9pJr
         00iQfQLYJipCta7HtQE5unSqBX9Y+/Dayl0Gg=
Received: by 10.210.59.14 with SMTP id h14mr146102eba.81.1231941339405;
        Wed, 14 Jan 2009 05:55:39 -0800 (PST)
Received: from ?192.168.1.11? (abwf55.neoplus.adsl.tpnet.pl [83.8.229.55])
        by mx.google.com with ESMTPS id 7sm6035897eyb.51.2009.01.14.05.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 05:55:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200901130043.04772.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105630>

Jakub Narebski wrote:

> The ISP I use (Telekomunikacja Polska S.A., aka TP) made some
> unannounced changes for ADSL service (Neostrada) which made it block
> repo.or.cz (and of course its aliases, including git.or.cz where git
> wiki resides).

Thank you all for your help with arriving at solution. I'll describe it 
below; perhaps it would help somebody else (now that it is in mailing 
list archive).


First, let me explain what I am working with:

I have access to shell account with set up SSH key access; let's name 
this machine host.example.com. I don't have admin rights there, and 
quota is quite tight; I have installed netcat (nc) in ~/bin - it is 
only 22 kB.

I don't know where to find SOCKS5 proxy, and I don't have 'tsocks'
installed either on my computer, or on shell account... I think.


Now, solutions:

1. For reading gitweb at repo.or.cz, and for reading and editing git 
   wiki at http://git.or.cz/gitwiki/ I use one of free HTTP proxies:
   http://www.4proxy.de (first such proxy I have found that has an
   option to _not_ obfuscate URLs; it still unnecessary escapes some
   things like '/' in the query argument).

2. For pushing changes to repo.or.cz I use SSH tunnel (I could have
   used ProxyCommand solution with netcat instead[1]). I run:

   $ autossh -M 2000 -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com

   at startup, and I have set the following in ~/.ssh/config:

   # TP S.A. blocks repo.or.cz
   Host repo.or.cz
   	#ssh -f -N -L 2222:repo.or.cz:22 host.example.com
   	NoHostAuthenticationForLocalhost yes
   	HostName localhost
   	Port 2222

   [1] Alternate solution:

   # TP S.A. blocks repo.or.cz
   Host repo.or.cz
	ProxyCommand ssh host.example.com exec /home/jnareb/bin/nc %h %p

3. For fetching changes via git:// protocol from repo.or.cz I use the
   following setup in git config:

   [core]
   	gitProxy = ssh-proxy for "repo.or.cz"

   Unfortunately example from Documentation/config.txt with "ssh" as
   git proxy command doesn't work, and neither putting command with
   options (e.g. "ssh host.example.com /home/jnareb/bin/nc") doesn't
   work: the command is _not_ split on whitespace. So I had to use
   helper script ~/bin/ssh-proxy:

   #!/bin/sh

   ssh host.example.com /home/jnareb/bin/nc "$1" "$2"


I hope that would help somebody... and if somebody notices better 
solution, hs/she would provide me with it :-)

-- 
Jakub Narebski
Poland
