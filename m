From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 10:29:56 -0700
Message-ID: <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Namit Bhalla <namitbhalla@yahoo.com>, Dave <dag@cray.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCE7-0003VS-5H
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab2DQR36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 13:29:58 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48771 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2DQR35 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 13:29:57 -0400
Received: by yhmm54 with SMTP id m54so3203001yhm.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gn0G3ixAf0M62kjMZojMHdyhL2ejF6eYW1T+oYq9ZbM=;
        b=XT0OQr6K/ReOYB7EWRz/LZlC2VBYFcidCIVx5A1RGbCxu7MDhNcVSCy8mVupXi+0X8
         4VCpWxoiUJbF3AElyUvHIs4NV6stfqbpXwZT72brgqx45Y9HO5onznEKcqqqp9itQ3Jw
         eJ0gOBxs2UnSBa3Isf8DKLFh+G1LhIH4+6UFLIXWI0usAjW8p+mJegumraroi0PnEdRZ
         7MARyR5CC/ylV8GosyPaAiEC47lE48xHwcvSDXQGwL8IswhMvZ0zsSYqI9IDz87toLoO
         rrEnOX57ZQiInGd8Qg2hs6C56R+6A4VX4tYL70ON0AjReov/Yg3M5UgZjAXJDUhhxXqu
         zq9w==
Received: by 10.236.73.195 with SMTP id v43mr16085395yhd.78.1334683796430;
 Tue, 17 Apr 2012 10:29:56 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 17 Apr 2012 10:29:56 -0700 (PDT)
In-Reply-To: <nng3983phhc.fsf@transit.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195772>

On 16 April 2012 13:08,  <dag@cray.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Put reusable library in its own repository, and use submodules to li=
nk
>> it up to project-a and project-b repositories.
>
> git-subtree is another option. =C2=A0It was recently merged into cont=
rib/.
> Whether to use submodules or subtrees largely depends on the work sty=
le
> of your group and how coupled the projects are to each other.
> submodules requires a bit more day-to-day maintenance by the user (in=
 my
> experience) while with subtrees it's a bit more involved to push chan=
ges
> from the combined repository back to the separate repositories.

(My reply below is based on my experience with Git and submodules from
about a year ago. I would really like to see better support for
including separate repos in Git. It does not appear to be an easy nut
to crack, though.)

If you really have only one or two libraries then submodules will work
just fine but if you have quite a few (we had around 50 when we moved
away from submodules) you will find it pretty much unworkable. It's
fragile and hard to keep the submodules in synch with each other and
the umbrella project. Another problem is branches. Branches are per
submodule but you want them for all submodules. You might want to look
into git-slave if you want to go this route. I haven't used
git-subtree so I can't comment on that. (I do not get the impression
that it really is a big step forward, though. I would be *very* happy
to be proven wrong, though.)

In general, I do not think the blanket statement "one repo per
project" is good advice. If projects depend on each other they should
be in the same repo. At least with the current support in GIt for
including separate projects. Please note that I'm not disagreeing with
the notion "one repo per project" itself. It's just not supported well
enough to be feasible if you have a fairly large group of projects
that depend on each other.
