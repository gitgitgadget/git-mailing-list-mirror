Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3EEC1F406
	for <e@80x24.org>; Mon, 14 May 2018 03:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeENDDl (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 23:03:41 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:47005 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENDDk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 23:03:40 -0400
Received: by mail-qk0-f169.google.com with SMTP id s70-v6so8842254qks.13
        for <git@vger.kernel.org>; Sun, 13 May 2018 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NV0qdWDnbuTDPxja1vmzZ93xfA9NrH9e04ltda/Vzr0=;
        b=rYjlodN7KA5szJJJGYBJcQqdwqBcJr6f/kxNEmRP17AmwGAmrXfUV0kDzSBCdg6PM+
         aAc4WTDQaYua/9wOOoAKX49JOff6k7/S/ulvJKD6wRSabtG4Ftcmz0esFicszQiWpHqH
         tO7YaheFw1bt30aBrEteOj/4hpIIMYEpKUkCRR3LZuycyiwWpZM6l7aZW+4kTf4Q7dvo
         JtqdVzXy6pK3y3r+R8k+qwGE5wEJTmhrJ3kIyq3ibOIY3Vp0vqm4wLeutAwkglhD/S/6
         XhAeDVhPsrQcIuBgg0dVCVRrGZFzIfoWNFH2EI8vue/wLJOQxXVcvyn5tqo3ZtQmbJs/
         sahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NV0qdWDnbuTDPxja1vmzZ93xfA9NrH9e04ltda/Vzr0=;
        b=SRTo9t4RgKT2GvLQimzgNmAoxQGbavq3ZpESJCQ4GldJEYBwvq/qD5wPJAxbYYekzH
         SsoFboFxd65itFxqQcvCZtqAckLCOBjeJDnzj+zLJZTHoKdmF1XWQY0xUAv+VPRK5jFN
         j961nc6mx1pkBvLxHWkHp/iz0PGVsNhTcIBUKacYJly2gIiwz9k5PsPvtZ/jWNVplo0a
         Y4KZvmJlvLr1doaLHdJEESOdlR1y/GnVlEZDsfl4FUDOk2HMF4yhr3cY4k8IvkZTR5rY
         933/o0OeAtiegPKmKehL7nTjBv1+PhHUABx217zelfWmRTB6o2SAjjNxV9iTFxONOgE2
         UYGA==
X-Gm-Message-State: ALKqPwdqCIncPGgfaLKS17L/RO30H30cYu84L2m88MO+0drSoFm97T4f
        MOsubXa8mSHPzr3qw+ERkwucWacDa8aps5SE4zE=
X-Google-Smtp-Source: AB8JxZp+gBYPonXs5QLRv1qozaaGztWskZv9rqaQTWdJSXh3Y80RHyAr3MaSNEYO1mwRH82XzsnyE4Bq8bSlyATp9JM=
X-Received: by 2002:a37:be86:: with SMTP id o128-v6mr6408791qkf.141.1526267020033;
 Sun, 13 May 2018 20:03:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 13 May 2018 20:03:39 -0700 (PDT)
In-Reply-To: <cover.1526204440.git.martin.agren@gmail.com>
References: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com>
 <cover.1526204440.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 May 2018 23:03:39 -0400
X-Google-Sender-Auth: 0M7nrdA1ENFxztS8rshJFGU1tDQ
Message-ID: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com>
Subject: Re: [PATCH] config: free resources of `struct config_store_data`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 13, 2018 at 5:58 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 13 May 2018 at 10:59, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, May 13, 2018 at 4:23 AM Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>>> Introduce and use a small helper function `config_store_data_clear()` t=
o
>>> plug these leaks. This should be safe. The memory tracked here is confi=
g
>>> parser events. Once the users (`git_config_set_multivar_in_file_gently(=
)`
>>> and `git_config_copy_or_rename_section_in_file()` at the moment) are
>>> done, no-one should be holding on to a pointer into this memory.
>>
>> A newcomer to this code (such as myself) might legitimately wonder why
>> store->key and store->value_regex are not also being cleaned up by this
>> function. An examination of the relevant code reveals that those structu=
re
>> members are manually (and perhaps tediously) freed already by
>> git_config_set_multivar_in_file_gently(), however, if
>> config_store_data_clear() was responsible for freeing them, then
>> git_config_set_multivar_in_file_gently() could be made a bit less noisy.
>
> How about the following two patches as patches 2/3 and 3/3? I would also
> need to mention in the commit message of this patch (1/3) that the
> function will soon learn to clean up more members.
>
> I could of course squash the three patches into one, but there is some
> minor trickery involved, like we can't reuse a pointer in one place, but
> need to xstrdup it.
>
> Thank you for your comments. I'd be very interested in your thoughts on
> this.

Yep, making this a multi-part patch series and updating the commit
message of the patch which introduces config_store_data_clear(), as
you suggest, makes sense. The patch series could be organized
differently -- such as first moving freeing of 'value_regex' into new
config_store_data_clear(), then freeing additional fields in later
patches -- but I don't think it matters much in practice, so the
current organization is likely good enough.
