From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 17:49:19 -0500
Message-ID: <CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
	<CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
	<20160216223451.GB9014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:49:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoQu-0007vF-DS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbcBPWtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 17:49:21 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35459 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbcBPWtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 17:49:20 -0500
Received: by mail-vk0-f50.google.com with SMTP id e6so147146859vkh.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SqTP00s/AxA8wnMmtw5Oifdo0R+ltiJTc0dYWWyP3x0=;
        b=ef4GFmadUznB3vqb4hvijFUH1hHxvn79TMqnQfSqteoU0I/eyHl0ab8hVIkrBlMHTQ
         xEwbgpoLmZPm0N3ePBBUMhQDjzUQa8YC4u6ofvSNqYbAaEjivJ1kGGVGV0OdMnlQbEWk
         QRTiNLVm3ln5mEW9RzqRsG9uZmUkXozLjzv52Q9jHKQK3bFUx25GEkFbSNGA45jxUiR+
         KeXa/UC36veMEft/7V9yws5whucW8loHG7wz5jvRtamcLYN/lbGAIefPP7yrDHZOz2GG
         eR5zmkCSHU/lNDp+SsiyAEuLd4VsEfXEnHBQL5tEtTZmlQofMWU7/0pgGGJpUfb1TB9+
         gaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SqTP00s/AxA8wnMmtw5Oifdo0R+ltiJTc0dYWWyP3x0=;
        b=hpdzaLuteGYSbzlv1UHX917XeQeergDBxLBPFqQbuo5BS+I1QpAgkbHw3YUmHqNxxs
         /9cCKzvNJjPMLVUEwsTsk85W0hMTLNdI+dOFC4f88ybIcJ4093cKbTL3mChGixfPo9UD
         miXEmYFp1Uyaw8odqmLeHcZ3i0AU7vtJumXe9jGAgL8ZwWffEWoMqgAJmLMYcwhWrrNR
         hAtBm2xM6WTjj3bMqxbjbmSaHLE649lPkVX/M0G7BCfQm5Ip4VoaUelrBkSSHG48AO79
         db5V4GdYN6wvA1vc0kqpZUaj/H7sV9HpbBDcktUZeozxJKZR+G9+OV+2304zPqPvHKXF
         KjKw==
X-Gm-Message-State: AG10YOT4QlKc7ttf3my06icOd+WzxjItE1CS5CJpBU/VCgg8Y4icm8P3j+bAfOlqcdGBkbdSlz9FclfXbEJA6Q==
X-Received: by 10.31.47.135 with SMTP id v129mr20233950vkv.115.1455662959301;
 Tue, 16 Feb 2016 14:49:19 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 14:49:19 -0800 (PST)
In-Reply-To: <20160216223451.GB9014@sigill.intra.peff.net>
X-Google-Sender-Auth: HQZoFQbV9OM-1n-d2xyluqsH7l8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286447>

On Tue, Feb 16, 2016 at 5:34 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 16, 2016 at 04:09:53PM -0500, Eric Sunshine wrote:
>> My initial reaction was negative due to the heavy review burden this
>> series has demanded thus far, however, my mind was changing even as I
>> composed the above response. In retrospect, I think I'd be okay seeing
>> a v6, for the following reasons:
>>
>> - I already ended up reviewing the the suggested new changes pretty
>> closely as a side-effect of reading your proposal.
>>
>> - It would indeed be nice to avoid introducing
>> strbuf_split_str_omit_term() in the first place; thus one less thing
>> to worry about if someone ever takes on the task of retiring the
>> strbuf_split interface.
>>
>> - It should be only a minimal amount of work for Karthik, thus
>> turnaround time should be short.
>>
>> So, I think I'm fine with it, if Karthik is game.
>
> I started to write up a commit message for my proposed change. But it
> did make me think of a counter-argument. Right now we parse
> "%(align:10,middle)" but do not allow "%(align: 10, middle)".
>
> Should we? Or perhaps: might we? If the answer is yes, we are likely
> better off with strbuf_split, because then we are only a strbuf_trim()
> away from making that work.

I also considered the issue of embedded whitespace very early on when
reading your initial proposal, but didn't mention anything about it
due to a vague recollection from one of the early reviews (or possibly
a review of one of Karthik's other patch series) of someone (possibly
Junio) saying or implying that embedded whitespace would not be
supported. Unfortunately, I can't locate that message (assuming it
even exists and wasn't a figment of my imagination).
