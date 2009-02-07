From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 10:22:15 +0100
Message-ID: <9b18b3110902070122r3397888aqcaebfcf3e6d40d51@mail.gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de>
	 <200902061012.42943.jnareb@gmail.com>
	 <b77c1dce0902060149j25e76250q76c2368bd3ca5857@mail.gmail.com>
	 <200902061126.18418.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 10:24:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVjQ4-00013s-Ln
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 10:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbZBGJWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 04:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbZBGJWX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 04:22:23 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:4897 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbZBGJWS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 04:22:18 -0500
Received: by qw-out-2122.google.com with SMTP id 3so651402qwe.37
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Okcqp8zjQHVFvsT/HjG/7U9Xd8knJJNzKGMWGr0Cvns=;
        b=tksCj7n4hC1klE3bjb2l4c2E+vHv5Vc4EGDI0/eoRzf9x9earzDQMfO7ub0qGqRl4D
         FdFR6AGXAeofG8zdNAWtDmqVNwA425uoT9AJ0gMtoIxqYEMBhjXfe4GUqWrRJJELScsn
         oauzHPrdvGNGsn9Z3p3VXjR5WK1MRzKr3wzkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q8ipmTZABfi54HXteoTiPkdpXOStmQAMTCnfpc6t3ytGJtPmwq22G0YpClCWhJqYOL
         pwf0EsxNaNwKgLNlU3vWuDVWE8KdbeUqS15R3CrDt4R7nvCbSS0tsc8t3THHwgVzgRpC
         0BMIwMbUy4A4ME1v3EK71YvxpVuuCyqyiygd8=
Received: by 10.214.216.7 with SMTP id o7mr3965751qag.155.1233998535784; Sat, 
	07 Feb 2009 01:22:15 -0800 (PST)
In-Reply-To: <200902061126.18418.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108834>

2009/2/6 Jakub Narebski <jnareb@gmail.com>:
> Dnia pi=B1tek 6. lutego 2009 10:49, Rafael Garcia-Suarez napisa=B3:
>> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:
>
>> > Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committag=
)
>> > to match word boundary at the beginning and the end.  This way we
>> > reduce number of false matches, for example we now don't match
>> > 0x74a5cd01 which is hex decimal (for example memory address),
>> > but is not SHA-1.
>>
>> Further suggestion: you could also turn the final \b into (\b|\@),
>
> You meant \b -> \b(?!\@), didn't you?  Word boundary _not_ followed
> by '@', and not word boundary _OR_ '@' as you wrote...

Since \b(?!\@) is effectively two zero width negative assertions in a
row you could simplify by saying:

  (?![^\w\@])

and that way you can easily add the '.' case as well.

Yves










--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
