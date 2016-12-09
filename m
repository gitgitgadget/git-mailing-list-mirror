Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33341FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 12:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbcLIMrK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:47:10 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35930 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbcLIMrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:47:09 -0500
Received: by mail-io0-f196.google.com with SMTP id b194so6528998ioa.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=saFEscD45CJ+1Mjotds5qAJ26AB38p6Nw21vt4RWkM8=;
        b=OEuq6cYNaaUvJpwgMrK9ol4BfPI1EzeeywzLLsMMWuTecAIyD6LxeCl3tC0PJ1oebX
         oCqXPpKN1HT1uLUDz7u22FdF/xuO8J83rJ8tLxDrbJ8tiV4Dvh/lOs0NfG4hzs6UDsMx
         lyh5tnLjIK7LtZ/Zywj34cH73IqRqsSsmUgbxNCO+C2r5dhZWKrdLy9ZsK1A76wSVpkV
         jlKhVOCd+RRHZdyFdBNbV1syhj4PasVM3TUFYKXtRJlKKVoi6Z8YiHotQxre5LnhIRf8
         WXF+DPeFSuwidanX4eQbSbxni1MGhv97s6rTu9HxIsaed3tbsT6pU6Zk1FwaM4/W8moK
         xaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=saFEscD45CJ+1Mjotds5qAJ26AB38p6Nw21vt4RWkM8=;
        b=U2t7ZkprOrm7ZxVeaxoxbUZuQcgQlq+ymN5b8yaRHje/1zRtVGnrQw4sDYt60lE3K8
         2COoNr3XtfiMBkWbhj3rVjsPvhBva7HA7VjgzM1j0cykH+/Myv8srOnrXhm/QvI6NXOq
         R7/zfJ/TVsDxzjQsjkCa+s2j9Kk19W64B9Lkp/yXz8QVMxoqjrT6q9KCfgLyKasx6My7
         TsM/IP2MldNVx9GqnZlFNED5uM9ZAgTiQcSX8iAozTbDexcK8zAkdg9KQUMjtaN0N6eQ
         RE/YPf8EEA1EmO4DdM9sa8//vPHgM34c5v8FajBiGkRNp+1O/N0dyrP8F1BDYVGdVZaE
         b0zw==
X-Gm-Message-State: AKaTC00d4/hDG5GdJfv7V2COvD8D79njK2hy7LaG3s1G6QrUfI9KeTVgw/mjw4eqqPP39qy3OkDFFqvoyq7tqw==
X-Received: by 10.107.132.74 with SMTP id g71mr69581738iod.19.1481287628359;
 Fri, 09 Dec 2016 04:47:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 04:46:37 -0800 (PST)
In-Reply-To: <CAGZ79kYtEUvuTX09sJm3C0rG0-BrBz4bN0FCs6E5d2jHhtKN6w@mail.gmail.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-5-sbeller@google.com>
 <CACsJy8Bs78ywGq5p6yAFGi1KACAXFEeroyQSJye5-RL5gqOS+Q@mail.gmail.com> <CAGZ79kYtEUvuTX09sJm3C0rG0-BrBz4bN0FCs6E5d2jHhtKN6w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 19:46:37 +0700
Message-ID: <CACsJy8BoPXDYZqqDOSZR-msNjuZgGzFL_mF2xQVsg82jUfdXmw@mail.gmail.com>
Subject: Re: [PATCHv6 4/7] worktree: get worktrees from submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 1:55 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Dec 8, 2016 at 2:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>>         worktree = xcalloc(1, sizeof(*worktree));
>>>         worktree->path = strbuf_detach(&worktree_path, NULL);
>>> @@ -101,7 +101,8 @@ static struct worktree *get_main_worktree(void)
>>
>> All the good stuff is outside context lines again.. Somewhere between
>> here we call add_head_info() which calls resolve_ref_unsafe(), which
>> always uses data from current repo, not the submodule we want it to
>> look at.
>
> Unrelated side question: What would you think of "variable context line
> configuration" ? e.g. you could configure it to include anything from
> up that line
> that is currently shown after the @@ which is the function signature line.

Hmm.. no idea. I once dreamt of writing "Diff-Options: -U10" in the
commit message and let git-log and everybody use that option
automatically, though. I guess it's unrelated to your question :D

> As to the add_head_info/resolve_ref_unsafe what impact does that have?
> It produces a wrong head info but AFAICT it will never die(), such that for the
> purposes of this series (which only wants to know if a submodule uses the
> worktree feature) it should be fine.
>
> It is highly misleading though for others to build upon this.
> So maybe I'll only add the functionality internally in worktree.c
> and document why the values are wrong, and only expose the
> "int submodule_uses_worktrees(const char *path)" ?

Yeah for submodule use then it should be ok. But people may start
using it for something else, not realizing that it does not work as
expected.
-- 
Duy
