Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20DEA1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 09:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbcLHJV2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 04:21:28 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34751 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbcLHJVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 04:21:25 -0500
Received: by mail-io0-f195.google.com with SMTP id r94so2166145ioe.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tsu/fbxXLyL4p8RiGoZCKojC26kEtJ5HMURdAivCddg=;
        b=CFEZjk53waHmJZ2Vn01V5R/hBCAjmBZz+97PesR0Q/KUWKg4EkB6vOJY6YlVe0m6lr
         mTrLucPJxm9iV1x5+s/xRh3Qdv83iivN9Y+FnYAhZa3UbvpY+ofB3M9jHSbCyFxXa2uw
         yqOsYIZVusWQqF6KdsVuM7V9ZQW98T0LXrWUieqhYEPWX64sndRumtr8Z2RFDhRn44jS
         vVIgKh+swnIdGxw9oBTr68gonipBC6X7Mc0QO+S+bL/hAM5eoCZva9oY+hzoEKEE+1Hm
         02wbsKBEyVLckJQ3pRuOAHJTqHKcEkh0UVpJ7NpLvgrmka20zqfnk/QiZ7D22GULcGWH
         xU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tsu/fbxXLyL4p8RiGoZCKojC26kEtJ5HMURdAivCddg=;
        b=UU90o84wAS/3sGctutChkPk9dBciaeP5n6HKwCJ9zOuBi3U2rNCiNWHxXuO9MKM+hD
         pTlvI+cAmC1NudeC/ioqsGfMqdXI4UrdFqIcg7rpepwitycwN+v6TkSCo/Y+o6Wrp1Ug
         y0PyXHr3vw19vpOXAzGpjAitfItMyP+d14TOAlaUhJD0NINwB/fR1ktisMRd7jPr7peQ
         jcj/uLjNmiYIBQSp8zutVuuOsh1kET/3U3OChedPeDe/1uEujsi2z7Zbua2JiPTPB1vt
         7Eou5uWqWl+BPnhmrB6m8XR1rHALgJ+RFdEbalLdOO+rrwmgImUsLB3dif2sbZcR/3eX
         Lacw==
X-Gm-Message-State: AKaTC01Lyq+q4Jk+bRFsYZqzCUSKAXCjwk4JzYgSsXw2HMGK7zMu6DBXId89sz6rls5sOgJd1azC70pvEih0HQ==
X-Received: by 10.36.34.196 with SMTP id o187mr819628ito.3.1481188884772; Thu,
 08 Dec 2016 01:21:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 01:20:54 -0800 (PST)
In-Reply-To: <20161207223936.GD116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-12-git-send-email-bmwill@google.com> <CACsJy8D9SAOYtzPTuGnst3J7qCUjMuGMrZ=KNH0MLSxMrq4krw@mail.gmail.com>
 <20161207223936.GD116201@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 16:20:54 +0700
Message-ID: <CACsJy8AUKNgPBo6aJ=FsLcMLVEWZ6hXWZ8M7qmvdiUZKjuv-CA@mail.gmail.com>
Subject: Re: [PATCH 11/17] pathspec: factor global magic into its own function
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 5:39 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/07, Duy Nguyen wrote:
>> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
>> > Create helper functions to read the global magic environment variables
>> > in additon to factoring out the global magic gathering logic into its
>> > own function.
>> >
>> > Signed-off-by: Brandon Williams <bmwill@google.com>
>> > ---
>> >  pathspec.c | 120 +++++++++++++++++++++++++++++++++++++------------------------
>> >  1 file changed, 74 insertions(+), 46 deletions(-)
>> >
>> > diff --git a/pathspec.c b/pathspec.c
>> > index 5afebd3..08e76f6 100644
>> > --- a/pathspec.c
>> > +++ b/pathspec.c
>> > @@ -87,6 +87,74 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
>> >         strbuf_addf(sb, ",prefix:%d)", prefixlen);
>> >  }
>> >
>> > +static inline int get_literal_global(void)
>> > +{
>> > +       static int literal_global = -1;
>> > +
>> > +       if (literal_global < 0)
>> > +               literal_global = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT,
>> > +                                             0);
>>
>> These zeros look so lonely. I know it would exceed 80 columns if we
>> put it on the previous line. But I think it's ok for occasional
>> exceptions. Or you could rename noglob_global to noglob.
>
> I was thinking the same thing but was so torn between the char limit.  I
> think it's probably ok to rename these vars by drooping the global since
> the function name themselves indicate they are global.

Exactly. I almost suggested just "ret" for that reason, but it was a
bit on the extreme side, relying entirely on the function's name for
context.
-- 
Duy
