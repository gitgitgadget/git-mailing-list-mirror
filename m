From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 05/12] for-each-ref: introduce new structures for better
 organisation
Date: Thu, 11 Jun 2015 23:26:48 +0530
Message-ID: <5579CBE0.3050301@gmail.com>
References: <5579B253.4020804@gmail.com> <1434039003-10928-1-git-send-email-karthik.188@gmail.com> <1434039003-10928-5-git-send-email-karthik.188@gmail.com> <vpqwpzarvl6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z36ip-0003DE-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbbFKR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:56:54 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35623 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbbFKR4x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:56:53 -0400
Received: by pabli10 with SMTP id li10so3068865pab.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8mLkQ11owoUUw78DXjiUIQ4BzZFwDPCbst4LTtWytOA=;
        b=EK28lE6QqdeaF0r63NM3dLKTHa1NMwn6hK65QznayuVcxHsymg4D1ZkYdv4scExkyA
         2g5nZzSqEz50yr0//SaSUgAeyPvfwyex7snxMXUkyX3UxH/NIQvK4/xTmKzlQsS7aOe0
         Q9xMqzBavFLaBGkQFVWr1prCmqGxPQfiYiIcSMA4NSocebq2kBilpj6DMnuE8OJUcE3D
         UnhKd5UW0NE7QKkyNrCIc7egnvAvClXAtz/6WIo2L800TTWrBt01oSuDs+ItmvU09Ok/
         jHnDCq1t+qK4wvAj1+DHaa8MvAULxctexOyHJT94I7QL9H+Qno4rV007+t1Ec3Qy6aJF
         1Xqg==
X-Received: by 10.68.99.197 with SMTP id es5mr8468784pbb.131.1434045413491;
        Thu, 11 Jun 2015 10:56:53 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id a10sm1338186pdn.57.2015.06.11.10.56.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 10:56:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqwpzarvl6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271446>

On 06/11/2015 11:11 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > +struct ref_filter_cbdata {
> > +    struct ref_array array;
> > +    struct ref_filter filter;
> > +};
>
> I didn't notice this at first, but why introduce the structure like this
> when you are going to turn it into pointers later in PATCH 7:
Here it is serving to for-each-ref, so I kept it this way so as to ensure
that currently as per this patch

struct ref_filter_cbdata ref_cbdata;

would be the only declaration needed in for-each-ref.c
If I made them pointers here I would need to have

struct ref_filter_cbdata ref_cbdata;
struct ref_filter filter;
struct ref_array array;
ref_cbdata.filter = &filter;
ref_cbdata.array = &array;

And this seemed like an overhead.
If you still think I need to change the code to reflect the change early on
I will gladly do a re-roll.



-- 
Regards,
Karthik
