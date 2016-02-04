From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic
 operations with the equivalent shell builtin
Date: Thu, 4 Feb 2016 14:39:49 -0500
Message-ID: <CAPig+cRuNzQR_-dRQqV+KOqEaXhuTNB2RxX6rkXKzembbgWyKw@mail.gmail.com>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqoabwi83q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:39:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPkx-0004Hx-3u
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966090AbcBDTjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:39:51 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32907 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965902AbcBDTju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:39:50 -0500
Received: by mail-vk0-f65.google.com with SMTP id n1so1910709vkb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EKGDaP8agMVPopty03uUtan7ufivkaiCZix5MZTo2L0=;
        b=Ext7rGvEYB9+Z6N7hFv8F31M2LDzvV2WYay5ryX+Aap9oy2fXYklUdQhgD2I5mRjm3
         59DJ2XguANydvk1fp8dEc968MviDQbY1IfdWNrRrekZJ3R9iN1sXa/Jyb1x2bbtQfuPX
         wYDGuGs5/q3q6DmQFDCV7yMSfl9x+O7bhKkNUy09VO3Ca9Y5XjB2iRGBG9iT2W6pHjXK
         zhFosSEST+mmCUEwAi3BSIbc5lI1DilrbVKcH3q6n68iZ8NbG9td+s3yxxxOnHFx1Wl8
         vjh1uMRq09Art1EXJlTJ08sPmLgEse/qBtdEdrl8Fo+MEg02cjKDMXi7qriBzrUqALb5
         HgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EKGDaP8agMVPopty03uUtan7ufivkaiCZix5MZTo2L0=;
        b=KOLLw/fv9q/1FeHSrt6xtCOR5WWhJPjwMXm/gNbVGsrlBI7Kg1jYl5ldc5zXRgtMWO
         IONapi/izCSvCTWURLQ9CNv37Jvf9Ql5rnUUMDOt45Av8UeF+ENZe0r6galr2KJOCv2F
         QlhH6NnI7YEF5m59OkDKFVzzyUACSOuB44YH6uRebR8QOTmHRmkNZh0tgX/NBcNIZtil
         t5toV05ktixe+jjjGquQFdFkLAtqiaxDTdkazT/9jq1Qr5ZD6F4lXR4KeGFv+AZBL2Xi
         xddIN0Yv+kkeFbp+hztwWugPv4wXqpxekfQLZOm8Sui3op3iSKiE5oG/hULMNUL3GqDI
         b7PA==
X-Gm-Message-State: AG10YOQLf8fxrenrq6OydxJLqAfK3mdlP3DSnmASKAX7ljN0YiZs8EuMnE1ja21eotwpcgAhFp8yIL+SHWEOiQ==
X-Received: by 10.31.168.76 with SMTP id r73mr6728992vke.117.1454614789688;
 Thu, 04 Feb 2016 11:39:49 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 11:39:49 -0800 (PST)
In-Reply-To: <xmqqoabwi83q.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: ofrZ3jdgwMKbPjqqy2Hel2tVn7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285483>

On Thu, Feb 4, 2016 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As pointed out already, quoting of "$this" inside the arithmetic
> expansion would not work very well, so [14/15] needs fixing.
>
> I do not see 01/15 thru 13/15 here, by the way.  Is it just me?

I didn't receive them either, and they don't seem to be on gmane...
