From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Tue, 24 Aug 2010 00:01:27 -0500
Message-ID: <20100824050127.GC20037@burratino>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
 <AANLkTi=R6ZdD9GUO6T6uCUkF+KVPbG1FGrieOfeusKct@mail.gmail.com>
 <20100823203304.GB4458@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 24 07:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlfM-0003aN-2n
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 07:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab0HXFDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 01:03:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52091 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0HXFDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 01:03:14 -0400
Received: by gwj17 with SMTP id 17so2404464gwj.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 22:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DUJYwAX95V61emGa/OxVcL3n3VNNIasECT/FJbrR2Fk=;
        b=nEW6DkZ6JkxGGi8c+hEPeEC9CLo4wwkjU5BimOwBZpeE21U/JS5IJxLXIBk5cF9T1G
         /FsD0NQ43LKhDOAm+iyLoao8MW1CqH6uH3reJsPmWYaPrQbLdUizzutilS0B9X6vhCNG
         n57jyEZnnqC02+fOnf5Z2ERmEgwETxg/NfJfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hftx5KFwPgzBUAr8LVMft1FxfQ2z+/m2yTfS8pXAOklEjOrWRc+A/9w6TA/UCyFTOg
         INWFyeLZIKytvYLUHJ+/TEcCAoUCiZK2C6PNqXSCMEEuP2ViYX/eKYhAqIl5HowjxwuF
         zJg/re4jVb7OntfSWeqpLEYIR8NW/e7c9au4o=
Received: by 10.100.33.3 with SMTP id g3mr4776357ang.170.1282626193331;
        Mon, 23 Aug 2010 22:03:13 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm12148206ano.32.2010.08.23.22.03.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 22:03:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100823203304.GB4458@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154290>

Jeff King wrote:

> Which does bring up one interesting boundary. If I run:
> 
>   git -c receive.denyDeletes=false git push
> 
> what should happen? Obviously with cross-server communication the
> environment won't get passed. I am inclined to say that even for local
> cases, receive-pack should clear the string.

Sticky.  I agree with you that that would follow the principle of
least surprise.

On the other hand if I use

	git push --receive-pack='git -c receive.denyDeletes=false receive-pack'

then I would expect it to work.  I don't think this is a security
problem because I already could have set the remote $GIT_CONFIG just
as easily.
