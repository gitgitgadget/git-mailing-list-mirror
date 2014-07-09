From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v7 2/2] test-config: Add tests for the config_set API
Date: Wed, 09 Jul 2014 18:12:18 +0530
Message-ID: <53BD38AA.9000409@gmail.com>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>	<1404903454-10154-3-git-send-email-tanayabh@gmail.com> <vpq4myqd92r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4rCg-0000wq-8E
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 14:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbaGIMm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 08:42:26 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:65065 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbaGIMmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 08:42:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so9231010pab.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8z+3bigDKntdUimrJFL5PJW6P4sHLFSAR+Os3S+PiSI=;
        b=JfAxMCM1y0PjsqTbMV3BSdSfDD05tKAp+I2mYiZk/60ZWJQxn+q6wBn5SH2VkAEYIC
         F7YnbsQHE7vZktnKhFpkWgb1Ty/ultJT1FR2GC84avNUoTL54kMDijVTNOAk6y9KHc7u
         Hw/YmqxQTRDAwPibSe3ETlADQZq1a72AGDstk4SnL+6BkQ0KVNk+vK1vSH8A5UXTkB2i
         2ir4OCO5pWWQATe2a5d07ZOAfzJ08T4fj76R5nKvuHwyqng6VXQmWQeaednrCGoJY/4w
         DlbfKM5vTt484qmhgrrVom0dX1whkRcAxc8i7ackc9/GMsjd/oniDEdG02OhmwCjSnLV
         QZzQ==
X-Received: by 10.68.94.225 with SMTP id df1mr41141877pbb.86.1404909743448;
        Wed, 09 Jul 2014 05:42:23 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.59])
        by mx.google.com with ESMTPSA id pa3sm16998868pdb.94.2014.07.09.05.42.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 05:42:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq4myqd92r.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253124>



On 7/9/2014 5:43 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +test_expect_success 'find value with misspelled key' '
>> +	test_must_fail check "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
>> +'
> 
> Sorry, this is still not right. You're checking that either test-config
> OR test_cmp fails. You want to check both.
> 
> Basically, you can't use the "check" helper here. Your v5 was right for
> this test:
> 
> test_expect_success 'find value with misspelled key' '
> 	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
> 	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
> 	test_cmp expect actual
> '
> 
> 

Yup, I had thought so too, that was the reason I left the && chain in check()
in version 6. I will revert back to v5 for it.

Thanks.
