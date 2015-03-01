From: Shawn Pearce <spearce@spearce.org>
Subject: Re: does the git over ssh protocol tell the server the hostname?
Date: Sat, 28 Feb 2015 16:41:37 -0800
Message-ID: <CAJo=hJtgYp53UMXA0x32TRz2y7jynuE6b31fvuNWJ2FH=iMWuA@mail.gmail.com>
References: <1424992494.4663.28.camel@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 01:42:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRrxQ-0000tt-G6
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 01:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbbCAAl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 19:41:59 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:43612 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbCAAl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 19:41:58 -0500
Received: by ykp9 with SMTP id 9so10411534ykp.10
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 16:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EXESXf2LXu97IE3k/2TMfRsVvmybLnO/kqdESsKwsV0=;
        b=XFkrTHi11aKZ5b2bm/9WfbzH5743d/RPZdaXomuuj75BwkkNlt3xMwjHB5cIxEcR61
         Myssu+uLvHXEKb/spsJucuwwxHa/0tRsal+azGvfyspmRgx07+L7zayfKaSow9Asz29I
         x1pH/RWMsXljqRoRTnXaYRquX6ssgD9hQRj9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=EXESXf2LXu97IE3k/2TMfRsVvmybLnO/kqdESsKwsV0=;
        b=f+J9mrWVmItNduqT+HezVve+hMu2OQYZA3TfSSL7VPPyB42oU868EvPghM2IGrIwCo
         z1+C6K3x5m4dB2N/Xqy15HirMLOWaCoKDuhuSKWXAo/2v7Q2J+QxqRE9OVL7LvwF/Zi+
         PfpBZO0cE5zWlsWwfc03W+Eu3RASL0iNxPBYQKqsh4a/TigdmHpYcXZP+Yp943dehJLS
         EUYt8eq7EpN4lOvVwAGkOyjU7SJ2B9wtvsc+S5+Hrp//KQg8i1UX/iwZ+OOSgbPKW4XS
         S7wNEqtrfmRdJEzjjg02T0dEsMVjm52KuTGdxQwo956PyLJCeBHBA9xYOt9+stwBO+iw
         PYrA==
X-Gm-Message-State: ALoCoQnFvzye2bztlDttsIZhGEslR5HrbTitASW4qUwWPRoNmPZZhZy2/jnELCJx5oTg39CevRuz
X-Received: by 10.170.136.19 with SMTP id d19mr21162404ykc.2.1425170517780;
 Sat, 28 Feb 2015 16:41:57 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Sat, 28 Feb 2015 16:41:37 -0800 (PST)
In-Reply-To: <1424992494.4663.28.camel@scientia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264542>

On Thu, Feb 26, 2015 at 3:14 PM, Christoph Anton Mitterer
<calestyo@scientia.net> wrote:
>
> I saw that when plain git (i.e. git://) is used, the client tells the
> server the hostname specified on the client side.
> For http one has the same automatically via http's Host: header.
>
> But after watching the git's over-ssh protocol, I couldn't find anything
> like that there? :-(

No, it does not send the host name.

The host name in SSH that Git sees could be an alias in the user's
~/.ssh/config file that is rewritten to a different host. So virtual
hosting keying off that could be confusing since the end user expects
to have more control over it than they do with git:// or https://
where the host name is usually a DNS record the user does not control.
