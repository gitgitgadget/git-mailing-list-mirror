From: Stefan Beller <sbeller@google.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Thu, 19 Feb 2015 15:15:26 -0800
Message-ID: <CAGZ79kaBYENOUAuG4j1itsEq54DoipL7pZSP+b+wTc0wrQZoOw@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<CAGZ79kaPhuCXgYvZ49NwVRvrKLVJLTWd0oWHv3jX31sOVCWKVQ@mail.gmail.com>
	<CAH8BJxEK1xwGMsR3JKe72AVS7+5-aaQA4_Q8fpuZndSh1-mong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 00:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOaJk-0002dS-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 00:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbbBSXP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 18:15:27 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:55332 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbBSXP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 18:15:26 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so20752957obc.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h+JGB0rzFWQBN62isPACW1EXP7d5DXCvCRj9dy0KS00=;
        b=d8IRsvMZC16/2gf7funLdP64ArKJws7oJNVA4g2GGC8udSShUuDCdvCGFNMNHCh6XH
         2C8Z7LOp9zPQJwEdmRzNehwG9hkGbCRu6j1f+jSI2AE8A2TuLG2l4X5yYxJFZ3KuDEDV
         YRUxuUxkMPFymU/OtTHoIMr5yoiVrThUi9aAggRF/gZObE3+xXOWt7id1RqAQ2TvVwIN
         pcIobkCgUoNDzIIyNwUXw4EaWp4xFSdUGDHM5/rrUaaUOpBO6NGMBVUcQVk2lu1uFL6K
         3JGUnLGpix89KRzW+kpczce2E3v2XZJLFR6pXLklWMNU5TSpXZeEPG42da4U9nkJMjDk
         cFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h+JGB0rzFWQBN62isPACW1EXP7d5DXCvCRj9dy0KS00=;
        b=hpSIZGabQ8f+rZJzvWsfXETsue1HH27QJZju2olgbw5hznkaxm0QC1LzaR2Vvvtkfl
         1pGRnS8eo2rJDtiqQosxD3JTrt8OyZU1PNIsPMAkyHZyIUdePGa71F4R+mV7878RnJEV
         G5nnJSZ/qpu21UYSjZq6Oy05Go/92D8AS2wFPFdSb0d/NcOBgDuNiXX9rtcGU1aofk87
         CIMYPbQPyJzJQ5hmHUmy1sWCOZcMRpNaFHJEBU4K5q3boNFK2KOtaQLo/w7wn2ZSQOsM
         e0XnX5n4+t0+pMd1BZg92LqzUwVzrGbS7KvKEbAS36n3PjhrFh273NVl70Y5DhUUUfg2
         9JFQ==
X-Gm-Message-State: ALoCoQk4Nw6bgkDOGsE8G5BjUkRbB5zKXY4R7EvCQeAPpqAGhlyTuWQ9bNorIeRKw0JBgr3gWqxE
X-Received: by 10.60.176.34 with SMTP id cf2mr4601820oec.52.1424387726254;
 Thu, 19 Feb 2015 15:15:26 -0800 (PST)
Received: by 10.76.173.137 with HTTP; Thu, 19 Feb 2015 15:15:26 -0800 (PST)
In-Reply-To: <CAH8BJxEK1xwGMsR3JKe72AVS7+5-aaQA4_Q8fpuZndSh1-mong@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264118>

On Thu, Feb 19, 2015 at 3:06 PM, Stephen Morton
<stephen.c.morton@gmail.com> wrote:
>
> I think I addressed most of this in my original post with the paragraph
>
>  "Assume ridiculous numbers. Let me exaggerate: say 1 million commits,
> 15 GB repo,
>   50k tags, 1,000 branches. (Due to historical code fixups, another
> 5,000 "fix-up
>   branches" which are just one little dangling commit required to
> change the code
>   a little bit between a commit and a tag that was not quite made from it.)"
>
> To that I'd add 25k files,
> no major rewrites,
> no huge binary files, but lots of a few MB binary files with many revisions.
>
> But even without details of my specific concerns, I thought that
> perhaps the git developers know what limits git's performance even if
> large projects like the kernel are not hitting these limits.
>
> Steve

I did not realize you gave numbers below, as I started answering after
reading the
first paragraphs. Sorry about that.

I think lots of files organized in a hierarchical fashion ranging in
the small MB range is
not a huge deal. Also history is a non issue

The problem arises with having lots of branches.
"640 git branches ought to be enough for everybody -- Linus" (just kidding)
Git doesn't really scale efficiently with lots of branches (second
hand information
except for fetch/pull where I did some patches on another topic recently).

Thanks,
Stefan
