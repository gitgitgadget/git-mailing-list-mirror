From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Tue, 17 Nov 2015 09:38:39 +0000
Message-ID: <564AF59F.2070601@diamand.org>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-4-git-send-email-larsxschneider@gmail.com> <5649958F.2010407@diamand.org> <90549E9A-205A-4848-B794-23E44F325F1E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 10:38:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyciy-0002WL-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 10:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbbKQJil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 04:38:41 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38647 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbKQJij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 04:38:39 -0500
Received: by wmec201 with SMTP id c201so16983253wme.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 01:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2DVcNEFy/zzxssN9liX1RK3QjecCYd496B6nlIbumPs=;
        b=T+7iIFlpDrw2KufF3r4Q8MMo+q47k7/e8plwMe1qpPW55bUu3k/DJA89Vr3fgNWCxz
         04rF2bSjx5vX7AykAW92bKxYLFPt0TT8MVAh3RhvUCKEJd73wHSEiTmmCgqtIzExNgOF
         q0rJzY0OzMsoMRhCgIwIdghwg6M9hXSZcVh8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2DVcNEFy/zzxssN9liX1RK3QjecCYd496B6nlIbumPs=;
        b=bGlQwCtvVT7NB39UFIsGKUVcTx366eEair6HNcRWSh5VzPTWUiKtPBlyxZAJAbQydO
         aWvOUXZeWcYmb731uG+Y47v0DebJn6hjkNI2e0ci7aOw0HBZBnQs7zVQZvEvp1O9V03o
         C+jkfXEL+4zjNkz3g8cEfeHFvmJugVW338qGHsSf2qzFPRmDT9xDxyK687JZaWFMvDu6
         5KCIcumyrs1oW1mAUSpXvCx4BAYXbZktGciDCxu+3NpavDWPByWiLaNdIjh1i9jnWgeX
         jHB8imJMRJ9fP/qJEQ6amoEsKByOdrgVjqH5/jnKkU1uY6SGqOZ9uZ1Rd+iKErEC8flc
         qlCg==
X-Gm-Message-State: ALoCoQk/D93yu1wo6+KWzEQkIP6iE1o0hGlTjyheF4bn9BgloX1YPLhua+7a4TfJCWfa1wXqsboT
X-Received: by 10.28.22.21 with SMTP id 21mr1372211wmw.72.1447753118344;
        Tue, 17 Nov 2015 01:38:38 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id b12sm23036167wma.6.2015.11.17.01.38.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 01:38:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <90549E9A-205A-4848-B794-23E44F325F1E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281393>

On 17/11/15 08:22, Lars Schneider wrote:
>
> On 16 Nov 2015, at 09:36, Luke Diamand <luke@diamand.org> wrote:
>
>> On 15/11/15 13:08, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> In rare cases kill/cleanup operations in tests fail. Retry these
>>> operations with a timeout to make the test less flaky.
>>
>> Should there be a sleep in that retry_until_success loop so that it doesn't spin sending signals to p4d?
> Agreed. I will add a sleep in the next roll!
>
>
>>
>> Do we need to worry about the time offset being updated (e.g. NTP) while this is running?
> Interesting question! I would consider this an edge case but I can see how it could happen.
> Do you see a way to handle that in an easy way?
>

You want to somehow call clock_gettime(CLOCK_MONOTONIC). That's not in 
python until 3.3. Writing a C program seems like overkill but could be a 
solution if this becomes a problem.
