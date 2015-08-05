From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Don't pass --full-history to git-log(1)
Date: Wed, 5 Aug 2015 23:28:38 +0200
Message-ID: <CACBZZX5GvCqx3LkWBDb4kDFpyaEwK-Fnhtof6nhKsctmx22m1g@mail.gmail.com>
References: <1438784487-9176-1-git-send-email-avarab@gmail.com> <xmqqr3nh4qx5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN6FC-0002a1-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbHEV26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 17:28:58 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35255 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbHEV26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 17:28:58 -0400
Received: by oihn130 with SMTP id n130so29817010oih.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aT/vfpX2Kb1rr0Oali+mzVrqAfF1/hPW+L9i25Ku03M=;
        b=SYQSMSI9thz72A8pUE/1vhlKtc8dsINtHmj0RpqZok0V1sm/SmepTeKov+fOZyjnai
         iXvMxRTPCRZoUbryD090/k/pdW8y/8I1nEO8Lbka/zQ0MtjjTqBNCINevmac+CieepEB
         vF6WXXM8nSMyzoYxMwZ6BDqBqY4KIw8XYtVTHr3aPPihHpvBtXT5giGpV9tnXMS9pwoX
         +cuHDPPzKMQehis7iDJN4n8vtQtVKt06oA5mTuYd+s0+bFyNB5RYPyF0PbWfrJe1zLn+
         TfGCMZyt3JPi8p8bdvc47MoCo/fZ8FxTj3ubx99J3ay0x9MsflJFfeK4KbfONy5FBLh7
         iRvQ==
X-Received: by 10.202.218.132 with SMTP id r126mr9405530oig.69.1438810137450;
 Wed, 05 Aug 2015 14:28:57 -0700 (PDT)
Received: by 10.76.144.37 with HTTP; Wed, 5 Aug 2015 14:28:38 -0700 (PDT)
In-Reply-To: <xmqqr3nh4qx5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275400>

On Wed, Aug 5, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> When you look at the history for a file via "git log" we don't show
>> --full-history by default, but the Gitweb UI does so, which can be v=
ery
>> confusing for all the reasons discussed in "History Simplification" =
in
>> git-log(1) and in
>> http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=3D=
90659
>>
>> We've been doing history via --full-history since pretty much foreve=
r,
>> but I think this is much more usable, and on a typical project with =
lots
>> of branches being merged it makes for a much less confusing view. We=
 do
>> this for git log by default, why wouldn't Gitweb follow suit?
>
> http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=3D=
90758
>
> seems to agree with you in principle that this would be what gitweb
> should do if it were written today.

I'm reminded of the make(1) story about not supporting spaces instead
of tabs because the guy already had a few dozen users.

We could have changed this in 2008, when Git already had much fewer
users, and I think we can still change it. It makes more sense as a
default, especially on busy repos with lots of merges. At work where
lots of merges are in flight literally 1/10 commits for any given file
is relevant.

Who'd be linking to gitweb's log output expecting its semantics to
never change, and is use case more important than having a saner view
for the vast majority of users who are just browsing around?

But if there's strong objections to it a coworker who encountered this
made a patch to it to add an extra "full history" an addition to the
"history" view (which would change, but not the permalinks), in case
there were objections to just changing it.
