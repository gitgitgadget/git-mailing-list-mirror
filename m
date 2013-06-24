From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Mon, 24 Jun 2013 04:44:43 -0400
Message-ID: <CAPig+cRgN7yMGWc6zM8RiLrFxOcsMcia_BKiYT6fgQX_toA_QQ@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-5-git-send-email-gitster@pobox.com>
	<CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
	<7v7ghkdl2p.fsf@alter.siamese.dyndns.org>
	<CALKQrge4Nac4nk1RSnOFwE4-BNtHRNDSZHh9ihPY7ERd5jQ2Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:44:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur2OH-0002xR-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab3FXIop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:44:45 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:65291 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab3FXIop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:44:45 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so9854359lab.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=qJAOatbl/CkPsEph+H/4vHVu7orL1zSF63NLHdoAJMg=;
        b=V6+CVuQsQtxTENv4LKoBaipbMfdks1fQeVe3Iq5D//+uZVDDJgulJ1VT6WxVpCeUYE
         T7As9GIPZHJ7bST7bsc0As2blhAVewefAv48jIosg3xD90KU4hvoFmwFU8h5xjz62Isn
         WCB3Dyksma8Z2ysrKFdQxBYPkZEn/gth6MsOtFVuthr+ZQLvcUlx/MfWTzwXAjWqg8W5
         nK95PBibRVYArrw4kjp4OijDoDISoKDnCxyBTnE6yGGaFELJK6g/0IxAqrNcV6ihCq87
         hV4jN2oKPOVxGmK1Z4fdVhgIDVQ7wX5TcMA41L4je8VzxfnnYAVm0T1DlqZeptiZShDI
         YFAQ==
X-Received: by 10.112.88.169 with SMTP id bh9mr196541lbb.12.1372063483623;
 Mon, 24 Jun 2013 01:44:43 -0700 (PDT)
Received: by 10.114.161.5 with HTTP; Mon, 24 Jun 2013 01:44:43 -0700 (PDT)
In-Reply-To: <CALKQrge4Nac4nk1RSnOFwE4-BNtHRNDSZHh9ihPY7ERd5jQ2Ng@mail.gmail.com>
X-Google-Sender-Auth: Jyhs-0EwCHItOx2EyvprKzTwp6M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228796>

On Mon, Jun 24, 2013 at 4:33 AM, Johan Herland <johan@herland.net> wrote:
> On Mon, Jun 24, 2013 at 9:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>>> +       git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
>>>
>>> Isn't  ${3:-repo1} a bashism?
>>
>> I do not think so.  But now I looked at it again, I think I would
>> use ${3-repo1} form in this case myself.  No caller passes an empty
>> string to the third place.
>
> Ok, I have to admit that I'm not at all sure where the line between sh
> and bash goes when it comes to ${magic}... Is there any good
> documentation on what is in sh and what is not?

POSIX: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
