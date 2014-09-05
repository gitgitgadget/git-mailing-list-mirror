From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Fri, 5 Sep 2014 13:23:17 +1200
Message-ID: <CAFOYHZDfpZPvuE_BZQHajc65fZNKoyqvFf+UZyf0LyLwrooqzA@mail.gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-2-git-send-email-judge.packham@gmail.com>
	<xmqq38c8waub.fsf@gitster.dls.corp.google.com>
	<CAFOYHZCcAwHwRy50kE8=rRwEOtrXovNkkKSQo2Gwcfvbve1Qwg@mail.gmail.com>
	<xmqqiol3uwr5.fsf@gitster.dls.corp.google.com>
	<CAFOYHZC5pWadJiqY=F3gP4DKcNzhogfWH76jAcez5AjW7FJrVQ@mail.gmail.com>
	<CAPc5daWip1dQ5Or6hzmdjoBUStusvs-jK0ODNuzAotNfM5BLbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 03:23:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPiFH-0000Xa-6Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 03:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbaIEBXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 21:23:18 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34044 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaIEBXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 21:23:18 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so21135948pad.18
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=wnbuMoEBO/YnNCcMYwSA3X/HJ/J3hrh+qKBezg2Cp5c=;
        b=hSpxebyTRJNfOuHon3kOExtvc6O4DSue8BUOnE3+I3yX+m+IifiEu2v2eW85FP13kh
         Lxqq7VmNyIgh88M8o33BOYqxEVZv/d+20CEciCZ88cWMTpsDD5kBp5SCE8jTBbs8tA23
         8gttZ3dXFXXV7CEWRwJCoyNcgUWNMNhy0nc4xHca7LC7L/2F/QDMld8XN4PtD5ugPoan
         cV4acQO0ySls8GLy25Zn2bY8I8+pj+7XJ76WlCEhatvu5dH6nqEotdcmWkyLHXRtqyN3
         0hTdtnEkTB7LxughJq0T5VvntVn7yxP9EyxB7GurvrmwHYewuzQWm2sMR+39J49BvNoO
         P8EA==
X-Received: by 10.66.136.12 with SMTP id pw12mr14010675pab.71.1409880197791;
 Thu, 04 Sep 2014 18:23:17 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Thu, 4 Sep 2014 18:23:17 -0700 (PDT)
In-Reply-To: <CAPc5daWip1dQ5Or6hzmdjoBUStusvs-jK0ODNuzAotNfM5BLbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256495>

(added back git ml because I accidentally dropped the Cc when replying
to Junio).

On Fri, Sep 5, 2014 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I doubt that a patchset that does
>>> not update mailinfo and mailsplit to extract information and to undo
>>> the indentation could be a right solution.
>>
>> I've read this sentence a couple of times and I can't understand it.
>
> "am" uses mailsplit on the input file to separate it into one or more
> input files, each of which represents a single change. On each of
> them, it uses mailinfo to extract the meta information (e.g.
> authorship), log message and the patch into separate files.

Except when --patch-format=hg|stgit is specified (or detected). In
these cases mailsplit is avoided.

> It does not make any sense for a support for a new input format that
> does not teach mailinfo how to handle that format. Transforming it
> into a pseudo e-mail format is not the way to go. If that approach were
> acceptable, that format conversion filter can be run completely outside
> "am" in the first place, no?

So teaching git mailinfo to do s/^    // (either when asked to or
using some heuristic) would be a better approach? I also think we
should accept "Author:" as an acceptable fallback if "From:" is not
present.
