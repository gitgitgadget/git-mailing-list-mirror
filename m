From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Thu, 24 Mar 2011 22:23:22 +0100
Message-ID: <201103242223.23563.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com> <4D8AF101.7030709@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:24:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2s0n-0001LI-JV
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 22:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab1CXVYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 17:24:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63272 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab1CXVYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 17:24:01 -0400
Received: by bwz15 with SMTP id 15so450808bwz.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 14:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=fi8J6SD2RsUakY6zK20MIg4/jWO3rv2DYUgPZNk0Eh0=;
        b=MlvArVCUlmVFr3wfFnboWno+MWqozgnjMxkk5w9Xo7bbqnb78WHiuaQ8XhB6Ogq2X5
         pj2iH3rhzjqt/v0Fcgk/rM05W7VVlzp3EhERwAlifS3uqHmHEfm86rHIRNG/K9NpCnc9
         UPwuXFyek/Uj4eiJd+QMBW7pICeRPPqOEzRMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T9wbyTEFSqq9UiZgkt05wg4vWYo++9rnx9bBknfkOaX+k8ID+8aHzyOY1oX/ptlN0V
         4CQt3CXsjYJ/KXME8E6iwQFVFQ5NRWO7NLpSl7As8hjj/kBT3tia57bwLJnfYxUnKK/L
         It0HA8Wo/wI0xoLpG5ocO2lANc6nRSYWeZPRc=
Received: by 10.204.16.198 with SMTP id p6mr1229968bka.143.1301001805063;
        Thu, 24 Mar 2011 14:23:25 -0700 (PDT)
Received: from [192.168.1.13] (abwk172.neoplus.adsl.tpnet.pl [83.8.234.172])
        by mx.google.com with ESMTPS id z18sm254486bkf.20.2011.03.24.14.23.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 14:23:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4D8AF101.7030709@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169945>

On Thu, 24 Mar 2011, J.H. wrote:
> On 03/23/2011 10:23 PM, Kevin Cernekee wrote:
> > On Wed, Mar 23, 2011 at 5:08 PM, John 'Warthog9' Hawley
> > <warthog9@eaglescrag.net> wrote:

> > > This patch takes the same basic goal, display the appropriate times
> > > in a given timezone, and implements it in Javascript.  This requires
> > > adding / using a new class, dtcommit, which is based on the
> > > dtstart/dtend microformats.  Appropriate commit dates are wrapped in
> > > a span with this class, and a title of the time in ISO8601 format.

[...]
> > 4) IE6 does not seem to like ISO 8601 format:
> > 
> > x = new Date("2011-03-09T03:29:09Z");
> > 
> > This sets all fields to NaN.  I suspect that getTime() values
> > (milliseconds since 1970-01-01) are more portable.
> 
> That's actually an issue, my understanding (as well as the understanding
> of all of the microformats that are out there) is that ISO 8601 is the
> "correct" format that these things should be in.  If IE6 can't handle
> that (and I'll admit I don't have trivial access to older IEs for
> testing right now), then there is a *LOT* of Javascript out there that
> is just broken.
> 
> Going a bit further, I would draw the line in the sand for gitweb
> supporting IE as a browser somewhere around IE 7 or 8 at this point as well:
> 
> http://www.w3schools.com/browsers/browsers_explorer.asp
> 
> IE 5, 6 & 7 look to have negligible market share at best as it is, and
> I'm not sure it's worth trying to go back and support IE6 or anything prior.

Another solution would be check if browser supports required JavaScript
features, and if not behave as if JavaScript was disabled (graceful
degradation).

[...]
> > Some other things that popped up:
> > 
> > 5) Some timezone offsets are not a whole number of hours.  Bangalore
> > time is GMT +0530, for instance.
> 
> The code is capable of handling this, it's mainly an issue of interface,
> which I'll bring up in response to 6 & 7

This is not issue of only interface: date.js has 'tzOffset / 100 * msPerHr'
and this do not support fractional offsets.  +0530 is 5.5 hours, not 5.3.

-- 
Jakub Narebski
Poland
