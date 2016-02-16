From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 15:12:29 -0500
Message-ID: <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVlzB-0005UI-I4
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 21:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbcBPUMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 15:12:33 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36069 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbcBPUMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 15:12:30 -0500
Received: by mail-vk0-f50.google.com with SMTP id c3so143785814vkb.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nZFVmKfc39pN8ZxNQqaM2aSJXFSVv/K4EiT2Dm1fjtE=;
        b=u9yg0C50G+EAnUdixYxX0bk7Uz39PbY6aNwrmet4MZDs8rJ4vilO/xsRI0/dkzdLri
         4Z8Df+3YWUkAb4FKMOG9VWB0gve+GMH/47asMx7hHTt3WY91mmHqTqMoGlINoj9ijnRe
         6P2wp3f3WMUhTX7OlbICzwpFLeTaPz594F6jU5/xiCxBW7Ap0lVA05tzQ5cFg6xNm5rR
         IUEhLgm5B/gFW8bxjQpcL7pgEgBYWir016L2cPeU85bmgXKggZWDIfHSEh0LftH8fvCv
         YRYjAchXpCD1mjWXQL0mqhGzGMc+i9la5CD9v8A7SCpfQU9fXV5pPZzLN0jSyWFaTPw1
         RAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nZFVmKfc39pN8ZxNQqaM2aSJXFSVv/K4EiT2Dm1fjtE=;
        b=M++lB4z1dkY3JPgB9aPc6flFwpBYMKVZn5LKU7WZPDjYGinEIzdj5IpCP+eVuU0rmM
         GCKwKSvPpyoayWhpZoksjYUuwy+93uUA7nVqgaNvtXha//cvWWVFdThgVkZL+TxUF4Ho
         DrHsxcvPBtXyD7dpT00ROYbqf2oKIgAVJSIQ3lHI8C/huaGp5UEmsPKpTZDyH6C2VUeh
         fZSYCTDwHamA6NcAKufHuwSQ4j5J4KSJZ5OtRztPOr2lTqfExEoE1NHGvVlNF40rtb2h
         4D4rvuh2sXmHgpETNY4RDfz2Fm2EUqvF4dLDMQhfzbnEtzySGFBJtsjJD1s8KBOFMH/B
         k2iQ==
X-Gm-Message-State: AG10YORci7qoUYcg7vwZ9yu2gWSuoBjHDhHap9lhcSj4zijPCHfHdCzxYERcS/3Zuf7/DRPfnSOXN2v4vy57Lg==
X-Received: by 10.31.141.2 with SMTP id p2mr19659336vkd.37.1455653549622; Tue,
 16 Feb 2016 12:12:29 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 12:12:29 -0800 (PST)
In-Reply-To: <20160216192231.GA16567@sigill.intra.peff.net>
X-Google-Sender-Auth: TqCIPjj1TyliP-q8vCEmiDyRJGU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286427>

On Tue, Feb 16, 2016 at 2:22 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 17, 2016 at 12:30:05AM +0530, Karthik Nayak wrote:
>> Use the newly introduced strbuf_split_str_omit_term() rather than
>> using strbuf_split_str() and manually removing the ',' terminator.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
> Did you consider just using string_list_split for this? AFAICT, you
> don't care about the results being strbufs themselves, and it would do
> what you want without having to bother with patch 1. [...]
>
> Sorry to waltz into a review of v5 with a suggestion to throw out all
> the work done in previous iterations. :-/ I just think the strbuf_split
> interface is kind of clunky and I'd be happy if we could slowly get rid
> of it rather than growing it. [...]

That's a nice idea, however, I'm not sure if making it part of this
series this late in the game is a good idea. The series has gone
through major changes and heavy review in each of the preceding
versions, and turnaround time has been consequently quite slow (due
both to the amount of work required by Karthik for each version, and
to the amount of time needed by reviewers to digest all the new
changes). v4 was the first one which had settled to the point where
only minor changes were needed, and we were hoping to land the series
with v5. (A few larger changes were also discussed in v4 reviews, but
we concluded that they could be done as follow-up patches.)

With that in mind, it might be better to make this change as a
followup to this series. On the other hand, as you say, waiting would
expand the strbuf_split interface undesirably, so the alternative
would be for Karthik to submit v6 with this change only (to wit: drop
patch 1 and rewrite patch 2 as you've shown). While such a change will
again require careful review, at least it is well localized, and
Karthik's turnaround time shouldn't be too bad. So...
