From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] My thoughts about implementing gitweb output caching
Date: Sat, 8 Jan 2011 12:15:39 +0100
Message-ID: <201101081215.42188.jnareb@gmail.com>
References: <201101080042.36156.jnareb@gmail.com> <20110108002643.GD15495@burratino> <alpine.LFD.2.00.1101072142550.22191@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 08 12:16:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbWmA-0005h8-A5
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 12:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab1AHLP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 06:15:56 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62098 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab1AHLPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 06:15:55 -0500
Received: by wyb28 with SMTP id 28so18155120wyb.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GB+78MiJpyja5X+ZRiVcAl5g4f9PYKwR+FbtW4KlnrU=;
        b=VcHzNyjPwNb7hCtFnUJxwA/zxmEioteFM1rTq3GC7qLNg2zJrAHqYv0UL4FUVSlV6h
         IjZDc7l0KQqOsAvq75P0FR6gSgqsMZAlMHtBCFB4we7yJPnz8IHk/pDue8LYXGDObV3v
         YSOPakBz8MQHyZttmX3o6U5DIvVHBSW3NwMgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pv7iBozkUnwvPMyzfM0uBjzd2utL7kDjY2g04661/1hJQ8Scu1Jfd4y2wtg8LXPiQD
         D9SyFYzVATBmmMKxP+NY8aK6bPw/ORjw+9O37Cke7OE0v1QKMxCkQ8gOvFUoqd5VIJm/
         P+IMSCuLBxXHDCUYmgZybXRZ7hLNZeKwk/+PQ=
Received: by 10.216.179.81 with SMTP id g59mr214500wem.35.1294485353600;
        Sat, 08 Jan 2011 03:15:53 -0800 (PST)
Received: from [192.168.1.13] (abvf4.neoplus.adsl.tpnet.pl [83.8.203.4])
        by mx.google.com with ESMTPS id n1sm12926212weq.7.2011.01.08.03.15.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 03:15:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.1101072142550.22191@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164815>

Nicolas Pitre wrote:
> On Fri, 7 Jan 2011, Jonathan Nieder wrote:
> > Jakub Narebski wrote:

> > > With output caching gitweb can also support 'Range' requests, which
> > > means that it would support resumable download.  This would mean hat we
> > > would be able to resume downloading of snapshot (or in the future
> > > bundle)... if we cannot do this now.  This would require some more code
> > > to be added.
> > 
> > Exciting stuff.
> > 
> > Teaching gitweb to generate bundles sounds like a recipe for high server
> > loads, though.  I suspect manual (or by cronjob) generation would work
> > better, with a possible exception of very frequently cloned and
> > infrequently pushed-to repos like linus's linux-2.6.
> 
> Even for Linus' linux repo, it is not a good idea to auto create bundle, 
> except maybe once every major release which is every 3 months or so.  I 
> really don't think this is a good idea to put this in the realm of 
> gitweb caching.

You are right, making gitweb aware of bundles (if they are put in some
specified place, e.g. .git/objects/pack or .git/objects/bundle) is I guess
a better idea than allowing for gitweb to generate bundles, perhaps
only if caching is enabled, and perhaps with very long expiration time.

Of course the standard way should be also the standard place for git
clients to find bundles in proposed extension to git-clone.

-- 
Jakub Narebski
Poland
