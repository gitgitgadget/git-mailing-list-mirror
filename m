From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Sat, 8 Mar 2008 19:29:45 +0100
Message-ID: <200803081929.46306.jnareb@gmail.com>
References: <20080308165245.15343.62914.stgit@localhost.localdomain> <20080308175106.GA13855@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 19:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY3oW-0001f0-Ht
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 19:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbYCHS3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 13:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbYCHS3y
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 13:29:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29231 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYCHS3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 13:29:54 -0500
Received: by nf-out-0910.google.com with SMTP id g13so511174nfb.21
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 10:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=DKQr4pCr0QNN4TkHTMxie/0GCXmGlhuNjUeZY0Qvgok=;
        b=Kms6GHCz5XtMWaBsQCaooG4Imf/3geyhSiQgaQn9B8xRNc6Y+HKc/k+LhKTiivpppLemr4oMllfrcfAV0+yPwq79CbvRFLuEqJxnOeBgN5l7wDI2sqG9TW4HZ5nvVzcIhcJ225Q+DLmFjWnIAgpSRF18W5SeonTAEUehZKrMBMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kvILsxrNHxSm9F9oe/fVLjxoZiS/7FjqCUcMombL9q8tjgQUAFr6fTCz0MMLhlmHlhFD/fntimfujlqJJr8l0k88U8bsFRNPsxETq3a5k0VCYC1YKUBwQ3J387xqOWo/69mNIpSBzcET27GnE7mfxMXGHu2xpwkKg8VFMR5Pfmk=
Received: by 10.78.193.5 with SMTP id q5mr7185439huf.75.1205000983985;
        Sat, 08 Mar 2008 10:29:43 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.251.176])
        by mx.google.com with ESMTPS id c22sm11076028ika.3.2008.03.08.10.29.40
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 10:29:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080308175106.GA13855@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76571>

On Sat, 8 Mar 2008, Charles Bailey wrote:
> On Sat, Mar 08, 2008 at 05:57:20PM +0100, Jakub Narebski wrote:

>> Add output_pipeline subroutine, which allows to use list form of
>> pipeline; instead of
>>
>>   open my $fh, "-|", "cmd_1 option | cmd_2 argument"
>>
>> we can now write
>>
>>   my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
>>
>> which allows to avoid troubles with shell quoting, and avoid spawning
>> shell.  Code is based on snippet http://www.perlmonks.org/?node_id=246397
>> simplified a bit.
> 
> I'm not a Perl open expert, and I don't know if gitweb has other
> issues on windows anyway, but the list time I experimented with it
> neither the open( FHAND, "-|" ) trick, not the list form of open in
> combination with the "-|" mode worked at all on windows.

First, gitweb is git web interface; I don't know if anybody tried for
example to run gitweb on Windows, be it from Apache or from IIS.

Second, it probably depends on the flavour (distribution) of Perl
used. ActiveState Perl requires some horrible workarounds[*1*], I don't
know what about MSys / MinGW Perl, Cygwin Perl, or Vanilla / Strawberry
Perl.


[*1*] Git.pm, Perl interface to the Git, includes workaround for
ActiveState Perl sheningans; gitweb currently doesn't use Git.pm
(Git.pm would need some extensions), but perhaps it should. On the
other hand it would make installation slightly more complicated.

-- 
Jakub Narebski
Poland
