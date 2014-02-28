From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: [PATCH] branch.c: delete size check of newly tracked branch names
Date: Fri, 28 Feb 2014 13:14:44 +0100
Message-ID: <CAL0uuq263WEFWvZFDeqdN4=fAJGPUtux2wwFGOUQEMfzmDOweQ@mail.gmail.com>
References: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
	<CACsJy8A7jVM1wdU2BK-NyQ5HJoY_19oKhSXCKqV_7qNN+OA+mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJML4-00024p-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaB1MOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:14:46 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:34215 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaB1MOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:14:46 -0500
Received: by mail-ve0-f181.google.com with SMTP id jw12so625340veb.26
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=61/AfKDwUauC0R+rfDVBRMARea5ecx6fUHC+75DZKh4=;
        b=okfBQYCg87VBZM2YRYcYz4qKe7MbSoUn0OZg2o4pAp+4uJ5ZrVd1rLZa+IcGYR6R6s
         J9Xxk5PYN6sJShvU0uFnw3kfIhEwSLD6xCfZkBfWGZaUCWQQ4FKtbjccv+G2lBaOj4cG
         1FYzPWXtmdgLzp3xNhG5lu8vw1e6ZRXSjew5Olb0CtimrEsEbJtEsxqzZHGbK7NMjZPi
         oJx+M+wYDvl5QsTb10bZKmGywARmbiz2x2otujMwBGTVE3S9gLMEw36Bhw6s4atPE9ZN
         gPylC2YBpeX0KKvwKSo7AoDGIEJ1m7bBsbSiIV+OaOlKhmc4TljV2TG6VrtIFXPAWZ3F
         z36Q==
X-Received: by 10.220.161.132 with SMTP id r4mr2219226vcx.29.1393589685018;
 Fri, 28 Feb 2014 04:14:45 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Fri, 28 Feb 2014 04:14:44 -0800 (PST)
In-Reply-To: <CACsJy8A7jVM1wdU2BK-NyQ5HJoY_19oKhSXCKqV_7qNN+OA+mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242946>

> Nice. new_ref is passed in install_branch_config() in latest code. I
> guess you already made sure this function did not make any assumption
> about new_ref's length?
>

The function install_branch_config uses the strbuf, as I wrote in the
commit message. The contents of this buffer are then fed to
git_config_set, which, after a few more function calls, parses the key
with git_config_parse_key. This function does not rely on any
assumptions (as far as I can tell!) on the name's length, and
allocates enough space for it in
https://github.com/git/git/blob/master/config.c#L1462.
