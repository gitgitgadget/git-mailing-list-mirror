From: Kris Shannon <kris@shannon.id.au>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Tue, 31 Mar 2009 15:20:20 +1100
Message-ID: <e51f4f550903302120s62f6056bg95f7a5aca4ec3d@mail.gmail.com>
References: <200903301024.08848.brian.foster@innova-card.com>
	 <49D09207.9080407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 06:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoVU5-0000bA-MG
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 06:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbZCaEUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 00:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZCaEUX
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 00:20:23 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:34892 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZCaEUW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 00:20:22 -0400
Received: by gxk4 with SMTP id 4so5105392gxk.13
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 21:20:20 -0700 (PDT)
Received: by 10.150.227.9 with SMTP id z9mr11486913ybg.218.1238473220175; Mon, 
	30 Mar 2009 21:20:20 -0700 (PDT)
In-Reply-To: <49D09207.9080407@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115207>

2009/3/30 Andreas Ericsson <ae@op5.se>
>
> Brian Foster wrote:
>>
>> =C2=A0Whilst this question involves linux(-mips) kernel tree,
>> =C2=A0it's a git(-related?) question, not a kernel question ....
>>
=2E..
>> =C2=A0But (using 2.6.21-stable and 2.6.22-stable as proxies),
>> =C2=A0tests indicate that going from .26.8 to .27 or anything
>> =C2=A0later will have numerous conflicts (100s? in more than
>> =C2=A030 files). =C2=A0Thinking about it, this isn't too surprising
>> =C2=A0since the -stable branches cherry-pick important/benign
>> =C2=A0fixes from later revisions.
>>
>> =C2=A0What's frustrating is that in essentially all =E2=80=9Cconflic=
t=E2=80=9D
>> =C2=A0cases, the resolution is simple: =C2=A0Use the later version.
>
> The trouble is "essentially all", as opposed to "all". Git
> can never know which of the conflicts are which, so it will
> leave it all up to you.

git mailing list <git@vger.kernel.org>

What you could do is something like:

git checkout -b mystable-27 linux-2.6.27-stable
git merge -s ours linux-2.6.26-stable
git checkout local-changes-26
git merge mystable-27

The extra merge might allow git to distinguish between 26->27
conflicts and conflicts due to your local-changes.

BTW, when doing these merges between release branches you
probably want to increase merge.renamelimit.
