From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 05:45:06 -0500
Message-ID: <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 12:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGo6m-0005FC-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 12:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759826Ab3ICKpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 06:45:08 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46135 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759831Ab3ICKpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 06:45:07 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so4912402lbh.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Z9VipgYYtt9u+RikXp0vosKjCFw+86kdlBSSIAGzg6k=;
        b=jHSNLVUI40gdIkHxZ632AAM69G/F9WYFkdncUbA9vcY4kYiEAmcSXRsC/C2ZvQi3Qk
         vspbWc9f8QjnVgl1GDXfhtuPkneH7YfaHfOimmhcrcjDux+WUNC7dFgcOzqt6TxRkxQ6
         0Yk+6YCmxf1Xu3fSG9godpMCo3iq/43QClk/YhgPRWNJv5judw6+feiXZKRom7yTIQy4
         V30jegeo81Jq1zzbXUEQKFTeWl2iNRk70ARy28tOr03yFsVDEXF7B2LebVv0cJSCCVbC
         hr/vBtaqRM/EkmsywxXHJinVwcFfHDCdv1kc2V/vTCOeVMWfNILaF9giPaBq/6DXP5nK
         xC0Q==
X-Received: by 10.152.3.42 with SMTP id 10mr26325431laz.22.1378205106448; Tue,
 03 Sep 2013 03:45:06 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 03:45:06 -0700 (PDT)
In-Reply-To: <20130903080358.GA30158@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233713>

On Tue, Sep 3, 2013 at 3:03 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 03, 2013 at 09:51:07AM +0200, SZEDER G=C3=A1bor wrote:
>
>> > I wonder if we should have a:
>> >
>> >   test_cmp_args () {
>> >           echo "$1" >expect &&
>> >           echo "$1" >actual &&
>> >           test_cmp expect actual
>> >   }
>> >
>> > to let these remain one-liners like:
>> >
>> >   test_cmp_args "$(git rev-parse start)" "$(git rev-parse final^1^=
1^1)"
>>
>> This idea come up before, but there is one flaw which makes this
>> function less useful: a non-zero exit code of the commands in the
>> command substitutions would be lost.
>
> Good point. You'd probably have to do something gross with eval, like=
:
>
>   test_cmp_args () {
>     eval "$1" >expect &&
>     eval "$2" >actual &&

I don't see any reason to perpetuate these yoda comparisons.

eval "$2" >expect &&
eval "$1" >actual &&

>     test_cmp expect actual
>   }




--=20
=46elipe Contreras
