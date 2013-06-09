From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 23:36:42 +0530
Message-ID: <CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
References: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
 <20130609043444.GA561@sigill.intra.peff.net> <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
 <20130609175554.GA810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulk1g-0006Pw-N9
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3FISHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:07:30 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41315 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3FISH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:07:29 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so14774716ief.12
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=luoUpx+NQ1hjlzm+DUoo5kT/pGzCT3TZ5grMZ3ZIiUI=;
        b=j/5IpDR+4P/dCDe6aMXKF9m3ZBXgvSMGyNQjlUly3AxkJJx3n78szcme7820sU9vIb
         qxriUDQZlK4uvYjlevhC19ndIxcWwhMJgZqpfTuo0dbs0xWeB0AXZiqJsblrVT0A09F/
         fJAnjV07SdemczSg4VTZ5GaSRZG2/BvKy13K+MRO0T8SD/jAtMM37lmRirR+Q+Zsy/rt
         H45XBsMURzU0TwpuBseIAih+mxDg3IVIidAtj2+N7Kh//W3IYaBPQHW+664dPgRqSIn4
         k42qwSb1BC6fZol2+lHbPtBEp9FasV3uLzje9D4BImZmHkJ9Afbd2+pIo3fNAANPr4SQ
         HqaQ==
X-Received: by 10.50.154.106 with SMTP id vn10mr598933igb.0.1370801248821;
 Sun, 09 Jun 2013 11:07:28 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 11:06:42 -0700 (PDT)
In-Reply-To: <20130609175554.GA810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227077>

Jeff King wrote:
> I already mentioned elsewhere that I think it would be fine to massage
> libgit.a in that direction. I even joined the conversation pointing out
> some cases where Felipe's ruby module would break. But I do not think
> that moving code in and out of libgit.a is an important first step at
> all. That is simply code that no library users would want to call, and
> is easy to deal with: move it out. The hard part is code that users
> _would_ want to call, and is totally broken. Patches dealing with that
> are the hard obstacle that people working in this direction would need
> to overcome. But I do not see any such patches under discussion.

Forget the rest; this makes it clear.  Thanks, and sorry for all the confusion.

So, reorganization is not the first step.  Can you please post an
example patch illustrating what needs to be done, so we can follow?
