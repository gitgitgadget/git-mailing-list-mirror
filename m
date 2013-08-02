From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Rewriting git-repack.sh in C
Date: Fri, 2 Aug 2013 21:10:59 +0700
Message-ID: <CACsJy8CaTA2vT0CxOAm0FacCWjNDJjZhg6mwSyspTChia-5ppQ@mail.gmail.com>
References: <51FBB8CB.8020600@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 16:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5G4s-0008Vb-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 16:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3HBOLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 10:11:31 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:62653 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab3HBOLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 10:11:30 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so1404266oag.38
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sJ52KOo1f8SyBWIZ4GtvmOCR29EkSU0rRxyHUfB+MtA=;
        b=T7bTLcYHIuCm8cy5ViL0A/wIj/gHLWPTAcsHlsYdBkDcSTM4gwnqSKMh/nFVSouo3b
         r5UcMzRoSkChkC3OCPBEcDJbxXUloRx7XUoQpCQoQKp50/EQEIpCn7sgzPjkHEyCIAn1
         wOpISkzC/5JABdRdxK4CtW9sPSaNu94eRSJdhpV6wvahM7Ove10nitejzdEWNz2HmrN8
         nalolwsuVSGmCVpdd2xc8PojITdpsxMcH6vZ2xLnSMSQ7d/M7RuxuVB22QxK0FvhaZLc
         ZrFbxIXHn1ji6xqGvYV4Hz5a6rlwnexfCBEVPcCDsuTzUe+HH7GNmxBNoHJS9GZY//jo
         5bng==
X-Received: by 10.182.34.166 with SMTP id a6mr5360365obj.102.1375452689760;
 Fri, 02 Aug 2013 07:11:29 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 2 Aug 2013 07:10:59 -0700 (PDT)
In-Reply-To: <51FBB8CB.8020600@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231524>

On Fri, Aug 2, 2013 at 8:48 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> Hello,
>
> I'd like to rewrite the repack shell script in C.
> So I tried the naive approach reading the man page and
> the script itself and write C program by matching each block/line
> of the script with a function in C
>
> Now I stumble upon other git commands (git pack-objects).
> What's the best way to approach such a plumbing command?
>
> I don't think just calling cmd_pack_objects(argc, **argv) would
> be the right thing to do, as we're not using all the command
> line parameters, so some of the logic in cmd_pack_object could
> be skipped.
> Another approach would be to use some of the functions as used
> by cmd_pack_objects, but these mostly reside in builtin/pack_objects.c
> They'd need to be moved up to pack.h/pack.c.
>
> So my question is, how you'd generally approach rewriting a
> shell script in C.

Start a new process via start_command/run_command interface. It's
safer to retain the process boundary at this stage. You can try to
integrate further later.
-- 
Duy
