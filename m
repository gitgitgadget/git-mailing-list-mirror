From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/11] Allow reference values to be checked in a transaction
Date: Mon, 9 Feb 2015 11:05:15 -0800
Message-ID: <CAGZ79kZmwk5=ViPdRVd+0ncMyAhGAbid6TJUznvMuK6pQ_VSRw@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqtwyvapx7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKte8-0007ND-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 20:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831AbbBITFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 14:05:17 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:46975 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133AbbBITFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 14:05:16 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so18406756igj.4
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XyCiddELbWc5QHGkxKhKpNd8NZuD5C7ZN60/Oulhl4c=;
        b=NWSQ5XC2nFLOxmNQWwVUkoML+hiAJ3/okjyv6VbfOOmkCoFJ3b3OKfJ8Wl5GZhbICM
         iubIlFal1orCl/a41aX0gARZq5NTdNP3nfH3oBzveAO2lyIGZ7WqUoPF8bo6aHJjWS4h
         ljfiSzYg5zbfF3EvDVQQZ1o0lF55V3J/vjE/LaQd6mAml3CAaKfWzYDNBevwYP1gEZjv
         E/okHQ1iYLNuPxv6qy9Rxnpdr6GseMQj+qob6Z9h2Ke9xU1Ka/8AScmBu1IljP+ZrFgQ
         Fq/3NjmAc68wDouNvInFsqiNS6TlJoCvn2/iBXko7A4FpvMKlX1UhFbtxeLlzfrlYMwS
         fAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XyCiddELbWc5QHGkxKhKpNd8NZuD5C7ZN60/Oulhl4c=;
        b=dbn4jHngrA1Iwq8EHWOHtVDcMGX2jaNwwAj9Dd8WD4qAaxHkYTkA57YHAtHXUaILqm
         jErVY+VpFSUXrMecjoy4EwsNs8rE9FO11A6By0wzONJttQ/rUOGS93EPfUsjBc9tM2cj
         EG+fmnNm0xMg6r6kanLRhvfpHW2NjiDYPPK1ArW5SHBXyKng9XnRL9hPdAm2j2WLSiQN
         Xin1ed5dWlThszIzvZEAuWK45Unp5de3hyJQL7UXxe/pRFHWPfHY0D57UjRsPDT8cH+b
         EL8+wkqtQLsLXOynRKhwKkBIia9HrxD7g0+ls3jqdOUFrhRd+1ye7n/idFeKX7ZC5dqi
         ulWA==
X-Gm-Message-State: ALoCoQn7Z6VmkgAj2wbqFpPo9v7Pm5YCW9zZSad1AuP+WsEegg5hBxeTH1zL502fc9fjD43FEEd9
X-Received: by 10.50.85.44 with SMTP id e12mr19040926igz.48.1423508715442;
 Mon, 09 Feb 2015 11:05:15 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 11:05:15 -0800 (PST)
In-Reply-To: <xmqqtwyvapx7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263585>

On Mon, Feb 9, 2015 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> The main purpose of this series is to simplify the interface to
>> reference transactions as follows:
>>
>> * Remove the need to supply an explicit have_old parameter to
>>   ref_transaction_update() and ref_transaction_delete(). Instead,
>>   check the old_sha1 if and only if it is non-NULL.
>>
>> * Allow NULL to be supplied to ref_transaction_update() as new_sha1,
>>   in which case old_sha1 will be verified under lock, but the
>>   reference's value will not be altered.
>>
>> * Add a function ref_transaction_verify(), which verifies the current
>>   value of a reference without changing it.
>>
>> * Make the similarity between ref_transaction_update() and
>>   update_ref() more obvious.
>>
>> Along the way, it fixes a race that could happen if two processes try
>> to create an orphan commit at the same time.
>>
>> This patch series applies on top of master merged together with
>> sb/atomic-push, which in turn depends on mh/reflog-expire.
>
> I am a bit puzzled by your intentions, so help me out.
>
> I see that your understanding is that Stefan will be rerolling the
> push atomicity thing; wouldn't we then want to have a "fix and
> clean" topic like this one first and build the push atomicity thing
> on top instead?

My understanding is to not reroll origin/sb/atomic-push, but
origin/sb/atomic-push-fix (which is worded misleading. It is not about
atomic pushes, but about enabling large transactions in my understanding)

>
> In other words, would it make sense to extend mh/reflog-expire (in
> 'next') topic with commits from "Fix some problems with reflog
> expiration (8 patches)" series and this series to fix and clean it?

I am not sure what advantages this would bring. A better history
for bisection? I cannot speak for Michael, but my understanding was
to have mh/reflog-expire and sb/atomic-push-fix merged now that 2.3
is out and everything else on top is unclear/rerolled/discussed as needed.

>
> We may even want to rebase/reroll mh/reflog-expire on top of v2.3
> while doing so to adjust to the transaction stuff, if that makes
> some of the changes in the two new series unnecessary (if these "fix
> and clean up" changes made in mh/reflog-expire in 'next', that is).
>
