From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: The shared Git repo used by git-new-workdir
Date: Mon, 16 Jan 2012 19:09:05 +0100
Message-ID: <4F1467C1.504@ira.uka.de>
References: <CAE1pOi3fBUBeNuhJqtJhxuMfz2G3iYOJy7U2HX6Nv4kqjcbnhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmqzV-0004U5-AN
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 19:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab2APSJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 13:09:03 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37690 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755736Ab2APSJC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 13:09:02 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RmqzH-0005EH-7K; Mon, 16 Jan 2012 19:09:00 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RmqzH-0007HA-2i; Mon, 16 Jan 2012 19:08:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CAE1pOi3fBUBeNuhJqtJhxuMfz2G3iYOJy7U2HX6Nv4kqjcbnhw@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1326737340.264960000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188637>

On 14.01.2012 21:59, Hilco Wijbenga wrote:
> Hi all,
>
> First off, I use git-new-workdir a lot and it's working great. Kudos
> to its developers!
>
> I have been looking at the Git clone that is at the root of
> git-new-workdir (i.e. the repository that is reused by all my
> git-new-workdir created directories). This repo shows a lot of
> activity when I run "git status" there.
>
> So now I'm wondering. Should I simply ignore this completely? Or is
> there some "clean up" I can do so that "git status" shows nothing? Or
> would I destroy my git-new-workdir directories doing that? So far I've
> only used this repo to create branches (i.e. to run git-new-workdir).
>
> I would like to understand a bit better how I should treat this repo.
> Whether it's basically a "do-not-touch" environment or whether I can
> safely treat it as a normal Git repo.

Take a look at the rather simple script git-new-workdir (everything 
important happens in the last 20 lines). It just makes logical links to 
all files (mostly directories) under .git except three files that relate 
to the index (mainly the index file itself and HEAD)

That would suggest that normal git operations operating on files in 
those directories happen identical whether you are in the root repo or 
in any of the satellites. Only where the whole repo is acted upon (git 
clone, cp/rsync or deletion of the whole repo) the root repo would be 
"special".
