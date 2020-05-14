Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43218C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F38206A5
	for <git@archiver.kernel.org>; Thu, 14 May 2020 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=calebgray.com header.i=@calebgray.com header.b="P78ELfzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgENOeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgENOeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 10:34:20 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB223C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 07:34:19 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id u12so2103461vsq.0
        for <git@vger.kernel.org>; Thu, 14 May 2020 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calebgray.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=pGWZVquw0SehZVtM3ON2wQuWpNTNL+3jBIc6l+pP7vY=;
        b=P78ELfzMv8O58R1DPAgtJxo8KokLnspVvj0gXkVAxSKFJDuWAxev4DQUEIxYVoi8MN
         e3QZo+N5BJW+E9JiF5QYywA8N7lNivzKBopMioxZzCD1diJ7Nojh/wA5aWKeCo8I6I3Y
         tYGnrxkY3/1o+X4N0SSHMEZhDdPkLaN9v5DW2Ny/r7DIrgB4zQA3URhRdsoTZy5dzZFK
         5tKWXDmufVsBPNDakcsLyfmaGxihqCTYqDeiW5cpPjPlnbioJ9QvlnCFUuy6ddHMjhW3
         KepYiU1IJMIbiEe7hP83lHU30kRoiTLJVBThW8g9az0urJ9FM2+oH+Z5ScS6BptSJmsT
         Svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pGWZVquw0SehZVtM3ON2wQuWpNTNL+3jBIc6l+pP7vY=;
        b=rC+maJkP/XOaJU64FOjjiAqeiilu4drxNWksVrXIpvRG6WJ8saicnh9U7Ol6CFtjeE
         3oWV1HywgLvq5MoEvT8s+oANdoL3wFzxAP1TSC6pGhX/S5kDEl8kx812PwVmCnB1kkFZ
         53c9x45zvohiRx2Z7a/UzXaovK+AeYfXZCe/jHTtqbyQb6AhQqTshXq0M8SwjIBBvX4f
         LPRqMKTQnCtuUc3MzxRn/QnMlNO2niIay6zPZp0mXW7u0MW4PUrQGNi05FyJ47vISnoH
         EGjV4l899bcPwRHd+rHxYi3JrHHk7U4TILcMqLsJ59Qlhq1yY8AkDHWTiiBkKWWl3vcq
         EN7A==
X-Gm-Message-State: AOAM531OaTLisJtaZ3Y0gG0K3avMMhs2TyDOfMGtTt81jadELPRNZgZq
        wbzR4CijqFVnQa6vmrHXqnFGkdjLD8fqbs+XSCtsMmoNyYY=
X-Google-Smtp-Source: ABdhPJx2mK0b3ZRk1E4DM4IIVcjhEjUtDMjqMQ5UC9smPHEB2uCUFXJrDzHrAOTUU2rhRfe4W/AcnZAUDpbCo5nCM+s=
X-Received: by 2002:a67:ee96:: with SMTP id n22mr3478483vsp.29.1589466858836;
 Thu, 14 May 2020 07:34:18 -0700 (PDT)
MIME-Version: 1.0
From:   Caleb Gray <hey@calebgray.com>
Date:   Thu, 14 May 2020 07:34:08 -0700
Message-ID: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
Subject: Add a "Flattened Cache" to `git --clone`?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've done some searching around the Internet, mailing lists, and
reached out in IRC a couple of days ago... and haven't found anyone
else asking about a long-brewed contribution idea that I'd finally
like to implement. First I wanted to run it by you guys, though, since
this is my first time reaching out.

Assuming my idea doesn't contradict other best practices or standards
already in place,  I'd like to transform the typical `git clone` flow
from:

 Cloning into 'linux'...
 remote: Enumerating objects: 4154, done.
 remote: Counting objects: 100% (4154/4154), done.
 remote: Compressing objects: 100% (2535/2535), done.
 remote: Total 7344127 (delta 2564), reused 2167 (delta 1612),
pack-reused 7339973
 Receiving objects: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
 Resolving deltas: 100% (6180880/6180880), done.

To subsequent clones (until cache invalidated) using the "flattened
cache" version (presumably built while fulfilling the first clone
request above):

 Cloning into 'linux'...
 Receiving cache: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.

I've always imagined that this feature would only apply to a "vanilla"
clone (that is, one without any flags that change the end result)...
but that's only because I've never actually cracked open the `git`
codebase yet to validate/invalidated the complexity of this feature.
I'm writing in hopes that someone else has thought about it... and
might share what they already know. :P

Thanks so much for your time!

Sincerely,
Caleb
