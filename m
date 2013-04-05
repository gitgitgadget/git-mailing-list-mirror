From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 13/13] remote-hg: push to the appropriate branch
Date: Fri, 5 Apr 2013 03:16:47 -0600
Message-ID: <CAMP44s04kWSQOsfE_KWAPdNSR=5oFnTcJDF4TPfRuQ6jPEGOyw@mail.gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
	<1365089422-8250-14-git-send-email-felipe.contreras@gmail.com>
	<7veheqjl4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWDw-0002u6-CK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab3DEJQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 05:16:50 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:42831 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab3DEJQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 05:16:48 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so3480001lbh.41
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tnB+Nz8rsSzJwuKLuinMPeuLRcQVFBk33HeIYmJ0kN4=;
        b=Sxgw3YEGfq3ZFfGJqeWRa30F/CE/5F8BrY99sumbBZrBdFiXO2yXsrFx9PwniAt0x9
         9WbQKxR0aAp+bUJ67iVeNZ6OJL/o/bs8+9avsBAi0QUFbtmQtZM0Pp1SG/VfhLq7wd++
         uLCeqUX/C2PRJ0S4g7ABAUDNzA6/ieuJn6MimYtk2NpDLlDumoWsN6V2qTSm6cjt26RI
         dkhtvRStqORZ/r9CJZvpOnqsMT8oCJHaF1WQcQOWDTiSTQVKHnXnfAquC9vEmCy4dU0C
         0tYiHlJKQb0OUS1RI+0aXQzoULeebKepkQheAduae4R6dSQKLdMqlfLEd7SOZnb39dV2
         dJoA==
X-Received: by 10.112.145.197 with SMTP id sw5mr5382464lbb.91.1365153407256;
 Fri, 05 Apr 2013 02:16:47 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Fri, 5 Apr 2013 02:16:47 -0700 (PDT)
In-Reply-To: <7veheqjl4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220167>

On Thu, Apr 4, 2013 at 10:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> From: Dusty Phillips <dusty@linux.ca>
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-hg | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
>> index 56b3641..d82eb2d 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -625,6 +625,10 @@ def parse_commit(parser):
>>      if merge_mark:
>>          get_merge_files(repo, p1, p2, files)
>>
>> +    # Check if the ref is supposed to be a named branch
>> +    if ref.startswith('refs/heads/branches/'):
>> +        extra['branch'] = ref.rpartition('/')[2]
>> +
>
> Is this meant to cut everything after "refs/heads/branches/", or cut
> at the last slash?  I know rpartition does the latter, but I was
> wondering if we see "refs/heads/branches/foo/bar" as its input here.

Good catch, it should be the former.

-- 
Felipe Contreras
