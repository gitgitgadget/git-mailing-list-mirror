From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 08:26:50 -0800 (PST)
Message-ID: <m3ipzl4bfn.fsf@localhost.localdomain>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 17:27:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLef0-0003rX-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 17:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab0KYQ04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 11:26:56 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51262 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab0KYQ0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 11:26:55 -0500
Received: by bwz15 with SMTP id 15so1011972bwz.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mf1Q4tkR81iM4KhmPFiyBUkAG0K5KiYRFPMxiiSelmk=;
        b=ISdFFEk3j/h7rQtP4VSRZ6OYnea3A68IP6U2LZtmy50mXQO7rcw/IA9RtAU2+JUiWr
         LfoNFDQxpI6qCPz4dzd4YD6JneoRUT3z3KdkpIsOX06j4sAxFFXDCrie6ZIia33/7s9O
         XMF/JCT67M4vktNOOmjl6v17mkOQp8iRDIlOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kY19tnafuD2bF/juGwQwfSiUblS/sShymeTrkN/KpZ2GoaPwtmG1X7+lyX2J0thAg1
         +8qUxQfMJSnuUmWrmWoAD929pvbG2xbPSvUY6r4uVUItc0YTFDxq6hm4U7ULu0/nwrPh
         0qccKL19c2d8fxzWBS/wikEUte4qFhpoUcPIM=
Received: by 10.204.113.195 with SMTP id b3mr886828bkq.210.1290702412071;
        Thu, 25 Nov 2010 08:26:52 -0800 (PST)
Received: from localhost.localdomain (abwg199.neoplus.adsl.tpnet.pl [83.8.230.199])
        by mx.google.com with ESMTPS id 11sm443710bkj.12.2010.11.25.08.26.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 08:26:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAPGQMbi015465;
	Thu, 25 Nov 2010 17:26:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAPGQ4XE015461;
	Thu, 25 Nov 2010 17:26:04 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162145>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/config-doc (2010-10-24) 2 commits
>  . Documentation: complete config list from other manpages
>  . Documentation: Move variables from config.txt to separate file
> 
> This unfortunately heavily conflicts with patches in flight...

The first patch in series can be automatically generated e.g. using
the following Perl script.  I have succesfully rebased this series on
top of current 'master' using it (checkout + script + commit), see
't/doc-config-extraction' branch in my clone of git repo:
  http://repo.or.cz/w/git/jnareb-git.git (can't push currently here)
  http://github.com/jnareb/git

Though that doesn't help with issues with second patch in this series,
which were discussed on git mailing list when sending it.

-- >8 --
#!/usr/bin/perl

use strict;
use warnings;

my ($in, $out, $line);

open $in,  '<', "Documentation/config.txt"
	or die "$!";

open $out, '>', "Documentation/config.txt+"
	or die "$!";
while ($line = <$in>) {
	last if ($line =~ /^.*::$/);
	print {$out} $line;
}
close $out;

open $out, '>', "Documentation/config-vars.txt"
	or die "$!";
print {$out} $line;
while ($line = <$in>) {
	print {$out} $line;
}
close $out;

open $out, '>>', "Documentation/config.txt+"
	or die "$!";
print {$out} "include:config-vars.txt[]\n";
close $out;

rename "Documentation/config.txt+", "Documentation/config.txt"
	or die "$!";

__END__
-- 8< --
-- 
Jakub Narebski
Poland
ShadeHawk on #git
