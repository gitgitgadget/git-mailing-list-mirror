Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4C31F600
	for <e@80x24.org>; Thu, 20 Jul 2017 19:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936598AbdGTT53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 15:57:29 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37748 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934707AbdGTT52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 15:57:28 -0400
Received: by mail-pg0-f48.google.com with SMTP id y129so18990090pgy.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lr05IqfS7gE9IefsLpwCSI6klaEeiEv/8CFg2p9b8T8=;
        b=suXwTr3K/bJiOix8q76eQ6yKQ53HQ3qLkm2L6yFdo6svWGeWlTermHfTHwpkLzvRTP
         1fiMBbbv4CMv7ltVw7nCUkwAEhVj0MKI/PNiSy7axRxmZMwckYCg7aEaWtnGErP+JDbn
         q+sn8IP2riAX406az8RR7TSwTdLfW+OVY6FKbonl6/0vp8yEehdOXxPMdyRSAMAuNIQ1
         k8JGfozr76wRijnzOZYXLOelvcfV4TI57KQLXLkc2k0k7rUj7j+WgkUMvSS3hb/ZGlVo
         pQRn753/OCEhlQq61NROOinFXiSZNsFNsm/wTol9CSZSZOR6GUC531R03XnclbRfxdD0
         5FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lr05IqfS7gE9IefsLpwCSI6klaEeiEv/8CFg2p9b8T8=;
        b=o1whbi6+2OrAqORUHLPnHwi52HNo/tFUVG/1Ejk9K5Egebw/aAvD+o7B2MIfNcNsV3
         Uk3iCyNAob/xtbzGOYH+oPIsmSxsRikPUqcJ9SaRBEXvDiYi74MRbFFGrSYzq8IbvY91
         95e+xOL7EKNakJptHtlTUdk7zai0gpawBIlOAGQDSFEhlwyzvAiAXmY3r7hCgB+b7yO8
         UZ2DPPdl5FwYS4rkwpo/+Dc4KXjPRlqa0bZgrfZAbxAPco/FvjZNO5tPqyjIdxdmNTpf
         jfT9aM9UHb7wI0uN2P8HkQh8pmauZ8aPBEOypwO/oVZeQ6js6+/vFwBxKI0X0HSVsGyD
         4hwA==
X-Gm-Message-State: AIVw110fKH4h6H88Qk+2nuQUQOOSQp1RVF+WBolmvAG6AdFBEaoJ7yeX
        46flGBqL7eQCZdlDoCbUwQJVCqDeeBsSL6qQog==
X-Received: by 10.99.44.138 with SMTP id s132mr5040464pgs.318.1500580647786;
 Thu, 20 Jul 2017 12:57:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 20 Jul 2017 12:57:27 -0700 (PDT)
In-Reply-To: <CAME+mvV9-spX0DrToZdtydhZ5cXA5A7R7JCca4f87Rn3tdLUpw@mail.gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-6-pc44800@gmail.com>
 <CAGZ79kZrVQZH3ASoZavEeCSUBei8By1xs3fAQaEbVSCMOXoYxg@mail.gmail.com> <CAME+mvV9-spX0DrToZdtydhZ5cXA5A7R7JCca4f87Rn3tdLUpw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Jul 2017 12:57:27 -0700
Message-ID: <CAGZ79kaQA+_qEy-wQOoW+XCHSsDx_bt2tKZi1=+CFS6BF1A8Og@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/8] submodule: port submodule subcommand 'sync'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 12:36 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Firstly, thanks for reviewing my patches. I have even checked out the
> other reviews
> and improvised the other patches according to reviews as well.
> I had a few doubts about this one though.
>
>>> +       const struct submodule *sub;
>>> +       char *sub_key, *remote_key;
>>> +       char *sub_origin_url, *super_config_url, *displaypath;
>>> +       struct strbuf sb = STRBUF_INIT;
>>> +       struct child_process cp = CHILD_PROCESS_INIT;
>>> +
>>> +       if (!is_submodule_active(the_repository, list_item->name))
>>> +               return;
>>
>> We can use the_repository here, as we also use child processes to
>> recurse, such that we always operate on the_repository as the
>> superproject.
>>
>
> Sorry, but can you explain this a bit more?

Well that was more thinking out out, in the sense of explaining why
it is the correct thing to do.

As the recursion is handled via spawning processes, each process
has the_repository pointing at a different repository (and the correct
repository for each process), at least to my understanding.

>
>>
>>> +
>>> +       sub = submodule_from_path(null_sha1, list_item->name);
>>> +
>>> +       if (!sub || !sub->url)
>>> +               die(_("no url found for submodule path '%s' in .gitmodules"),
>>> +                     list_item->name);
>>
>> We do not die in the shell script when the url is missing in the
>> .gitmodules file.
>>
>
> Then to have a faithful conversion, IMO, deleting the above lines
> would be the correct way?

Well, then we may run into segfaults due to dereferencing a NULL pointer.
So we have to figure out, what the code actually does when there is
no URL set. According to my understanding this would

    url=$(git config -f .gitmodules --get submodule."$name".url)
    # second case, but empty vars:
    sub_origin_url="$url"
    super_config_url="$url"

    ....

The issue with this shell script is that there is no difference between
"" and NULL, so the place where we do

    sub_origin_url="$url"
    super_config_url="$url"

we would need to translate NULL -> empty string

>
>>> +
>>> +       prepare_submodule_repo_env(&cp.env_array);
>>> +       cp.git_cmd = 1;
>>> +       cp.dir = list_item->name;
>>> +       argv_array_pushl(&cp.args, "submodule--helper",
>>> +                        "print-default-remote", NULL);
>>> +       if (capture_command(&cp, &sb, 0))
>>> +               die(_("failed to get the default remote for submodule '%s'"),
>>> +                     list_item->name);
>>> +
>>> +       strbuf_strip_suffix(&sb, "\n");
>>> +       remote_key = xstrfmt("remote.%s.url", sb.buf);
>>> +       strbuf_release(&sb);
>>> +
>>> +       child_process_init(&cp);
>>> +       prepare_submodule_repo_env(&cp.env_array);
>>> +       cp.git_cmd = 1;
>>> +       cp.dir = list_item->name;
>>> +       argv_array_pushl(&cp.args, "config", remote_key, sub_origin_url, NULL);
>>> +       if (run_command(&cp))
>>> +               die(_("failed to update remote for submodule '%s'"),
>>> +                     list_item->name);
>>
>> While it is a strict conversion from the shell script, we could also
>> try to do this in-process:
>> 1) we'd find out the submodules git dir using submodule_to_gitdir
>> 2) construct the path the the config file as "%s/.gitconfig"
>> 3) using git_config_set_in_file (which presumably takes file name,
>>   key and value) the value can be set
>
> Thanks for pointing that out. That surely reduced a child_process.
> Although the path of the config file for the case of submodules
> would be constructed by "%s/config".

Ah yes, that is correct.


>
> Thanks,
> Prathamesh Chavan
