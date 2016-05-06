From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 5 May 2016 23:58:52 -0700
Message-ID: <CAGZ79kaO+g7Dm5AgdYGADj=pYDLjV-ALGTxrmwrNGUy1NB=tNg@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
	<xmqqpot06oys.fsf@gitster.mtv.corp.google.com>
	<xmqq60ur7ll3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:58:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayZiz-0002J0-KU
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 08:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757848AbcEFG6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 02:58:54 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35237 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbcEFG6x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 02:58:53 -0400
Received: by mail-ig0-f175.google.com with SMTP id bi2so37881378igb.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8o3cwD+cmgnYyj5fI7T5IJs8Fb8EkHJIs3e5rX+Qzmg=;
        b=al/AC4fO7wuYIdPJPR/tdk8hucyZkWvsRXXlmqN4VTZI6diFvEYIZb3ghm3TGswZxA
         KATpv4gTcALPouMycHYKaWDxTFZfkzuJ542w3l22Egg1QgY5VdIiuhHu8SZ3G9j6aqaO
         mRV7s3sSX6k7wobs2Bgo1I8QkzqqlYsxzID8DSj8GJ6KEBDAiSRWy7DKtJyjKrgrmay7
         2Unk84VwXwLCD0FHcXYSmmG2qGcJh9A2t3bl4VHwWy2h1MYVlwPxJWyAt2/ojyaSeLxH
         5enU2z5oCxXisl5R/0e8Dt8RtLgcd3pRlLdz/eWpfnlTUfprEv5cw14LJXkKHNFl096I
         FKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8o3cwD+cmgnYyj5fI7T5IJs8Fb8EkHJIs3e5rX+Qzmg=;
        b=lkvb2uMSe1M91felz9ByK/Eht+r0DAjsk1co/MiKpDQRktPq5UGnKODagajzb91iS9
         7WYVpk1OqVefEn5yC9n/arolpD3LuEgdQSLPeM9oaSWr1UOKpzPfferorBCBGPH1NeAt
         rFOTA0OBXUvYJRdeYWKWNkt0Ljjp/rogB0CcOjI2pHp1JBsmyXwYS/LqdwfD/BDd16yP
         Zh4SKBoalUKk3XNXOL7WLDQ9L3uRcxskE8x7zPtO4v3Cuo9PLW+KU8AhA3VcN72Sx5e3
         qgSPICew0NvC0Mxg8lyl9XNd4geFfIFOwXknvvkth0mHSIuoy9dyWiA/gYjJ6RV42npX
         5fnw==
X-Gm-Message-State: AOPr4FXhH8RsjxQSS1JEf2hTJXil2wrHgvwSNXAZqajsH7kbR1a7lx1m4UR4ghXTdyGYDu9YoDjAjS0Lxd55v7A8
X-Received: by 10.50.29.45 with SMTP id g13mr8643622igh.93.1462517932248; Thu,
 05 May 2016 23:58:52 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 23:58:52 -0700 (PDT)
In-Reply-To: <xmqq60ur7ll3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293747>

On Thu, May 5, 2016 at 11:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> When deep/in/ is an unrelated repository, and running either
>>
>>     git add deep/in/the
>>     git add deep/in/the/tree
>>
>> would add deep/in/the/tree/is-a-leaf.txt to my index, but if I did
>>
>>     git add deep/in
>>
>> I'd lose that and suddenly everything there turns into a submodule.
>
> Also, I recall that you floated an idea to declare that
>
>     git add deep/in/the/tree/is-a-leaf.txt
>
> must always behave as if this is done instead:
>
>     git -C deep/in/the/tree/ add is-a-leaf.txt

In a different thread, yeah. I am not sure about that any more.

>
> Even though I am not a huge fan of an operation that crosses module
> boundaries, I think that is a sensible semantics of a "cross module
> boundary operation" (the actual implementation should not be
> iterating over pathspecs and chdir(2)ing around for each and every
> one of them, though), if we need "cross module boundary operation"
> in order to support end users working on a project with one or more
> submodules at the same time.

I agree.

>
> But treating the bug under discussion as a "feature" will destroy
> that future.

The bug under discussion was blogged about in 2010 and still persists.
I'll try to find out if people actually use it.

If that bug was fixed, but I still wanted to enjoy the upsides of it,
I could to that with pointing core.worktree into deep/in/tree.
e.g. I have git.git and gitk-git as separate repositories,
then I could still do a

    GIT_DIR=gitk-git/.git git -C git.git/gitk-git git checkout
<sha1-of-gitk-repo>

This looks more complicated than this bug/feature though.

There are 2 fundamental cases though.
 (1) The bug we're talking about (as explained in that blog), refers to 2
    independent repositories, whose work trees are nested
 (2) You seemed to bring in the notion that the nested repo is considered
    a submodule of the outer repo, i.e. they have a relationship.

I don't mind (1). It's a neat hack as these 2 repos are totally unrelated
(except for the working tree in the file system being the same files).
You could also achieve a similar handling by hardlinking gitk-git/gitk
and git.git/gitk-git/gitk.

In (2), we have a gitlink, which by definition takes up the whole directory.
So any file in that directory in the file system which represents the root of
the submodule should belong to the submodule.
