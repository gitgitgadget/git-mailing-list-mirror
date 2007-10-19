From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Proposed git mv behavioral change
Date: Fri, 19 Oct 2007 13:33:39 +0200
Message-ID: <28B30BAE-9482-4219-924B-F0EDFB2936FB@wincent.com>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu> <20071019015715.GW14735@spearce.org> <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU> <20071019021618.GE3290@coredump.intra.peff.net> <A2491F60-A00E-412A-8389-1C9EB5EDFCEF@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 13:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IiqCZ-0007FZ-0B
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbXJSLeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 07:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbXJSLeb
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 07:34:31 -0400
Received: from wincent.com ([72.3.236.74]:59101 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbXJSLea convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 07:34:30 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9JBYI3W018281;
	Fri, 19 Oct 2007 06:34:22 -0500
In-Reply-To: <A2491F60-A00E-412A-8389-1C9EB5EDFCEF@mit.edu>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61690>

El 19/10/2007, a las 4:29, Michael Witten escribi=F3:

> Ah. Basically my 'pseudo-code' is correct, but redundant.

If I understood the original poster's proposal then I don't think =20
your code does what he asked for:

> What you want to happen is the following:
> =09
> 	git show HEAD:A.txt > path/B.txt
> 	git add path/B.txt
> 	mv A.txt B.txt
> 	git rm A.txt
>
> Is this correct?

Here you're copying the content of A.txt as it was in the last (HEAD) =20
commit, but from what the poster said he wants the content of A.txt =20
as it is staged in the index (that is, there may be staged but =20
uncomitted changes).

> Better:
>
>>  	mv A.txt path/B.txt
>> 	Point the index entry for A.txt to path/B.txt

Yes, that is basically what he was asking for, as I read it.

El 19/10/2007, a las 5:47, Jeff King escribi=F3:

> Hrm. So you _do_ want to do an index-only move of A to B, in which =20
> case
> the suggestion of a "git-mv --cached" seems sensible. Though I'm =20
> curious
> why you want that.

I agree that git-stash can be used in this workflow but I can also =20
imagine cases where the proposed "git-mv --cached" might be a bit =20
nicer. I'm thinking of occasions where you just want to do something =20
like:

   git mv --cached foo bar
   git add --interactive bar

I'm not sure the proposed "--cached" switch should ever be the =20
default -- would need to ponder that one -- but I do think the switch =20
would be a nice addition.

Cheers,
Wincent
