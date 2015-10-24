From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Sat, 24 Oct 2015 20:07:53 +0100
Message-ID: <562BD709.1020307@diamand.org>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com> <xmqqmvvd8n7t.fsf@gitster.mtv.corp.google.com> <C5352225-D67D-4ECD-83DB-D5E5A8ED13A7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 21:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq4AY-0004gD-7l
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 21:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbbJXTHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 15:07:54 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38600 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbJXTHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 15:07:53 -0400
Received: by wicll6 with SMTP id ll6so68261676wic.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ksGk3OQJ0sHs6oF8YbNV+vx7/2oQ/yybTUZJNJNoUzk=;
        b=iOZ6YfYIAFSpxkm77jQmqBPc5z+nwVn3GBj6EnUmCnFT2hUeI5H3XHIjsDiuglcJzn
         /8PUrgVgUNg12ajJ37dcPCNcKsFMbXuduLossa4igZ7YJLZ1VLy51GgBlRUdjYkOv2ts
         rBMcN9aERMMiA8mL77NZ8RejMNmeXreBMZG84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ksGk3OQJ0sHs6oF8YbNV+vx7/2oQ/yybTUZJNJNoUzk=;
        b=HgrFxUo+0Eq+XC/ioHKqyFz3F4jM+3rAcbvO7t0FLITp6GKc9VSn/BvCY80D0OVvY3
         H0/6jbzh96xJrxUf+HRjE4wIOZ+oCSIoJwke4v04BKPa6CBajDnNfk8XuuZfpIJp5Urp
         94ej7F0o9Uqv3gN3ttkDqdttm8U14o6y0GKoADBT+/HM4wQ/5KpRnQclwQp6z6f0B9gQ
         qzT6cVFD15SpBzMJFSdaiWkB82d4eQDxO8UoGm44yJUV/++IZaJZl+1ey2BFcRw9T5Vx
         lHBo3tARKTvD1TKAryYtMaRkMNMXRBZzTTocewu/EN0GKNAinTwR034eZA4nSPUTVckN
         yttQ==
X-Gm-Message-State: ALoCoQm5D1uxm+Bbxv0RIJHNtLj4Ls/kdJIdWgFzkbSJtFYcstViFOKuHxByxfqXpLG4PSJBAk+T
X-Received: by 10.180.8.230 with SMTP id u6mr10621432wia.21.1445713672512;
        Sat, 24 Oct 2015 12:07:52 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id jh4sm25057632wjb.33.2015.10.24.12.07.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Oct 2015 12:07:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <C5352225-D67D-4ECD-83DB-D5E5A8ED13A7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280132>

On 24/10/15 17:28, Lars Schneider wrote:
>

>> Also I have this suspicion that those who do want to use client spec
>> to get a narrowed view into the history would almost always want
>> this "ignore empty" behaviour (I'd even say the current behaviour to
>> leave empty commits by default is a bug).  What are the advantages
>> of keeping empty commits?  If there aren't many, perhaps git-p4
>> should by the default skip empties and require p4.keepEmpty
>> configuration to keep them?
>
> I agree.
> @Luke: What option do you prefer? "git-p4.keepEmptyCommits" or "git-p4.ignoreEmptyCommits" ?

keepEmptyCommits.
