From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sun, 20 Mar 2016 12:19:46 +0530
Message-ID: <CAJj6+1H6L=LxnDRzuC6OzXgVvzXsngGJ5X=E5Fi6Fg7JXkEJaQ@mail.gmail.com>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
	<20160319175705.GA6989@sigill.intra.peff.net>
	<CAJj6+1HaVnRcmDHOTDdx=o8a+aXvSi8+LykWzrfx7knE-_3ocg@mail.gmail.com>
	<20160319181228.GA9115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 07:50:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahXBV-0006xm-Os
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 07:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbcCTGtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 02:49:50 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38150 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbcCTGts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 02:49:48 -0400
Received: by mail-ig0-f170.google.com with SMTP id ig19so49035357igb.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HfAWM5aSqE70W8eMAwVbYPDHLVln8f5TqBfo/IFcczo=;
        b=vbveXjiTv+NMqy6hXxDYvmKOGNep6wifHrxZpbT0liMuERlSHBaaFbnZ84EWM+IabY
         wC+LJ9mMcgcLUet+tAujPeVOidB1ESsFUvUVMBTJAKFs1DJZ39BE6GS0Z9ziLA3tcUv1
         nRPHxY4oL4aIZ3QM5tT4bfmCBup/Abx8zE/IvYpko6tOeuQoQX1A/Q7Fw7ZwYKYk6FXM
         mervkMol2fZgMMOqr0rN6rQI/xlyxnwGrlvR9If1m45vjQXNd2ptKBnKnZ2qREXE2WnF
         jPg78t6A2Pd9202yjtHOxBVTBEAkofKk+Ja1L2+YB1c6tbHWtqv61zKKyR/BgPFfHJHN
         XPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HfAWM5aSqE70W8eMAwVbYPDHLVln8f5TqBfo/IFcczo=;
        b=AcNDRZkg5YdwQGCidgB9qo6yNBn1a0I78Q1YnDy2lmHUfCsRDWV8wOY5ysHbc6yHhE
         1RnOCwkVAH58Qok/KuOQGZ+XmlX/HPrmYEzt5KhGtmUyyfreGTg9f1U0WxwfwhIt5D1Z
         HkD4mnWJOgLgeLwGZ2TK4MbhEOirTYK83JcgKKtFSzlI+KOZaN6BoBvc4Yk0Q7Xkb7lh
         KembvcQVD3vgY2ZfXVvX2ieTi0gWJeZymzCj46rQSX2dPTtdZbq3LOj924ydVYWru5bH
         /nuaOmaPBV0d7YOr83RRbz6gNY03KshWC02kmxSsclYsuY3eYRsY7peawxPqYiyhlYAs
         5ulA==
X-Gm-Message-State: AD7BkJKjiGMiDWGvUuoinkMQk6YMGbZ9i8oD0OeOpHdGvEDb1XJEY+0f700Liv4au6fHFtqvkCD3vR52rNEcVg==
X-Received: by 10.50.12.8 with SMTP id u8mr6360730igb.33.1458456586354; Sat,
 19 Mar 2016 23:49:46 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 23:49:46 -0700 (PDT)
In-Reply-To: <20160319181228.GA9115@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289336>

I went for 3, and have sent a patch for that here - [PATCH/GSoC]
parse-options: Add a new nousage opt
However, it currently has one bug
Running 'git tag --contains qq' twice will first show an error, then
print qq, meaning that the first command creates the tag qq.
Running 'git tag -l --contains qq' works fine.
My first question is if 'git tag --contains' (without '-l') supposed to work?
If not, then I would fix that bug, otherwise fix the bug my code
introduced, and add tests for it.

-Chirayu

On Sat, Mar 19, 2016 at 11:42 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 19, 2016 at 11:38:09PM +0530, Chirayu Desai wrote:
>
>> > You'd teach parse_opt_commits() to store the string _name_ of the
>> > argument (e.g., using a string_list rather than a commit_list), and then
>> > later resolve those names into commits.
>> Gotcha, will need to figure out where exactly would those names be
>> resolved, can do after following the code path a bit more, can do.
>
> Without looking too closely, I suspect you could do it as the first step
> in filter_refs(). Or alternatively, add a function to "finalize" the
> filter state before making queries of it.
>
> -Peff
