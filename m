From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 3/3] t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
Date: Sun, 12 Sep 2010 21:33:26 +0200
Message-ID: <201009122133.26427.jnareb@gmail.com>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com> <1284284466-14506-4-git-send-email-jnareb@gmail.com> <7vtylueuc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 21:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OusJ8-0008PW-OI
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 21:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab0ILTda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 15:33:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64820 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0ILTd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 15:33:29 -0400
Received: by fxm16 with SMTP id 16so2763487fxm.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eJiUX/rayMVoSKA8EnIsiwmgI00ckalNlaK9LgUWYdw=;
        b=wS2uh2m11tRMGDMP8aRnQmER+BVCSQevYAmfjxSKFCCPV5+QlbzborJHR2XDGg67OT
         DeeuBfOE72rVY7A0oAeMYBuMbsw4y/qJIDipsI6gTcF866H5i7VLv8BcdTxTsFlo7I6O
         tdHnfREHLccLCJM5e8sMD2OeihhMjr3T0SC/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WA4aOLso8+LL/E8NS9KUcoJ6odi5r+pLquZS0TK/Tabr9zj/G7arlCPqJjFwIpPyfI
         Ozf11A2jQAgVBWmBOIyZxAT15FDlykSbrB47EjxymcgweGQOp/n2Msrd8fWhEAIf5wnX
         zm0fNwkzy4rrFPfCDODfzL69BOTFEAwAPhsyk=
Received: by 10.223.119.203 with SMTP id a11mr2503866far.86.1284320007902;
        Sun, 12 Sep 2010 12:33:27 -0700 (PDT)
Received: from [192.168.1.13] (abwi198.neoplus.adsl.tpnet.pl [83.8.232.198])
        by mx.google.com with ESMTPS id 14sm2441701fav.2.2010.09.12.12.33.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 12:33:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtylueuc4.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156044>

On Sun, 12 Sep 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > It is an RFC because I am not sure where to put documentation,
> > i.e. description of GITWEB_TEST_INSTALLED.  Should it be put in
> > t/README, in gitweb/README, or in gitweb/INSTALL, or in
> > t/gitweb-lib.sh header?
> 
> I think the comment in this file is fine.

O.K.

> > +	# You can set the GITWEB_TEST_INSTALLED environment variable to
> > +	# the gitwebdir (the directory where gitweb is installed / deployed to)
> > +	# of an existing gitweb instalation to test that installation.
> > +	if test -n "$GITWEB_TEST_INSTALLED" ; then
> > +		SCRIPT_NAME="$GITWEB_TEST_INSTALLED/gitweb.cgi"
> > +		test -f "$SCRIPT_NAME" ||
> > +		error "Cannot find gitweb.cgi at $GITWEB_TEST_INSTALLED."
> 
> I don't know if GIT_WEB_TEST_INSTALLED=/path/to/some/directory (naming the
> directory that houses the script which must be named gitweb.cgi) is easier
> to use than GIT_WEB_TEST_INSTALLED=/path/to/some/gitweb.perl (naming the
> script that is allowed to be renamed).

First, I was following what GIT_TEST_INSTALLED does (it points to bindir,
not to git binary).  Second, I had half of idea to also change paths to
static files... but they are not used anyway, at least not currently
(no check for links).

Anyway we can support both situations, slightly similarly to how
GIT_TRACE can have different kinds of values.
-- 
Jakub Narebski
Poland
