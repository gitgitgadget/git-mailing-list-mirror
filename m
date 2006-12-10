X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 20:11:52 +0100
Message-ID: <200612102011.52589.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612101402.51363.jnareb@gmail.com> <457C0F8F.7030504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 19:09:42 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RukytlrF9kCcV2u6Z7qwl2KFmhmUg8qZPxAQG2Zis/gdaa5HlQmjbvpheBddDMRraMlScS5Vh0tUzmkqWVLxKnB5jhBo5TleO5Td0GmkNCudVG7tNqjxRhfUdNQ8TXLYZu/qVlhw7TPoh9WgKLM77OZBN3JHWxLGoC0R99kS1bw=
User-Agent: KMail/1.9.3
In-Reply-To: <457C0F8F.7030504@garzik.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33916>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtU3P-0007W6-AQ for gcvg-git@gmane.org; Sun, 10 Dec
 2006 20:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762427AbWLJTJf convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 14:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762429AbWLJTJf
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 14:09:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:49411 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762381AbWLJTJe (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 14:09:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1143379uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 11:09:33 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr8637908ugm.1165777773222; Sun, 10
 Dec 2006 11:09:33 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id x37sm4710911ugc.2006.12.10.11.09.32; Sun, 10 Dec
 2006 11:09:32 -0800 (PST)
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Jeff Garzik wrote:
> Jakub Narebski wrote:
>> Jeff Garzik wrote:
>>> Jakub Narebski wrote:
>>>>
>>>> P.S. Any hints to how to do this with CGI Perl module?
>>>
>>> It's impossible, Apache doesn't supply e-tag info to CGI programs. =
=A0(it=20
>>> does supply HTTP_CACHE_CONTROL though apparently)
>>=20
>> By ETag info you mean access to HTTP headers sent by browser
>> If-Modified-Since:, If-Match:, If-None-Match: do you?

Adn in CGI standard there is a way to access additional HTTP headers
info from CGI script: the envirionmental variables are HTTP_HEADER,
for example if browser sent If-Modified-Since: header it's value
can be found in HTTP_IF_MODIFIED_SINCE environmental variable.

But of course gitweb should rather use mod_perl if possible, so
somewhere in gitweb there would be the following line:

  $in_date =3D $ENV{'MOD_PERL'} ?
    $r->header('If-Modified-Since') :
    $ENV{'HTTP_IF_MODIFIED_SINCE'};

or something like that...
=20
> You can use this attached shell script as a CGI script, to see precis=
ely=20
> what information Apache gives you. =A0You can even experiment with pa=
ssing=20
> back headers other than Content-type (such as E-tag), to see what sor=
t=20
> of results are produced. =A0The script currently passes back both E-T=
ag=20
> and Last-Modified of a sample file; modify or delete those lines to s=
uit=20
> your experiments.

It is ETag, not E-tag. Besides, I don't see what the attached script is
meant to do: it does not output the sample file anyway.

>> It's a pity that CGI interface doesn't cover that...
>>=20
>>> You could probably do it via mod_perl.
>>=20
>> So the cache verification should be wrapped in if ($ENV{MOD_PERL}) ?
>=20
> Sorry, I was /assuming/ mod_perl would make this available. =A0The HT=
TP=20
> header info is available to all Apache modules, but I confess I have =
no=20
> idea how mod_perl passes that info to scripts.
>=20
> Also, an interesting thing while I was testing the attached shell=20
> script: =A0even though repeated hits to the script generate a proper =
304=20
> response to the browse, the CGI script and its output run to completi=
on.=20
> =A0 So, it didn't save work on the CGI side; the savings was solely i=
n not=20
> transmitting the document from server to client. =A0The server still =
went=20
> through the work of generating the document (by running the CGI), as =
one=20
> would expect.

The idea is of course to stop processing in CGI script / mod_perl scrip=
t
as soon as possible if cache validates.

I don't know if Apache intercepts and remembers ETag and Last-Modified
headers, adds 304 Not Modified HTTP response on finding that cache vali=
dates
and cuts out CGI script output. I.e. if browser provided If-Modified-Si=
nce:,
script wrote Last-Modified: header, If-Modified-Since: is no earlier th=
an
Last-Modified: (usually is equal in the case of cache validation), then
Apache provides 304 Not Modified response instead of CGI script output.

--=20
Jakub Narebski
