From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: groff .ft command use in asciidoc
Date: Wed, 17 Nov 2010 04:15:16 -0600
Message-ID: <20101117101516.GA12416@burratino>
References: <20101117095233.GA23817@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Wed Nov 17 11:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIf3j-0005v3-93
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 11:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541Ab0KQKQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 05:16:05 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60651 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0KQKQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 05:16:03 -0500
Received: by gwj17 with SMTP id 17so975441gwj.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wP65rAn44UWANsT6rcW8zzfFB+j8Klaoe+2ElcaWkO8=;
        b=HiZ2YQN8gSSd3MyBnPYLo6rfkrVJe0erg+c1Kc0G/toucVF2+m0S9CTLOCOVX5GZvA
         iPLiTErnR1aDihwcS6emZxvFdHLPqd8BYAwN+rVs9prr9e36AzLMiFdT1DlpMs76Lfpl
         5cuQ9JjQkKKGliLzkezQd0H2E/OqLdpntpckM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gqrDkPXFSQBZfuQSsjpUf2FMXPlLBkwXOo0qPMcMoF9i3avnb2oGl8XXb7LFpIhCwB
         YbbNmJ+NYD5mwgAnVOtWH4FTSf+z6oebOAGWKfagPYCOZ8gF4BqK7W7PeTs5/zcCeqgT
         vd51GOOzMy8wCFOxgZVes4N7ZhfcJ/oECNWls=
Received: by 10.151.43.10 with SMTP id v10mr13746564ybj.421.1289988960039;
        Wed, 17 Nov 2010 02:16:00 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 43sm1487046yhl.37.2010.11.17.02.15.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 02:15:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101117095233.GA23817@basil.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161609>

Hi,

Andi Kleen wrote:

> The git manpages on my opensuse 11.3 (git 1.7.1-1.14)
> frequently use the .ft command the opensuse groff does not 
> render.
> 
> For example from the final output of "man git-commit":
> 
>            .ft C
>            $ edit hello.c
>            $ git rm goodbye.c
>            $ git add hello.c
>            $ git commit
>            .ft

This is in my opinion a bug: unless you use ASCIIDOC_NO_ROFF, git's
asciidoc.conf will include raw roff directives in the docbook markup
it generates.  And then docbook will escape the periods, producing
the output you see.

The workaround is very simple: set ASCIIDOC_NO_ROFF to nonempty
when you build documentation.

I think the only reason this is not the default is that no one has
tested it with old DocBook XSL versions, but I'm not sure.
Documentation/Makefile has some notes about this.

Hope that helps,
Jonathan
