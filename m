Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA8B20966
	for <e@80x24.org>; Mon, 27 Mar 2017 06:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdC0G54 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 02:57:56 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:35362 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdC0G5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 02:57:54 -0400
Received: by mail-ot0-f172.google.com with SMTP id y88so24403742ota.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WGtQAzH8TBH7yQZHICdHvkjibw56bX+DPeAh+gT2m7A=;
        b=QlQpgzkqaaojtdPifob5DOgwyRgxD03So7JhFMl08wXozNJehSE+uq5T1rZ28CfMxa
         N38Rz2z1/Apr7XVwHd4lZg78FlrHLXooj4ytjgpXkFKqmtnG3DaAV2FAB2jvxCF+KDzU
         c7p9O2cMPej9jdlsaBmJoLg/zcbIkeUZOlAaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WGtQAzH8TBH7yQZHICdHvkjibw56bX+DPeAh+gT2m7A=;
        b=rMO06+1yXS8l03nvT9qgyVzoVLkPHP61nhehW4BV7V/Rv6ToR69l+o0OOJvgJm9h51
         uSCxp28mlcI5ETEf4ND4YDGMcQTQjd4L5dyhjDaTQSWjJcZdQP6k9NYD6OrtLe12fUK/
         qiPvi5pAwVWhfjtNL6yRs85+xwxv36NCjrQpdT+cMc3Z2Z0kOJzUa0g5qbbNfWu+i1He
         E/W4rc8FPLOG4mDVuGnjf4zLq9x3zdyqG4W8BwvkQnJY9exuusMjvendtYbRfkt47RoE
         HI4JpafCRGyfW72Dlohs5OdWdFMM3xS7aNc+agfrt+K47SCy0Inczf7LELVPJ+SyFyCD
         yaQw==
X-Gm-Message-State: AFeK/H1AmocMxvdG0dXZ4zLejBIllVOb9x4CVRhlkzDC+VZ7hppj2kwpNp1WZWPEQ3VlCuhH7PRxLltyzYlOlA==
X-Received: by 10.157.55.161 with SMTP id x30mr11458785otb.24.1490597867771;
 Sun, 26 Mar 2017 23:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.38.225 with HTTP; Sun, 26 Mar 2017 23:57:47 -0700 (PDT)
In-Reply-To: <xmqqefxj4ofm.fsf@gitster.mtv.corp.google.com>
References: <20170326091537.2707-1-luke@diamand.org> <xmqqefxj4ofm.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 27 Mar 2017 07:57:47 +0100
Message-ID: <CAE5ih78jhR3GwMBdPyi5oOHByC2fVxefExStc9pCNMTu-1Os7w@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Add failing test case for name-rev vs symbolic-ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 March 2017 at 00:18, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> As per the discussion about use of "git name-rev" vs "git symbolic-ref" in
>> git-p4 here:
>>
>> http://marc.info/?l=git&m=148979063421355
>>
>> git-p4 could get confused about the branch it is on and affects
>> the git-p4.allowSubmit <branchname> option. This adds a failing
>> test case for the problem.
>>
>> Luke Diamand (1):
>>   git-p4: add failing test for name-rev rather than symbolic-ref
>>
>>  t/t9807-git-p4-submit.sh | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>
> Ahh, thanks for tying loose ends.  I completely forgot about that
> topic.
>
> If we queue this and then update the function in git-p4.py that
> (mis)uses name-rev to learn the current branch to use symbolic-ref
> instead, can we flip the "expect_failure" to "expect_success"?

Yes. The test passes with your change.

>
> IOW, can we have a follow up to this patch that fixes a known
> breakage the patch documents ;-)?

Yes.

Regards!
Luke
