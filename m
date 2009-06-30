From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 1/7] gitweb: refactor author name insertion
Date: Tue, 30 Jun 2009 23:08:58 +0200
Message-ID: <200906302308.58488.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <200906302204.40876.jnareb@gmail.com> <cb7bb73a0906301323j32e1f8dam9ba185401b2d1e2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 23:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLkZg-0005xf-QD
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 23:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZF3VI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 17:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZF3VI5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 17:08:57 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64711 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZF3VI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 17:08:57 -0400
Received: by fxm18 with SMTP id 18so420385fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TeeNp9HjLZX97iC3UJCtp7tf8lU/UeCDbZWCQSfUuig=;
        b=cBcNXj/iWY2hRQYwVsqFpnNtX152Tsze6JD6CN3UrDGyGcd8ma1Na6GgEEmO82FoJ2
         Qx0P8UViRQRkaDHnoPn1QbLdAo9QJqv1xy2CSfNxlHfH9BkieFgYHVIPJaqivs7BMHBM
         ItXAaGlCvpG/lTiFy7lXxvQl5Bm7YH78r/WjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LIrmAsVitaRDRtEylsBuKu1rpfVPsTSTFjUuQfIiu+rRWZmyM72pylGJxgZT6iox+u
         l7QQTekHedDEDF8QJwtyR9ARsueVYK/BWmxrD/nOSgU8WqdoZon39vKqeH5ikuz6kGB3
         Jex4bWWq43X4FlP+p7wqs1I/9iGi8k/OjY9hw=
Received: by 10.103.24.11 with SMTP id b11mr5154389muj.133.1246396139420;
        Tue, 30 Jun 2009 14:08:59 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id w5sm2277775mue.4.2009.06.30.14.08.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 14:08:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906301323j32e1f8dam9ba185401b2d1e2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122544>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:
> 2009/6/30 Jakub Narebski <jnareb@gmail.com>:
>> On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

# prints time in local timezone, from result of parse_date=20
# in the following format: " (HH:MM +/-tz_offset)" or " (%H:%M %z)"
# with "atnight" warning when 0 <=3D hour_local < 6

or something like that.  Or just

# prints time in local timezone, from result of parse_date=20

>>> +sub print_local_time {
>>> + =A0 =A0 my %date =3D @_;
>>> + =A0 =A0 if ($date{'hour_local'} < 6) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(" (<span class=3D\"atnight\">%02d:=
%02d</span> %s)",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $date{'hour_local'}, $dat=
e{'minute_local'}, $date{'tz_local'});
>>> + =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(" (%02d:%02d %s)",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $date{'hour_local'}, $dat=
e{'minute_local'}, $date{'tz_local'});
>>> + =A0 =A0 }
>>> +}
>>
>> Very nice refactoring.
>>
>> It could do with a comment describing its output, but it is not
>> necessary, and IMHO not worth resend. =A0We can always add it "in tr=
ee".
>=20
> Damn! I was sure I'd forget something ...

Don't worry. It can be always addd later, or Junio can just squash=20
proposed comment (see above).

--=20
Jakub Narebski
Poland
