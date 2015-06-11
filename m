From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 05/12] for-each-ref: introduce new structures for better
 organisation
Date: Fri, 12 Jun 2015 00:51:36 +0530
Message-ID: <5579DFC0.6030002@gmail.com>
References: <5579B253.4020804@gmail.com> <1434039003-10928-1-git-send-email-karthik.188@gmail.com> <1434039003-10928-5-git-send-email-karthik.188@gmail.com> <vpqwpzarvl6.fsf@anie.imag.fr> <5579CBE0.3050301@gmail.com> <vpq4mmeqcrr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z382y-0001z2-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbbFKTVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:21:41 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35898 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbbFKTVl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 15:21:41 -0400
Received: by pablj1 with SMTP id lj1so3555141pab.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yFU5pY6rF42TsgIu7wpQVytWUpWGMR0emX1aosPeVxY=;
        b=RM4YJcjur+rIf0YADuEwei4PaliQyHxNR69agG8Fkv6CVBBbYLFd2k45MB+A5DO5Aw
         OMey4Eespp9Ct1DmgolDnq0GY3eaNw92+cYjWuld2MSxeedOAwiux5vUiooGkLsRdnHq
         xlWxS6//699JH9WMe0ykVd4981A1H15l5UNw06bof7Pr9AHkRkgjZzBTKDZNeSqPSXz8
         SKh5r+h0Y8LZi27JFy5vPjNEkuKzxKKViB2lLI0fva0AjyOwVXvF/Oo93EshtbYy31iL
         XBdfFlDwS6hHyeBxEVnTQwtAAwKCRE+55xF2c8mM7VlRdIzACtFyAWPQNybBNGuuYodf
         9hTw==
X-Received: by 10.68.197.161 with SMTP id iv1mr17308453pbc.0.1434050500795;
        Thu, 11 Jun 2015 12:21:40 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id fy5sm1426640pdb.93.2015.06.11.12.21.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 12:21:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq4mmeqcrr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271454>

On 06/12/2015 12:43 AM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > On 06/11/2015 11:11 PM, Matthieu Moy wrote:
> >> Karthik Nayak <karthik.188@gmail.com> writes:
> >>
> >>> +struct ref_filter_cbdata {
> >>> +    struct ref_array array;
> >>> +    struct ref_filter filter;
> >>> +};
> >>
> >> I didn't notice this at first, but why introduce the structure like this
> >> when you are going to turn it into pointers later in PATCH 7:
> > Here it is serving to for-each-ref, so I kept it this way so as to ensure
> > that currently as per this patch
> >
> > struct ref_filter_cbdata ref_cbdata;
> >
> > would be the only declaration needed in for-each-ref.c
> > If I made them pointers here I would need to have
> >
> > struct ref_filter_cbdata ref_cbdata;
> > struct ref_filter filter;
> > struct ref_array array;
> > ref_cbdata.filter = &filter;
> > ref_cbdata.array = &array;
>
> ... but after PATCH 7, filter and array are passed to ref_filter so you
> don't have this overhead anyway. Makes sense.
>
Yes, there we wouldn't have a ref_cbdata in 'for-each-ref'.
But this would be taken care of in 'filter_refs()'.
"Makes sense." Not sure if you're agreeing with me or you want me to re-roll.

-- 
Regards,
Karthik
