From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn metadata commands performance issue
Date: Thu, 15 Jan 2015 12:53:38 +0100
Message-ID: <87sifcdzul.fsf@fencepost.gnu.org>
References: <CAKdxknyCQf6HpnTZ8BMVVpEX3vcVEoTo5BmpqrkgFuxV+k7wmw@mail.gmail.com>
	<20150114203012.GA26023@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Niluge kiwi <kiwiiii@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 12:54:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBj06-0001Zb-5P
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 12:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbbAOLyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 06:54:05 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:42881 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbAOLyD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 06:54:03 -0500
Received: from localhost ([127.0.0.1]:41920 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YBizv-00069b-Uj; Thu, 15 Jan 2015 06:54:00 -0500
Received: by lola (Postfix, from userid 1000)
	id 688F4E048C; Thu, 15 Jan 2015 12:53:38 +0100 (CET)
In-Reply-To: <20150114203012.GA26023@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 14 Jan 2015 20:30:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262477>

Eric Wong <normalperson@yhbt.net> writes:

> How big is the parent process which forks the git commands?  On Linux at
> least, fork() performance is negatively impacted by parent process
> memory size.

Huh.  I thought with the advent of demand-paging, at the very least with
copy-on-write, this was supposed to be sort of a non-issue.

The old original UNIX version, in contrast, consisted of swapping out
the current process without removing the in-memory copy.  But since the
in-memory copy then did the exec call and since usually the exec call
was happy about every page of free memory (we _are_ talking about
something like 64kB of total available memory here), that tended to work
reasonably well.

-- 
David Kastrup
