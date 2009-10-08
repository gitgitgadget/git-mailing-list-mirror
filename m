From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Git archive and trailing "/" in prefix
Date: Fri, 09 Oct 2009 00:07:45 +0200
Message-ID: <4ACE62B1.8070801@gmail.com>
References: <loom.20091008T172303-658@post.gmane.org> <7v4oq9j1gs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 00:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw1B4-0002VL-NT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 00:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZJHWIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbZJHWIY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 18:08:24 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60048 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbZJHWIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 18:08:23 -0400
Received: by bwz6 with SMTP id 6so1195861bwz.37
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=uXJjZ/9OdSQWB29Lujeb9S1my6LpGhfMbaxk7UtSZXU=;
        b=T2BW7EQe3AKCAFQD4Gy6lkpmNn+05CdSxiHfSPcqunyh3PkhpQmjnWDyQURk2s9Hmj
         s+PGUg3SI6AG62jLa1XvFIiTV+AwTsMsa57kcUisW3L+eoJgxJiGgw9kfdurgmOfHsyf
         4YFSXSdzL3qG8RelTbgFTAi5L6bE4aZzy1YX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=l4khj6xGBV17c9rYOQnPZBWK/3Z28oVmQxVnFUqpNDC54XxEYU3EUXzwMbJ5Uy964S
         ETY96CWQVb//WjGg+1l5GkF6XPAIqKA+6nH9zX2Z9PdCryCmeG4a3p3xn0DDXJI9FJvi
         xCEcj71TmPIc+SeGv4yGYFaAoHTspSzYdaQbo=
Received: by 10.102.204.21 with SMTP id b21mr760319mug.9.1255039666064;
        Thu, 08 Oct 2009 15:07:46 -0700 (PDT)
Received: from ?192.168.1.98? (host120-48-dynamic.23-79-r.retail.telecomitalia.it [79.23.48.120])
        by mx.google.com with ESMTPS id 12sm293989muq.18.2009.10.08.15.07.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 15:07:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7v4oq9j1gs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129719>

Junio C Hamano wrote:
> Sergio Callegari <sergio.callegari@gmail.com> writes:
>
>   
>> The git-archive man page indicates that if the --prefix option is passed to
>> git-archive, it is compulsory to end the prefix with a "/"
>>     
>
> No, it does not have to.
>
> 	$ git archive --prefix=v1.6.0- v1.6.0 Makefile | tar xf -
> 	$ make -f v1.6.0-Makefile
>   
Thanks... I now see better all the possible uses.

> This is consistent with the way the same --prefix option can be used with
> checkout-index.  e.g. to swap Makefile in work tree and in the index:
>
> 	$ edit Makefile
> 	$ git checkout-index --prefix=old- Makefile
> 	$ git update-index Makefile
>         $ mv old-Makefile Makefile
>
> These may or may not be useful examples, but this feature has been with us
> for a long time.  I wouldn't be surprised if removing the ability to
> archive or checkout with filename prefix (not leading directory path
> prefix) causes grief to existing scripts of people.
>   
That's why I asked btw. I did not want to start experimenting 
modification like auto adding a "/"
after the prefix without knowing whether they could have limited some 
other uses or broken some
consistency. I now see they would do.

I guess the bug in using --prefix on a worktree with subdirs without 
specifying a path is not specific
to git archive, then.

Sergio
>   
>
>   
