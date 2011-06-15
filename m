From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 03:40:23 -0700 (PDT)
Message-ID: <m3ei2vv0nw.fsf@localhost.localdomain>
References: <4DF87B42.1020004@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 12:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWnWT-0000Ke-8S
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 12:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1FOKk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 06:40:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59085 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab1FOKk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 06:40:27 -0400
Received: by bwz15 with SMTP id 15so336540bwz.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=SCn0Al23vMrYK2W2uKwT5cSXueTz1FuplvlH5eRJZS0=;
        b=hPZor6p05hGh1YBFyfrBOSPpVak5+hGiiJxL7jmPXJ6GvDNf8PS6NyatPW7gpBtAHW
         sD8jPZB2Z3RxpkBmuO2wKhN2KAaQEztDJxjSkpygxeY9g+vTB6ffgkpNwfXg95nMh2wJ
         m40/mTxFR/fZKRExDFqunFpKTo7mtJ9Ue0q4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Pgg0Cb8ypzjqMM+chh65vyfHAlIN9RXe3Gbt24lPOTfOwhwPIPGm609RCje4r4d2nG
         aGrdZd9lx/cXnvR52qKfYgxIFUBncqOnBN0eUgF18Hlq5npmvFIi/ola2ogcesIGzFyP
         UCVcFxsi+Vn03jaxAqxSxZvpY8fkEL8ngx6ps=
Received: by 10.204.128.198 with SMTP id l6mr370916bks.19.1308134426337;
        Wed, 15 Jun 2011 03:40:26 -0700 (PDT)
Received: from localhost.localdomain (abwp5.neoplus.adsl.tpnet.pl [83.8.239.5])
        by mx.google.com with ESMTPS id ag6sm313912bkc.18.2011.06.15.03.40.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 03:40:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5FAdnRa031683;
	Wed, 15 Jun 2011 12:40:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5FAdVjQ031672;
	Wed, 15 Jun 2011 12:39:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4DF87B42.1020004@st.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175820>

viresh kumar <viresh.kumar@st.com> writes:

> I wanted to copy my complete Linux GIT repo from Linux PC to Windows. I also wanted everything
> related to remote branches too, so need to copy and clone and fetch wouldn't work.
> 
> I don't have windows on same network, so i need to copy to memory stick and then to Windows PC.
> 
> After completing copy operation on mem stick, i found something strange.
> - git branch shows correct results and is exactly same of state at Linux machine.
> - git log is also fine.
> - git status, shows me a lot of files are modified, which is not present in Linux.

That is probably because stat information is stale... or stat
information doesn't work.  Does second "git status" still show files
as modified?

> - git reset --hard also doesn't work and fails with following error.
> 
> 
> $ git reset --hard HEAD
> error: unable to create symlink arch/microblaze/boot/dts/system.dts (Operation not permitted)
> Checking out files: 100% (36696/36696), done.
> fatal: Could not reset index file to revision 'HEAD'.

Try setting `core.symlinks` to false, or just try

 $ git -c core.symlinks=false reset --hard HEAD

Notice that your repository includes symlinks.


BTW. what filesystem do you use?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
