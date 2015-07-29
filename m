From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Wed, 29 Jul 2015 23:34:27 +0200
Message-ID: <vpqmvyed4ws.fsf@anie.imag.fr>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder\@gmail.com" <christian.couder@gmail.com>,
	"gitster\@pobox.com" <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 23:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKYzp-0003SN-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 23:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbbG2Veg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 17:34:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45955 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbbG2Vef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 17:34:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLYNZu026438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 23:34:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLYRFk024113;
	Wed, 29 Jul 2015 23:34:27 +0200
In-Reply-To: <CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 29 Jul 2015 15:19:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 23:34:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TLYNZu026438
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438810466.50904@yuWb0+pbXYNbMZOLtG5A0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274958>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -1254,9 +1273,26 @@ static void emit(const char *cp, const char *ep)
>> +static void reset_formatting_state(struct ref_formatting_state *state)
>> +{
>> +       int quote_style = state->quote_style;
>> +       memset(state, 0, sizeof(*state));
>> +       state->quote_style = quote_style;
>
> I wonder if this sledge-hammer approach of saving one or two values
> before clearing the entire 'ref_formatting_state' and then restoring
> the saved values will scale well. Would it be better for this to just
> individually reset the fields which need resetting and not touch those
> that don't?

I'm the one who suggested these 3 lines. I wrote them this way with the
assumption that there would only be 1 field to keep, and thet the rest
of the series was going to add more fields to reset (currently true I
think), to avoid the risk of forgetting one value to reset.

I'm fine with the other way around too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
