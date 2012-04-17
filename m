From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Tue, 17 Apr 2012 10:23:17 -0400
Message-ID: <4F8D7CD5.3080508@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-4-git-send-email-marcnarc@xiplink.com> <20120416223429.GA13440@burratino> <4F8D2195.9030507@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK9Ip-00039y-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 16:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab2DQOWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 10:22:40 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:44793 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab2DQOWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 10:22:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp14.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 075F61D80B5;
	Tue, 17 Apr 2012 10:22:37 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp14.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9138C1D809E;
	Tue, 17 Apr 2012 10:22:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <4F8D2195.9030507@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195761>

On 12-04-17 03:53 AM, Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 04/17/2012 12:34 AM, Jonathan Nieder wrote:
>> marcnarc@xiplink.com wrote:
>>
>>> +        grep descriptive-branch actual | grep "[new branch]"&&
>>> +        grep descriptive-tag actual | grep "[new tag]"&&
>>> +        grep others/crazy actual | grep "[new ref]"
>>
>> Careful. :)  I suppose the simplest fix would be to leave out the
>> brackets so the '[new ref]' tag is not misinterpreted as a character
>> class, like so:
>>
>>     grep "new branch.*descriptive-branch" actual&&
>>     grep "new tag.*descriptive-tag" actual&&
>>     grep "new ref.*others/crazy" actual
>=20
> s/grep/test_i18ngrep/

With the switch to test_i18ngrep do I have to worry about possible rege=
xp
misinterpretations of "[new branch]" et al?

Jonathan, I figured regexps aren't an issue with plain "grep" (unlike "=
egrep"
or "grep -e").  I take it this is a portability concern -- are there sy=
stems
that actually replace plain "grep" like a "egrep"?

Also, in my test's pipes I believe only the second "grep" needs to be
"test_i18ngrep", right?  (Only strings like "[new branch]" are
internationalized.)

> Also:
>>> +    echo "Nuts" >> crazy &&
>>> +    git add crazy &&
>>> +    git commit -a -m "descriptive commit" &&
>>> +    git update-ref refs/others/crazy HEAD &&
>>> +    (
>>> +        cd descriptive &&
>>> +        git fetch o 2> actual
> redirections should be without spaces between '>' and the filename
> (>>crazy, 2>actual), for portability.

Consistency; got it.

Thanks guys!

		M.
