From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] fast-import: treat filemodify with empty tree as
 delete
Date: Fri, 28 Jan 2011 11:13:59 -0600
Message-ID: <20110128171359.GA26930@burratino>
References: <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
 <20110126230608.GA26787@burratino>
 <7vd3nji54o.fsf@alter.siamese.dyndns.org>
 <20110127060749.GA5586@burratino>
 <20110127193353.GA19378@m62s10.vlinux.de>
 <20110127194844.GA20894@burratino>
 <20110127204649.GB19378@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 28 18:14:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piru3-00074t-3l
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 18:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab1A1ROR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 12:14:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48389 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1A1ROQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 12:14:16 -0500
Received: by fxm20 with SMTP id 20so3559878fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Y5OnVYmSG5M4eenK+0gqC3LLuUIB1BQQJXtbU8RDzls=;
        b=lGBFQ4OoVAe+6oM0wtc61oBaa1u8W/XZCCQIXjomecutU1d7Bzg1QbbX6w9RBI6HRd
         kRsFYWc73wd2Y7RcSBxlyaT+zVnXfoLjgtJSnEGN/K6D7ZsI2jFb5zDNJSUHeM2mIz3g
         WOek63+2pSzesxRT8NNop6LRdvDVBE0vGDehs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bpdy1r87Y4YMvaISFYW5U8IxOPwo3TBZXL+/9uZ28wmH6bmTYHOnnUNURRPn7LQxT/
         GbalXLdD41lDnPV/RzNmtmK5JVqx3AdDUAMfhPw1Iu6BaHm4igAeIDmj+EkyULIyt6yM
         Ah18d/KjPKb5WYXbeHw8gqSJYM6Ba4xnExfKg=
Received: by 10.223.98.193 with SMTP id r1mr2634247fan.83.1296234854738;
        Fri, 28 Jan 2011 09:14:14 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id e6sm6519366fav.8.2011.01.28.09.14.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 09:14:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110127204649.GB19378@m62s10.vlinux.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165628>

Peter Baumann wrote:
> On Thu, Jan 27, 2011 at 01:48:45PM -0600, Jonathan Nieder wrote:
>>> On Thu, Jan 27, 2011 at 12:07:49AM -0600, Jonathan Nieder wrote:

>>>> +	 empty_tree=$(git mktree </dev/null) &&
[...]
>>                               unless we hardcode the object name
>> (which I prefer not to do).
>
> Wny not? It *is* already hardcoded in the GIT source code (see
> grep -a1 EMPTY cache.h output).

I think it is okay for the git implementation to rely on an
implementation detail. ;-)  Likewise, t0000 checks that the empty tree
has id 4b825dc6.  Meanwhile I would like to see people's scripts
and other tests using the $(git mktree </dev/null) form, since it is
more self-explanatory and avoids hardcoding an implementation detail.

Of course this is not an absolute thing.

Hope that helps,
Jonathan

Further reading: t0000-basic.h --help:

	Note that this test *deliberately* hard-codes many expected object
	IDs.  When object ID computation changes, like in the previous case of
	swapping compression and hashing order, the person who is making the
	modification *should* take notice and update the test vectors here.

"Tips for Writing Tests" in t/README:

	However, other tests that simply rely on basic parts of the core
	GIT working properly should not have that level of intimate
	knowledge of the core GIT internals.  If all the test scripts
	hardcoded the object IDs like t0000-basic.sh does, that defeats
	the purpose of t0000-basic.sh, which is to isolate that level of
	validation in one place.  Your test also ends up needing
	updating when such a change to the internal happens, so do _not_
	do it and leave the low level of validation to t0000-basic.sh.
