From: "Bob Hiestand" <bob.hiestand@gmail.com>
Subject: Re: exporting the last N days of a repository
Date: Wed, 5 Nov 2008 13:49:31 -0600
Message-ID: <cc29171c0811051149qaf8b980s37c53cd48c481ab4@mail.gmail.com>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
	 <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
	 <cc29171c0811030855s2fb0d7a5ncdfdd6acd7c71537@mail.gmail.com>
	 <93c3eada0811041449u20e0fc74gf6a1cb420923e484@mail.gmail.com>
	 <cc29171c0811041618jfbcb293l42a19805f06803a0@mail.gmail.com>
	 <93c3eada0811041954i24a15e33tcdd89f50c162b8d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 05 20:51:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxoP2-00047Y-UI
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 20:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243AbYKETte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 14:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757542AbYKETte
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 14:49:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:23935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530AbYKETtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 14:49:32 -0500
Received: by rv-out-0506.google.com with SMTP id k40so174495rvb.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 11:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dqYAk3Oqkq0WbYJ/vj9i3JeViFgpp8gF0W02hPNwklY=;
        b=bNkInotWQD5SYwOVvuYkoFe82acTDdeXr5ydAvgDsq0TZM6spAtu1EZ8XpLmnU7d1k
         iyl+Q4Tws5qQeI0Zg1jnvQjVJnegZkWHb4zn5VHp3PADoc2gxEdAmq0pjr9ZGUn2WyGS
         zomrQhtjF5PfMmmZhDtbRL5wh/7yXhaLlTCtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YvCbo+0A5lycDdRs4l7V/SC/eyhFaXHlQEFfku6aE5KjV+K1VQ875KF8HjXJYfbTir
         YfFml+/lcCYi1FggbJ63ku4HivNr0OAWh4ESPiY8kS7+PRTGCMgkbixw5DYaHUgDyIqU
         WsyQjX87+hF8gmMRHG1a7xS0NrxhBjDYFawBM=
Received: by 10.141.4.3 with SMTP id g3mr645340rvi.284.1225914571232;
        Wed, 05 Nov 2008 11:49:31 -0800 (PST)
Received: by 10.114.123.10 with HTTP; Wed, 5 Nov 2008 11:49:31 -0800 (PST)
In-Reply-To: <93c3eada0811041954i24a15e33tcdd89f50c162b8d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100178>

On Tue, Nov 4, 2008 at 9:54 PM, Geoff Russell
<geoffrey.russell@gmail.com> wrote:

> Thanks Bob but when I ran your version (using master@{15} instead of
> --since =...) it
> effectively dropped the recent history, not the old history. Imagine a sequence
> of 30 commits, no branches.  I want to keep, for example, 15 through
> 30 and dump 1
> to 15.  So I need to have the working directory as at commit 15 and
> then all the changes
> to bring it up to 30.
>
>       ... 11--12--13--14--15 ... 28--29--30
>
>       ... Dump 1 to 15           keep 15 to 30.
>
> Your script kept 1 to 15 and dumped the rest.

I guess that's because you're using reflog syntax and pulling up a
commit that isn't on the current branch, due to rebasing, resetting,
or any such activity.  Using the reflog syntax, for the few commits I
tried, produced the desired result.

I'm not sure why you'd use reflogs, however, as I believe the
--max-age or --since parameters to rev-list seem to be more in line
with your request.  Actually, I'd be surprised if you couldn't
identify the one commit that you wanted to use and use it directly;
the rev-list was just to show an example.

Thank you,

bob
