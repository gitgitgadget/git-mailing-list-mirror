From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/28] fetch: add --update-shallow to get refs that
 require updating .git/shallow
Date: Wed, 27 Nov 2013 19:54:14 +0700
Message-ID: <CACsJy8CJRzCVzJ7LfEY_2Gxzq=96BB44UQUeMD0R-a6buYNu4A@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1385351754-9954-16-git-send-email-pclouds@gmail.com> <CAPig+cRMj_RY53--OLDmonZLzhzf0Cu+JrDc8LAicSn5QGKNyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 13:54:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vledn-0003np-5x
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab3K0Myr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 07:54:47 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:62650 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab3K0Myp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 07:54:45 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so5195197qec.23
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VdQNlD25ZFHpWfwQ0G0fBS9NjlbtPMehX+UyCA78/G8=;
        b=d2Iv76f/PTp+wYsuFFZXfp9gricYX21GZQFQtrr1qeElIzpe3YTYM27v3Emy4nYh7n
         HeC+MEcEpp+9GJmFsXqdstpjh4lNJt5/0yzffTaRusqmr71BivlEecF1CvrXrau3Ft+p
         9Mh1KCbXnywuitXzlbjo3EiwYPIcGF21+ZTDFgOBa2w82GCStg9OZwsEN00gZZQdBpKC
         pkZP5fveXcCufujZSW91TxoQHRLok6K2O/b5I07p9clRYRF5uqOcpPkTLFLwFK7ZCjMM
         Ud5OcdJuAb4NPNg1XiFQ9nQDYuEfQeg/d7ZOxLo0DVuW60iWMIuyOBhvRaPSuGmitWxz
         XHMQ==
X-Received: by 10.224.171.196 with SMTP id i4mr66493673qaz.38.1385556884617;
 Wed, 27 Nov 2013 04:54:44 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Wed, 27 Nov 2013 04:54:14 -0800 (PST)
In-Reply-To: <CAPig+cRMj_RY53--OLDmonZLzhzf0Cu+JrDc8LAicSn5QGKNyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238439>

On Wed, Nov 27, 2013 at 8:53 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
> <pclouds@gmail.com> wrote:
>> diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
>> index e011ead..95b6313 100755
>> --- a/t/t5536-fetch-shallow.sh
>> +++ b/t/t5536-fetch-shallow.sh
>> @@ -141,4 +141,26 @@ EOF
>>         )
>>  '
>>
>> +test_expect_success 'fetch --update-shallow' '
>> +       (
>> +       cd notshallow &&
>> +       git fetch --update-shallow ../shallow/.git refs/heads/*:refs=
/remotes/shallow/* &&
>> +       git fsck &&
>> +       git for-each-ref --format=3D"%(refname)" |sort >actual.refs =
&&
>
> Exit status of git-for-each-ref could be lost down the pipe.

I think it's ok. If for-each-ref is broken or something the final
output in actual.refs will be different anyway.
--=20
Duy
