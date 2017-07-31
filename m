Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3807B1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdGaXFb (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:05:31 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36415 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdGaXFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 19:05:30 -0400
Received: by mail-vk0-f52.google.com with SMTP id u133so65924vke.3
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yn+j6Wm6B39x+v0toC12kzr2K8lGhb4BrwTiP0M5cFE=;
        b=WnrnrVIiiS7hjNAsaO/+FfixoJTX7GYGT2Ka1z8JidaZ6MVhy2m0JxNmWmbJDjFdCq
         tv3lMia4OYxHUr+ur+PIO/jkMicdbX0R2MqEV0QsGVWztQwF31hq0j9sv1NvDaOw3Vx8
         wqw4k2mNQjhyGBn/JN59bA9PbIP/yWJCvGXjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yn+j6Wm6B39x+v0toC12kzr2K8lGhb4BrwTiP0M5cFE=;
        b=PWjqc4+kQCqKRuOKf2YSgyfviyRgzMBwQMessrwqHmRLWo4QFiYpn7YSIrP3myiWTj
         o6vIEfhPULfSnMBcQG2QC6bhq2aXM2dXwcrUI+6BdoJeDIoQ/uebBi0ChOmrGOr+MkE8
         zb0kORLuKE59fPj4CBDgd1wwGm8F7LptMSfZi2YLDfW+WIN010dJRprwAc2cBI3G6ccN
         HdGerjuH8NtmCrHr8jbpKQZkmlySxJmQHK36WjG/uCdiKiJYglhBRjeDTTJ2XNFXS2TW
         AEL7jlcb3bRW+1PTwBJc3yudlWIIyxa6xbZoS7ulVfoZQCJdFn9m6pRS0eZEsX/z9HG9
         iqyQ==
X-Gm-Message-State: AIVw113poO1tw4zdfzYR5v/391lQwM/hyFgRLwHc4TyCN1eWiR2xTKID
        ZdIqdBKcrQqEsTcW4kShwB+ky/CAw9i+
X-Received: by 10.31.195.3 with SMTP id t3mr11769702vkf.98.1501542329899; Mon,
 31 Jul 2017 16:05:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Mon, 31 Jul 2017 16:05:09 -0700 (PDT)
In-Reply-To: <CAGZ79kZ3vbpzSEMHVHMtF0drY1P1rgz1eB7OB-J31-y6K+x5sw@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAGZ79kZ3vbpzSEMHVHMtF0drY1P1rgz1eB7OB-J31-y6K+x5sw@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Mon, 31 Jul 2017 16:05:09 -0700
Message-ID: <CAJo=hJu-j+7CfKy8vCS9t+6=-PVGNC5D6HuYgqpO7GrNi=MDig@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 12:01 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> 4th iteration of the reftable storage format.
>>
>> You can read a rendered version of this here:
>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>>
>
>>     uint16( restart_count )
>
> When looking for 16/32/64 bit hard coded ints I came across
> this one once again. How much more expensive is reading
> a varint? As the block_len points at the restart_count, we cannot
> replace it with a varint easily, but we could use a byte-reversed
> varint instead. If we do this step, all restart offsets could also be
> (reverse) varints?

Its not the expense of decoding a varint, its making the file
structure predictable so its simple to binary search within restart
points. If these were varints, it becomes much more difficult to
divide the remaining range in half and update the boundary conditions
to locate the next mid-point.
