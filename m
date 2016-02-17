From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 01/11] ref-filter: use string_list_split over strbuf_split
Date: Wed, 17 Feb 2016 17:21:38 -0500
Message-ID: <CAPig+cS8sJn9tV2kW=ASN2wTtKiK-H5oa8bThiiGfu_vMv7DoQ@mail.gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
	<1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
	<20160217221430.GA24899@sigill.intra.peff.net>
	<xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:21:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWATf-00054o-2v
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbcBQWVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 17:21:39 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36132 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965454AbcBQWVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 17:21:38 -0500
Received: by mail-vk0-f52.google.com with SMTP id c3so28109868vkb.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5z8bK+HRJu31I8THHCe8hEE4AZ9fxwjlOSzYI+Fhzqw=;
        b=f97napPrcPx7wyTK/mBPAelP//eU5cXrT70ZUwgd0fjpdNYl2RHsJpGoY18jqy8clU
         3jUZc7WrPJ8EIci5QR2S5kexYJPCOeqSCMvDqDrsC34rCPdviTsn5xzpZG4HS3Y6ko04
         bK2GDrzpOapJOBkrxP4rtnX1lG3I+qqpUVXm3HSYSzWTgHsUtUrQqtKrBNYZbOJKkBHD
         QVpHk7vmKE5nNyF2IE+HR6o5mv9aQhdfpNFHHbzM6NWT4ifjTgsiQc6OVoGjG01eZlGD
         6WgY9y3uomz8ZxPQmd3+0QbFMzNR+gGKkDFKBWn+X1sPgiPdnUqpX1B6xuzpl2weyxQ1
         9kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5z8bK+HRJu31I8THHCe8hEE4AZ9fxwjlOSzYI+Fhzqw=;
        b=D2trt5zfB6A9M5HUYontjCKN6NV24rCCQ1eLHtrrmPY2DPAGrddNTrKWSXIwpjNlSP
         zczfy1hxVH5Ml9M6yMO0qTHp19pcDGCG9k8AywyV9pJnos+LGekH/V4qAB4dJN/0rh67
         l/nnXJmUuxrPzL6qj5ezZgyGXWSpgwElFPArZu9rHIl0cJy7UqP7s/V6OaK8iatDRC9D
         /+kd+ZdiuA/E3F7BbUTF2ry2Sq5IEnbZlPrOxRQaAFRQJSFHjFFyy+3fEf3STtO/0tqr
         MfXP6SDofUs54bEECYNG/91k18nuIijALAEXixvg14Pu7lQlgPodLyyu0QIqsRl5OI56
         DS/A==
X-Gm-Message-State: AG10YOQglQ2gDgrmS2amwuU3t/Dh8Ytt69uN9fZnyhm1heWlHnelIKoK8xiXoV76GIthElYdj9DggMhoTWG0hw==
X-Received: by 10.31.149.3 with SMTP id x3mr3560751vkd.46.1455747698134; Wed,
 17 Feb 2016 14:21:38 -0800 (PST)
Received: by 10.31.61.143 with HTTP; Wed, 17 Feb 2016 14:21:38 -0800 (PST)
In-Reply-To: <xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: mls1OgQswCjPyzbYNHhPB1RZ05o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286561>

On Wed, Feb 17, 2016 at 5:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> On Wed, Feb 17, 2016 at 05:11:50PM -0500, Eric Sunshine wrote:
>>> On Wed, Feb 17, 2016 at 1:06 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> > From: Jeff King <peff@peff.net>
>>> >
>>> > We don't do any post-processing on the resulting strbufs, so it is
>>> > simpler to just use string_list_split, which takes care of removing
>>> > the delimiter for us.
>>> >
>>> > Written-by: Jeff King <peff@peff.net>
>>>
>>> Perhaps Peff can give his sign-off...
>>
>> Ah, right. I usually sign-off when sending to the list, so the version
>> he pulled from GitHub didn't have it.
>>
>> Definitely:
>>
>>   Signed-off-by: Jeff King <peff@peff.net>
>>
>> And I don't think "Written-by" was doing much here, anyway; I am already
>> the author by the From header at the top. :)
>
> ;-).
>
> So, is everybody happy with this round?

Yes, v6 looks good to me and is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
