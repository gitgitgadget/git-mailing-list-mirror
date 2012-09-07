From: David Aguilar <davvid@gmail.com>
Subject: Re: gitk does not reload tag messages
Date: Thu, 6 Sep 2012 20:08:26 -0700
Message-ID: <CAJDDKr7AJ4Mrw8_wsB9WSqPT8sBca8FmBGHoq2Ay_ivLyUyAGg@mail.gmail.com>
References: <MTAwMDAxMC50aW1tYw.1346955478@quikprotect>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim McCormack <cortex@brainonfire.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 05:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9owm-0005Bp-R8
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 05:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab2IGDI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 23:08:28 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38610 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557Ab2IGDI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 23:08:27 -0400
Received: by vbbff1 with SMTP id ff1so2417274vbb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RAWwMp0SJGT0NC227RuQfZMbGSL9PWGnfkkFZh0isRU=;
        b=YnLIZytQX13D2tgoj2OAa3T+RBN5Mc/99pjVSR7jpP92gKk6FIh/pGCDo81lmzdUYr
         iGPG7XDVimlC8rvt2Skupjw5jXpfoKo07tH9gx3qaBD02OSp4EpXXfSczcdmSdBtoLBf
         1vQafaXe02WXYHFrUnra3VYYiYoWlWWhnzyis0Py2w6eGE6papem8AQjb3Kj3qpdLeZ7
         sg8QRq470YxgvdXi8G4tkzoXOsbw8kp5OeM3PuTfFMWVJ7J3LY/t+dYWkwYF/mlxoE1a
         4c6LzlKWSGSvdcBeBB9FoqaHncxEIjiSQw/auDmLWsJakAbQl5nqHb6b6sTnWjIl3vua
         FRQQ==
Received: by 10.220.241.143 with SMTP id le15mr5292592vcb.3.1346987306714;
 Thu, 06 Sep 2012 20:08:26 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Thu, 6 Sep 2012 20:08:26 -0700 (PDT)
In-Reply-To: <MTAwMDAxMC50aW1tYw.1346955478@quikprotect>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204945>

On Thu, Sep 6, 2012 at 11:17 AM, Tim McCormack <cortex@brainonfire.net> wrote:
> If a tag that gitk knows about is deleted and recreated with a
> different message, gitk still shows the old message after any
> combination of refresh, reload, and reread refs.
>
> git-gui version 0.13.0.8.g8f85
>
> Reproduce:
> 1. git tag -a test -m "foo" HEAD
> 2. Open gitk, see that correct message ("foo") is present for tag "test"
> 3. git tag -d test
> 4. Reload/refresh gitk [optional, it won't make a difference]
> 5. git tag -a test -m "bar" HEAD
> 6. Reload/refresh gitk
> 7. See that the message on tag "test" is still "foo"
> 8. $ git show test # shows correct message "bar"
>
> Apologies if this is an old version or a known bug; I could not find an
> issue tracker to search, although I did check the gmane archives.

Tags in git are meant to be immutable.  You can delete them, but you shouldn't.
That's not really how they are intended to be used.

gitk avoids re-reading that information because the normal,
typical use case is that the tag messages do not change.

It would probably be a performance regression to "fix" this.
In which case, IMO it's not a bug.
-- 
David
