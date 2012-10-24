From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Large number of object files
Date: Wed, 24 Oct 2012 13:59:16 +0700
Message-ID: <CACsJy8CcMBJLV=urVoWOQABQzQkC6y35spPF+_3fW6dtJjHtvg@mail.gmail.com>
References: <CAMJd5AS1=Cf--0=1Xynxf1J-22fxBq05XjNGMcUep+ndAOO7ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 09:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQuwa-0000JR-EN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 09:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933650Ab2JXG7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 02:59:48 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51373 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282Ab2JXG7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 02:59:47 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so158713oag.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 23:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JufDPq/4WJYPxps72iGamlOic/ehS6gaKlwjtmCvdFY=;
        b=c1dzFgl7/TooUkIYyKitPpVsZLxiCaU8dHLnFAx1jIxBT8O0m3lSXuqGL0EuSE3Igs
         4ACnkwsllsUJ1zPZb0knmmu12+z3ZyeYbBt+B68taFfZRFuMHXcvFqQyAg4o1EpnKBdP
         4EcYMDPe2CsXWfBPDrlxU3h+HPNkeZsC9Hj4zEtTYHnEi/bOz2fKiO9sKlwHmFsky4UW
         gByzBzdG9d2pmnp8IHuZqI1APVjJ1r2LVxIc0xAO8IKvF1VDQ3zppebrZCm4etcPOOTO
         ixFPheGECfUrkYdpD0LWfX/IJpnoAY6afUzKA76fpSFTckfCTcMBaDGgijBJ/FBqjjMR
         NB3w==
Received: by 10.60.169.137 with SMTP id ae9mr13135090oec.91.1351061987067;
 Tue, 23 Oct 2012 23:59:47 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Tue, 23 Oct 2012 23:59:16 -0700 (PDT)
In-Reply-To: <CAMJd5AS1=Cf--0=1Xynxf1J-22fxBq05XjNGMcUep+ndAOO7ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208291>

On Wed, Oct 24, 2012 at 12:21 PM, Uri Moszkowicz <uri@4refs.com> wrote:
> Continuing to work on improving clone times, using "git gc
> --aggressive" has resulted in a large number of tags combining into a
> single file but now I have a large number of files in the objects
> directory - 131k for a ~2.7GB repository.

Can you paste "git count-objects -v"? I'm curious why gc keeps so many
loose objects around.

> Any way to reduce the number of these files to speed up clones?

An easy way to get rid of them is to clone the non-local way.
Everything will be sent over a pack, the result would be a single pack
in new repo. Try "git clone file:///path/to/source/repo new-repo". You
can also try "git prune" on the existing repo (read its man page
before use).
-- 
Duy
