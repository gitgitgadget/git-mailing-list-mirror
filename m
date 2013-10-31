From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 16/16] add: avoid yoda conditions
Date: Thu, 31 Oct 2013 14:42:42 -0600
Message-ID: <CAMP44s3CnoLAUu=R4FCFWGyJpn58oTZgzQKgF7wE1hUnutv84w@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-17-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6i5z8Z9HPzsUWTh8U2HXc9p6MPgQjJ7K6KSDw8FXtFyww@mail.gmail.com>
	<xmqqmwlp41xd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbz4s-0002fO-D0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab3JaUmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:42:45 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:38200 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3JaUmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:42:44 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so3310065wgh.29
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=InqqFvk4fMKbEQAZsRzSuWpV1IzjQ98hifhLpshHpIU=;
        b=Rlg2PXL4U0IuMdygcPIv+XLKysarijHTCx3JDrRsJeXTbO5VMqjL0tv0+FZNOfMtrZ
         e+5l2l5fdl4xwUpHW6sfb5EKpUrrVHw01mzDgYF/JYdqApBFwSkvdirwy36/b0ghdcFJ
         NSzM7ZSEOqlQ6foY2sRoOxYmRoPsNB1w2+mW4UPPoNj+6Yve/+k50kO1xmcRLzmiTx+m
         abncc4GEdrYs+Elqyx2a/kt36uXSFEux381VgIyqi8YuPzFgc9GlEouZuK86rVgNIxv8
         Ese8/yccNcnHVuxaJrrtCksrzuPb+2vag+i6VaT6IlzMhzh2NGIdABuns9F4iU0X21Fa
         4mvQ==
X-Received: by 10.180.99.3 with SMTP id em3mr11164wib.4.1383252162707; Thu, 31
 Oct 2013 13:42:42 -0700 (PDT)
Received: by 10.194.242.167 with HTTP; Thu, 31 Oct 2013 13:42:42 -0700 (PDT)
In-Reply-To: <xmqqmwlp41xd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237179>

On Thu, Oct 31, 2013 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I agree that there is no justification to write "if 0 == something",
> when "if something == 0" suffices.  The latter reads better and that
> is why the phrase "yoda condition" was invented.
>
> But the situation is different when both sides are not constants,
> and especially when "<" and "<=" are involved..

To me revs.nr is virtually a constant, I'm comparing i to revs.nr, not
the other way around.

I believe I explained this already, but here it goes again:

if (1.60 < john.size)

This makes no sense, "if 1.69 is smaller than john"?

The situation doesn't change when you use a variable:

if (size_limit < john.size)

Translates to "if size limit is smaller than john", and still makes no sense.

-- 
Felipe Contreras
