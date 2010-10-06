From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Thu, 7 Oct 2010 01:32:11 +0200
Message-ID: <201010070132.12196.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <201010070100.33478.jnareb@gmail.com> <AANLkTikVmHgk=jLCs11tJ7yhUL4H2gnM_pKkXOJSxYq7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dTH-0006iw-08
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759186Ab0JFXcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:32:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36509 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0JFXcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:32:19 -0400
Received: by fxm4 with SMTP id 4so64770fxm.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AqFTUj0u1zzdEb9BxQHxl5QF+q+GmzaumSo+undOH+w=;
        b=a7VWCCNVQSkhOaYNyikz9Cvyysd0sHLttrMZFjT/IgqTw1zvaOCrQT8/69p93iwYtl
         o17CP03Z4aRcOJCw1UNZLi5nuxUTLv1P+RKVaILOs1ODKP+BVWRn0hyVjD/KlJQHRy7e
         IcQNaHOKp1wDhms5u8tigexwgxZ4k6NLUt+8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JDv3Dx5+lZ5b1QEOoz5evVd8gtHSZfiQg+tRpsN8OunZ1TsrE/+cCnvbTuJrxqo3qf
         FhQSQ2kw8B3GtHjCwTxu8aWxIsIZTzuryQ41erquGe/5T1HDrc+trSw8fNX9p89KXpKc
         xxEucdHceeFNlNhTXzyCDs62rhkU88OWwGPEM=
Received: by 10.223.120.66 with SMTP id c2mr1766500far.85.1286407936390;
        Wed, 06 Oct 2010 16:32:16 -0700 (PDT)
Received: from [192.168.1.13] (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 10sm731815fax.18.2010.10.06.16.32.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:32:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikVmHgk=jLCs11tJ7yhUL4H2gnM_pKkXOJSxYq7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158356>

On 7 Oct 2010, Thomas Adam wrote:
> On 7 October 2010 00:00, Jakub Narebski <jnareb@gmail.com> wrote:

[...]=20
>> I should really have run gitweb, caching modules and tests through
>> perlcritic...
>=20
> And your other patches.   :)

Well, you can't run (as far as I know) *patches* though perlcritic ;-)

>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last if $read_c=
nt =3D=3D 0;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $size_left -=3D=
 $read_cnt;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #last if $size_=
left <=3D 0;
>>>> + =C2=A0 =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 close $read_fh
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn'=
t close file '$file' opened for reading: $!";
>>>> + =C2=A0 =C2=A0 =C2=A0 return $buf;
>>>> +}
>>>
>>> "use Carp;" would be more useful here, and hence croak() and confes=
s().
>>
>> For a web application we usually do not want to have too detailed er=
ror
>> message present to client (to web browser) to avoid leaking of sensi=
tive
>> information.
>=20
> Unless we use fatalstobrowser, it will still end up in Apache's error
> log.  I don't see a problem here.

The problem is that we do equivalent of fatalsToBrowser, i.e. set up
error handler with 'set_message(\&handle_errors_html);'.
=20
>>> unless( defined $code and ref $code eq 'CODE' )
>>
>> "ref($code) eq 'CODE'" would be enough; 'undef' is not reference, an=
d
>> ref(undef) returns "".
>=20
> Sure, but it still assumes $code is a reference, and there's no
> guarantee of that in the code path.

Yes, but if $code is not reference, then ref($code) evaluates to empty
string, and "ref($code) eq 'CODE'" comparison would fail... without any
warnings.  You don't need to check upfront for "defined $code"; it is
the only thing I wanted to nitpick.
=20
--=20
Jakub Narebski
Poland
