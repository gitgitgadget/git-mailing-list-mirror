From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Wed, 13 Jan 2016 09:48:17 -0800
Message-ID: <CAGZ79kaRyQXDiOQCdmBuEQdGevj7ebnmCtErVy4ymwPzLfrmtA@mail.gmail.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
	<xmqqoacqs6g7.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZO=qLXK=tDt=DT=9og=aNgxk+ukoO4e5qDT=OAJCCS2A@mail.gmail.com>
	<xmqq37u1quyf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:48:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPWw-0004Co-MI
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbcAMRsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:48:19 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36584 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182AbcAMRsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:48:18 -0500
Received: by mail-ig0-f175.google.com with SMTP id z14so156682613igp.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jhOudn8hbn1Vg4F1tFVx473EqA59uVn8UqfbCCm8e+Y=;
        b=EJi47Ju48hbReHohgX0zl5y8RFFKgglVCk9HmYUg0lu6GM8A8LL7cXiuidvUHqf2cz
         w9AB3nnlXQ5SpUNro3SvG0KwWGIkhk5wtBdeOPu8mOc57S4h1l26BogprU+wwsv/oeZC
         u6FOCUc/i8cBtzxmmz8SJXKZyEn44TwmtxbiiQ+Q1nqMLT8W23hjA+2Psxbt5PUqar2U
         JI2VhDneZ2hnemvCri9p/tNU1zmgsRsKGQbYjuL+ZpOFoBeHQOMcTYo6CoFGtj/+dANA
         Bd0Zjg99JnXaEhyDDP6BH/nw9/4S4Oac74b451EwWQ4XoPrZJQSmWzwJNCckb3eUi77I
         xkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jhOudn8hbn1Vg4F1tFVx473EqA59uVn8UqfbCCm8e+Y=;
        b=XJhAZXE+zVusHu/3Vj/80Eq/Ba8x5+VUPxkyNEmD9KAQz8NVY7E8XQ893bHqS0Ce6x
         wPziTcwAjwucN92AHKIFGYKc/s6eos9CX4+tGaX6o7KvTrwz87e0OaONUkltAoyl1KgF
         LZptureU7SIBotjMFqH4OBBn7jQDZ+GSMD5qOy5LlhAJrQrhfW5Lh8mcPt4COmby+rnA
         8lq7imvZPmPBbaB1SfqXWuAd30ycJRZ6Fgrola2RJwiCJrWAP5/hnoM7r9/yjwIw1hxo
         lcVX6wp8LM+vZ63RxwH3hiQ5e41tmoQ1QoNamsKmpVEmEpZ/azhGWDFsWNjusXJ/fNUm
         4o1g==
X-Gm-Message-State: ALoCoQkVlmTZzr+cOG+IneBkDJXgMP+U7ImKr/ETBrJeMmJOZ3BThz2fPfeYq4Sf1mY0DYhINq4Vt3tA13SVolfmmY5Mg0U0CHijD5hTVcreL7Xrqf2a2/U=
X-Received: by 10.50.77.81 with SMTP id q17mr89670igw.93.1452707297519; Wed,
 13 Jan 2016 09:48:17 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 13 Jan 2016 09:48:17 -0800 (PST)
In-Reply-To: <xmqq37u1quyf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283955>

On Wed, Jan 13, 2016 at 8:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Additionally to that I needed to switch the order of arguments for the
>> parallel processing calls, too, to make it compile again.
>
> That sounds as if the previous one that was queued did not compile,
> but I didn't recall seeing such breakage.  Also comparison between
> corresponding patches did not show such a change, either.
>
> But perhaps ...
>
>> I assume I just did that work twice as the previous version
>> ought to compile, too.
>
> ... means that you didn't need such a switch after all, and the
> re-sent series didn't have it.

My local state has had the switch, and I needed to make it before sending out
the latest version. I do not recall doing that to the previous version, but that
version is fine, too.

Which means I may have missed some review comment (if any) or
that I am forgetting things (I was on holidays for 3 weeks, barely touching
an electronic device).

>
> I am just making sure that I got the right version in my tree, so
> please don't behave as if I am accusing you that you advertised that
> you did more work than you actually did and go defensive ;-)

It should not sound as if I go defensive by being accused. I just want
to point out I may have missed a thing on my end, so double caution
for reviewers may be warranted. It was badly worded though.

>  If the
> reason I didn't see one kind of change in the series I received is
> because it didn't have to be done and the description mistakenly
> said that such a change is included, that is perfectly fine.
>
> Thanks.

Thanks,
Stefan
