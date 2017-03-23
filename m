Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C28320958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbdCWSrq (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:47:46 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35226 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934846AbdCWSrp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:47:45 -0400
Received: by mail-pg0-f41.google.com with SMTP id t143so62255023pgb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o+cPyPbbxpeRzoya5vXJNceaEzrYWZCvxEDlcRyR5Z0=;
        b=ZyY/9yGokurD+m6cXtAFNttRrinBOfOiCrNujdfpqEsXfYaGPQhKUY28zRhZumei60
         cXU+K83jik4u3zSSmyUMjsFqmoTcO3kxzhr03VuQnsWyQO+Z0eUByql50H1/nwq4UVL6
         0slG23dexNFCYxi9nn5smgcuVtLhPEsGx6o2j/aHRL+Yx0JLRJ1aqa5GO+U07dRpN/A6
         z3z6vTwhNaGV2Ody9pVubC8eIjNITqJthzIgSEfCOFVNcBRzO1pJNpF/JhihEJ4midIY
         U7HoYNZOogqIiS7izkW05f5v73NBTqVQPk8b/vnjwli2macRd/KxlMPuy9Pf6FVODzyx
         Lw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o+cPyPbbxpeRzoya5vXJNceaEzrYWZCvxEDlcRyR5Z0=;
        b=NI1Rcp6MBxxU6Z0YmP46g+w9EUal9eJrCEdDsUWapEgFN17zAUejYUbI2blpizLf+B
         XuFlVvatZTb+BUahXFx81xoBSkntrxdlCqk+mIa9rvoiq2DqPQx+30xkJIxZj9Clr6e8
         lfKib2zDyOQEg2Nw8DAWrlRkbZB4yX+Q23lVCPa093pTbkkpdrkvJ0vu+KuOwJz7WDHs
         3tnrTgDuffxkEYFOqA5rZOgxFR+TCnqmx49JXwsVMduSCl5Pt3hYak7mJXeZ+Uml3zvr
         +B22HXCAzd39sOwb1vm9lzShlIcjWs3huC3ztpNEbGtQ7zbFYJ7k6RISR158I7LqYOrk
         SLCQ==
X-Gm-Message-State: AFeK/H1WeyJ9cj3JblTAnEp82cQf7ZTIMs02yYit9GdyOBMC1bIPUvO5YNVqOh1mfKqLMHP2JNJvI78uJ242ybQ6
X-Received: by 10.99.119.140 with SMTP id s134mr4565338pgc.162.1490294840012;
 Thu, 23 Mar 2017 11:47:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 11:47:19 -0700 (PDT)
In-Reply-To: <xmqqo9wsfrsr.fsf@gitster.mtv.corp.google.com>
References: <20170323004329.15892-1-sbeller@google.com> <20170323004329.15892-2-sbeller@google.com>
 <20170323005341.GH26108@aiede.mtv.corp.google.com> <xmqqo9wsfrsr.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 11:47:19 -0700
Message-ID: <CAGZ79kZriqCE4-9bVQTNGXEZsJi-Z+ryp3QRu-MC8Sn1kaGSdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule.c: port is_submodule_modified to use
 porcelain 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Stefan Beller wrote:
>>
>>> Migrate 'is_submodule_modified' to the new porcelain format of
>>> git-status.
>>>
>>> As the old porcelain only reported ' M' for submodules, no
>>> matter what happened inside the submodule (untracked files,
>>> changes to tracked files or move of HEAD), the new API
>>> properly reports the different scenarios.
>> [...]
>>>  submodule.c | 53 ++++++++++++++++++++++++-----------------------------
>>>  1 file changed, 24 insertions(+), 29 deletions(-)
>>
>> Neat.  Is this something that could be covered in tests, or should I
>> be patient and rely on patch 3/3 for that?

I am not sure how to cover it in tests properly, as we do not expose this
function to the outside directly.

This function is used in only one place (diff-lib.c, in
match_stat_with_submodule,
which itself is used in run_diff_files and get_stat_data), which is deep down
in the diff library.

>> I think this would be easier to understand if it were two patches: one
>> that switched to --porcelain=2 with no change in behavior,

I don't think so as it would double the code to review.
I'll see if I can present this conversion in an easier way.

> That sounds like a sensible organization.

ok.

Thanks,
Stefan
