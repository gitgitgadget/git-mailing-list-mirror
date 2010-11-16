From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit -s: allow "(cherry picked " lines in sign-off
 section
Date: Tue, 16 Nov 2010 17:36:49 -0600
Message-ID: <20101116233649.GA30700@burratino>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <20101116193018.GA31036@sigill.intra.peff.net>
 <20101116202556.GA27390@burratino>
 <20101116204027.GB27390@burratino>
 <7vlj4shoej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 00:37:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIV5m-0001Uh-AP
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 00:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140Ab0KPXhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 18:37:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54832 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745Ab0KPXhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 18:37:32 -0500
Received: by gyh4 with SMTP id 4so807955gyh.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 15:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QNJY2tz57WP5/NXeGXyRma/e/1EQDPuJaiU4mhGuL8o=;
        b=cBdnPL+wTyh0/FVunyEHJmCikAEBdMB5AjwL5vqQodXYcudo2P2pNL+9oRSbphSmzk
         SFROgtJhiNe1OrqCSraPtS9mM1msXHgdIT+rxXdFTuvFogC9JOAVJ4eOVrCCyOvJ5YLu
         +pk9bcRQCCA9mRAihgOWIv8etqk7s8juLPKAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uWwSCNaeiypqnkvQeH3TxEg9vR5mhTvwCbY26wDRx+ZP5eQIMvV9+hOMQj5XwpZwHL
         s1f07qVu8Bz2i+YLY3K41OBvkNXFedW+xNcRmLRN+p7gK76gPWU3PkHKFq14XCgG+mKB
         HJN13hD/QDkRrp425z98yB0ZS6zhSob3lHJCE=
Received: by 10.100.191.7 with SMTP id o7mr5868203anf.198.1289950651468;
        Tue, 16 Nov 2010 15:37:31 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d10sm5621315and.39.2010.11.16.15.37.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 15:37:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlj4shoej.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161591>

Junio C Hamano wrote:

> I am not sure I agree with the reasoning of this patch, by the way.  A
> cherry-pick is an event that breaks the life of the patch, so it may even
> be a sensible thing to do to express "the above sign-off chain shows who
> were involved in the original commit; I am cherry-picking it out of
> context, and these people do not have much to do with the result" with a
> blank line on both sides of the "cherry picked" line, like this:
> 
>	A concise summary of the change
> 
> 	A detailed description of the change, why it is needed, what
>	was broken and why applying this is the best course of action.
> 
> 	Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> 	(cherry picked from commit 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0)
> 
> 	Signed-off-by: Back Porter <backporter@example.com>

How is the cherry-pick event different from the send-by-mail-and-apply
event?

In both cases, the result has a distinct commit id and distinct
signoff and it is unlikely that the previous patch handler was testing
with the same tree as the next one.  (And each patch handler should add
relevant comments if the new situation warrants that.)
