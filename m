From: Alexander Rinass <alex@fournova.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Thu, 12 May 2016 13:16:06 +0200
Message-ID: <D97D1033-70B9-46D5-A672-042DE0283CCA@fournova.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com> <1459802325-22056-2-git-send-email-alex@fournova.com> <xmqqzit80yov.fsf@gitster.mtv.corp.google.com> <57040EE0.40503@kdbg.org> <C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com> <xmqqy47gi6xz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 13:16:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0obH-00012v-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 13:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbcELLQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 07:16:11 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36449 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbcELLQJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2016 07:16:09 -0400
Received: by mail-wm0-f43.google.com with SMTP id n129so254859362wmn.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jvPYyzCceJJz8wE5c93DLSQFe+3dZ5344HdnCjJO0S4=;
        b=RApPQ8HvBOeWF8qoy4IS869rLE5NtbtG6sliu+2TmV0ntV42AGUi3p3BA6Tn2UHgxr
         TZdYFFLc5mUhWvOCg9YYH9So8XDq5cNZx911Q7pEFtb+WD4OuTBya4vRA5zB3Y9hzwAN
         pItR05BpameDTPToSc/L5f7vRTvXANId4/qhtMBCbg7t+kk0aHCmj/JbFbrED1wzq9lX
         gMrJoHYQ+72QFWc81Mr7l+IxTatFYzrQRoOPbfWAJMtThNI1amTcuAKx2B9Ir95UI5bW
         qPZkXnThkZU28SZsshSCYFN6BUW476AofUsxcItGh6y6sHvDygAUk1bni7yq0aY1xLk7
         2G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jvPYyzCceJJz8wE5c93DLSQFe+3dZ5344HdnCjJO0S4=;
        b=Ng1qGh+ym9yS5RNT9EA3gsTA+9ry743bwGnBGJzAGuS753m0N7iPmWW2gIzC4oTA0H
         4vv79HZp6/R66lm2AbtdP1zqw8R8GrcOEr7Q/NZGo1/O6VIWzohNH+DW4HggltX4rrEq
         2UC5F7R69PUOTu+pXaB2YTFdltXKtOHB80MY5x7HGRdoZk8oWVG69GSWp2yCAO6r+AFt
         OANCeu3Fer8c0GGc/YkwsWMf/idXvptkzSOL5D260HbPt1Xqg6l2OSaqEMQqCXGnNG9a
         lfnWBvDd50olSi1sVEyyL/7a0x727IBQ71UMwx6oySClsolkRStds63pXZLC2lp9fdf4
         RfIQ==
X-Gm-Message-State: AOPr4FXbS8k+/6l8j10133BVnpHfeWghO8M/SlJiZXex6DsOeXeX9xaGCWeVFo2DEH0h0w==
X-Received: by 10.194.6.225 with SMTP id e1mr9759895wja.152.1463051768036;
        Thu, 12 May 2016 04:16:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:df40:5780:74f5:89be:d6b1:6ed4? ([2a02:908:df40:5780:74f5:89be:d6b1:6ed4])
        by smtp.gmail.com with ESMTPSA id ck9sm12920112wjc.22.2016.05.12.04.16.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 04:16:07 -0700 (PDT)
In-Reply-To: <xmqqy47gi6xz.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294405>

> On 12 May 2016, at 00:08, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Alexander Rinass <alex@fournova.com> writes:
>=20
>>> On 05 Apr 2016, at 21:15, Johannes Sixt <j6t@kdbg.org> wrote:
>>>=20
>>> Am 05.04.2016 um 19:09 schrieb Junio C Hamano:
>>>>> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
>>>=20
>>> I sense NFD disease: The combining diaresis should combine with the=
 o, not the g. Here is a correct line to copy-and-paste if you like:
>>>=20
>>> Thanks-to: Torsten B=C3=B6gershausen <tboegi@web.de>
>>>=20
>>> -- Hannes
>>=20
>> Thanks for reviewing and catching the NFD encoding error.
>>=20
>> I will send in a patch v2 with the correct NFC encoding.
>>=20
>> Would you also like me to alter the commit message as mentioned by J=
unio?
>>=20
>> I could rewrite the sentence:
>>=20
>> =E2=80=9CAs a result, no diff is displayed when feeding such a file =
path to the
>> diff command.=E2=80=9D
>>=20
>> into simply saying:
>>=20
>> =E2=80=9CAs a result, no diff is displayed.=E2=80=9D
>>=20
>> However, I don't read the original message as it would imply that on=
ly
>> file paths are affected by the precompose_argv call.=20
>>=20
>> Are there other suggestions on improving the commit message?
>=20
> I think after this message there were a few suggestions, and then we
> heard nothing.  Should we still be waiting for a response from you?
>=20
> Thanks.

Sorry for not replying earlier.=20

I will create a v2 patch until the weekend and send it to the mailing l=
ist.
