From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 17 Nov 2008 23:08:18 +0100
Message-ID: <4ac8254d0811171408o1845fca7kea23b16b076b2818@mail.gmail.com>
References: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
	 <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
	 <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 23:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2CHq-0006Wl-1D
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 23:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYKQWIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 17:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYKQWIW
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 17:08:22 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:13389 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYKQWIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 17:08:21 -0500
Received: by an-out-0708.google.com with SMTP id d40so1157950and.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 14:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fxwo/xnBZT1dlbJNW37oDcx0Jt1LFEYOM11O5c5ytng=;
        b=hTe2vC8YhN4RHMKTVTzyWYHHrFf2gkNIuSSiVnJ/xwsuw4xnouGLo7mInjUmP746Gy
         s38nOz06plXfyu6cTYD12XFmICTOhkUtIpxevyVurA3cs+BiQVRCd+YAS8vbRw/3Z0/G
         OXytRtxqgoqx8kd1SOQo66kFypMiHnwecisVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cG/SgE18S4mhH/T9nKXopDrBUAxLj4Pxcjv8olzwD3Z7Lv1bRfxail2LkX+eoQdmh3
         H8XyJ00BXQ276QcqA9BjS5kKrIyg5uOs9DS9K/DwUxC7mCigUVHp1jPY6jNqYUAc+0yj
         rv84RcjI/P6lQtwfrxioTAZtAKcx3O9ql+Jfg=
Received: by 10.65.189.20 with SMTP id r20mr4234559qbp.71.1226959698399;
        Mon, 17 Nov 2008 14:08:18 -0800 (PST)
Received: by 10.64.119.3 with HTTP; Mon, 17 Nov 2008 14:08:18 -0800 (PST)
In-Reply-To: <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2008 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> I think you need to have something like the following applied on top of
>> what's in pu to be able to use "pull -v -v -v" and be able to count the
>> occurrences via parse-options.c. What do you think?
>
> Makes sense, except that as a futureproofing we may be better off doing
> the same for -q as well.

Please see my patch with the following subject arriving here soonish:
"[PATCH] Retain multiple -q/-v occurrences in git pull"

>> --- git-pull.sh 2008-11-17 11:32:19.000000000 +0100
>> +++ git-pull.sh.b       2008-11-17 11:33:03.000000000 +0100
>> @@ -26,7 +26,7 @@
>>         -q|--quiet)
>>                 verbosity=-q ;;
>>         -v|--verbose)
>> -               verbosity=-v ;;
>> +               verbosity="$verbosity -v" ;;
>>         -n|--no-stat|--no-summary)
>>                 no_stat=-n ;;
>>         --stat|--summary)
>>
>> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>
