From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Gitweb: Use a default for a bad env config file
 variable
Date: Tue, 10 Aug 2010 19:08:46 -0500
Message-ID: <20100811000846.GF2099@burratino>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
 <vpq4of2scen.fsf@bauges.imag.fr>
 <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
 <AANLkTikDtK0vyRwJE3Un5uFkK7FzoWtiWpL8gPqLQjH5@mail.gmail.com>
 <1281458849.28858.18.camel@ping.CS.McGill.CA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, avarab@gmail.com,
	Jakub Narebski <jnareb@gmail.com>
To: James Shubin <purpleidea@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 02:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiyto-0008Mh-MO
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 02:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198Ab0HKAKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 20:10:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60575 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0HKAKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 20:10:19 -0400
Received: by iwn33 with SMTP id 33so4513827iwn.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VqguU7HvZnItce2nUS8iKlphczbDBQYs4YLEzfLZhG4=;
        b=o50XOgwOd2DJ7jIlxpDs6MkmKCi2L04CJ0CP9EP1OXrNU2TjsRdEnKPYS+/MAWayyF
         gW0VaGG+z8FpF0myM9tYPWLbAmSxsQu6lFbGFJD7nfp5+ed5e+VTxM7sfgR/1CCF+Anp
         GSGZ5NWj6TnIo+4DfzgMsLh5ErUk0UYDgFQTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZaJS2GpDT0Dh53yuSsiJdLRG4PxOZXacaGSsC9PdoOkgBw6bpoSmXbrplkkoVXPlTu
         eW8pjBbs7+X0UjY3ZH/tABZiaeFDMNLTfgCQZ1w+sqnMrWLbdjfGI6s4czFO+2acVCV0
         AL6iFR5/0jrO3BUwYDGMjFujHe/R9Nwg0Eze0=
Received: by 10.231.161.73 with SMTP id q9mr21715704ibx.70.1281485418687;
        Tue, 10 Aug 2010 17:10:18 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm6446368ibk.21.2010.08.10.17.10.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 17:10:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281458849.28858.18.camel@ping.CS.McGill.CA>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153176>

Hi James,

James Shubin wrote:

> Signed-off-by: James Shubin <purpleidea@gmail.com>
[...]
> It's quite trivial really, all that changes is that if someone sets
> the environment variable: $GITWEB_CONFIG_SYSTEM, and this points to
> something like: /srv/gitosis/gitweb.conf, which doesn't actually
> exist, then gitweb will default to trying out the built in default of
> /etc/gitweb.conf (if it was built with that value).
[...]
|	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
|	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++"; # die if there are errors parsing config file
|	if (-e $GITWEB_CONFIG) {
|		do $GITWEB_CONFIG;
|		die $@ if $@;
|	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
|		do $GITWEB_CONFIG_SYSTEM;
|		die $@ if $@;
|	} elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
|		...

Interesting.  I am a bit nervous that this might be confusing.
cc-ing Jakub for input.
