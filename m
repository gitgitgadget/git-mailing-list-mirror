From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Sat, 10 May 2014 20:45:47 +0700
Message-ID: <CACsJy8DKSsp_Y+KosFPUP5UobiiS2GjdgOug8_x+d6iLec6HbQ@mail.gmail.com>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com> <20140508212647.GA6992@sigill.intra.peff.net>
 <874n10ot2m.fsf@fencepost.gnu.org> <20140509001145.GA8734@sigill.intra.peff.net>
 <87zjiro856.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 10 15:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj7bb-0005wt-P3
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 15:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbaEJNqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 09:46:19 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:45421 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbaEJNqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 09:46:18 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so5656609qga.6
        for <git@vger.kernel.org>; Sat, 10 May 2014 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7oYtHkmH8lbTy/VXU/m4GZTA/5TEwXlU+nV+I0bK6U0=;
        b=mkhhFd7XRzKKT1vMiVP3S0ZOQDiMZ/XBbpGhyxv9LDEOIjbW+Uk2NGXRHPJAIYC2X0
         OG7tmXD/Vh7NbiWRth+BXlaymtvhQz7xU2FtsD2gw4s1O9SnbSGD8nWN7ZgnM4/SBQLe
         qRyerS+yEXnD9RGZGai84z6BYRNGc3lNF3sp6BiQdnDi+m+bw7QwnSqw1lRaI4pNY9fP
         UzrWJ1/ETKWuOgi7+YtHDMIVi0QPml+Y7A4uLVHykV5i2K+IDY/q+pEEaq+7kQ/HWml2
         wf6tCMPFOzZA5LqpKTbHq2Kg7zN2RkINWshXrfX7YlhrfS46ujchDD5lYEt9cofnPgzh
         oiFA==
X-Received: by 10.140.107.198 with SMTP id h64mr21291366qgf.30.1399729577388;
 Sat, 10 May 2014 06:46:17 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 10 May 2014 06:45:47 -0700 (PDT)
In-Reply-To: <87zjiro856.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248658>

On Fri, May 9, 2014 at 12:04 PM, David Kastrup <dak@gnu.org> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I'd actually be inclined to say the opposite of what Junio is saying
>> there: that "-b" should blank the author field as well as the commit
>> sha1. I'd even go so far as to say that "-b" should probably be the
>> default when boundary commits are in use. I cannot think of a time when
>> I have found the boundary information useful, and the IMHO the output
>> above is less confusing than what we produce now. But I admit I haven't
>> thought very hard on it.
>
> Arguably if the user explicitly limited the range, he knows what he's
> looking at.  Admittedly, I don't know offhand which options _will_
> produce boundary commit indications: there may be some without explicit
> range limitation, and we might also be talking about limiting through
> shallow repos (git blame on a shallow repo is probably a bad idea in the
> first place, but anyway).

No it's not. The idea of shallow repos is to work like a normal repo
(most of the time at least). Excluding git-blame from shallow repos is
a bad idea. Luckily it's not hard to detect shallow boundaries: if a
commit has no parents and lookup_commit_graft() returns -1, then
that's it.
-- 
Duy
