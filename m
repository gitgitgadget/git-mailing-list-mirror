From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/7] submodule add: label submodules if asked to
Date: Wed, 11 May 2016 10:26:15 -0700
Message-ID: <CAGZ79kYWg08Cz0oznLSOryvXvYof+Y0=qbszF5r5fXqxr2HDMw@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-3-git-send-email-sbeller@google.com>
	<xmqqlh3hl7mc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 19:26:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Xtt-0004Zr-82
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 19:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbcEKR0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 13:26:17 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35282 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbcEKR0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 13:26:16 -0400
Received: by mail-ig0-f182.google.com with SMTP id bi2so161115781igb.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=QK69al0QMV45jholsSF9znethl9FLALKDeGwU1j1DFc=;
        b=YBco0aKhuwhjadHaO9JQEiRptQh97UIGYS4uLy3AiDykvmrx1JP40Siswt2+bt8V74
         E5ns+O5YNv6aQgfzbxOAClTwIzRaUgxiovM2Vw4FAdxkc1SnJDV8FNVRViox2ar9r0X4
         VqZp0IN//DdS5/68WrI3r2p4CEVfthW/NerOI83wBemXuqAWNJvJNb4HSBSiCgLz0W4g
         OpPphPES5dLCLW/zEMl+6J+78tP3ivHS4m/EkRsIgBp5g+souJx97FaHX56bpFC4Y5K/
         9T1VKFJplHuBn3qlkIa6RtCb47l4ntFhdQs//vTQZypOt8qtzgxBULKfWX9XRCYz/QJx
         jA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QK69al0QMV45jholsSF9znethl9FLALKDeGwU1j1DFc=;
        b=RdX/rs5zooseSxRTsPeyH/uLBybRrmNg3xZHMs2jKeP60FDZkhylRePYYAksRJpkim
         agJOwpxWoOOQDIL++YSGe+/QypmQAhpUMKyNY5lc0IArXqs4RpHO5/adapK6Vqq2zlBX
         CxXx9LQqgzpYRY5K6zLH2b/PG7g5hZbevKLl1thfidJhKXaDm8uniOByTrXNxg0DF741
         Y8CvHR2YoH07CtaE1a1qw4YGG04cXpVHQBSk0iTcUOMkDDA8O9tYG580Lwd8DvDSTZfB
         cTXYb5fRuwQKBBIBPbKSG+1iexMLJk1rmFzlHeOIl7JzRt479l7bCizROx1Won5o0n+n
         1Zog==
X-Gm-Message-State: AOPr4FUp3xoh8bzNqy7uCXG0Q7RKu3w771PPl69xBaqm0iZ56Rz2KgXIh54qx1snqx8e+A8aOcZK1XKM6m7hRM6R
X-Received: by 10.50.250.165 with SMTP id zd5mr23682627igc.85.1462987575369;
 Wed, 11 May 2016 10:26:15 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 11 May 2016 10:26:15 -0700 (PDT)
In-Reply-To: <xmqqlh3hl7mc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294354>

>> +cat >expect <<-EOF
>> +labelA
>> +labelB
>> +EOF
>> +
>> +test_expect_success 'submodule add records multiple labels' '
>
> The existing tests in this file may be littered with this bad
> construct, but please do not add more example of running things
> outside of test_expect_{success,failure} block unless there is a
> good reason to do so.

I thought that was the standard for tests as I have seen
them quite a few times. Looking for those "cat >expect ..." constructs
more closely they are often found inside tests as well. Makes sense
if the expectation is used for only one test.
