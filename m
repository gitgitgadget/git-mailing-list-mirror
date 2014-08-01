From: Nico Williams <nico@cryptonector.com>
Subject: cherry picking and merge
Date: Fri, 1 Aug 2014 14:22:20 -0500
Message-ID: <CAK3OfOipw+Tg4PF5HAr8tb204vt17EVn46Lm9VMuHW1299yP8A@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:22:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDIPU-0004j3-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbaHATWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 15:22:25 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41413 "EHLO
	homiemail-a35.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755888AbaHATWX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 15:22:23 -0400
Received: from homiemail-a35.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a35.g.dreamhost.com (Postfix) with ESMTP id 6AFF554073
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type:content-transfer-encoding; s=
	cryptonector.com; bh=TZ27GZViUVa9NXzmpzIt169hT48=; b=tMg2gEdJ81m
	nlbVNOBRJLNXqUxqs4tg99i3+cwpNoJambN1NwRjFmo1JX9F24Nr6sCNrPLhubGb
	ykrgYQz4FK4C0cAO48hJOvBTkeLahkql3O9AR8wZqx+gKRllhIxQsC2M9IZiDvL7
	9snaw3gtDInQcjt3suwTc+lWPejCujpU=
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com [209.85.212.173])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a35.g.dreamhost.com (Postfix) with ESMTPSA id 1DBFB54058
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 12:22:22 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id f8so1906951wiw.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 12:22:20 -0700 (PDT)
X-Received: by 10.194.103.38 with SMTP id ft6mr10773674wjb.18.1406920940798;
 Fri, 01 Aug 2014 12:22:20 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Fri, 1 Aug 2014 12:22:20 -0700 (PDT)
In-Reply-To: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254653>

On Thursday, July 31, 2014, Mike Stump <mikestump@comcast.net> wrote:
>
> Cherry picking doesn=E2=80=99t work as well as it should.  I was test=
ing on git version 1.7.9.5.
>
> Put in a line in a file, call it:
>
> first version
>
> then cherry pick this into your branch. Then update on master and tra=
nsform that into:
>
> second version
>
> then, merge that branch back to master.  Death in the form of conflic=
ts.

The problem is that cherry-picked commits lack the metadata that git
merge could use to avoid this spurious conflict report.  The reflog
has the metadata in question, but there's no guarantee that that
reflog will be available where you do the merge.  (IMO this is another
reason to want branches as objects, so such ancillary information can
be recorded somewhere, but in a way that can get dropped if desired
and without changing commit hashes, but I digress.)

If you always rebase your commits on top of the upstream, then this
problem goes away.  You can't always rebase your commits on top of the
upstream though, but wherever possible it's the best course of action
for this and other reasons.

Nico
--
