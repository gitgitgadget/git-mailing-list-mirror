From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 03:12:32 -0700
Message-ID: <4D872490.4000500@gmail.com>
References: <1300700704-22674-1-git-send-email-bebarino@gmail.com> <1300700704-22674-2-git-send-email-bebarino@gmail.com> <4D872420.8080501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:12:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1c6N-0006b3-6r
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab1CUKMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:12:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48242 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1CUKMh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 06:12:37 -0400
Received: by pwi15 with SMTP id 15so736591pwi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=y0XEQUDxMluGH1pMF/Fo+Ac2rBvq9BMDgRDbRHXJfBE=;
        b=aAgz7scHd43a8Nv/zuUm6WQSYk7OA/C/xTm2QAY9V1qTqA94ZRZgph6PKz4WclFBn0
         TpdNs+o/nCIJ+xEBo7lnCl6x4u23/a6VsWT6M9+7P8R+Ia41W+ib+nLWw54F9ktd+YN7
         wmonh/pY1WwzCqgp2YkhvpO/G0xvl5blAT6cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ap6eY8n3AJB8Qe25UPjiOEilQlyNO5RNcz0VdEOe4Up1f52CxHFEn3LJKQc8X9sb8Q
         wPh2sg5mldIGcKszM+oISeELaMzVFOFx/EUoeVQX0oD6fC7PcQBD4c1acGmNtFqNAdIk
         SWIX4H5Ga4dwbjk6B70m/ffI2G2ZCVdrmksQI=
Received: by 10.142.151.4 with SMTP id y4mr3062163wfd.133.1300702356023;
        Mon, 21 Mar 2011 03:12:36 -0700 (PDT)
Received: from [192.168.1.107] ([75.85.182.25])
        by mx.google.com with ESMTPS id w32sm7110503wfh.19.2011.03.21.03.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 03:12:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110313 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D872420.8080501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169573>

On 03/21/11 03:10, Johannes Sixt wrote:
> Am 3/21/2011 10:45, schrieb Stephen Boyd:
>> diff --git a/daemon.c b/daemon.c
>> index 347fd0c..4c8346d 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -660,7 +660,7 @@ static void check_dead_children(void)
>>  static char **cld_argv;
>>  static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>  {
>> -	struct child_process cld = { 0 };
>> +	struct child_process cld = { NULL };
> 
> IMO this change is not good.
> 
> The purpose of { 0} is not to initialize (only) the first member, but
> rather to serve as a visual marker that says "We want the complete struct
> zero-initialized".
> 

Sure that's fine. I was iffy on that change, but decided to try to
silence sparse as much as possible. I'm fine with dropping those hunks.
