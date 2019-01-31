Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E621F453
	for <e@80x24.org>; Thu, 31 Jan 2019 13:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfAaNGo (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 08:06:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52924 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbfAaNGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 08:06:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so2426520wml.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLFNx1cswSW9MB4zbHaNc1a8LG3tIyeTkdmmpo6k/FA=;
        b=cugygARrburuDUI6j/iCCk2aU0I6ETXvIpNDzP576Ch201R42JoueBDOt1l5rzfG1l
         j8SOgfLVr6sF7egVY3ybQJK+PGKez/zW2zI8O8k6Zlu/GyBPM+m59XzeywLL08LcU9so
         Knjk/YnhDteH8sLIm1DaJ4AwaWwSlloi1gLDDFNFidP9XUmTtezoMFQP3Or/Tj+CXXv7
         W+zvdqJHRvyrk5qTzesCMZmh8m6UDuTx/AxJ/4zQOlRVBz7jVnyIqicM7QbS0co27aAr
         AUmn0QEXPJjHV25zELYWVlY/3l5ubj2aoO89gmWtctQiNEkIy/YvfhDHk1iZDHZW8q4s
         o8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLFNx1cswSW9MB4zbHaNc1a8LG3tIyeTkdmmpo6k/FA=;
        b=XThSn3Hk+Xr2Tyup+qSKSaqMsUYekKrXZBf1dMa73I7sx1oc1Q9DDtD1wg7dW4b3LP
         foHs+iYQ9dadUJq0OaBOPdMiLTi21nzy4mD+aXVZ/FM8XcO07xfZmLRSKseVS6YdOwrz
         aXKgXcAn4o6wlauotAAUXC/fXjYDtnO2+IvJsOZybH73TIg9xWtDHukbRMGCN8ISKlAk
         7ipOWcaNND2kHnebXYm1Gn911ZFmsAlTI9tanE7V3GSkwXUAUiunEHP5uAstbyG6zn2c
         zafPN+4fkwgtxCTxeWslqA+c4uawshlgiW87PaojQDgXxlsoPj60Qcy/3iyBY5VIMEt+
         NO4Q==
X-Gm-Message-State: AJcUukc4V9lhBRSLclIDotPHiqkzG+sdB/qgzj0IITDsmtuSRFHA7xVv
        DGnxakBDWy4UjaqX8YblI10=
X-Google-Smtp-Source: ALg8bN7KGwDPD4mvBHaSq/iDOubdAY95gxAO0VIdbW9wznrk7lPTHY1r6vFYryiJwgQtZQ+EXQM5DQ==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr30533255wmh.40.1548940001748;
        Thu, 31 Jan 2019 05:06:41 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id q12sm4247266wrx.31.2019.01.31.05.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:06:40 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:06:38 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
Message-ID: <20190131130638.GI13764@szeder.dev>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190130094831.10420-9-pclouds@gmail.com>
 <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
 <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 12:29:01PM +0700, Duy Nguyen wrote:
> > > +EXAMPLES
> > > +To check out commit "HEAD~3" for temporary inspection or experiment
> > > +without creating a new branch:
> > > +
> > > +------------
> > > +$ git switch --detach HEAD~3
> > > +HEAD is now at 9fc9555312 Merge branch 'cc/shared-index-permbits'
> > > +------------
> > > +
> > > +If it turns out whatever you have done is worth keeping, you can
> > > +always create a new name for it (without switching away):
> > > +
> > > +------------
> > > +$ git switch -c good-surprises
> > > +------------
> >
> > I had to go re-read git-branch documentation to understand why you
> > recommended "git switch -c <new-branch>" (or even why this mode
> > exists) over plain "git branch <new-branch>". I wonder if the
> > difference between the two deserves a bit more discussion here and
> > above in the description of the -c/-C options.
> 
> There is this bit in git-branch, will that help?
> 
> -- 8< --
> NOTES
> -----
> 
> If you are creating a branch that you want to checkout immediately, it is
> easier to use the "git switch" command with its `-c` option to create
> a branch and check it out with a single command.
> -- 8< --
> 
> Otherwise any suggestions are welcome, I guess I could rephrase it a bit like
> 
> -c <new_branch>::
> --create <new_branch>::
>         Create a new branch named <new_branch> starting at
>         <start_point> before switching to the branch. This is similar
>         to creating a new branch with linkgit:git-branch[1] except
>         that `git branch` does not switch branches.

I think the second sentence, in particular the "except..." part, in
this description goes backwards by explaining how 'git branch' differs
from this.  I think the most to-the-point explanation instead of that
second sentence would be something like this:

  This is a shorthand for 'git branch <new-branch> [<start-point>] &&
  git switch <new-branch>'.

