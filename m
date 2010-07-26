From: "Jasper St. Pierre" <jstpierre@mecheye.net>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Mon, 26 Jul 2010 14:44:30 -0400
Message-ID: <AANLkTinmwZiqdhrzSnF=3nADwoFbor8XUAfw1LDjWoHR@mail.gmail.com>
References: <201007231518.31071.trast@student.ethz.ch> <20100726154041.GA18762@coredump.intra.peff.net> 
	<AANLkTikmFVHeMVEgj_G5h8VMNaw0zIm0Ol-vC1ffc45v@mail.gmail.com> 
	<AANLkTimRrpiv7cu=j598K3x4h3UGW7-Hik6-6jA8R_5J@mail.gmail.com> 
	<AANLkTilDKIwcQ0OmXAihq8AkS7v31HseEI3BGTUyzl9v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:44:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSfa-0003Cs-Fc
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab0GZSox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 14:44:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64981 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab0GZSox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 14:44:53 -0400
Received: by wyf19 with SMTP id 19so2399852wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 11:44:52 -0700 (PDT)
Received: by 10.216.185.143 with SMTP id u15mr7438185wem.21.1280169890455; 
	Mon, 26 Jul 2010 11:44:50 -0700 (PDT)
Received: by 10.216.79.68 with HTTP; Mon, 26 Jul 2010 11:44:30 -0700 (PDT)
In-Reply-To: <AANLkTilDKIwcQ0OmXAihq8AkS7v31HseEI3BGTUyzl9v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151878>

Hm. I've always wondered about the percent double-encoding problem,
where the "%"
in "%2B" double-encodes to "%252B", which might require the mandatory s=
erver
implementation then.

I do think that because "git://git.gnome.org/git+" was working,
something on the server
was going right.

On Mon, Jul 26, 2010 at 2:35 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jul 26, 2010 at 18:22, Jasper St. Pierre <jstpierre@mecheye.n=
et> wrote:
>> Where is '+' used in the URL context? I don't see that it's a
>> replacement for '+'
>> aside from formencoded, which is from CGI, not HTTP or the URI spec.
>
> In my example? Nowhere, but I used : and @, which are also reserved
> characters.
>
>> I also can't access something called "test 2.txt" from Apache with
>> "http://localhost/test+2.txt", so I don't think it's unescaping the =
'+'.
>
> Yes, that's not supposed to work. But you should be able to access
> "test+2.txt" using /test+2.txt and /test%2B.txt and
> /%74%65%73%74%2B2%2E%74%78%74 for that matter.
>
> git-daemon only seems to handle the first form. Which is probably a
> bug, maybe it doesn't *have to* URI unescape its arguments, but it's
> probably a good idea anyway. E.g. some systems that handle URIs will
> convert : to %3A automatically when passing them through. That would
> break a git URL.
>
>> I don't think we should do anything about the '+' case, except where=
 used in
>> formencoded parameters (aka the "query string"), where it is used.
>
> I don't really have an opinion on what we should do. It's not a
> problem for me, I'm just noting how it could break, and that maybe we
> should try harder and support URI escaping where we handle URLs.
>
