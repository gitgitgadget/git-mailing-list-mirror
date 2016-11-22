Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4361F4CF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbcKVAEu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:04:50 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34311 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753309AbcKVAEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:04:49 -0500
Received: by mail-qk0-f176.google.com with SMTP id q130so2334270qke.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oiaz8WBzh+xcuNkh3QCOuGNwFksfwZBTpABwYI09690=;
        b=ZfWCYIed/fGYijJuyMSnIXZLULTVRX5By++VjlCOkkRGmZ3cGkUZ8pP+p67R5eH06b
         DDmynHB15I0XpkgzRVemR4n0+vOdzeAjMVha+psyCioGd59InT0pIv3Ngz/EyhocKbF1
         mBD88FCsgfVicVpZQ0EjmDply9M+EKnumLLr7A1ZeKMY6woodhysT5gHoCNHNeslp623
         3473yDU3R9ZzSFfs/LN1cVTK5f7kPuxJ0MzlkSSXmPsBsY1sn2YW3W3aUyQlVZqfklqg
         8aGrmjUzFZSSGmXwvkrhsF57xZQTTQqnzvtZWdu20C9Wf6QWz5fxpD6C4kLuG5B5+VVP
         xziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oiaz8WBzh+xcuNkh3QCOuGNwFksfwZBTpABwYI09690=;
        b=nGL8l0KGPL3mQdMakn7mdWCAycrG7Jk/r/bvZ9Kcwx5sEZCb5IN/+yxO0q5P3O5afu
         rf8u/w5b+JP1G7yU8r5bh4C6TNPiUDDyxwrZD+m6xjwt0ZlccmLU7a8dOsQa3OcOXaVV
         5kM0etcJCGD9T8ZUpBMdrBSzc+Dl+0h3c/0UKAI72U7BT/0GdKFNN1osI6aI8CdX+U2y
         fuoxS9YJgnDX9h4uwgLcYW7AxT8E+dix0o6MV9vEPx9jFXBr0FZXoFmobQzzWDEfczMt
         cpylAij5EAUCvDNe6nSpxPkmrIATf0Z6KfKXshI40KZluQINkjTrCxWQOjsfcer++g8L
         8NRA==
X-Gm-Message-State: AKaTC03ipVzj+Z4ND5wJSnDpT3AvQhK7dybp1YanwKQ+25/gU5/cHlS2Mbv3VMX5JGgVwkAxffsTqgaFqOSdpI6Q
X-Received: by 10.55.20.164 with SMTP id 36mr18206633qku.86.1479773088154;
 Mon, 21 Nov 2016 16:04:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 16:04:47 -0800 (PST)
In-Reply-To: <CAGZ79kY=tzrsn7rS4UsRfSku_pKNNWNDc2OiTO-4-vg5h8NwWQ@mail.gmail.com>
References: <20161121204146.13665-1-sbeller@google.com> <20161121204146.13665-2-sbeller@google.com>
 <xmqq8tscim31.fsf@gitster.mtv.corp.google.com> <CAGZ79kY=tzrsn7rS4UsRfSku_pKNNWNDc2OiTO-4-vg5h8NwWQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 16:04:47 -0800
Message-ID: <CAGZ79ka60_D8xfQyBegkXxkTGW5YDMuagB7kjhiCR6NriLR8+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule: use absolute path for computing relative
 path connecting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 1:03 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Nov 21, 2016 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Can the effect of this change demonstrated in a new test?  There
>> must be a scenario where the current behaviour is broken and this
>> change fixes an incorrect computation of relative path, no?

I do not think the current usage exposes this bug in
connect_work_tree_and_git_dir. It is only used in builtin/mv.c,
which fills the second parameter `git_dir` via a call to read_gitfile,
which itself produces an absolute path.

The latest patch of this series however passes in relative path for the
respective git directories.

So the commit message of this patch is misleading at least.
Maybe:

  The current caller of connect_work_tree_and_git_dir passes
  an absolute path for the `git_dir` parameter. In the future patch
  we will also pass in relative path for `git_dir`. Extend the functionality
  of connect_work_tree_and_git_dir to take relative paths for parameters.

  We could work around this in the future patch by computing the absolute
  path for the git_dir in the calling site, however accepting relative
  paths for either parameter makes the API for this function easier
  to use.

  While at it, change `real_work_tree` to be non const as we own
  the memory.


>
> I found the latest patch of this series broken without this patch.
> I'll try to find existing broken code, though.
