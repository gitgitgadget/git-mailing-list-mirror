From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via 
	'plackup'
Date: Sun, 23 May 2010 12:38:02 +0000
Message-ID: <AANLkTikSXOrF-mS3XzVAohgoNXXNZwN3jBw6Sh4TnK6M@mail.gmail.com>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com>
	 <1274392538-29687-1-git-send-email-jnareb@gmail.com>
	 <201005222330.43532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 14:38:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGARn-0001Am-6v
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 14:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab0EWMiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 08:38:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52903 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab0EWMiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 08:38:04 -0400
Received: by iwn6 with SMTP id 6so2793415iwn.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vxEI3HF8m/6dfSrsOdouy+z3WESpyhXwLYMX7Iv4C8E=;
        b=dr3rq8NjcDrR9MmzfI7rrH3JkAqV0r0brzwXsIP0ZONFYj0mGQ0jZ+N2oF4rWLlYJN
         pEJllmxeC1LdTZb85YRdpEMD4K+k2OQTjXvsf+aiXYpfYkefx1R4il1yyWwCpXgQcTAd
         LXbM81xioK2h1P8Jb656mSFOWMflmDxG4Dj0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NsL6VPiG+njuk8NrZWNl/7qA0mUgkszxQCql+IfAyIZrucC/qjzcVCo4ENGSgtKZ2h
         JOs+ZYtCTkPzfgwNTQed06PokqVlwz59L8TwpdCSHHi2yDzsBMr4C3binZ+YxTmsvnqb
         FdH+XzLqreHB+UbF0qyfIRfcHKWZyo+Odu4tQ=
Received: by 10.231.150.4 with SMTP id w4mr3994144ibv.41.1274618282175; Sun, 
	23 May 2010 05:38:02 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 23 May 2010 05:38:02 -0700 (PDT)
In-Reply-To: <201005222330.43532.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147575>

2010/5/22 Jakub Narebski <jnareb@gmail.com>:
> Webrick, which is in similar situation, uses httpd.conf config file i=
n
> YAML. =C2=A0Unfortunately there is no config / serialization reader i=
n Perl
> core, so if we have to go this route either the config file would hav=
e
> to be in Perl, or gitweb.psgi wrapper would have to include some simp=
le
> config file parsing.

You could easily do (pseudocode):

    unless (eval { require Config::Any; 1 }) {
        do $conf_file;
    } else {
        my $parser =3D Config::Any->new( ... );
         $parser->docnf( $conf_file );
     }

Then you'd read (eval) a perl config file by default, but remain
compatible with saner config formats for users prepared to install
things from the CPAN.
