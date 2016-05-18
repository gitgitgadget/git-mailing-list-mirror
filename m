From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/12] revamping git_check_attr() API
Date: Wed, 18 May 2016 09:51:23 -0700
Message-ID: <CAGZ79kYLVDkeHUMCxOB57YYeJt3f4O8csEp_tyO-oWMTzJ-9hw@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 18:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34hB-0003Hs-W3
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbcERQvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:51:33 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34620 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694AbcERQvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:51:25 -0400
Received: by mail-io0-f179.google.com with SMTP id 190so72913483iow.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nx9w5V8u5SNw2wizsMTx2jOhEmoRFw+Kw8TkmrYUSVQ=;
        b=WyZW1c9LAQBYmhE+77aQdMK/Nj85K2cK0aFPCk/ewZg5PA0rW3LHBDr6SYTctqBzHu
         8pCDU8Kn5Fq11QYifu1OnKXPxBY7k4fCjzR6i7ysvTRQUNaS7MEK0l72Cmc3/YaVGNUO
         ykaCYzPtNfu3yWN5b33vg1ETMdCngUFuckp1YwJfAE9e68hPlSd5fYEddw4p6wgHr2IY
         ToEHtrRRTnWo6VUjAx2f7buDBTb1FQB8mFtoWJ0/rpAQB06w3mGx/fwcehGuGbKfZTnl
         ECV8zQ4jMhUrDAmgmlgUVTvrm4tK4kpqpCdHTJCxvFfmTdB4/E1bOGT9JSYxGXZ5aDi6
         yo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nx9w5V8u5SNw2wizsMTx2jOhEmoRFw+Kw8TkmrYUSVQ=;
        b=ApUJjmLsM7J4vQqDjKF3jBtRVRvgiuwVGQb2kzgq+0T11ras9JjD+hLMbRjfPK4pFt
         8Qu7MlJq9Lm3pP0EwoI3zr2HxGEUiZzq2zd3pxHJXyLI1GeTJKHWkRDsA7hH55YCNBe/
         dVpuDCUhE5uofeOWQxAxrrMoQcOOjLiLffez8QsL36d8t89Ke8HpGtvNs3Kr2ctQSErU
         bYCmRE38SRoB86gfjFOL8JVkVRm5vqfoJp5AdB309UscHKQa8+28Xd67j7FkqhnvRUOL
         3aGVEcnWC+AnHYS9CkaxvE3wozwTCwcqkhxuvwvIXwvAeZP0Q/3H9uVXCG58s6I5+xvd
         DU1Q==
X-Gm-Message-State: AOPr4FXC5ySg3lqPFT3it65eS09U113ksOmLLdIm/2ei7W/sbh0791JoiFYMec5vVbtzKv/xWXxCw70KpXjJhkU+
X-Received: by 10.107.173.3 with SMTP id w3mr6693716ioe.110.1463590284344;
 Wed, 18 May 2016 09:51:24 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 18 May 2016 09:51:23 -0700 (PDT)
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294974>

> The patches in the earliest part of the series have been sent to the
> list already; there is no substantial change (I think I made a
> typofix in the commit log message found by Eric).

and a new patch got added here:

    attr.c: tighten constness around "git_attr" structure

I cannot find it on the list though?
(I only see it in the "What's cooking" email and on origin/jc/attr)

Minor nit:
So I wondered when you prefix the subject of the patches with "attr.c:"
and when with "attr:". All patches with "attr.c" prefixed touch only that
file, the others will change the attr system beyond that file scope.
However the "tighten constness" touches the header file, too. So
you'd maybe want to loose the ".c".

Thanks,
Stefan
