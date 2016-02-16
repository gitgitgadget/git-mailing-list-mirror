From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 16:09:53 -0500
Message-ID: <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:10:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVmsi-0002mg-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbcBPVJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 16:09:56 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36648 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbcBPVJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 16:09:54 -0500
Received: by mail-vk0-f47.google.com with SMTP id c3so145148536vkb.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7UlH6E0XN4hQax9E7DX36S9S8BrnZyCmqrpZiBbkAUk=;
        b=RCH5zEPlraSYNX1OAe7X26Ej5rj4wnLXnmMJzO4Sr6oR2pG+XNYh35x+Ge5phrgm2e
         yBWaI+RymZFF3/SB1n9hR5W9ZHJxJPKIFRRoXKwQNwCSHfPmmnIt6YFWlQsTXMC05ESx
         ase3fG/WWqEG0sp96TAvMEAyvKh3ht1NQ4jqZ0/4esFJx4I2Id4j4gcXZYKtQFv4cTlQ
         uWcwVA1PYIsW5gD/frgj5tjAKdaLdxptErVn2z40EarLX4hNEjgth9inIAPjARBBT/KC
         OAihDHRq/9RXJi2Eh81iqPbXJJ/F2VEb0o1Zqp8HkN1Ss3j/FM7mE4FlJ6BOTBzgM/bf
         atGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7UlH6E0XN4hQax9E7DX36S9S8BrnZyCmqrpZiBbkAUk=;
        b=Ck6ezxUi0bO252bJvJW2ifNriWE2k5jQBtPhuyV0JHwyyBOb5/gBmZ9fNJaqy9SdVA
         ELLQjwLO0kPjg+doLovKv4AMeUwkKukrKecC2UKF1y8axQUB/VnljrMaFDjXhQobzfpW
         fm0uAIoupJbv2p8gl1DhLk1HzNi19eTX3vE9O4LL7u4StNYjvcFs6/StKbDapejETJCm
         Fh3LS/03XJ7kSoCbQ8kO+kdTmMUveeYTV9EDrbo5Hd9ZrHGD46LMuO7atE5qYa/xIMyP
         Y+ojBQLnp4xUL0134LX4LNgbkKV2HM4mSnFYqX9+mr832B8kwXN9wYSQBiZQXjNDWNnk
         ZnEw==
X-Gm-Message-State: AG10YOSa5gtBTadOdNb6SW7sb3dexdHAyayHnHZK80QieZEQD1nOlhwgXTnCsP/7gUXbnFpTnyb6tR8cCi/3ZQ==
X-Received: by 10.31.146.2 with SMTP id u2mr17491570vkd.19.1455656993135; Tue,
 16 Feb 2016 13:09:53 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 13:09:53 -0800 (PST)
In-Reply-To: <20160216204954.GC27484@sigill.intra.peff.net>
X-Google-Sender-Auth: -UuN6jiE4HguOundT91H0SCcGyE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286432>

On Tue, Feb 16, 2016 at 3:49 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 16, 2016 at 03:12:29PM -0500, Eric Sunshine wrote:
>> > Did you consider just using string_list_split for this? AFAICT, you
>> > don't care about the results being strbufs themselves, and it would do
>> > what you want without having to bother with patch 1. [...]
>>
>> That's a nice idea, however, I'm not sure if making it part of this
>> series this late in the game is a good idea. The series has gone
>> through major changes and heavy review in each of the preceding
>> versions, and turnaround time has been consequently quite slow (due
>> both to the amount of work required by Karthik for each version, and
>> to the amount of time needed by reviewers to digest all the new
>> changes). v4 was the first one which had settled to the point where
>> only minor changes were needed, and we were hoping to land the series
>> with v5. [...]
>>
>> With that in mind, it might be better to make this change as a
>> followup to this series. On the other hand, as you say, waiting would
>> expand the strbuf_split interface undesirably, so the alternative
>> would be for Karthik to submit v6 with this change only (to wit: drop
>> patch 1 and rewrite patch 2 as you've shown). While such a change will
>> again require careful review, at least it is well localized, and
>> Karthik's turnaround time shouldn't be too bad. So...
>
> Yeah, I don't insist, and like I said, I'm not 100% sure we can get rid
> of the strbuf_split interface anyway. I thought it might actually make
> things easier by making the series _shorter_ (so my regret was that
> mentioning earlier could have saved reviewing effort on patch 1).
>
> It does mean extra review of the patch I posted, but my hope was that
> it's small and localized, and wouldn't impact the later stuff seriously
> (there are some textual tweaks to carry it forward, though).

My initial reaction was negative due to the heavy review burden this
series has demanded thus far, however, my mind was changing even as I
composed the above response. In retrospect, I think I'd be okay seeing
a v6, for the following reasons:

- I already ended up reviewing the the suggested new changes pretty
closely as a side-effect of reading your proposal.

- It would indeed be nice to avoid introducing
strbuf_split_str_omit_term() in the first place; thus one less thing
to worry about if someone ever takes on the task of retiring the
strbuf_split interface.

- It should be only a minimal amount of work for Karthik, thus
turnaround time should be short.

So, I think I'm fine with it, if Karthik is game.
