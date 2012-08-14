From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Implement ACL module architecture and sample MySQL ACL module
Date: Tue, 14 Aug 2012 09:27:19 -0700
Message-ID: <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
 <7v1uj98nbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michal Novotny <minovotn@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:28:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1JyP-0006r3-MC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 18:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab2HNQ1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 12:27:51 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56341 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab2HNQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 12:27:41 -0400
Received: by ggdk6 with SMTP id k6so642013ggd.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=I2dpGG1sfLTGDouvR/TBi8EYTDQwkKSvTTUlKC5r3Hk=;
        b=DRqhrTcf70jotcvpspaUbcpKmwH4jbz89gd3DRc784G4XyclcPAIw8a7BaltJzRHQH
         AwOLh5kcdtr19eWUm2w7z6WoYSB/aOGEm/oC3xaCpN/vSX83h83IbWCXAAEWpJztaXp4
         7C/BQLKAMhz2W9CkC5WnReiIqkKfDp/kHgZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=I2dpGG1sfLTGDouvR/TBi8EYTDQwkKSvTTUlKC5r3Hk=;
        b=P25l5cD5X2jFi/gstrKtMiR7ydt/UxV6u5+Dru+En36oPiACk/VsjXTTcELt6/S+I4
         PkS3AwNwIiDvOLtZfPxuy05CIo/C6XkWwfuyHzZGeY53eYSCoSvoViA0lOmG4K2P+cgu
         XGTqP54AX/cG363RWdnCpYDevZOIExq67WApsxbxRHKmaZzDQMmD6HW8JCaswb+98FpY
         WTl+3U5409Y4cOCY4DjiYRDvmsYaMjie4MIq/5AyuidD0ZsDgQ2H3yWqseGR4/ZiWTQm
         KaMdV6NcuRohQ/e0gGhZhxb2oeaBJQ1voTwhbdMzTLq8z3UcoQMYcVVDgMBemYvZFqLb
         iw6g==
Received: by 10.50.57.194 with SMTP id k2mr12775965igq.32.1344961659647; Tue,
 14 Aug 2012 09:27:39 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Tue, 14 Aug 2012 09:27:19 -0700 (PDT)
In-Reply-To: <7v1uj98nbj.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl5UCsGFEB1lr/i1ChZ9EAe0o0Nge5Guc8z1PklwvREkEKc71ZajnzNQieZegTYRZuvrXWe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203412>

On Tue, Aug 14, 2012 at 9:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michal Novotny <minovotn@redhat.com> writes:
>
>> Hi,
>> this is the patch to introduce the ACL module architecture into git
>> versioning system.
>
> No, it doesn't.  It adds something only to "git daemon", but does
> not affect any other uses of Git.

Yes, this part of the commit message also confused me until I read
through the patch further. :-(

>     Side note: I am not saying other uses of Git must be ACL
>     controlled by MySQL database.  They shouldn't be.  I am only
>     saying that the proposed commit log message must match what the
>     change does.
>
> Please familiarize yourself with Documentation/SubmittingPatches
> first, and then imitate the style in existing commits in the history
> and posted patches by the "good" developers (you can tell who they
> are by observing the list traffic for a few weeks), by the way.
>
> As "git daemon" already has a mechanism to specify what repositories
> are served with whitelist or blacklist, I am not sure if this patch
> adds enough value to the system to make us want to add further
> complexity only to carry more code to be audited for security.
>
> Opinions?

Traditionally Git has been about providing the plumbing to handle the
protocol and storage, and other tools that wrap git manage access
controls, e.g. UNIX filesystem or gitolite. I would strongly prefer to
keep that arrangement.

Parsing the request line of git-daemon is easy. But we could make it
easier. An alternative arrangement would be to add a new command line
flag to git daemon like --command-filter that names an executable
git-daemon will invoke after parsing the request line. It can pass
along the client IP address, command request, repository name, and
resolved repository path, and tie stdin/stdout to the client. This
binary can decide to exec the proper git binary for the named command,
or just exit to disconnect the client and refuse service. This makes
it simple for a tool like gitolite to plug into the git-daemon
authorization path, without needing to be the network daemon itself,
worry about number of active connection slots, etc.
