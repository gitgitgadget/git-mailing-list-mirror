From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Save notes state when releasing
Date: Mon, 23 Sep 2013 09:25:05 +0200
Message-ID: <CAC9WiBiOAediWzgLsjcH=gorwtzrUSHumZQ3f8xk3gsestyXMw@mail.gmail.com>
References: <CAC9WiBh3ha61M789DL==Nch30P_mvGwDLODqNzwaAbmHtyhPkQ@mail.gmail.com>
	<20130920103401.GB21684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 23 09:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO0WM-0006iS-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 09:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab3IWHZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 03:25:07 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:63219 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab3IWHZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 03:25:06 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so1956471vcb.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4bwZwCFtZkCG1F1hImUiEBmU9KTrYumsJJg20w6bcwA=;
        b=jgW6rxpCrJsR986DIy9lDZVt97YShbKa6sxBvx3tmlMrhcpvJ3hwut6CGTXu8IbyQ4
         TRanpvy6S0le/Vit4VuZqzWXf9FK1ARNuL8OC4YHqa+vG4k7z6YfrIfpa6ehuFfCR5xK
         oxshYaAjvmjc0JruQshkB0Bc5h0neGbwndcyPMTxIUfxpfi3ZpVsWKSKbkJwSYLjzF6+
         VvY+DRN9Qegqz6gK2+tC3SKq/5kEydf/UcDOmklAG7qN8/gtNl3XHrjfzFqk7Wu+Si8u
         mi8aqcUBhWLx7UBFB9UNbdoY5oA27PFfBiPJFBkusc8lHQLLUN9Qe6M2XKm2V47CGXmn
         9p7w==
X-Received: by 10.59.9.138 with SMTP id ds10mr20996807ved.5.1379921105450;
 Mon, 23 Sep 2013 00:25:05 -0700 (PDT)
Received: by 10.58.8.169 with HTTP; Mon, 23 Sep 2013 00:25:05 -0700 (PDT)
In-Reply-To: <20130920103401.GB21684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235202>

On Fri, Sep 20, 2013 at 12:34 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 20, 2013 at 07:38:17AM +0200, Francis Moreau wrote:
>
>> I'm using notes in my project. I'm wondering if it's possible to save
>> the state of the notes when I'm releasing/tagging a new version of my
>> project so I can restore the saved notes state if I checkout back the
>> old release.
>>
>> Therefore I would be able to inspect notes (which may have been
>> removed or modified after the release) as they were when the release
>> happened.
>
> The notes are stored as git trees, so you can point a "tag" ref at a
> particular state, just as you would with a normal branch. The "git tag"
> command expects to create refs under "refs/tags", whereas "git notes"
> expects to find notes under "refs/notes". The simplest thing is to just
> use "git update-ref" rather than "git tag" to create the pointer. Like:
>
>   $ git update-ref refs/notes/v1.0 refs/notes/commits
>
> and then you can always view the v1.0 notes as:
>
>   $ git --notes=v1.0 log
>
> You can even set the notes.displayRef config to always show v1.0 notes
> when they are available for a commit. Though if they are a subset of the
> current notes, you would expect to see duplicates. Depending on what you
> are storing in your notes, you may want to clean out your notes tree
> after the release.

Thank you Jeff, that's what I was needing.
-- 
Francis
