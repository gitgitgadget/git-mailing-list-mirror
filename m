From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 0/5] git_config callers rewritten with the new config
 cache API
Date: Wed, 30 Jul 2014 19:33:37 +0530
Message-ID: <53D8FB39.7040904@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com> <vpq1tt3rmbt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:03:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCUTv-0002ko-7w
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 16:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbaG3ODn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 10:03:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47627 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbaG3ODk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 10:03:40 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so1579234pab.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Eo0IQCLpU4e7JtxIw93SN+5ozzSSGheWIQXabgsINEU=;
        b=fQdUVsy+GKJ3RdvVjpgHCJdI3PFGqlQlzufmHSxvPDauHVxK/YjdrObPsqUERMXSbr
         uso+tai7uUEWiOz9EBcFB+wrwnR4QGcMvQyz9LIPHZKr7t4yf/FFrQ3JU6Rs82omVWSr
         +zfoB++xAY0UYgf4QEcPWKkxnpswIybTxwFUG+zaaOHO+4bTdG4NNP2KA0X7pBOC+5Y4
         Dzi5Hy465CufJdW6Sn0VToOpQvi9QDM1rQKVYVGLehrsEhgCFeR6HmgoEyHsTPAUDANm
         Na9lpydrkjOqmVaNkn9V+YP15dRpRFaanh+TwSSITXv2HjjQTPWsnOYDM4icAc4t7azm
         KeqQ==
X-Received: by 10.66.119.132 with SMTP id ku4mr4857494pab.121.1406729020081;
        Wed, 30 Jul 2014 07:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([223.184.63.185])
        by mx.google.com with ESMTPSA id bj8sm8319895pad.46.2014.07.30.07.03.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 07:03:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq1tt3rmbt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254495>



On 7/30/2014 7:16 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> [PATCH v4]: Tiny style nits corrected. Patch 2/5 has been totally reworked.
>> 	One thing to check is if the config variables I changed in the series
>> 	are single valued or multi valued. Though I have tried to ascertain
>> 	if the variable was single valued or not by reading the docs and code,
>> 	mistakes may creep in.
>>
>> [PATCH v3]: Most of Eric's suggestions has been implemented. See [2] for discussion.
>> 	Also, new helpers introduced in v7 of the config-set API series have been used.
>>
>> This series builds on the top of 4c715ebb in pu (ta/config-set).
> 
> I think it semantically needs your other WIP series, that makes
> git_config_get_* die in case of error. Otherwise, there's an unexpected
> behavior change in case of error.
>

Yes you are right, there is a call to git_die_config() also in the series. I will add
the info in the next reroll. Also, any thoughts on what to do with git_default_config()?
We can,

1> make a new function git_load_default_config(), use it for the rewrites.

or

2> git_default_config() is rewritten to be loaded only once even if it is called
again and again during the process run, so that we use the same function in callbacks
and in the new API using rewrites.

Thanks.
