Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C737320189
	for <e@80x24.org>; Sun, 19 Jun 2016 02:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbcFSCXb (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 22:23:31 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33389 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbcFSCXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 22:23:31 -0400
Received: by mail-io0-f178.google.com with SMTP id t74so98172254ioi.0
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 19:23:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2T8Y4kfQs6a2a4v3GwCxO6f4tmT5IpXueI8SxFEGFmM=;
        b=KM2QzGg3VcdhGUBu5ZS4Ld5PALAgNV6RImlPbnQqc9+VtVT3IdQmYuq/bajuOfNrb/
         3z4HRyhSisL+S5zmqvu0ZK2IVIwFmuto3T2shDWwwvqo9+WHBVpZeP3FrZLaxvdsC0rt
         uwOB8MeXQbVH6JfldZQ6lyO7RaeHEw8RkRLVhG2GrWFXx61N5LS4n6KX1t5qqK8OqzR5
         D1mlhCTeQLn7UXaVIboV6ACKt+Tte1yQ957AhG3bHLyJCliofcda5cW5bisXvCcULdgZ
         U19DHT92RzdzCNro/AdbDGxNDhGnT7hUaxfGGpGH+VnGz2EtFqO948qkzLExIvldvIjM
         LmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2T8Y4kfQs6a2a4v3GwCxO6f4tmT5IpXueI8SxFEGFmM=;
        b=NqhgPShcT3zNjQ5Mu6O465mLwW8Ka9QThLE6eWe5Knj0B/qOUooSfZ/yl6SW2bNfNr
         aXdnO5H0o5JmloURcAG7csCR9DuJ2ErnRWTx6BuCrkBBmORgwDb53pSrwRHS7kRU8MFO
         RuAhdKedmBDbt0H4ix3mAX5hcdtFAIomr2J7t62Q4uNvZDXQU5hahPbPNbgNaI48wsQg
         gaw34n8ZyPr4L4j+xEtmddhZ1i8CIn0LxoyAVOYbALYSPiufK+J2j78bzrogIAPsDbAp
         txlahBpitdRCtvbNt7NaxxYbimZA6j/ddFnmQ6AdgvyQGZcTtMg7btU5vq/Bf3AKnqmD
         XqDw==
X-Gm-Message-State: ALyK8tKi6OUSHVZ5VgzesEnyXfwP4SBRgGSzeDCfxV962+q3Oyy7buHTgSXZTIIDVoQl9AaSJ+NsIHgyJfaFxw==
X-Received: by 10.107.132.28 with SMTP id g28mr14457759iod.34.1466303010356;
 Sat, 18 Jun 2016 19:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sat, 18 Jun 2016 19:23:30 -0700 (PDT)
In-Reply-To: <1466300967.28660.9.camel@frank>
References: <20160619005704.1771-1-emilyxxie@gmail.com> <1466300967.28660.9.camel@frank>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Sat, 18 Jun 2016 22:23:30 -0400
X-Google-Sender-Auth: eqnkw-GVKT4NftHFHdbv7DDVijI
Message-ID: <CAPig+cR5V7ZX8J9caYKTv4ECG_GP=N6geYQ+eReigicUC27cnA@mail.gmail.com>
Subject: Re: [PATCH] pathspec: prevent empty strings as pathspecs
To:	David Turner <novalis@novalis.org>
Cc:	Emily Xie <emilyxxie@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 9:49 PM, David Turner <novalis@novalis.org> wrote:
> On Sat, 2016-06-18 at 20:57 -0400, Emily Xie wrote:
>> +     while (argv[n]) {
>> +             if (*argv[n] == '\0') {
>> +                     die("Empty string is not a valid pathspec.");
>> +             }
>
> nit: git style doesn't use {} on one-statement ifs.

Also, drop the full-stop (period) from the error message and, to be
consistent with modern practice, don't capitalize the first word.
Finally, the string should be localizable, so wrap it in _(...):

    die(_("empty string not valid pathspec"));
