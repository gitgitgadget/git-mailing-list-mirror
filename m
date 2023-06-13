Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E6EB64D0
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 18:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjFMSnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFMSnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 14:43:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1F1BE1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 11:43:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd6df68105cso416510276.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686681787; x=1689273787;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaIAytrkYXpcQXV+VkwzOTbeXfUP3t68kEMW6p30Das=;
        b=wsxhAgsZYWX3sdVzp79n+uguXwl+mrfm8x+jEM7r6FwWuPDAVSrW8cdv+sXU09ip4L
         zdu4Z5aYY+jzVMAD/zeC4FONcaWNL+lS+/4nXtHq9k28kBz4fqSgKtLOb5YTCly6sa8o
         yRCFwXI4WOMkgsb5ApgewadLAoCBKPPqipDNutNbSb35KgwB6OAxg9Nyi0EVn66iqYnt
         kxydVxjo+BB/aR2m8eyQwaB6tjp0xD1qACoRSxU/6fu0+SkiYpL7aobqKTZs5qlT5Khh
         i+on75r3UhpiokAngO/hOJ49DOHZPAWMNmXL2Fzq+I5ZwY/SX1JLb9rAW7V62tjhV5BQ
         n03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681787; x=1689273787;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jaIAytrkYXpcQXV+VkwzOTbeXfUP3t68kEMW6p30Das=;
        b=j3FJ3tWfwsn49slMvoM31lrsFUjWrcfQn2J7Sb8Tq5i85EGsOKyCX36mobILcc1e3v
         oJH1z/98KDEw0kyt1YyUCq03PnBt4f3vrjfXPRyMMFfwfodhS7gsRSviidWU+ha9kaWK
         7ov7yeJ6xdsd/bco94xvtYlYt94tCRfha+e43/j1fYqJfDJkuG424HygAZkKrUYyLYss
         /q0bUXupPFfc1p1nfq4ILKRiAjzDa8KIz0fqVBaAyoC58wqA/RaG73XtknS0WQ7z4755
         s9likHhG3Unylv1GGeUMk6aF9Xv8IxaD6Ko/k0lgTkMbarHIeGevMWoHYX3ikzG7xs1g
         Dq7A==
X-Gm-Message-State: AC+VfDzH+VwfyN1vludUr1H5+3daACUSisTk9IgfhJSLOajDuwSvPCa7
        LutO6PdMGxur3m+0A3P/FHJIbRx73bSbEb8dKlyB
X-Google-Smtp-Source: ACHHUZ652YOXl+gZUx2jOr2QnRtm2QLcmjWhS9643l98fIktmm1AYjJsLJPIHcLx7EdhKACIaxQmlCXeYKElssoTmclE
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9387:0:b0:bcc:285c:66dd with
 SMTP id a7-20020a259387000000b00bcc285c66ddmr1101844ybm.11.1686681786856;
 Tue, 13 Jun 2023 11:43:06 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:43:03 -0700
In-Reply-To: <CAPig+cRS=cpV1e4QoSy5uypA+-hECyPe2rEg3scV8LVBfzZ5hA@mail.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613184304.36482-1-jonathantanmy@google.com>
Subject: Re: [PATCH] CodingGuidelines: use octal escapes, not hex
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:
> On Tue, Jun 13, 2023 at 1:44=E2=80=AFPM Jonathan Tan <jonathantanmy@googl=
e.com> wrote:
> > Hexadecimal escapes in shell scripts are not portable across shells (in
> > particular, "dash" does not support them). Write in the CodingGuideline=
s
> > document that we should be using octal escapes instead.
> >
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > ---
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
> > @@ -188,6 +188,9 @@ For shell scripts specifically (not exhaustive):
> > + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
> > +   "\xc2\xa2"), as the latter is not portable.
>=20
> The shell itself doesn't interpret these sequences, so this
> description feels too generic. Perhaps it would make more sense to
> cite specific tools for which octal sequences are needed for
> portability reasons, such as `printf`, `sed`, `tr`, etc.

Ah...good point. I checked with "echo" in "dash" and assumed that it
was "dash" that was interpreting the escapes, but indeed it is the
"echo" (and "printf") builtins in "dash" that are actually interpreting
them. What do you think of the following in the commit message:

  Hexadecimal escapes in shell scripts are not portable across shell builti=
ns (in
  particular, the "printf" of "dash" does not support them). Write in the C=
odingGuidelines
  document that we should be using octal escapes instead.

and in the CodingGuidelines doc:

+ - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
+   "\xc2\xa2"), as the latter is not portable across some shell builtins l=
ike printf.
