From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Fri, 16 Mar 2012 17:14:56 +0100
Message-ID: <4F636700.2090105@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F636227.2060102@lyx.org> <7vaa3gilg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Zo4-0006BI-PH
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 17:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423121Ab2CPQPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 12:15:02 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423118Ab2CPQPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 12:15:00 -0400
Received: by eaaq12 with SMTP id q12so2195194eaa.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 09:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=lDi98vhuLwgdmkDwnlcTk4yz1q9Sjfoc+leK2trcM8c=;
        b=WApRzp7rPB0XbKfQkwlwgS2vE6B2MOzBdu6KhQ5zP9JhyA9Wyb/j9rECYoYAWl9tIX
         9z4KGlXij8w0LiHWJkv73xmPMdYvzGoPoaVjIEZ88zMMpOjxAvvcsFEH0wAZtdfxpNSs
         CGrxDkUqDBDGCfiy47QMZ6ymbf9c2pRujvWF/MOJRTr1I6F8NUvbBGKlWTTJSdtNG1ui
         Ymy1Oy50EhGjlhWF7izE2RE+ENhlv10atAC6PLnV7MnUdGVPhkixBMyFlKvkuSap86zx
         lW0eZnYtZGrO2OnL8TjE9TW+5x/eQxP98HB9IiwEzkM4Zf6TX9e7w1AS6frj/CE0Vdih
         suFA==
Received: by 10.14.204.3 with SMTP id g3mr400231eeo.75.1331914497837;
        Fri, 16 Mar 2012 09:14:57 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id n56sm19983802eeb.4.2012.03.16.09.14.57
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 09:14:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vaa3gilg7.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkUoNJhpJ0vPiux2Fme7CENO+I8htqVErVjUArLW+cUuCgGdQBTwObHNKdAn+qWiVAvd+vm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193274>

Op 16-3-2012 17:01, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> Op 12-3-2012 21:01, Junio C Hamano schreef:
>> ...
>>> I haven't find it necessary in practice, as the re-fix for me
>>> typically would go like this:
>>>
>>>       $ git merge other-branch
>>>       ... rerere kicks in; eyeball the results
>>>       ... ah, my earlier resolution is no longer correct
>>>       $ edit $the_path
>>>       ... test the result of manual edit in the context of the merged whole
>>>       ... and be satisified
>>>       $ git rerere forget $the_path
>>>       $ git add $the_path
>>>       $ git commit
>>>       ... rerere records the updated resolution
>>>
>> This doesn't really work for me:
>>
>>       $ git merge other-branch
>>       Auto-merging<path>
>>       CONFLICT (content): Merge conflicts in<path>
>>       Resolved '<path>' using previous resolution.
>>       Automatic merge failed; fix conflicts and then commit the result.
>>
>>       $ git rerere status
>>       $ git rerere forget<path>
>>       error: no remembered resolution for<path>
>>
>>       $ edit<path>
>>       $ git commit -a -m "fix"
>>       ... no sign of rerere doing something.
>>
>> Why is this different from what you describe above, and how can I
>> modify the recorded resolution ?
> Do you have rerere.autoupdate set by any chance?  If so, don't.  At least
> when you are trying to purge the broken rerere entry.

No, I turned rerere.autoupdate off. Proven in the above by the line 
"Resolved... " instead of "Staged...".

Vincent
