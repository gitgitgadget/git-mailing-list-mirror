From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v9 2/2] test-config: add tests for the config_set API
Date: Tue, 15 Jul 2014 22:37:03 +0530
Message-ID: <53C55FB7.7060405@gmail.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>	<1405434571-25459-3-git-send-email-tanayabh@gmail.com> <xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 19:07:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X76CT-0005Gh-H3
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 19:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbaGORH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 13:07:28 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:42891 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbaGORHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 13:07:09 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so4057111pdj.36
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=D92Ow3OJAakjBR/cOK2BRgHJ8qMSClz0UaOFAnw4ZrQ=;
        b=mDSsxXddOw40R3XuRXzkAVkikQ/m6SOtNQXBBnLPkPHFzbaT2t7jOARp/JcSCKuM5z
         48rdoGsJuoUOl0go5DmLi1Eh2Mldi/cZABkKg9OSQVXbti1sbBAsk5phoSQs/zbPBrhd
         WZAb6d6IhbTE/YheFHrCakg/K9ytYIKd1GMppS7ZUsSi6Gu0OVsZEu5YC+G01+C+87gj
         8U+4PqNzdd1K8HmxU/fHwVtFsk3lBWCA/LigT+CxoPDMRY4nU4BAb8cBgIoHwwwJSp60
         3RZu2fnwSrUGhq5bU7ul5yVRazUekLh/+YNoYoDRM8d7cXgFIgwj53OcWT8p9PqfdhTa
         LOTQ==
X-Received: by 10.68.135.67 with SMTP id pq3mr1964241pbb.165.1405444029244;
        Tue, 15 Jul 2014 10:07:09 -0700 (PDT)
Received: from [127.0.0.1] ([223.226.20.20])
        by mx.google.com with ESMTPSA id di10sm8499810pdb.94.2014.07.15.10.07.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 10:07:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253574>



On 7/15/2014 9:27 PM, Junio C Hamano wrote:
>> +test_expect_success 'setup default config' '
>> +	cat >.git/config <<\EOF
> 
> So the default .git/config that was prepared by "git init" is
> discarded and replaced with this?  Shouldn't it be
> 
> 	cat >>.git/config <<\EOF
> 
> instead?
>

Most of tests like t1300-repo-config.sh or t1303-wacky-config.sh
clears the default config, will it be okay to clear it in
this test series also? I need it for
test_expect_success 'proper error on error in default config files' '
which requires me to compare the line no at which the error was found.

>> +test_expect_success 'find multiple values' '
>> +	cat >expect <<-\EOF &&
>> +	sam
>> +	bat
>> +	hask
>> +	EOF
>> +	test-config get_value_multi "case.baz">actual &&
>> +	test_cmp expect actual
>> +'
> 
> Hmmm, wasn't the whole point of the helper to allow us to make
> things like the above into a one-liner, perhaps like this?
> 
>       check_config get_value_multi case.baz sam bat hask

Noted and corrected.

> I suspect the same applies to most if not all uses of test-config
> in the remainder of this patch.
>

I cant use it for configset_get_value_* as it may have variable number
of files as arguments. :)

Thanks,
Tanay Abhra.
