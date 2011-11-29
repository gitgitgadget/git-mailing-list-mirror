From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Tue, 29 Nov 2011 01:49:36 +0100
Message-ID: <201111290149.36931.jnareb@gmail.com>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com> <201111282332.07276.jnareb@gmail.com> <CAKD0Uuw35Kdno=OxqP5SYtaVjqUFZCLL9fSSscN7sq=KmycyxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 01:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVBtJ-00040A-6s
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 01:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab1K2Atk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 19:49:40 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49647 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1K2Atj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 19:49:39 -0500
Received: by bke11 with SMTP id 11so9323597bke.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=KWIqIhPFIEVveZCUS99MGoxN8CxjpHlqMXfGkShPhcc=;
        b=UpdgPXCG68/phrny0Rj0B12HP51giUbNYXhhBJ5eQE0gFmfbqf7AsIkyaICdrOqwV0
         oF8C6vz6yHoepHlxJLrNCY4AEBvohHdpel+xbGwEXUqwwAy/Zifolk38/0a3UOPjydad
         POP5wUEX8cAVawz12B3iNJC3bJ4y70s4IxfLg=
Received: by 10.204.129.88 with SMTP id n24mr46942053bks.19.1322527778193;
        Mon, 28 Nov 2011 16:49:38 -0800 (PST)
Received: from [192.168.1.13] (abwn156.neoplus.adsl.tpnet.pl. [83.8.237.156])
        by mx.google.com with ESMTPS id cc2sm33354335bkb.8.2011.11.28.16.49.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 16:49:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAKD0Uuw35Kdno=OxqP5SYtaVjqUFZCLL9fSSscN7sq=KmycyxA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186041>

J=C3=BCrgen Kreileder wrote:
> On Mon, Nov 28, 2011 at 23:32, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> J=C3=BCrgen Kreileder wrote:
>>> On Mon, Nov 28, 2011 at 21:13, J=C3=BCrgen Kreileder <jk@blackdown.=
de> wrote:
>>>> On Mon, Nov 28, 2011 at 17:54, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>>> =C2=A0[...]
>>>>>
>>>>> The configuration is very similar. =C2=A0Perhaps that is the diff=
erence between
>>>>> Apache 2.0.x (mine) and Apache 2.2.x (yours).
>>>>>
>>>>> Does adding `$r->err_headers_out();` before `$r->status(200);` he=
lps?
>>>>> I'm grasping at straws here. =C2=A0mod_perl documentation is not =
very helpful.
>>>>
>>>> Doesn't help unfortunately. =C2=A0It's hard to find any informatio=
n about
>>>> this on the net (except for your comment on stackoverflow :).
>>>>
>>>> The only way to get mod_perl to return a custom error message with
>>>> correct status code I've found so far is $r->custom_response($stat=
us,
>>>> $msg). =C2=A0Unfortunately mod_perl then ignores headers I set, e.=
g.
>>>> content-type.
>>>
>>> I guess this explains it:
>>> http://foertsch.name/ModPerl-Tricks/custom-content_type-with-custom=
_response.shtml
>>> Requires quite some restructuring to gitweb.perl.
>>
>> I'm coming close to declaring that ModPerl::Registry is horribly bro=
ken
>> with respect to error pages created by CGI, and say that we don't su=
pport
>> it, removing mod_perl configuration examples from gitweb documentati=
on.
>=20
> Makes sense.  The benefits of mod_perl are properly small for gitweb =
anyway.

Anyway you can run gitweb with FastCGI (supposedly - I don't know if it
was tested), which provides the same (or most of the) advantages that
mod_perl gives, without the troubles.  Just rename gitweb.cgi to
gitweb.fcgi and configure web server appropriately (and have FCGI Perl
module installed).

--=20
Jakub Narebski
Poland
