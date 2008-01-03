From: =?UTF-8?B?R3LDqWdvaXJlIEJhcmJpZXI=?= <gb@gbarbier.org>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Thu, 03 Jan 2008 20:14:09 +0100
Message-ID: <477D3401.2010005@gbarbier.org>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src> <477A26FD.7020408@gbarbier.org> <m3myrpo1p0.fsf@roke.D-201> <20080101202352.GA4295@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 20:15:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAVXF-0005So-9V
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 20:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYACTOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 14:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbYACTON
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 14:14:13 -0500
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:51998 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbYACTOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 14:14:11 -0500
Received: from localhost (mfilter1-c.gandi.net [217.70.182.21])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id D8C76362B5;
	Thu,  3 Jan 2008 20:14:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter1-c.mgt.gandi.net
Received: from relay1-v.mail.gandi.net ([217.70.178.75])
	by localhost (mfilter1-c.mgt.gandi.net [217.70.182.21]) (amavisd-new, port 10024)
	with ESMTP id tkrLwWzjPNef; Thu,  3 Jan 2008 20:14:05 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id BC234362AF;
	Thu,  3 Jan 2008 20:14:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080101202352.GA4295@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69530>

Jan Hudec a =C3=A9crit :
> On Tue, Jan 01, 2008 at 10:12:28 -0800, Jakub Narebski wrote:
>  =20
>> Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:
>>
>>    =20
>>> I think that real HTTP support is better than all workarounds we
>>> will be able to find to get through firewalls (when CONNECT is not
>>> available, some awful VPNs that send Etherne over HTTP may work
>>> ;-)).  That's why I'm ok to work several hours on git code to
>>> enhance real HTTP(S) support.
>>>      =20
>> There was also an idea to create a CGI program, or enhance gitweb
>> to use for pushing. I don't know if it would be better way to pursue
>> to work around corporate firewalls, or not...
>>    =20
I subscribe to this point of view.
I will look at the list archive to search for what has been said before=
=20
about this.
>
> It is what bzr and mercurial do and I think it would be quite good wa=
y to go
> for cases like this.
Ok, I will have to look at bzr and mercurial...

>  Eg. while our corporate firewall does allow anything
> through connect on 443 (so I can use ssh that way), it does *not* sup=
port
> web-dav in non-ssl mode. So I eg. can't even get from public subversi=
on
> repositories at work.
>
> I have also thought about optimizing download using CGI, but than I t=
hought,
> that maybe there is a way to statically generate packs so, that if th=
e client
> wants n revisions, the number of revisions it downloads is O(n) and t=
he
> number of packs it gets them from (and thus number of round-trips) is
> O(log(n)). Assuming the client always wants everything up to the tip,=
 of
> course. Now this is trivial with linear history (pack first half, tha=
n half
> of what's left, etc., gives logarithmic number of packs and you alway=
s
> download at most twice as much as you need), but it would be nice if =
somebody
> found a way (even one that satisfies the conditions on average only) =
to do
> this with non-linear history, it would be very nice improvement to th=
e http
> download -- native git server optimizes amount of data transfered ver=
y well,
> but at the cost of quite heavy CPU load on the server.
>  =20
Well... frankly I don't think I'm able of such things.
Writing a walker over webdav or  a simple cgi is a thing I can do (I=20
think),  but I'm not tought enough (or not ready to take the time=20
needed) to have a look on the internals of packing revisions (whereas I=
=20
can imagine it would means that "my" walker would be suitable only for=20
small projects in terms of code amount and commit frequency).

I had a quick look on bzr and hg, and it seems that bzr use the easy wa=
y=20
(walker, no optimizations) and hg a cgi (therefore, maybe=20
optimizations). By quick look I mean that I sniff the HTTP queries on=20
the network during a clone. I need to look harder...

BTW I never looked at the git:// protocol. Do you think that by=20
tunneling the git protocol in a cgi (hg uses URLs of the form=20
"/mycgi?cmd=3Dmycommand&...", therefore I think "tunnel" is not a bad=20
word...) the performance would be good?
Maybe it's not that hard to write a performant HTTP/CGI protocol for Gi=
t=20
if it's based upon existing code such as the git protocol.

--=20
Gr=C3=A9goire Barbier - gb =C3=A0 gbarbier.org - +33 6 21 35 73 49
