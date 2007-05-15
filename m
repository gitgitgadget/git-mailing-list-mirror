From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Tue, 15 May 2007 18:30:09 -0400
Message-ID: <464A3471.9070007@gmail.com>
References: <20070515201006.GD3653@efreet.light.src>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 16 00:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho5XG-0002UL-W9
	for gcvg-git@gmane.org; Wed, 16 May 2007 00:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906AbXEOWaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757914AbXEOWaV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 18:30:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:19806 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906AbXEOWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 18:30:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2095829wxd
        for <git@vger.kernel.org>; Tue, 15 May 2007 15:30:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Bzi8CZT51hzl7wSL+jVCxKvJiT+FpNoZGPh3Ddr5n0/1r1uRK2+rXpK000Nb3iKV2lW/LM/Plc4mo5BpP9K+PCpo6CmwPkkfQu20wAYMicV1TsXDubqUCOyZsvHD+4pfagmQuRXkXFtrLNHO3zRQsB+3LHYAZ0SZ4jRqxt8uGBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=O2UrNmhx5jT/c8EWMdbIX0vBL2FsC+X2+35RnDohBRa8qupAloIgexs2GSYu4afK7Lnvn82JVGr810I6dvJ8jFmOsBBFgbQFffcRpadnt65aj9nzw80u3UCqg/qpoKS+VOyaEg7MDgIccnguNuQgX4QJ6Q3NQBXAgWK/DkWft+k=
Received: by 10.70.39.2 with SMTP id m2mr12465822wxm.1179268219774;
        Tue, 15 May 2007 15:30:19 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id i39sm213061wxd.2007.05.15.15.30.17;
        Tue, 15 May 2007 15:30:18 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20070515201006.GD3653@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47381>

Jan Hudec wrote:
> Hello,
> 
> Did anyone already think about fetching over HTTP working similarly to the
> native git protocol?
> 
> That is rather than reading the raw content of the repository, there would be
> a CGI script (could be integrated to gitweb), that would negotiate what the
> client needs and then generate and send a single pack with it.
> 
> Mercurial and bzr both have this option. It would IMO have three benefits:
>  - Fast access for people behind paranoid firewalls, that only let http and
>    https (you can tunel anything through, but only to port 443) through.
>  - Can be run on shared machine. If you have web space on machine shared
>    by many people, you can set up your own gitweb, but cannot/are not allowed
>    to start your own network server for git native protocol.
>  - Less things to set up. If you are setting up gitweb anyway, you'd not need
>    to set up additional thing for providing fetch access.
> 
> Than a question is how to implement it. The current protocol is stateful on
> both sides, but the stateless nature of HTTP more or less requires the
> protocol to be stateless on the server.
> 
> I think it would be possible to use basically the same protocol as now, but
> make it stateless for server. That is server first sends it's heads and than
> client repeatedly sends all it's wants and some haves until the server acks
> all of them and sends the pack.
> 
> Alternatively I am thinking about using Bloom filters (somebody came with
> such idea on the bzr list when I still followed it). It might be useful, as
> over HTTP we need to send as many haves as possible in one go.
> 

Bundles?

Client POSTs it's ref set; server uses the ref set to generate and 
return the bundle.

Push over http(s) could work the same...
