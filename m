Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E4C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 16:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359541AbhLBQoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359173AbhLBQoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 11:44:15 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E6AC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 08:40:53 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id p2so124018uad.11
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H4vUJyGsIGk7fysi3iRrJp5rc+qP7n8iOQNPOe4rXVY=;
        b=PrqrVNEzfm0/bdK/Hb0eWNZ0siJDIMuYqOw9FvoPXjTg2n8kxVJN4tq6gJuXVq3PB0
         z8l9Twh6e2bHmhOaCubrnkoRXQWhn8yCAPUZOZTt9m8IF+37DP2m0KMVPr7zQY7MRkpP
         9Gc/WXX4AUXWwBvwz/JWNRf5BTnZDnN3uhRLHgHzP+GSVkWwM5Ei07cVMxLaZ+fJvzB6
         PMy7jr1+LSiOt7u4KaNFlhO5QaD0iJHoQ20C9Kp/C3+6q9xaz4KPANmArLFg+QKmT3O7
         spKjRyWQvHelv0WoRULn4nsrWt+L/F7Kpzyz0COofjurAg4ZgZsIOLggdv55BeTOcNJS
         7fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H4vUJyGsIGk7fysi3iRrJp5rc+qP7n8iOQNPOe4rXVY=;
        b=lh0daABGiBOxRFl7A9NPPf0bvR7JREhAOnqd01E/U2zu8N9QbnsCx/LMYdDBMImlZ4
         6P5G3lMseRMw/Nv6qhMOEdQki4zT1Wo+g5ZpzHq6larUbVFItaWuj4J9lv0bqn8wEmAb
         uW6TDcGQydA0Z9yBTFFJ+xqyd/zI3mKziPgN2T6tN92FVDabsgyJm5QLxBR9S9balplJ
         Jqw1ALBd+PeZbMW0TlzIbjDOwYR1nDicT5LVrL0waF930jAGyh5lXHo1oLBe5W+c7OX7
         0IJTE1d7PY/pMXW7A58NF32rqr3QgZtfwgTTSxyF/YooavtBFkiHagZOo3Z++10HkXBn
         g9sQ==
X-Gm-Message-State: AOAM532C/tCcXgws1O8jbcJvHqKEHRr/uhtvu0WnMdCavPCbn1i9oH1D
        I3JmDBrukzJgFKywQ1L+iF3JdbqRP2XxoBO/oP6ywKBXCGM=
X-Google-Smtp-Source: ABdhPJzx5xJ2hYce3RjwTeaOUinsHCuYeg7jxxQEwqwltM8wiRc8ILvLeFLu8j/ioXmckutWe1bp4Wh33YINihbi9Jk=
X-Received: by 2002:a05:6102:dcb:: with SMTP id e11mr16476345vst.8.1638463252447;
 Thu, 02 Dec 2021 08:40:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
 <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com> <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
 <xmqqbl224k09.fsf@gitster.g> <CAFQ2z_M35tbF6+C2MkMRm7hO8CNdUSrGTcx+8Os348+rHu4ojg@mail.gmail.com>
 <xmqqh7bs177v.fsf@gitster.g> <YafMS6qI+6t6SOtg@coredump.intra.peff.net>
In-Reply-To: <YafMS6qI+6t6SOtg@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Dec 2021 17:40:41 +0100
Message-ID: <CAFQ2z_NvHK17w3Rd958uwNziT2w5wXhiAJTSkCgBi32smgQuOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 8:26 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 01, 2021 at 11:00:04AM -0800, Junio C Hamano wrote:
>
> > > The test helper takes the flag as an argument, in decimal. If you loo=
k
> > > for 2048, you should find it.
> >
> > Awful---when the symbolic constants change in the code, the test
> > will silently break?
>
> Agreed, this is quite nasty.

I've added parsing symbolic constants in v3.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
