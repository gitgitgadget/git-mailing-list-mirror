Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDDE202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 21:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbdCIVX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 16:23:27 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36631 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdCIVX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 16:23:26 -0500
Received: by mail-pf0-f176.google.com with SMTP id o126so33281516pfb.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wl3fJuPqPFGdMIIDTxdSNmvOqSmnW3sZmkSW6jjOHoQ=;
        b=fKGVXqxxdjh6QnjGKtwSdEmU9nTw1EqhjGrJrH26Hll5e+NT+Avtg4R6n60zOozi/h
         A4gBu/DWdn9/9X1IU4akcNDaMExmWciAH4yMMszdAK7+GlMcyJQFMgUgAYs6iYjWCihg
         GqKLSi/LAh4d88+n8n+kZXjQSURfsupSKSfdAvgSZb8zn5PTR74vWwhuP5a7ALYk0IYy
         e8re/xcqNjzXupoMEwuQH/wJlDqmSdnaHyPbo/cH5y+cuOVz6+jaD97RhRBoUqKwjRqu
         Mpt+ApJYsAtjJNrur/x7Lywc0W/ep/b/2Y5NU9rMzjfD2z0481rEsJ/nr5IlahlBBB4S
         8dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wl3fJuPqPFGdMIIDTxdSNmvOqSmnW3sZmkSW6jjOHoQ=;
        b=a/9rjNowwHugNKcbSE4ToNWR8tdnZVt18eT3xOPwYOYGAHp+QPMsa9UwgxsPAGuZZh
         YgWtW+EVdI4D0GRnwidP5+yFVi3TkUmhNfIlLsgA2jqRpiQXzRWBX/9FNvESniHv0oyh
         yM0TRGXry3X/hS5u39qxIR1zcdwJMN/VhWldzbD22JMlCPrtfLTCQ+88Y1fIyUlOPB8s
         XX3hVJ1F53txxSokxCU9AqF9+E3S/mqMsx/pfuQSUXzPHx8RoEUdC7TlA1ez3KO8QiIy
         55P2jw2v5BbkW1zvbRzdOxY+zo4NAEDc9SbvubFhHqnCHfb60zCAFWL/mz1t4wWm4nHt
         PpbA==
X-Gm-Message-State: AMke39mUv/zhU54aylK0NrjH5VaP29IAF2AFItIVBI7IKunYpGhbACAjnPdhjwsQ8Ing/ZuGlHBtJivRu5WqSm1v
X-Received: by 10.98.91.131 with SMTP id p125mr16502821pfb.165.1489094549237;
 Thu, 09 Mar 2017 13:22:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Thu, 9 Mar 2017 13:22:28 -0800 (PST)
In-Reply-To: <20170309210756.105566-1-bmwill@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Mar 2017 13:22:28 -0800
Message-ID: <CAGZ79ka=kV_QQo3ExHmieNUajCvzZejFfmDsKeHr9XR0QvEVmA@mail.gmail.com>
Subject: Re: [PATCH 0/2] bringing attributes to pathspecs
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 1:07 PM, Brandon Williams <bmwill@google.com> wrote:
> This small series extends the pathspec magic to allow users to specify
> attributes that files must have in order for a pathspec to 'match' a file.
>
> One potential use for this is to allow a repository to specify attributes for a
> set of files.  The user can then specify that attribute as a pathspec to
> perform various operations only on that set of files. One simple example:
>
>         git ls-files -- ":(attr:text)"
>
> can be used to list all of the files with the 'text' attribute.

Thanks for reviving these patches.

I have read through both of them and they look good to me.

Thanks,
Stefan
