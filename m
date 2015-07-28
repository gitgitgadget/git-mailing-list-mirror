From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Tue, 28 Jul 2015 21:33:11 +0530
Message-ID: <CAOLa=ZSDQLWF=ZsSeJ0rCtqTxh23bKSSSRfj9mGYaVJiMYbj8w@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
 <vpqd1zc1xik.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7M6-0004UC-QU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbbG1QDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:03:43 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33057 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbG1QDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:03:41 -0400
Received: by oige126 with SMTP id e126so71842761oig.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fFA6WIVLYyvHdAEdp1xZGsCyDMgMOazOx5E3zIkaY/8=;
        b=wgVbOX3KjD8g4r1G236v24UJo5hvyszBvpkFTZuau1xxOcniHLe+f01e2dC68LviVP
         r4yHugDlv+vDah0eQKKmM+5oBi+RhgbRptqKt9HbaOEIPmyo8kf94olwILMAkGkq5eHu
         x87m66tXCokQtz7sASPluBT4fSCHLOklb+apDurwjAbG+hMFe38IUmx3QHOrYG42gtDy
         UZ+ysJeYXUEccpvoqq+LeADDf61H7+cBovz1YKiaswo1OD3d59Cpf55Np72toQPIU+jw
         HxzAtO8p8e+ZUsJsqoAfXXPMF4c7r84Ia8fb7ckxqnn5hDoagyqeJinrB9h1nm4/B0pi
         9kqg==
X-Received: by 10.202.186.132 with SMTP id k126mr33863512oif.60.1438099420647;
 Tue, 28 Jul 2015 09:03:40 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 09:03:11 -0700 (PDT)
In-Reply-To: <vpqd1zc1xik.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274781>

On Tue, Jul 28, 2015 at 2:15 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -133,4 +133,20 @@ test_expect_success 'reverse version sort' '
>>       test_cmp expect actual
>>  '
>>
>> +get_color ()
>> +{
>> +     git config --get-color no.such.slot "$1"
>> +}
>> +
>> +cat >expect <<EOF &&
>> +$(get_color green)foo1.10$(get_color reset)||
>> +$(get_color green)foo1.3$(get_color reset)||
>> +$(get_color green)foo1.6$(get_color reset)||
>> +EOF
>> +
>> +test_expect_success 'check `colornext` format option' '
>> +     git for-each-ref --format="%(colornext:green)%(refname:short)||" | grep "foo" >actual &&
>> +     test_cmp expect actual
>> +'
>
> This is not a very good test: you're not checking that colornext applies
> to the next and only this one. Similarly to what I suggested for
> padright, I'd suggest
>
>   --format="%(refname:short)%(colornext:green)|%(refname:short)|%(refname:short)|"
>

That was the purpose of the "||" but that doesn't check the color of next atom,
Thanks for the example will use that :)

-- 
Regards,
Karthik Nayak
