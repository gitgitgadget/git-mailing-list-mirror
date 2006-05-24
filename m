From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Wed, 24 May 2006 21:16:26 +0200
Message-ID: <4474B10A.1020704@gmx.de>
References: <4471CF23.1070807@gmx.de>	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net> <44737353.20904@gmx.de> <7vzmh81gfa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 21:16:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiyqK-0007d4-BL
	for gcvg-git@gmane.org; Wed, 24 May 2006 21:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWEXTQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEXTQZ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 15:16:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:63417 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751268AbWEXTQY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 15:16:24 -0400
Received: (qmail invoked by alias); 24 May 2006 19:16:23 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp012) with SMTP; 24 May 2006 21:16:23 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmh81gfa.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20701>


>> 2.) Searching for a way to add objects to the database I spent quite a
>> while to find the right command. Don't you think it would be much more
>> intuitive having an
>>
>>     git-create-object [-t <type>] [-n] [-f] [-z] [--stdin] <file> [-r
>> <ref-name>]
>>
>> command for creating any type of object (-t blob as default).
>>     
>
> No, I do not think we would want to make it too easy and relaxed
> to create arbitrary object-looking thing.  Each type have
> defined format and semantics, and creation of an object of each
> type should be validated.  I do not want to encourage bypassing
> it by introducing such a backdoor.  The backdoor is easy to
> write, but I suspect it would actively harm us, instead of
> helping us, by encouraging "let's build a custom type of object,
> we do not care if other people would not understand it"
> mentality.
>   

Well, this is exactly what you have now in
    git-hash-object -w -t foo

That is why I said, all input should be validated by default. All I
proposed was
a) unify the tools in order to have less duplicate code (git-mktag,
git-mktree & git-hash-object do merely the same except for the
validating part)
b) remove the possibility to introduce unchecked objects of arbitrary
type (or only allow it with the -f = "force, use with caution"-option)

maybe I should have written "blob, tag, tree or commit" instead of
"arbitrary". I did not mean really arbitrary like it is implemented
right now in git-hash-object.

Bj
