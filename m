Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAED520195
	for <e@80x24.org>; Fri, 22 Jul 2016 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbcGVQHP (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:07:15 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35390 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbcGVQHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 12:07:14 -0400
Received: by mail-it0-f48.google.com with SMTP id u186so40635041ita.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 09:07:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4BgIBtRmXuFw6vsLS97qWTOBdCFlxL5Rmv+9bvndmlY=;
        b=OCt2VPbgf6J8uQQ5aq+mPUQaGzs9u8ZUkP8PPKk4lk7e4Y6I9PSum1pmQ20Fdbrphl
         eNFb0qSV3rR9SkY2j891kHE71CRu/ohe3juCqn0B2ozMA70URU/T8VefK+LjSFcPXgbR
         2Qx2Qs5EhtKH6G29oe5NCZrehsMt/uT9KBivvjvvdrXtHQ/PJeA83Q83nfqwQ8hj60kC
         wlufCfrjeqhXQU87FnCXm5HlwZAu8clgV6bOxfSZ+1AnKeFcJtNB7WVHDHfTefv86b+0
         ugJhzD4BwCvc6KXxShaqse1yj2X0jb7ArWBxqECRJF0SRrCNq7DArfqC73WGq+wsAiao
         hCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4BgIBtRmXuFw6vsLS97qWTOBdCFlxL5Rmv+9bvndmlY=;
        b=AD3LVib3Fei9xX+78vO5OM0AfzgnSmHHDgHUWMCay35Q8I8IMIQ1l17lafx+ePid+l
         gFirkYbAaN14NFYaS6c7sgMuPNlgDMw1a6GVOlicbNyzh5JEIW8wZwJZyU3ZosZ3y1Cl
         sqnp8fHYH4MrHtOFZOXaJGo8xx7/iW7Fj+C5MgCjQbwbd5JkeKiBjZ1IdLnQ/xZJmYdM
         p+ULwAP6WEEEmNgb1ygNT+a5/sPRw5N1x3ajOqcWSw953+adxMslDvAugzIPiYa55MhY
         VAlM6QoriXT/4hHS9Gj55VM/9vWWGo12XjB3qSqdh22uSeUgxoRJh3xvvNQO1k+N6MGF
         F36g==
X-Gm-Message-State: ALyK8tLHDF2P2IdT4WHJ9LQuXDzOqXDq055ffAMikLAEZ475LQh9W80QM07iBFAaNSib1zaOIJ065qpX4Rzu35sa
X-Received: by 10.36.228.138 with SMTP id o132mr67137775ith.49.1469203633306;
 Fri, 22 Jul 2016 09:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 09:07:12 -0700 (PDT)
In-Reply-To: <64e9e8fc-50b3-98d8-fca8-6a70028c6398@web.de>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com> <64e9e8fc-50b3-98d8-fca8-6a70028c6398@web.de>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 09:07:12 -0700
Message-ID: <CAGZ79kbMbW9Aex92cFj0oVWMBC0F2z9JDm9QdAO4BQPSSMhDNg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Jens Lehmann <Jens.Lehmann@web.de>
Cc:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:32 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 21.07.2016 um 01:22 schrieb Stefan Beller:
>>
>> So maybe we want to drop that series and first talk about a migration plan
>> from
>> the current state to a world where we have the existence depending not
>> on the url
>> parameter, but a boolean variable submodule.<name>.<good_name>.
>> Depending on <good_name> a submodule would be ignored or tried to checkout
>> in e.g. `submodule update`
>
>
> Whoa, that's a very intrusive change with a ton of compatibility
> problems waiting to happen. Maybe its simpler to make "git submodule
> sync" aware of worktrees and error out with an "you cannot use
> submodules with different URLs in a worktree scenario" error when
> the URL is going to change? That should make most use cases work
> while avoiding the problematic ones.

I think fixing sync alone is just a drop of water on the oven.
Actually I can think of scenarios that have different URLs for different
worktrees (think of the automatic CI thing that should only fetch from
an internal server, whereas the dev-checkout fetches from upstream)
Actually each config variable (including the update strategy as you
mention below, but also the depth, branch, path) may be different in
one work tree.

I do not want to forbid the existence of different settings (URLs)
per worktree. Rather I think a different setting is a user decision,
hence they will want to run "git config --worktree ..."

And one of the unfortunate things is the coupling of existence of a
submodule and the URL. If that were to be decoupled, you could do
a "git config --worktree submodule.<name>.exists true" (or it is wrapped
fancily in "git submodule init") and the URL would not have to be copied
from the .gitmodules file.

I agree that this is a breaking change, which is why I'd guard it with
a config option such that the user can make the choice if they want
to go with the old behavior or the new behavior.


>
>> If we want to move the current behavior of submodules forward, we
>> would want to have
>> anything but the url as shared variables and then use the url variable
>> as a per-worktree
>> existence flag.
>
>
> Without having though deeply about all submodule variables, I see
> them as worktree specific. E.g. "update=none" is used on our CI-
> Server to avoid the disk space cost on some checkouts of a certain
> superproject while using "update=checkout" on others where their
> content is needed.

But this is a conscious user choice, so you would have configured
that on a per-worktree basis anyway?
i.e. it seems to me as if "update=checkout" is a default that is good
for all but one worktree, so why would you want to configure that n times
instead of just once as default?
The non default behavior is then overwritten in the specific worktree.
