From: Avi Kivity <avi@cloudius-systems.com>
Subject: Re: [PATCH v4] git-am: add option to extract email Message-Id: tag
 into commit log
Date: Wed, 02 Jul 2014 19:15:29 +0300
Message-ID: <53B43021.9090506@cloudius-systems.com>
References: <1404312673-11836-1-git-send-email-avi@cloudius-systems.com> <53B41F28.8040205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 18:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NCC-00057U-8n
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbaGBQPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2014 12:15:40 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58395 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbaGBQPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:15:39 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so11689947wes.33
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 09:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zY210CxgkQRJjImBmd6ZIRdMz4zjZFRzH8/vDxU7+ug=;
        b=NHAd53rOm5bUKIiZfcFnSVOxRoH0NP+dK7YA819l/JOT0TAZXhLqMkPBJYeNmuarRn
         DAzhWTAGiv2rUTdK3T7clK2cngVoyL1sDJKVIouTrkvW2d262wwIExjloHuX1EEqnzUY
         gabEC0TqWtgMEpJQCikVJpywLJcVaXcH3ppnoagqXONkl6dOPoK14Wm2SyuI8zf+Vu1j
         WTugZ3L+kQGm2ja6EV/8iU3mOzCWQ3vWzrjtdTaC3dDMc9fMQGz4w2TWl13l83ydDadV
         wK1fR3lhc3nLCqbpbDt/PpJq2E7TYJpbHx24fw57Z2gr+A0QQQBWeU/YWF8J/f74YZ3t
         BdSw==
X-Gm-Message-State: ALoCoQk26PJeQlzAzuRaTcXVszL4xTv6uoQMQUzcOwNRdwm621pATpyVrDQ90LnGyJbRdEuSyEVl
X-Received: by 10.180.76.132 with SMTP id k4mr5340928wiw.1.1404317737673;
        Wed, 02 Jul 2014 09:15:37 -0700 (PDT)
Received: from avi.cloudius (84.94.198.183.cable.012.net.il. [84.94.198.183])
        by mx.google.com with ESMTPSA id i12sm55966339wjr.32.2014.07.02.09.15.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 09:15:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B41F28.8040205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252790>


On 07/02/2014 06:03 PM, Torsten B=C3=B6gershausen wrote:
>> @@ -565,6 +568,7 @@ Use \"git am --abort\" to remove it.")"
>>   	echo " $git_apply_opt" >"$dotest/apply-opt"
>>   	echo "$threeway" >"$dotest/threeway"
>>   	echo "$sign" >"$dotest/sign"
>> +	echo "$message_id" >"$dotest/message-id"
>>   	echo "$utf8" >"$dotest/utf8"
>>   	echo "$keep" >"$dotest/keep"
>>   	echo "$scissors" >"$dotest/scissors"
>> @@ -651,6 +655,10 @@ then
>>   else
>>   	SIGNOFF=3D
>>   fi
>> +if test "$(cat "$dotest/message-id")" =3D t
> Does the usage of '"' inside of '"' look good, or can we write like t=
his:
> if test $(cat "$dotest/message-id") =3D t

With your change, it will fail if the file is missing or empty.

Complex shell scripts cannot be made to look good.  If that's a=20
requirement then the script should be rewritten in a reasonable languag=
e.
