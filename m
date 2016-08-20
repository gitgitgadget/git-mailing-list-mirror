Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3671E1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 19:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbcHTTO2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 15:14:28 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:2316 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbcHTTO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 15:14:28 -0400
Received: from PhilipOakley ([92.22.56.254])
        by smtp.talktalk.net with SMTP
        id bBirbXDGsxR4bbBirbfK87; Sat, 20 Aug 2016 20:14:25 +0100
X-Originating-IP: [92.22.56.254]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=b6TTeGxEIY1/y6ABFUBF6w==:117
 a=b6TTeGxEIY1/y6ABFUBF6w==:17 a=8nJEP1OIZ-IA:10 a=1f_8sUU9AAAA:8
 a=uPZiAMpXAAAA:8 a=vggBfdFIAAAA:8 a=LqMjxxrv5svK1h0LeM4A:9
 a=YINEebd3GXqNeZDW032c:22 a=svzibyHiZmA4t4YY0eFS:22 a=ulBnneXc4k8OkFd-VeVl:22
Message-ID: <91F685E894D94BB89892C695B8C1796E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Zenaan Harkness" <zen@freedbms.net>, "git" <git@vger.kernel.org>
References: <20160820072214.GB24992@x220-a02>
Subject: Re: git rm --cached should be git rm --cache or git rm --stage
Date:   Sat, 20 Aug 2016 20:14:25 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfE1QR6POUe7GXSOquNNaSGuh/XDoGyQiuKZOmjtGQybRR4vizzSfiUeQTf9iZ5IWJwtP10Hr0bgfCmNjkOUZqM9s55fUuhc+vjXmXPltwAKuazlr9GVy
 kPkGEjv5R3WbKVM0CpguRCd+OCY7ptU/MHLGMkLoZu/JPMoTsHkeMkNBOM1LJ7Pu4cSEgyjM9V/Fzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Zenaan Harkness" <zen@freedbms.net>
>
>  Please CC me :)
>
>
> From man git-rm:
>
> --cached
>  Use this option to unstage and remove paths only from the index.
>  Working tree files, whether modified or not, will be left alone.
>
>
> This wording is unclear and dangerous, and ought be cleaned up somehow.
>
> Probably also the option name should change.
>
> See here for examples of community self-help compensating for git-rm man
> page's particularly bad wording:
> http://stackoverflow.com/questions/6919121/why-are-there-2-ways-to-unstage-a-file-in-git
>
> I suggest:
> - change "--cached" to "--cache" at the least (allow both)

Such small nuance changes rarely have the effect hoped for when there are 
such gross misunderstandings by the user.

>
> - probably deprecate --cached and add "--stage" to replace it
>
> - perhaps change the wording in the man page above to something similar
>   as on the stackoverflow page above,
>   e.g.:
>   "Removes a file from the index. In the case where the file is already
>   in the repo, git rm --cached will remove the file from the index,
>   leaving it in the working directory and a commit will now remove it
>   from the repo as well. Basically, after the commit, you would have
>   unversioned the file and kept a local copy."

The idea of 'removing from the repo' can have a connotation that it means 
total removal from history(the repository hold the history!), and not just 
future commits.

>
>   or perhaps something like:
>   "does not unstage a file, it actually stages the removal of the
>   file(s) from the repo (assuming it was already committed before) but
>   leaves the file in your working tree (leaving you with an untracked
>   file)"
>

The easiest way is to simply swap around the two sentences so that the 
positive action is listed first - this better matches people's typical 
cognition. Human Error (by Reason)[1] tells us to Never state warnings and 
caveats after the instruction, and preferably be positive.

"--cached:
Working tree files, whether modified or not, will be retained unchanged.
The option will remove paths from the index (only) to unstage them from 
future commits."


>
> The git "stage" is a primary concept, and a primary noun (one reason
> many of us have come to appreciate git), and git's cmd line options and
> help docs ought reflect this.
>
> Thanks,
> Zenaan
> --

Philip
[1] https://www.amazon.com/Human-Error-James-Reason/dp/0521314194 

