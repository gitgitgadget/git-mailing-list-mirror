From: Avi Kivity <avi@cloudius-systems.com>
Subject: Re: [PATCH v2] git-am: add option to extract email Message-Id: tag
 into commit log
Date: Thu, 03 Jul 2014 17:08:33 +0300
Message-ID: <53B563E1.8080201@cloudius-systems.com>
References: <1404291113-4424-1-git-send-email-avi@cloudius-systems.com> <xmqq1tu3isti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 16:08:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2hgw-0007Iq-2w
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 16:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbaGCOIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 10:08:45 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:47551 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567AbaGCOIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 10:08:43 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so283034wev.34
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 07:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9KyEwQFyVs0x6VOTtp9fB/YQUaUlAoCkn+VprqvHNr4=;
        b=EwRGYgsoanOBXY9ELMwEMRS0CzmibJt4tyu996oFh0WQc1tIf3z2pUuwhUV65t8FYW
         WSIcbDHOGDxmbPKCxKELFlZmtXnNaOvkAa3VSzqMxPLieiQ+TdupGXPIFbIP/LgJD9qN
         vpFA1ZHSwgxyMyXIaca7qqjRbS0holznhby3gsvSXxQKTEFWet58f5HrdBHydkqTq2PS
         +rFDOfHpY0rca5CiG8q6JehKF5QqnhOI7wxZKSXv8UXsR3/MscSUmZh5d9YYMSJ8qeh2
         77h7a+3ea2YvCsiHf8zjQtszM8xm4c31WX8xhCMrJAiDs9nSkTGvGvGlK0ito0LZSDvc
         gHug==
X-Gm-Message-State: ALoCoQlcnZaqsk2wEaledQn1l/cyUwgCN9kFYx4I65h0Fx1RjdEslIO/MJgiRIGyDShvQovY30Mn
X-Received: by 10.180.97.67 with SMTP id dy3mr11458382wib.16.1404396515950;
        Thu, 03 Jul 2014 07:08:35 -0700 (PDT)
Received: from avi.cloudius (84.94.198.183.cable.012.net.il. [84.94.198.183])
        by mx.google.com with ESMTPSA id q11sm67504423wib.14.2014.07.03.07.08.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Jul 2014 07:08:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq1tu3isti.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252861>


On 07/02/2014 08:17 PM, Junio C Hamano wrote:
> Avi Kivity <avi@cloudius-systems.com> writes:
>
>> +		if test 't' == "$message_id"
>> +		then
>> +			grep ^Message-Id: "$dotest/info" || true
>> +		fi
>>   		if test '' != "$ADD_SIGNOFF"
>>   		then
>>   			echo "$ADD_SIGNOFF"
> Seeing how existing code carefully makes sure that ADD_SIGNOFF has
> an empty line before it when and only when necessary to ensure that
> there is a blank after the existing log message, I would suspect
> that this patch that blindly inserts a line is doubly wrong.  The
> output from "grep" may be appended without adding a blank when
> necessary, and appending of ADD_SIGNOFF may end up adding an extra
> blank after Message-Id.  Am I reading the patch wrong?

Yes, you're right.  Will have to redo the logic for deciding whether we 
already have a tag stanza or not.
