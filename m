Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C5C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C217B2076A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szW8oNic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGJUOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUOo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:14:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E859C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 13:14:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l2so7078668wmf.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rgVkCM39gDzF2ISlPfsIqXzjySqhgfVNtbzgDkjsqA=;
        b=szW8oNicQG4NAwv1g/SQZ6sn9GWpTuX3EWQGqKeU8FfzFrp7EhPsWc3DbpPqnppE4t
         loZnXlGGO6Ewen5f/L1frlWsLO31XCrS7wwfXHUQX4jEMeIhawx8ClBaCS5VjB2tFFki
         vaNHIWSvJ9ZpGTxSJG/agwecJkUHFB20SpyRS/qqhTcMzmauWcsp6OQ115ikspE9jknx
         4gbKhMMdlhEzF2nN9fL56eUaRJQ9/VWpXR56uY3U2HPBQCSV12Gkhr2KFfmG81FEg56R
         2lEU6inBzHd1pn77yw5lRPik7ifasdkmP3Ms+cy2zrqcO7kXpg/cpS2443B1g7EySxO1
         iMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rgVkCM39gDzF2ISlPfsIqXzjySqhgfVNtbzgDkjsqA=;
        b=mejmjFtbfxzSS30a1iKlpT2oBKNwsX6MQX3EM/pam89bqWo1btccuJJabgEMgUjKcw
         JtKoa+aCAKtqGNwjdNQqu526rbva3zxQRUpXsk4Z/bSh/IgHSUD/ML1uR36B2aEDZkVd
         ay7WgXx6LSmYeZapBFAVcv3CPlWm2R2L7PaVK4KPLl/0v84IHgzzSMUUXfjWrVIHdJOo
         CTWHl3ZeWrjtPcea0sU/jQxjMLYsvmXWEX/7gvgiXMxxrenIPCku52LV/2sVpRq4sTha
         XhWLGbb1wqaoj04MLiC0ph5lRK3L8zo2ff2czqGVIAgsDAsolYwPMM1C2HzI2IqGezdg
         H57g==
X-Gm-Message-State: AOAM533Amh/CedZOlTfaHPB5E40OlowvONqC+vWIOguR3YrrUJvGUh37
        5BUPiz+2gIrF6IYiGpRvJGl4o0gpDAHcTJV/5Qw=
X-Google-Smtp-Source: ABdhPJwaBtTktdOrYgQ6il+KK2FVhMNJNUN4HaE78mW+xxLSxVVTA4SGBXEFc2IxVbAjkjjfdXcmd2npnd/2upzxjwQ=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr6508015wmf.87.1594412082816;
 Fri, 10 Jul 2020 13:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP9c5k5kLSqhCh9400iLdZ=+-nKonavOYpBSs_NHdaVVJ_ycQ@mail.gmail.com>
 <xmqqk0zbt9h3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0zbt9h3.fsf@gitster.c.googlers.com>
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Fri, 10 Jul 2020 15:14:31 -0500
Message-ID: <CAMP9c5kzRoVKEQMMVt_tnRMrayP+yT0c+Q2xxewbrZN8piCbHQ@mail.gmail.com>
Subject: Re: --function-context shows wrong function in chunk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This happens even with -U0 which does not include the e.g. trailing
bit of other_routine.

$ git diff -U0 -b --function-context
diff --git i/example.c w/example.c
index d87b59b..346e2a7 100644
--- i/example.c
+++ w/example.c
@@ -6,3 +6,3 @@ int other_routine() {
 int main() {
-
+    puts("Hello, world!");
 }

Zach Riggle

On Fri, Jul 10, 2020 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Zach Riggle <zachriggle@gmail.com> writes:
>
> > When using --function-context, the function that is claimed at the top
> > of the diff does not match the actual function.
> >
> > Note that the change exists in main, but the hunk header
> > (terminology?) shows other_routine.
> >
> > $ git --version
> > git version 2.27.0
> >
> > $ git diff -b --function-context
> > diff --git i/example.c w/example.c
> > index d87b59b..346e2a7 100644
> > --- i/example.c
> > +++ w/example.c
> > @@ -4,5 +4,5 @@ int other_routine() {
> >  }
> >
> >  int main() {
> > -
> > +    puts("Hello, world!");
> >  }
> >
> > Zach Riggle
>
> I think it is possible to modify the "find the line that match
> xfuncname pattern" logic to start scanning backwards from the first
> actual change (i.e. the blank line in the preimage of the patch
> inside "int main() {" function in your example) and make the hunk
> header say "int main() {" instead of "int other_routine() {".
>
> I however doubt that such a change makes any sense.  In fact, I find
> the sample output above both quite logical and also even desirable.
>
> It is logical because the first thing we see in the hunk, "}", is at
> the end of "int other_routine() {" function; it does not conclude
> the "int main() {" function.  Saying "int main() {" there on the
> hunk header line would be misleading and confusing.  It sends a
> wrong signal that there was such a line _before_ the first line we
> see in this hunk, which is definitely not.
>
> It is desirable because it gives more information than saying the
> illogical "main".  The reader can see what the routine before the
> beginning of main function we see in the hunk is.  In the above
> example it may not matter, but if we see "return -1;" at the end of
> that function and a call to other_routine() from main(), e.g.
>
>         @@ ... @@ int other_routine() {
>             return -1;
>         }
>         int main() {
>         -   int i = other_routine();
>         +   int i = other_routine() ? 1 : 0;
>             printf("%d\n", i);
>         }
>
> it would be more informative than having "int main() {" there.
