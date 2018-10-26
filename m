Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505591F453
	for <e@80x24.org>; Fri, 26 Oct 2018 18:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJ0DWT (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 23:22:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45043 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeJ0DWT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 23:22:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so2130632edb.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KSKkIaCtGJ05stNkyGa6QLTdLfIE+YHoPG/sMNWPsQ=;
        b=e2aTLJhZBryKVAC99EO9wvTbn/qUuv8NG3zs34La6OLAUDeCJVhOXAM/2lrtpVl8yS
         AmvS86wxBGffaRGS2HKm8ULS9PflQGbtGi1cN1X0JVTpm9RnHPj/HEhM9quRUaDWEpWL
         vbu1jtiHNb0YMjlccpLagDhJ9rfYBEDoyugc4P5lHWTMIMNg6J3ayGmsR9STLOkgcgxz
         e1XyDnx21xRuxCeTe1fO1j53IGBKHw8PrEuGO7/FSvJ6I49zR7C9woqQ5wY5CHjjqif7
         v60Lz8qWsDdPZzCizsMRSuI1LPtgyxp6izSx5tHRBxhdnMEyybZQDv79HI7HPMi9Z8aU
         iFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KSKkIaCtGJ05stNkyGa6QLTdLfIE+YHoPG/sMNWPsQ=;
        b=Na2LmBHnkjSl9YxKUHCAbjJsRnfpqHg4Mg5ByU3W6i5Q7AWZ+YK10ThrEfRyHmu8KP
         4Rnyg+ZfTbPsAWVx4nPsZQLAJtth64Zm1f//ljXYToBmcpVd8sMN7idlfieQC+GPwOvo
         bmePdVpYkeq3DCCdo9BGy981pe2puGQSDccEcNDxra4QsU+lCXMDmMvpJN0wxfweb8ig
         beRrThjvSfV7prIJLOEaCYRpGmVl1/73LsCAzU0keU80y7PelUg0i9k88omYpZYRQL2P
         hgvKuc1UiIr67S6AViAu4DcIpZNAVwyP/bJyrONZ+QgyQXJks7OxDH/UtI7mfC6QBc9L
         sJRw==
X-Gm-Message-State: AGRZ1gLllqeqV1mUopoqIEF2gNgFJ/Kq6hADrttoQBME0pyd0Zb/bDOW
        zB0NAaqqCq2sGBNlQhEbjiR3ZwsemsWEmZwri9zwaw==
X-Google-Smtp-Source: AJdET5dCR2RhjpAsE0nV0SBVsJ+ds/eshG8l3ydHBfGXkS1zhSUjBp2k30qCzG85GoQA1GEaq2ogL3aAsWvlptyFxXA=
X-Received: by 2002:a50:8ce4:: with SMTP id r33-v6mr4011053edr.231.1540579449961;
 Fri, 26 Oct 2018 11:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181025161813.17252-1-ao2@ao2.it> <CAGZ79kZvzLtSgAw8epGpG+T2f2Q7z2ZkXe=4gKMQTkM8ikwcog@mail.gmail.com>
 <xmqqin1peadh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin1peadh.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Oct 2018 11:43:58 -0700
Message-ID: <CAGZ79katS+PHWWD_0EqSmoEFazE0vAbMsg8G+iowNfbDmMkyMg@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Make submodules work if .gitmodules is not
 checked out
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 6:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >> In this series I am addressing the comments by Stefan Beller about the
> >> tests in patch 9.
> >>
> >> If the new tests look OK, I'd say we try moving the series to "next" and
> >> see what happens?
> >
> > Sounds good to me.
>
> Which means (1) the plan sounds OK but I didn't look at these new
> tests or (2) the new tests look OK and I am happy to see this go to
> 'next'?

I looked at the tests and found it a pleasant read, so I think the plan of
merging it to next and seeing what will happen is a good one.

Stefan
