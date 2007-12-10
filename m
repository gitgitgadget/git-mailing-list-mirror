From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] Configurable name(s) for .gitmodules
Date: Tue, 11 Dec 2007 01:34:02 +0800
Message-ID: <46dff0320712100934o86af6femaaf563cf40295333@mail.gmail.com>
References: <46dff0320712070800j6dd83714j265b3f7b291b855c@mail.gmail.com>
	 <20071210165200.GF3490MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Sven Verdoolaege" <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 18:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1mWT-0005n7-PG
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 18:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbXLJReH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 12:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXLJReG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 12:34:06 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:26325 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752060AbXLJReF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 12:34:05 -0500
Received: by rn-out-0102.google.com with SMTP id i6so220108rng
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FUDWuiCNrCo7711RdKBGmwRCVW7IYmMpuQWfktiyk8w=;
        b=PbpgRWOLqNSSArog+1MzqnPeqvrSTzBKSfmtJU9uxbaBU+dAIbMw075vqFZcp7cEFDtwU1o12XU/0Cean5si8nfzBcAxXBUlyUSMsKkZB+eUX6eRzs1+Ad1p5Iv7ZD15jMeIYbLstM96ROygvxEqYMfctvelswVzI+9VE+pfgVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bkS1BM4J//NstYjIGgn7yX/Tyl4Cpbm/5OqCsod8fw9BbpnnBUIrzgtsqv9SoHwzBvDZOWsh5p/zfkhtAMPurN8c6X1bGi4EPjRMZ6D/DrWr0G3q6BuRPIvcbAbAY565e4sflRHL1pgEsN3+KHKAOxtXUPEWpMKmmq1N7DQbyUM=
Received: by 10.150.200.8 with SMTP id x8mr2366789ybf.1197308042544;
        Mon, 10 Dec 2007 09:34:02 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 10 Dec 2007 09:34:02 -0800 (PST)
In-Reply-To: <20071210165200.GF3490MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67740>

On Dec 11, 2007 12:52 AM, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sat, Dec 08, 2007 at 12:00:12AM +0800, Ping Yin wrote:
> > I have a super project with many submodules. Each kind of role may
> > check out different set of submodules. There are some common modules
> > which are almost checked out by every role.
> >
> > Here comes my question: how to implement this elegantly? If all
> > submodules are put in the same .gitmodules, every role has to in the
> > command line manually designate all submodules to be checked out.
>
> You could have submodules (roles in your case) containing
> other submodules, as proposed in the thread that ends in
> http://thread.gmane.org/gmane.comp.version-control.git/48643/focus=48939
>
> skimo
>

Thanks for the suggestion. Linus's idea is what i want. As linus said,
one level of indirect will give much more flexibility. It's wonderful
to put something like following to .gitmodules.
	[module "infrastructure"]
		submodule = lib
		submodule = build

	[submodule "lib"]
		url = git://xyzzy/lib-1.2.3

	[submodule "build"]
		url = git://xyzzy/build-0.61

Also I  found Lars's following reply,  i still don't understand quite
well why this idea is not accepted.

> The reason I wanted to use
>
> [path "lib"]
>   submodule=xyzzylib
>   url=git://xyzzy/lib-1.2.3
>
> is that the git-submodule command always starts out with the submodule
> path, trying to map that to an url or a submodule name. My proposal
> allows
>
>   $ name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
>   $ url=$(GIT_CONFIG=.gitmodules git-config path."$path".url)
>


-- 
Ping Yin
