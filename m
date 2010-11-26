From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 00/18] WIP implement cherry-pick/revert --continue
Date: Fri, 26 Nov 2010 00:28:36 -0600
Message-ID: <20101126062836.GF18751@burratino>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 07:29:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrns-0001PO-2G
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 07:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab0KZG2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 01:28:44 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41852 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0KZG2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 01:28:43 -0500
Received: by gwj20 with SMTP id 20so795557gwj.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 22:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jPs2Jrl1LTvqg7WFyrebkeXs97isuVg6yEB3QeBiLAQ=;
        b=sC4eAHaL7yPtg+i67obi+jJKELpSgJaVwnMgaAp0F7ea1edBJk5TRkAvJX9x6TsZPA
         M0rhjtwafqAsz/HePTxaUSvxqwd7wXrYZUvY7dzd3WrgPbJQTLsCk+67NkAUwc3wkyp2
         wXPNT2izoVuSpHqcJ8vZ1IhU/pvIByxSG/fzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GpQk/tpjaJvdcZdavSFT6lCO1NB32Njg41pQBwBhyaKn6AvGwLLR8pM/dUEuYrA2jA
         6fnjxd9QHF29eg1WbPo7E1pzOOWdTSNUi6pkrkjnNvL6Na2Apd0kdDY9ZtPbY7iPzIOn
         x464YUKq2lqEDNTQnYPy8CF34Ruo2DROMmV90=
Received: by 10.151.155.21 with SMTP id h21mr1007797ybo.154.1290752921287;
        Thu, 25 Nov 2010 22:28:41 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.sbcglobal.net [68.255.101.216])
        by mx.google.com with ESMTPS id m46sm1041105yha.44.2010.11.25.22.28.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 22:28:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162206>

Hi Christian,

Christian Couder wrote:

> Many patches in this series are replacing calls to "die()" by
> "return error()", because the TODO and DONE files are written
> only when cherry-pick fails. This is efficient but perhaps it
> would be simpler and safer to write them before each cherry-pick
> just in case it fails, so that the "die()" calls don't need to
> be removed.

Another possibility would be to use set_die_routine()/atexit()/
sigchain_push_common(), but the "always write" solution does seem
simpler.

> (17):

Perhaps too many. :)

I like where this is going.  My main complaint is the commit messages;
given a clear explanation of the design it should not be too hard for
others to help write documentation, enhancements, and tests, but
without it is much harder.

Nit: the style of commit message in patch 16 is unnecessarily
demoralizing.  It basically says "track down the history in this repo
that may not exist in 2050 if you want to know what this patch is
about".  I think it would be better to say

	This code was written as part of the git sequencer
	Google Summer of Code project, 2008

and let the rest of the commit message tell the important details.
Readers can google for the detailed history.

Thanks for your work.
Jonathan
