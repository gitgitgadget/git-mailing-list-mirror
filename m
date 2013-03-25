From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 09:35:51 +0100
Message-ID: <51500C67.9040308@web.de>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 09:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK2tB-0001Gi-9c
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 09:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab3CYIfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 04:35:54 -0400
Received: from mout.web.de ([212.227.15.4]:62415 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359Ab3CYIfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 04:35:53 -0400
Received: from [192.168.178.41] ([91.3.170.222]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M57Ra-1UbJ7Z29Nu-00zLfo; Mon, 25 Mar 2013 09:35:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:20km4/+qmQAQs4HQohPWpx1iVS88aL6BbslXQn818OF
 MJ23+ntDeq4fSPb5OWatqR0IhnvJd4YFSc2EzQcUT+9nZrBiNq
 x6u4twaV2OmGlOc1dFmbfsHpe+tlseZnKl+xUUGbemmLFTdFvg
 oUbbn6oRz4Lbni3YqXi3wWoIEnpId8EoXvL0UoOd2rnYHq28Kq
 fTvVQv652WjCREvZekBqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219018>

Am 24.03.2013 18:38, schrieb Ramkumar Ramachandra:
> I find this behavior very inconsistent and annoying.  Why would I want
> to commit the submodule change immediately?  Maybe I want to batch it
> up with other changes and stage it at a later time.  Why should I have
> to unstage them manually now?  I get the other side of the argument:
> what if the user commits the .gitmodule change at a different time
> from the file change?  In other words, the user should have a way of
> saying 'submodule stage' and 'submodule unstage'.

Hmm, AFAIK you are the first to bring up such a feature, as in most
use cases doing a "git (submodule) add <path>" is expected to stage
what you added. Maybe you could teach the stage/unstage code to also
stage/unstage the corresponding part of the .gitmodules file, but
I'm not sure it is worth the hassle.

> Now, for the implementation.  Do we have existing infrastructure to
> stage a hunk non-interactively?  (The ability to select a hunk to
> stage/ unstage programmatically).  If not, it might be quite a
> non-trivial thing to write.

Have fun when adding two submodules and unstage only one of them
later. I think this feature will not work unless you analyze
.gitmodules and stage/unstage section-wise.
