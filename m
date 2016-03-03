From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] index-pack: correct --keep[=<msg>]
Date: Thu, 3 Mar 2016 16:44:58 -0500
Message-ID: <CAPig+cTgJxtuVOEAes_T1jjdN-MqHnSXkmL8mQ80n7rRd=gqXg@mail.gmail.com>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 22:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abb3Z-0003Hu-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 22:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411AbcCCVpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 16:45:01 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33169 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758315AbcCCVo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 16:44:59 -0500
Received: by mail-vk0-f48.google.com with SMTP id k1so19306863vkb.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Sk/oV3F4mKgF8KJuk5I4e910YO2q+vKHzYcDuqcUkt8=;
        b=KKqqpkKuxrJlTJ0CsOvH4oHn0AkwzRBG17XUGaOmlpcIaOJVZAVsEsxgxQIAkv2161
         GkFg3RxLQKIsXtpxLgg1SIGBgEZgd/AjZco47VtHBQdtz+qI5b44YYJKFru4Uy8Cmh/7
         U5SDjeVzV6sx+xmVQP6u+6E+gYY8PDAyJHvF4dBc12++BlPj5JqV+5ohUTECM7IFsT2y
         JdeimX1G+5GCeaFFUm1Wp9a74XBuUJqOdkvnAflxDzCo86D9LzMFE7Ih0i3w1v7ESyDC
         fva5EJ5Y2oOcUCoqmqhMExBlRyOz3iLwH6NsG9iEeOQx4SUTFKQxv8YmuHaL8Qy1/Hqm
         LyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Sk/oV3F4mKgF8KJuk5I4e910YO2q+vKHzYcDuqcUkt8=;
        b=lUumqflzHPAQT3e/YAyIClF2frN78cfHrJ6+W2rtsYW03psB4XDNBA9CY686IB4GHc
         dvOnQeR+PCCgrmAlY6MiU/9zP3IaWxTYlDCHFMyaoMCtBL2kxF7K+cskK3RJm2kgdFdN
         zhDaGZYmIxhwhA5B+51jhpIdYMUgP4A1dMpwrA4RIuHoc585E9dHmaqED1nn2O1ElDhW
         WFLTJgBThiRt0MmB8uohigoBIEv007URfQImk/4smwOmVt6CIJV5ysMquSANcG8lsPlT
         CkYON4QxnqULwLHFNe1LAeapniSEMDqvfy0DsWCmgdIN/S9vF952HWymRJby/e7CaQ+L
         q1Rw==
X-Gm-Message-State: AD7BkJLfEiCzjETLJ7huTB1LLtvq5VBazr4OQhHIeNHF3O+zJVDSMv3KSoBh0RzQM+KxDWvgVEczLG1tJqvqtg==
X-Received: by 10.31.150.76 with SMTP id y73mr3728822vkd.84.1457041498801;
 Thu, 03 Mar 2016 13:44:58 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 3 Mar 2016 13:44:58 -0800 (PST)
In-Reply-To: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: Quc7jB8WvrMjbgOSa0gTSbtXe6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288214>

On Thu, Mar 3, 2016 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When 592ce208 (index-pack: use strip_suffix to avoid magic numbers,
> 2014-06-30) refactored the code to derive names of .idx and .keep
> files from the name of .pack file, a copy-and-paste typo crept in,
> mistakingly attempting to create and store the keep message file in

s/mistakingly/mistakenly/

> the .idx file we just created, instead of .keep file.
>
> As we create the .keep file with O_CREAT|O_EXCL, and we do so after
> we write the .idx file, we luckily do not clobber the .idx file, but
> because we deliberately ignored EEXIST when creating .keep file
> (which is justifiable because only the existence of .keep file
> matters), nobody noticed this mistake so far.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
