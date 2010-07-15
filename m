From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 01/11] gitweb: fix esc_url
Date: Thu, 15 Jul 2010 21:32:38 +0200
Message-ID: <201007152132.39441.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <201007151552.23324.jnareb@gmail.com> <7vfwzkvahf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZUAq-0005Kz-BC
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934542Ab0GOTcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 15:32:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59571 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934512Ab0GOTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:32:41 -0400
Received: by fxm14 with SMTP id 14so659653fxm.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KGl8H6T7NHVP5ePsbarntwgO1GYhHHe2BCAlcbX0PZ8=;
        b=NU3fLIH/r2KuwOQN9R18UWwCb5aqnfHh+XUfhBlUSjkfAW5ZZVZ7hoVuX+Q5jIlZkp
         tzWoFprT35KYqpLpvG2OalP7JBUApCBfXLknoGkW+w68YAZ3jh4vWVz225qd3p93pu8B
         KPc8jmxr8vACqq7DNzFsFb70KaXB34aguICc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kYRq4PN/k1p//4su706F/aloJrTxSUXdmwltTrW1JPelZP2LZrrxbMZs9e4X6kOW5l
         T3Ew6+X5pqVp2fyS/mUdrhxDXqRyp2tU9AcovZagacfs8pWhXCWCzQUMt+lKVoPfZiI3
         1pIm4jf3HVKy6MYxSRtIFzTwRWR9kNndopoQY=
Received: by 10.223.109.140 with SMTP id j12mr1077785fap.22.1279222360301;
        Thu, 15 Jul 2010 12:32:40 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id m3sm440717fai.41.2010.07.15.12.32.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:32:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfwzkvahf.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151117>

Dnia czwartek 15. lipca 2010 20:57, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:
>>> The custom CGI escaping done in esc_url failed to escape UTF-8
>>> properly. Fix by using CGI::escape on each sequence of matched
>>> characters instead of sprintf()ing a custom escaping for each byte.
>>>=20
>>> Additionally, the space -> + escape was being escaped due to greedy
>>> matching on the first substitution. Fix by adding space to the
>>> list of characters not handled on the first substitution.
>>>=20
>>> Finally, remove an unnecessary escaping of the + sign.
>>>=20
>>> commit 452e225 has missed fixing esc_url.
>>>=20
>>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
[...]
>> Second, I would probably write commit message differently, to emphas=
ize
>> that it is just finishing work of commit 452e225 (gitweb: fix esc_pa=
ram,
>> 2009-10-13) by fixing esc_url like it fixed esc_params.  But it is n=
ot
>> something very important.
>=20
> I tentatively rewrote the message like so:
>=20
>     Earlier, 452e225 (gitweb: fix esc_param, 2009-10-13) fixed CGI
>     escaping rules used in esc_url.  A very similar logic exists in
>     esc_param and needs to be fixed the same way.

Thanks.

> It makes one wonder why they have to be separate functions, doesn't i=
t,
> though?

They need to be separate because you have to escape params-related
special characters ('?', ';', '=3D') when quoting params, but you
shouldn't when escaping (external) URL as a whole.

--=20
Jakub Narebski
Poland
