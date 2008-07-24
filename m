From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 21:55:13 +0400
Message-ID: <20080724175513.GY2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <20080724165335.GW2925@dpotapov.dyndns.org> <alpine.DEB.1.00.0807241811580.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM538-00079y-H1
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbYGXRzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYGXRzW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:55:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:32458 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYGXRzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:55:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1460783fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q6b5Zwgf54exo+g3aDbd+BOz4TerVE1DUc3s5/kPi2M=;
        b=udJFlF2KVKtqeo17vsX3rqlJ7IABxdH7d7lp5czc4v3HYzZQMYc1o/lqyY/LCju7nG
         W5yAmw195uqZqfeEVP7K5x19kWoxIHhanPe42YAJzTQojic7XGkc6RlW9fN05MJbpGGR
         RB7vf6as4d1udWsZeZcXkbKjlFJuA4EjfOmNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kMXMRnImIYTRym/okvrDHwFGyAU9Y78RnwhnVCzKuv5h+041ieN4d5K5z1P2bvF3dp
         8G6jGi2DS/45DuXLHnw7xgk2MiuEEwDeET1L5QslDXEAvTOZdF30tp/olPuapUpTVCAZ
         +uP0kUVot1a+HiW0Xt3sHizLxJogLDeOaUvMM=
Received: by 10.86.80.5 with SMTP id d5mr1105857fgb.11.1216922117467;
        Thu, 24 Jul 2008 10:55:17 -0700 (PDT)
Received: from localhost ( [85.140.170.251])
        by mx.google.com with ESMTPS id d6sm5187941fga.2.2008.07.24.10.55.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 10:55:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807241811580.8986@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89924>

On Thu, Jul 24, 2008 at 06:14:09PM +0100, Johannes Schindelin wrote:
> On Thu, 24 Jul 2008, Dmitry Potapov wrote:
> > 
> > Here is the average based on 3 attempts:
> > 0.232s with autocrlf=false
> > 0.265s with autocrlf=input (14% increase)
> 
> And you tested... on git.git?  One of the smallest serious Git users?

If you take a huge repo, you are going to be bound by disk IO unless
huge amount memory, so all files reside in the filesystem cache.

> 
> If you want to come close to the hard cases (that you would punish with 
> setting autocrlf = input, not yourself of course), test _at least_ the 
> Linux kernel.

false   input
6.913s  8.426s
6.922s  8.337s
6.969s  8.335s
6.975s  8.386s
6.939s  8.435s
6.954s  8.320s

autocrlf=input takes 20% more than autocrlf=false, which is rather
strange, because I clearly saw some disk activity... so I expected
it to be less...

In any case, this test is rather artificial, and the real one should
be is of course applying patches... Maybe I will try that later...

Dmitry
