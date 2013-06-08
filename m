From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 20:15:56 +0700
Message-ID: <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com> <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <sop@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJ0R-0006rs-Pj
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab3FHNQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:16:28 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55971 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab3FHNQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:16:27 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so8041609obc.31
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fv0ALk4bW4wAuKAAa1phFihBtubLitq7ZoQDF97V/yc=;
        b=cxO0GjJxDD29jX/qTzbJpQe+UBNyuJyjhz0mycWhm2vxhV+pShkPGJGKb7pvzPq+AP
         bmsIlyUZqfFJMOfpFQLeFLHyaBG80rdpktfSLltrDQ2H7RwEI5McmloYwRJUEQARtl7R
         /LcF8YLe95b4xlrVXP134Wgw0y2/BYu9kJqLxjbPEqVot6aqXmY6udybcSU7wMigctZG
         Kj2PgBA+jBjUeiJKF9GmAFNZ+loUb4AqUccTv89N5H5KtPkmNTOShHX3U6PatDIoLIcp
         12iYuZaJO8qF83or1tyHFxmv1anTQo0cuUNTFZNKocnHsLpTK9BCNpMWB5CasMeKb7/8
         lDwA==
X-Received: by 10.60.125.101 with SMTP id mp5mr2257553oeb.18.1370697386885;
 Sat, 08 Jun 2013 06:16:26 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 06:15:56 -0700 (PDT)
In-Reply-To: <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226815>

On Sat, Jun 8, 2013 at 7:55 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>>> until libgit.a == libgit2. Done.
>>
>> Read up about the introduction of libgit2, why it was created in the
>> first place instead of moving a few files around renaming libgit.a to
>> libgit2.a. Unless you have a different definition of "==" than I do.
>
> As far as I know, there was never an extensive on-list discussion
> about why git.git cannot be lib'ified.  The first appearance of
> libgit2 is here [1].  I briefly read through the initial history of
> libgit2.git too, but I cannot find a single discussion detailing why
> lib'ifying git.git is fundamentally unworkable (there's some vague
> mention of "global state baggage" and "presence of die()", but that's
> about it).  Unless you can point to some detailed discussions, or
> write out a really good reason yourself, I don't think there's any
> harm in letting fc try.  Ofcourse, he still indicated any sort of plan
> yet, and I'm also waiting for that.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/99608

Hm.. I thought Shawn wrote a bit more in that mail. Apparently I was
wrong. I think it's discuessed in the list from time to time
(otherwise I wouldn't know) but I don't keep bookmarks.

I _think_ the reason is because git was never written as a reusable
library in mind from the beginning.  So global states and die() exist.
Worse, "run once and let the OS clean eveything up at process exit"
leads to some deliberate memory leak if it's made a library. See
alloc.c for example. The internal API is not really designed to be
usuable/stable as a library. All of these made it very hard to convert
the current code base into a true library. So the effort was put into
creating a new library instead, copying code from git code base over
when possible.

So instead of redoing it again, I think it's better that you help
libgit2 guys improve it to the extend that git commands can be easily
reimplemented. Then bring up the discussion about using libgit2 in C
Git again.
--
Duy
