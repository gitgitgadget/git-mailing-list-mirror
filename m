From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Fri, 18 Mar 2016 14:13:24 -0400
Message-ID: <CAPig+cQYYPmUtOoTGDzzQJC8n+9UoVEskmnZ19E=rroyU5+Pkg@mail.gmail.com>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
	<xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elena Petrashen <elena.petrashen@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agytu-000405-B1
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbcCRSN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:13:27 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34021 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbcCRSNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:13:25 -0400
Received: by mail-vk0-f52.google.com with SMTP id e185so151251335vkb.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=RvZqbJLW2wgoRx4v13TPo4lbXx4n8QTUPJUaGvEpK6Y=;
        b=zrW5w5IKacrz/b+hIEiFkUaiXx/qYhhXPAlHNo7cHRAqqo3fZgt3guSI0TU4rNp/iS
         A8cH3dijcxD0L74CM6KzpQmLYEpgNjfeJKVktbGcgClUMD3o9LJ+luU0diSwHgTaROEn
         G7+n+0tzz6tC57yIcpdsu0oLH6mhqoI9hZ8vSEmM25SjooL+2n76qmx6MUZe8afIkscp
         OOipnEPAH/1cusTHN7UNr8zlZu2tW0M2a/GQqdw3rZmdEF12z9/dj3wiOW0J9vrla/HX
         CUl7meL1njjU8qvy8TiuZmHNASpkWx37zMerQtnzITSMwC3SMZLMP0t/LHZUt71oAL38
         EDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RvZqbJLW2wgoRx4v13TPo4lbXx4n8QTUPJUaGvEpK6Y=;
        b=Hkby6RO2w/pkjkel+0HxBkEv8+Fs+SEbLMoiOaFP5RpC6gwWk09RCMDi8jalrMU+6s
         hLiJ5A9bXDsgj2mgAAJamzfWnC+PXEmZl8rvUJFw4RFENHDVo0m3MiIccGd9p7orlGgl
         1Ngi+uRvtj6Pq4//ZwdpesVwPzupK01jFwT2CsfVm6rGUt88O4zyfeuML00eVvaDA0Zc
         pLuwF4Zlu8mAvZswLY1LrsowbP0yerLZA5TpDZiMRoT7ZdzxM+WVcdnZWUsV3qHnCJar
         TxF/cWOxxAMP2V9phk58NO4EqskEj5euEpNVdlQbSnRg0wpVOQbYrrdzHsO19BLeAzAn
         zeNA==
X-Gm-Message-State: AD7BkJJ8PMi4yLtj1AWGPfqbTr1AcEL8vDzGZ1HoWyOdNK2Y7P1E26aXcawiYEhHXXPMMKzm7qtYeWNeYRbS4w==
X-Received: by 10.31.130.74 with SMTP id e71mr3748407vkd.117.1458324804691;
 Fri, 18 Mar 2016 11:13:24 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 18 Mar 2016 11:13:24 -0700 (PDT)
In-Reply-To: <xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 21b1S47KRk-uhXFwup4klCoQe6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289238>

On Fri, Mar 18, 2016 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On the submitted patch itself, in decreasing order of importance:
>
>  * The approach you took turns every "-" that appears as a command
>    line argument into "@{-1}", but it does so without even checking
>    where "-" appears on the command line is meant to take a branch
>    name.  This closes the door to later add an option that takes "-"
>    as an argument that means something different (e.g. one common
>    use of "-" is to mean "the standard input" when a filename is
>    expected).
>
>  * There is no explanation and justification in the proposed log
>    message why you took a particular approach.  Why is that a good
>    approach?  What are the possible downsides?  What were the
>    alternatives (if any), and why is the approach chosen is better
>    than them?
>
>  * We forbid declaration-after-statement in our codebase.
>
>  * When you do not yet have the "branch I was previously on", I
>    imagine that your implementation would give you this:
>    [...]
>
>  * You do not need the brace pairs around the body of these new
>    "for" or "if" statements.

Also for consideration: You'd probably also want to add a test or two
or three to verify that "-" works as intended, and a documentation
update may be warranted.
