From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 9 Jun 2013 15:41:54 -0500
Message-ID: <CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
	<CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
	<7vfvwrowd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlmRL-00063c-Ay
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab3FIUl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 16:41:57 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:42799 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab3FIUl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 16:41:56 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so2892942lab.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h0DWBS4xyoTEShVXQZndhPzHCIRHxNC7V517dATSUmA=;
        b=tvmoNtf2H2nHTWx69UeYk+VR9OoqnmIdS89H8bCO8iccPyXGxPTUzEI1m9ZII5RfhJ
         V6QEeOSKiWGY+Bhz+9h729dpHkynQtco+R4rnZV4YprF2cQx7yhdrQYbqDLA6h44JOYQ
         VbaUpjX5wCWskoz/xDJ8Hmw66U5Vr7hnQd+vGUkP/5RhW0VaGmw/FjjVIvCwW7Kunius
         xCZIntMGqgRAWFrTG40+NXgoU6cfGHfOlCG/hx2vzIMZVcjWCBC6tfHmkEBUxTUdmXtR
         ooca5HZtYq/qdKxM0dupKEPF5Z/BvN07sgiLcIQu6eOLWlQ1tNAPZqXbzUTk8vRvC5NL
         WNXg==
X-Received: by 10.152.5.7 with SMTP id o7mr115621lao.43.1370810514268; Sun, 09
 Jun 2013 13:41:54 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 13:41:54 -0700 (PDT)
In-Reply-To: <7vfvwrowd0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227166>

On Sun, Jun 9, 2013 at 3:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Jun 9, 2013 at 2:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Sun, Jun 9, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>>> --- a/t/test-lib-functions.sh
>>>>> +++ b/t/test-lib-functions.sh
>>>>> @@ -606,6 +606,18 @@ test_cmp() {
>>>>>         $GIT_TEST_CMP "$@"
>>>>>  }
>>>>>
>>>>> +# Check if the file expected to be empty is indeed empty, and barfs
>>>>> +# otherwise.
>>>>> +
>>>>> +test_output_must_be_empty () {
>>>>
>>>> Why such a big name? test_empty() does the trick.
>>>
>>> Primarily in order to avoid that exact name "test_empty" that others
>>> may want to use for a helper to check that the contents of a string
>>> variable is empty.
>>
>> Which is never going to happen.
>
> For anything, a failure from
>
>         test -z "$mustbeemptystring"
>
> in the test suite is much harder to diagnose because there is
> nothing left in the trash directory to inspect, as opposed to
>
>         test ! -s "$mustbeemptyfile"
>
> where you can just go there and inspect yourself.

Except that it's usually gone. And I challenge you to find a instance
where there's a test -z "$mustbeemptystring" that throws a test
failure. It will take you time to find it (if there's any).

Moreover, by that rationale, we should call test_cmp, test_file_cmp,
but there's no need, because that's rarely needed (if at all). There
will not be a need for test_string_must_be_empty() just like there's
no need for test_string_cmp().

-- 
Felipe Contreras
