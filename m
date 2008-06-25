From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC] git-svn: sanitize_remote_name should accept underscores.
Date: Wed, 25 Jun 2008 11:01:11 -0400
Message-ID: <32541b130806250801p1508d15axc610f335b8d235ef@mail.gmail.com>
References: <1214322898-9272-1-git-send-email-apenwarr@gmail.com>
	 <20080625064435.GL21299@hand.yhbt.net>
	 <20080625065556.GM21299@hand.yhbt.net>
	 <7vfxr23s6m.fsf@gitster.siamese.dyndns.org>
	 <20080625074548.GA8984@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 17:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWVc-0007iv-Q0
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYFYPBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYFYPBP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:01:15 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:6132 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYFYPBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:01:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3261979fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GmTRlXHrhUkUQvZ92QsW3J9l3j/Bapdmt3OQEBg00Xs=;
        b=ichsUIrxJl2N4/wFmlviib6gMkCkD+W8pHD1muBQcZiP4metZpSLrjWM3xA7dD1fhz
         XBkOhTwf7Wy19coolUgxXcIyEa9pK0XPIxUV3/v3zQISUdd7W+dh5P2dJcM+6hT+YSL8
         /XnegRkCbzjmeP+caG9BJIRYQBquMqPOtkOcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CnIC4JGUGQPAqTUQqpXf2FL9mlIHLrbW/5udBVgQif51QgHmJzo8X++0eEKGpUv3SK
         wmr3PYmQCGl5OAFCdGsX2LC+NVTLd+VN6+NAOR3FrnI5MBO2r/tL4+/1PHapzBbeW6wL
         LdJ2gGVd2WgPgx9HeCrJNyONOfSO3IdbUnXOU=
Received: by 10.82.113.6 with SMTP id l6mr648728buc.88.1214406071654;
        Wed, 25 Jun 2008 08:01:11 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 08:01:11 -0700 (PDT)
In-Reply-To: <20080625074548.GA8984@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86285>

On 6/25/08, Eric Wong <normalperson@yhbt.net> wrote:
> No, nothing to do with DNS hostnames in the remote names.  I think I
>  just looked at remotes2config.sh one day and used it as a reference :x
>
>  It's late and I've had a rough few days, but shouldn't
>  sanitize_remote_name() just escape . and "?  Right now it's converting
>  stuff to . which has me very confused...

I think there might be higher-level problems here: what is it
sanitizing anyway, and why?  If it found my D2007_Win32 svn-remote
entry in the config (as it seems to have done when trying to locate
its parent branch during fetch), and *then* it sanitized it to
D2007.Win32, that doesn't even make any sense.  Clearly something
straight from the config file doesn't need to be sanitized.

However, I don't understand the code well enough to be able to say a)
whether that's exactly what happened, or b) other places where
sanitize_remote_name() *is* important, or c) whether
sanitize_remote_name() is even correct.

Have fun,

Avery
