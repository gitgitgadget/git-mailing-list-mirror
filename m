Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008BE1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756354AbcIGSCU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:02:20 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36487 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756288AbcIGSCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:02:19 -0400
Received: by mail-it0-f44.google.com with SMTP id i184so212651882itf.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UIZ69lWfFcgg4cukUyT8zp7fACKEXdjZAznzju+BAJk=;
        b=ID5vdEjITuVF2V+qnQ4QPXoKWmj4PAB1bFIIg1mRWRyFUAfQWqlcImgWZuQyzwmwop
         WtDeCTde09bBYsdqie8KVE6fykfrFFPIf3Zv2KOwR2sloX3dTivBE9TWVASRx8sE2FUh
         h8BMK/avpGoyWvBkc2qGI1UX62ZdccmdyCjRZmnk/FbTmKA7C0hTaPWNNQCd7Tzofogv
         afA7K3otE061xpDFT9WVsyLVb0QNU3t8cVG9V738NRhruq4yImaOZg9npaRSkTF7ykCQ
         otoaa97H5FcSWdkWVEPgesj+VcRB3dT9hG4pze5s24HKPbMngyeZS5GValRxi0FplYHD
         9wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UIZ69lWfFcgg4cukUyT8zp7fACKEXdjZAznzju+BAJk=;
        b=QlZ7Xr39kpJb0cMSnesrFSBup5lbrJomhdq/hQWvcw8c/KnlhlUOBnZQXwLUmKXIHB
         E1Xi3OdNPusk5x7HigvCkrNUevO5RLEtSWQQPaaHYg1Oq9yLV+vgw7culzcJGm8gudFw
         gb8/cLPaQWGp9RMGfIAY6mW3rz0cfsVMHKMJvXSLOzk8Gv4p1jj/UTYUNEq4nIDzVtTp
         z3Ue8b4dYncTRMOr/2plaSb6UuxFi6JRw+LKr/sy54Vna8sts4yKRuapxNaPa5eIh0uY
         dLRGj9u+sfZanYxQN3GBwjgt5ryCtlCuOus2MXKQFu8EmRETs35CryLVTQEJzMWdIFHV
         SepQ==
X-Gm-Message-State: AE9vXwO1hgmLey3A1b/K1vgtB1cP2UWX6+dYaK1mhmbu1TlM9+MvYtum1F9fqULvHFWkhevJ1wDvsZmyDlKmO56l
X-Received: by 10.36.189.15 with SMTP id x15mr497046ite.97.1473271337932; Wed,
 07 Sep 2016 11:02:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 7 Sep 2016 11:02:17 -0700 (PDT)
In-Reply-To: <xmqq7fanoas6.fsf@gitster.mtv.corp.google.com>
References: <20160904234237.10548-1-stefanbeller@gmail.com>
 <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com>
 <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com> <xmqq7fanoas6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Sep 2016 11:02:17 -0700
Message-ID: <CAGZ79kbSG-9xdmG3LWEsVoJnhEr5pcL8D-95E99a+=JaXGOXCA@mail.gmail.com>
Subject: Re: [PATCHv3] diff.c: emit moved lines with a different color
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> as we do not want to see dashes ('moved-old'), I think I'l go with
>> "movedfrom" and "movedto".
>
> OK.  They would be color.diff.movedFrom and color.diff.movedTo in
> the doc, and "movedfrom" and "movedto" in the code (as the caller
> already downcased them for you to strcmp()).
>
>> When going through the second pass and actually emitting colored lines
>> we only find matches in the hash map if the current line AND the previous line
>> match as we lookup by hash code, i.e. if we have a moved line, but the
>> previous line
>> changed we do not find it in the hashmap and we don't color it, such
>> that the reviewer
>> can spot a permutation.
>
> Hmph.  Does this have impact on a line that was at the beginning or
> the end of a file that got moved to the beginning or the end of a
> file (four permutations, of 9 if you throw in "middle"), because
> some cases it does not have a "previous" line?

I spotted that problem as well. We need to adapt the algorithm a bit more:

  If the previous line is of the same kind (i.e. starting with + or -),
    then we have to take it into account,
  otherwise (i.e. previous line is different, such as header, hunk header,
  or different sign)
    then ignore previous line, as the previous line is already
    having a different color.

That works for the very first line of a file as well.
