From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Stash during incomplete merge
Date: Tue, 28 Feb 2012 16:24:08 -0600
Message-ID: <4F4D5408.3060505@gmail.com>
References: <4F4A7BC7.5010702@cisco.com> <4F4D377B.2000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Feb 28 23:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2VT1-0007im-R2
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 23:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100Ab2B1WYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 17:24:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64872 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab2B1WYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 17:24:07 -0500
Received: by ggnh1 with SMTP id h1so2872790ggn.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 14:24:06 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.101.20.1 as permitted sender) client-ip=10.101.20.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.101.20.1 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.101.20.1])
        by 10.101.20.1 with SMTP id x1mr8947135ani.36.1330467846304 (num_hops = 1);
        Tue, 28 Feb 2012 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=lhcF5KFcywf/whldal5BZGiIWU2qT/8OGpB5IgEn7rw=;
        b=hz06/AFkd1vge9P4pWYmZoaw1xTiHkI/EyzL//zUxBt3Rp6+r0V6k7qJ+PWqdOUov1
         nQ4qtzIWB97zCOvwbstwV8e9gy1QGzu3Aue947cQ/oNYFOR496eYNL4i/U/0gWTGwQ3q
         M8bJ4vNTfwLJ2MTmMAeUwuz9MJioGxvid6m3w=
Received: by 10.101.20.1 with SMTP id x1mr6768001ani.36.1330467846257;
        Tue, 28 Feb 2012 14:24:06 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 32sm31086420anu.14.2012.02.28.14.24.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 14:24:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F4D377B.2000206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191787>

On 2/28/2012 2:22 PM, Neal Kreitzinger wrote:
>
> You may also want to consider the --keep-index option on your "git
> stash save" if your "testing" workflow doesn't involve adds or
> commits before the git stash apply/pop.
>
the very limited case I had in mind (and probably incorrect assumption)
about your "testing" workflow was:

hack merge-conflicts
$ git add conflict-resolution  (conflict-resolution is in worktree and
index)
hack conflict-resolution with extra stuff (original conflict-resolution
is still in index)
uh-oh, i got carried away and started doing extra stuff (evil merge) and
forgot to finish testing just the conflict-resolutions (pure merge-commit)
$ git stash --keep-index (conflict-resolution is still in index and now
back in wokrtree)
finish testing just the conflict-resolutions (merge-commit-to-be)
(conflict resolutions worked (I knew they would))
$ git stash pop (original conflict resolution is still in index, but
extra-stuff is back in worktree)
$ git commit (commit the conflict-resolutions/merge-commit)
$ git add foo
$ git commit (new foo stuff committed after merge commit)

v/r,
neal
