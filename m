From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Tue, 9 Jun 2015 10:39:16 +0200
Message-ID: <CAP8UFD1EwRx=yF0ogiAjZdLf6idU+d1_YAsubHKRcXb866_8hw@mail.gmail.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git <git@vger.kernel.org>, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2F4E-0007A5-NE
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 10:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbbFIIjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 04:39:21 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34578 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbbFIIjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 04:39:17 -0400
Received: by wgv5 with SMTP id 5so7279732wgv.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/Xfs2dA14jzOYW5ogOPlha8PciDTCG4eDPK4xV16ToA=;
        b=zIOjSP5z4GnrmocIGD3rCkqO25U+++xmvEgib08Qub6205a61t53JSei6Zd79MdRFK
         UJi98R+g2kDa5NHieQeHNJiJOvh0qDHBtdUeogO+1Ph4CYfHJoIqr8RijdHxxolcS2C8
         E66ov1+IrnjmzYzEuEG7NSg88gkRv3G+jWe4zoGwvI5pi2pC2oplQrdaN1CSn77QeZ1K
         jLEVg5puH/Ri+lyeb5jyxNbXiZ2sQdjp1xXH3AbCrm8PxwXgjO2UwTwctzh3UjuxUUgX
         BfuqgnkbZQ6MySVIrFUHOITrdLsGj2z74erPEl2wDKZeL3PCRxhnbTpFOECYSEzlXBLl
         fqEg==
X-Received: by 10.194.95.132 with SMTP id dk4mr40936459wjb.88.1433839156341;
 Tue, 09 Jun 2015 01:39:16 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 9 Jun 2015 01:39:16 -0700 (PDT)
In-Reply-To: <vpqbngpl5zu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271152>

On Tue, Jun 9, 2015 at 9:01 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
>
> s/add/addition/
>
> Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:
>
>> +static const char *name_bad;
>> +static const char *name_good;
>
> Same remark as PATCH 2.

As for patch 2, I think "name_bad" and "name_good" are better than
"name_new" and "name_old".

[...]

>> +             name_bad = "bad";
>> +             name_good = "good";
>> +     } else {
>> +             strbuf_getline(&str, fp, '\n');
>> +             name_bad = strbuf_detach(&str, NULL);
>> +             strbuf_getline(&str, fp, '\n');
>> +             name_good = strbuf_detach(&str, NULL);
>> +     }
>
> I would have kept just
>
>         name_bad = "bad";
>         name_good = "good";
>
> in this patch, and introduce BISECT_TERMS in a separate one.

Yeah I agree that it is more logical to have first a patch that does
on bisect.c the same thing as patch 2 does on git-bisect.sh.

For example the patch series could be for now:

1) bisect: typo fix
2) bisect: replace hardcoded "bad|good" with variables
3) git-bisect: replace hardcoded "bad|good" with variables
4) bisect: simplify adding new terms
5) bisect: add old/new terms
