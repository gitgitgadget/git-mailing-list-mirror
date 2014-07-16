From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: [PATCH v3] sha1_file: do not add own object directory as alternate
Date: Wed, 16 Jul 2014 08:42:35 +0200
Message-ID: <53C61EDB.6050905@gmail.com>
References: <53BFB055.206@gmail.com>	<xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>	<53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com>	<CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>	<53C3D2AD.9050204@gmail.com> <53C4BFC7.2000507@kdbg.org>	<53C510A9.4010208@gmail.com> <xmqqd2d6v2yf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:43:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Ivr-00012X-08
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 08:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbaGPGnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 02:43:10 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63948 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbaGPGnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 02:43:09 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so705644wib.16
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2WBdsZQoYoOtAoO2q0HTLQ598UOcFo6hyskRaMy9nFU=;
        b=M56kdPWjskFS9DplRC1jgxKPK7DlGz3GvS4FuHp/BIknTMRUWH2umBLh2ozZn8ijsV
         I5ndCgMIaeX4ZMBS/T2LgbtfP3c7acLaisaXto2mEN9y7/d1qHSURQW64+ThVGpgqRXs
         A3KDlx5WPqjy12Z/hLy9v052Ti/rbcQqiX1W4R3SHbI/+lbiQlr7UzdEi3BwM6/rHWf4
         WawVsMKT16hVKrL8ufbqtL6sKgVLT9+UG51OJWoPZAgcn/UtLjXRbYSYE7EJGZ3EzRHj
         feIB3+L0AlrNKQSzZeBcd+vzOY+xzYVYh81brl05k/JgtffwK0fO+qOcJUO36EfNVifk
         4Q+w==
X-Received: by 10.180.188.203 with SMTP id gc11mr4229035wic.59.1405492988304;
        Tue, 15 Jul 2014 23:43:08 -0700 (PDT)
Received: from [192.168.32.231] (merlin.mvtec.com. [62.96.232.130])
        by mx.google.com with ESMTPSA id d4sm5290798wiy.13.2014.07.15.23.43.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 23:43:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqd2d6v2yf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253656>

On 15.07.2014 21:26, Junio C Hamano wrote:
>> +	strbuf_addstr(&objdirbuf, absolute_path(get_object_directory()));
>> +	normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
>
> This is somewhat a strange usage of a strbuf.

There might be a more elegant way, but I tried to mimic the local coding 
style and simply copied how the alternate paths were normalized. Let me 
know if you want this re-rolled without strbuf, otherwise I'll leave it 
as-is.

>> diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
>> new file mode 100755
>> index 0000000..8341d46
>> --- /dev/null
>> +++ b/t/t7702-repack-cyclic-alternate.sh
>
> Do we really have to waste a new test file only for this test?

Absolutely not. I'll add it to 7700, which seems appropriate.
