From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Tue, 17 Nov 2015 09:34:04 +0000
Message-ID: <564AF48C.9040406@diamand.org>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>	<1447592920-89228-4-git-send-email-larsxschneider@gmail.com>	<CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>	<52A9F66D-12C4-4BB5-A2D4-C476A1E12DC5@gmail.com> <CAPig+cR8igO1bWNgma_yZqrcru_jnKchpRH+i2_AaNj8Atcb9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 10:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyceU-0004Ol-6A
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 10:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbbKQJeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 04:34:07 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34167 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbKQJeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 04:34:04 -0500
Received: by wmvv187 with SMTP id v187so217373198wmv.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 01:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BuZtXSX7Br96l27VePYKkYiSN342J0q7NH6p4y4pM70=;
        b=TzmUr0MqCRo5Y4XtXSqIv+SDo+GANM9vSS/9Af6yd63/1JDzXuUND/S1k0UkyL1K7d
         xcxRGlJLjtigxNfL/Kr7gmccoY/+NmJoV4zJYXziZ+5JBCIOf7An6NqbKjeOvKKXRaU6
         CEqhwBnAHUIrD2x8pnmXKxr6p8CByoanhAZDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BuZtXSX7Br96l27VePYKkYiSN342J0q7NH6p4y4pM70=;
        b=CfIcMyHFK+AMfadeaaYQmOnW+lpwRi1P5rM9Dy23aDhjnTxE09NgKYcecbr6QXR5oS
         EZsegWEesDM7eTpbtEA5KLyv9u6QuRNIpyhEWrXzIgF8K0wLjlLd2CfyOAhRAsB17RRa
         FtWERCkcYIKUOUFve4RENjI+qVRZFv0sxXzk2ot2mzAzugn/a6Fgzc4Cd092ngGL6sHX
         4cpiux3pbY3sn17ZIJxz30/Yzbyk1nAMZp0jo0p3X+r2UXbJnW/splZprDy+llelcvuu
         pKYLgukdh/YbFAhbQrZ97IJXAkEm9sFj/FeaZhexifj3hDG5SazsDrUj1x0RJ7flAXCH
         SrEg==
X-Gm-Message-State: ALoCoQnldN0U7LKoPH9RZqIJtg0ooHW8VQ7evO3fbrqfkZmVgCuMu81jlAOY/HFBMXOy8YrYmbAC
X-Received: by 10.28.184.134 with SMTP id i128mr1539198wmf.12.1447752843135;
        Tue, 17 Nov 2015 01:34:03 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id v196sm12479148wmv.10.2015.11.17.01.34.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 01:34:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAPig+cR8igO1bWNgma_yZqrcru_jnKchpRH+i2_AaNj8Atcb9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281392>

>>
>> While implementing it I thought more about it. P4D is only
>> supported on platforms that support the date function. That means
>> these tests will only run on platforms that support the date
>> function. Consequently I wondered if this would justify the
>> slightly more complicated code. However, if you think this change
>> would help the patch to get accepted then I will add it.
>
> I don't feel strongly about it, and it's not my call anyhow. Opinions
> of Junio, Peff (as interim maintainer), and Luke weigh much more
> heavily than my own. Punting on dynamic detection of "date +%s" may be
> perfectly acceptable with the attitude that it can be implemented
> later if someone runs across a case where it's actually needed.

Which other platforms are we talking about here?

https://www.perforce.com/downloads/helix

 From there, you can get Solaris10, HP-UX, AIX and various flavours of 
BSD. Solaris supports "date +%s".

HP-UX and AIX, I really don't know.

Windows? I assume 'date +%s' will work for people using mingw.

Is it possible to get the time in seconds by doing something like this:

time_in_seconds() {
	python -c 'import time; print time.time()'
}

Luke
