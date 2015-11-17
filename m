From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Tue, 17 Nov 2015 13:26:44 +0100
Message-ID: <20151117132644.Horde.0sLxtm6pFWvFfyP7Yzukk0F@webmail.informatik.kit.edu>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
 <1447717227.23262.10.camel@intel.com>
 <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
 <1447719035.23262.17.camel@intel.com> <20151117072049.GA25414@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>, git@vger.kernel.org,
	gitster@pobox.com, spearce@spearce.org, lee.marlow@gmail.com,
	felipe.contreras@gmail.com, jacob.keller@gmail.com
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 13:27:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyfLh-0003lb-Cm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 13:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbbKQM05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2015 07:26:57 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59442 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702AbbKQM05 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 07:26:57 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZyfLW-0002PM-1M; Tue, 17 Nov 2015 13:26:50 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZyfLQ-0003nC-Ii; Tue, 17 Nov 2015 13:26:44 +0100
Received: from x590e0731.dyn.telefonica.de (x590e0731.dyn.telefonica.de
 [89.14.7.49]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 17 Nov 2015 13:26:44 +0100
In-Reply-To: <20151117072049.GA25414@flurp.local>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1447763210.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281405>


Quoting Eric Sunshine <sunshine@sunshineco.com>:

> On Tue, Nov 17, 2015 at 12:10:35AM +0000, Keller, Jacob E wrote:
>> On Mon, 2015-11-16 at 18:50 -0500, Eric Sunshine wrote:
>> > It should be possible to extract the alias within the shell itself
>> > without a separate process. For instance:
>> >
>> > =C2=A0=C2=A0=C2=A0=C2=A0read alias rest
>> >
>> > will leave the first token in $alias and the remainder of the line=
 in
>> > $rest, and it's all done within the shell process.

Actually, putting this read in a while loop and feeding 'git =20
send-email's output into that does fork() a subshell:

   $ echo "outside: $BASH_SUBSHELL" |while read line ; do echo "$line  =
=20
inside: $BASH_SUBSHELL" ; done
   outside: 0  inside: 1

>> I'll look into this :)
>
> My reason for asking is concern about scripts possibly breaking if
> someone comes along and wants to "fix" --dump-aliases to also dump
> the alias expansions. One possibility is just to punt today and say
> that when that feature is needed in the future, then that someone can
> add a --verbose option to complement --dump-aliases which would emit
> the alias expansions as well. One nice thing about punting at this
> point is that we don't (today) have to define a format for the output
> of the expansions.

I think we should cross the bridge when we get to it.

However, we could still be nice to that brave soul who might want to =20
cross it in the future, and since at this point we are interested in =20
listing only alias names, perhaps we should not appropriate the =20
broader '--dump-alias' option, but go with the more specific =20
'--dump-alias-names' instead.


G=C3=A1bor
