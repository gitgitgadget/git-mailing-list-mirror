From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] remove inline iteration variable
Date: Wed, 16 Aug 2006 10:14:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608161011100.20470@chino.corp.google.com>
References: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
 <81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 19:15:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDOyu-0003Km-Hw
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 19:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWHPRO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 13:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWHPRO5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 13:14:57 -0400
Received: from smtp-out.google.com ([216.239.45.12]:43510 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750972AbWHPRO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 13:14:56 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7GHEoY4032070;
	Wed, 16 Aug 2006 10:14:50 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=Tqd+hYLlco8STtdSsafMMewndNk0N/4ALuGiaz2daBX3cJjXIbAx3SXNhV2LgOBMD
	7OTNrQS2kDarLQ/WfGIwA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7GHEjYq027631;
	Wed, 16 Aug 2006 10:14:45 -0700
Received: by localhost (Postfix, from userid 24081)
	id 9A4EF87D71; Wed, 16 Aug 2006 10:14:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4E28887D70;
	Wed, 16 Aug 2006 10:14:44 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25518>

On Wed, 16 Aug 2006, Alex Riesen wrote:

> On 8/15/06, David Rientjes <rientjes@google.com> wrote:
> > Remove unnecessary iteration variable in inline.
> > -       for (i = 0; i < in; i++) putchar(' ');
> > +       for (; in > 0; in--)
> 
> while(in--) putchar(' ');
> 

That goes into an infinite loop if the argument is negative because it emits a 
cmpl $0, x(%ebp).  Should never happen, but there's no reason not to prevent it 
with a for loop.

		David
