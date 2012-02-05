From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Specifying revisions in the future
Date: Sun, 5 Feb 2012 22:58:43 -0000
Organization: OPDS
Message-ID: <178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley>
References: <jgjkk0$qrg$1@dough.gmane.org> <m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home> <201202052324.59941.jnareb@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>, <jpaugh@gmx.us>,
	<git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Andreas Schwab" <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuB2d-0004iL-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab2BEW6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:58:34 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:2853 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288Ab2BEW6d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 17:58:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAK4IL09Z8r9j/2dsb2JhbABCilikWIEGgW0BBAEBBQgBAS4eAQEhCwIDBQIBAw4HAQIJJRQBBAgSBgcXBgESCAIBAgMBhTeCKwy4O4gVg08BKQwBAQkEFAsPCgGCb4EiCAEEBAwCgmZjBI1JkmmHUQ
X-IronPort-AV: E=Sophos;i="4.73,366,1325462400"; 
   d="scan'208";a="360210902"
Received: from host-89-242-191-99.as13285.net (HELO PhilipOakley) ([89.242.191.99])
  by out1.ip04ir2.opaltelecom.net with SMTP; 05 Feb 2012 22:58:31 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189982>

From: "Jakub Narebski" <jnareb@gmail.com>
To: "Andreas Schwab" <schwab@linux-m68k.org>
Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>; <jpaugh@gmx.us>; 
<git@vger.kernel.org>
Sent: Sunday, February 05, 2012 10:24 PM
> On Sun, 5 Feb 2012, Andreas Schwab wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>>
>>>>> "the successor of <commit>", OTOH, is not well defined, since there 
>>>>> can
>>>>> be several successors, and one can't order them reliably (you can't
>>>>> really know the set of successors, because they can exist in different
>>>>> repositories).
>>>>
>>>> Yet it would be nice to have a concise notation for "the nth successor
>>>> of <commit> towards <commit>" (using --first-parent ordering when
>>>> ambiguous).
>>>
>>> First, "the nth successor"... from which refs?
>>
>> From the first given commit towards the other given commit (the latter
>> defaulting to HEAD).
>
> That helps some, but not all situations, see below.
>
>> > Second, `--first-parent' won't help here.  Take for example the
>> > following situation:
>> >
>> >    ---X<---*<---.<---A
>> >             \
>> >              \--.<---B
>> >
>> > X+3 is A or B?
>>
>> If "towards A" then it is A, if "towards B", it is B.  In other words,
>> to get the "nth successor of C1 towards C2" take the leftmost possible
>> parent when walking from C2 to C1, then walk back n commits along this
>> path.  This way you should have an unambigous definition.
>
> Nope, still ambiguous:
>
>
>
>  ---X<---*<---.<---A<---.<---M<---
>           \                 /
>            \--.<---B<------/
>
> Is X+3 A or B?  Though '--first-parent + towards N' is I think 
> unambiguous.
> -- 
Is there also a rule missing for X+2, viewed from D, in this example

X<---Y<---Z<---
          \          \
A<----B<----C<----D
as to which order the first parent rule should _not_ be applied when D's 
first parent chain doesn't reach X (it reaches A).
Using 'oldest' first for alternate parent testing would make X+2 = B, whilst 
'newest' first would make X+2=Z. I have used the chain order for 
'newest/oldest', rather than commit date.
(I'm sure that there already exists a natural rule in the dag walk order).

Philip 
