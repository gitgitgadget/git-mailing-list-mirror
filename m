From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 20:04:01 +0000
Message-ID: <20130127200401.GT7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan>
 <20130127145056.GP7498@serenity.lan>
 <7vzjzuv224.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYT1-0004A2-KJ
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab3A0UEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:04:12 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42902 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915Ab3A0UEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:04:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id E9F6821478;
	Sun, 27 Jan 2013 20:04:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhEfraKzlLVD; Sun, 27 Jan 2013 20:04:10 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 0ED5322B51;
	Sun, 27 Jan 2013 20:04:10 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id ED27C161E02E;
	Sun, 27 Jan 2013 20:04:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dDT5xHsFHfi; Sun, 27 Jan 2013 20:04:09 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0F014161E565;
	Sun, 27 Jan 2013 20:04:03 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vzjzuv224.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214723>

On Sun, Jan 27, 2013 at 11:49:39AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When this change was originally made (0846b0c - git-remote-testpy: hash
> > bytes explicitly , I didn't realised that the "hex" encoding we chose is
> > a "bytes to bytes" encoding so it just fails with an error on Python 3
> > in the same way as the original code.
> >
> > It is not possible to provide a single code path that works on Python 2
> > and Python 3 since Python 2.x will attempt to decode the string before
> > encoding it, which fails for strings that are not valid in the default
> > encoding.  Python 3.1 introduced the "surrogateescape" error handler
> > which handles this correctly and permits a bytes -> unicode -> bytes
> > round-trip to be lossless.
> >
> > At this point Python 3.0 is unsupported so we don't go out of our way to
> > try to support it.
> >
> > Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> 
> Thanks; will queue and wait for an Ack from Michael.
> 
> Does the helper function need to be named with leading underscore,
> though?

It's a Python convention for internal functions.  Since this is a script
not a library module I don't feel strongly about it in this case.


John
