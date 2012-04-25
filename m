From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 13:25:49 +0200
Message-ID: <4F97DF3D.1000507@in.waw.pl>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com> <1335184230-8870-4-git-send-email-pclouds@gmail.com> <xmqqd36wgam5.fsf@junio.mtv.corp.google.com> <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com> <4F97DAE4.4070706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:26:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0ML-0006YP-DI
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758513Ab2DYL0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 07:26:04 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35496 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab2DYL0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 07:26:03 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SN0M8-0007Jr-1N; Wed, 25 Apr 2012 13:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <4F97DAE4.4070706@viscovery.net>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196309>

On 04/25/2012 01:07 PM, Johannes Sixt wrote:
> Am 4/25/2012 12:46, schrieb Nguyen Thai Ngoc Duy:
>> 2012/4/25 Junio C Hamano <gitster@pobox.com>:
>>>>       /* Give years and months for 5 years or so */
>>>>       if (diff < 1825) {
>>>> ...
>>>>       }
>>>>       /* Otherwise, just years. Centuries is probably overkill. */
>>>> -     snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365);
>>>> -     return timebuf;
>>>> +     strbuf_addf(timebuf,
>>>> +              Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
>>>> +              (diff + 183) / 365);
>>>>  }
>>>
>>> This is just a tangent, but could we possibly come here and say "1 year
>>> ago"?
>>
>> Nice catch. Singular form here is unnecessary. If you plan to revert
>> that, please put a comment so nobody will attempt to convert it to
>> Q_() again next time while searching for possible candidates.
> 
> I am sure that there are languages (Russian? Polish?) where a variation is
> needed not only for the singular, but also for plural depending on the
> number, so we still want to have this wrapped in Q_().
Yeah, both Polish and Russian...

Polish:
Plural-Forms: nplurals=3; \
  plural=(n==1 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);

Russian:
Plural-Forms: nplurals=3; \
              plural=n%10==1 && n%100!=11 ? 0 : \
                     n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2;

Looking at http://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/Plural-forms.html, basically all languages which have nplurals=3 or nplurals=4.

Zbyszek
