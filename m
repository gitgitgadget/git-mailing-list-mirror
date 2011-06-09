From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 17/19] transport-helper: export is no longer always the
 last command
Date: Thu, 9 Jun 2011 02:51:41 -0500
Message-ID: <20110609075141.GA4885@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-18-git-send-email-srabbelier@gmail.com>
 <7vsjrjzubl.fsf@alter.siamese.dyndns.org>
 <BANLkTim1R=1SrUXgOOjmRioG45KKVity3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 09:51:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUa20-0005Iq-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab1FIHvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:51:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65290 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1FIHvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:51:50 -0400
Received: by iyb14 with SMTP id 14so1099128iyb.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ePZr41ooUYd2V9OCaM1DWWv0koAlLrVPTf13N9kd3pk=;
        b=Dm3MPGRQTRQm7jsJq+wXKiCulHA0DKMrO1qb0Fs7Hue8gwZ7kRwewzZ1xqmXBYdTqK
         qjhg7/9MdqiSfTJ8H1GTBvn2OJQxZ8DO1IqbHgI2bqhxB4JunSYmGyG1QhGZJLb7OGNY
         uLW5GOLi3xga+VonLbG2HC639bSZBQz2IELlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gskzq8nVh9Xpn6wbRMTCwOMB3DWzYsZkwr1iA+APvCBUUghD7smOhWE9ejCDENZ/B7
         I2hJhCGOGYFwqYSXRJ6gvgxl+d0PiFJGAUt6J92U/iz3aU6ls7SyXiX8zhebk/mTG3Q2
         aWY+SbtyPrN6/1HGjPSRjl6OM1d81Z5gqO5C8=
Received: by 10.42.159.194 with SMTP id m2mr716492icx.83.1307605910155;
        Thu, 09 Jun 2011 00:51:50 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.ameritech.net [69.209.61.87])
        by mx.google.com with ESMTPS id v16sm670281ibe.34.2011.06.09.00.51.48
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 00:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim1R=1SrUXgOOjmRioG45KKVity3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175502>

Sverre Rabbelier wrote:
> On Thu, Jun 9, 2011 at 03:07, Junio C Hamano <gitster@pobox.com> wrote:

>> Could you clarify the logic, perhaps by commenting a bit more where this
>> field is examined and code changes its behaviour in disconnect_helper()?
>
> Previously this bit had to be set, so that we didn't try to write the
> trailing \n on a closed socket. Now, the socket is no longer closed,
> so we can send the trailing \n again. Does that make sense?

Yes, but I'm still missing something.  What does the trailing \n ever
have to be written?

"git log -Sdisconnect_helper -- transport-helper.c" doesn't give many
clues.  I imagine it's a way to check whether the child is still alive
and to warn it not to be alarmed when the output end of its input pipe
closes.
