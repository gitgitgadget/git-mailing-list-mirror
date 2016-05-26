From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4 2/2] rev-parse: fix some options when executed from
 subpath of main tree
Date: Thu, 26 May 2016 22:26:11 +0900
Message-ID: <20160526132611.GA2736@glandium.org>
References: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
 <1464261556-89722-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	szeder@ira.uka.de, sunshine@sunshineco.com
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 15:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5vIw-0004Qd-0B
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbcEZN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 09:26:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33858 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbcEZN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:26:21 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b5vIh-0000pg-9T; Thu, 26 May 2016 22:26:11 +0900
Content-Disposition: inline
In-Reply-To: <1464261556-89722-3-git-send-email-rappazzo@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295652>

On Thu, May 26, 2016 at 07:19:16AM -0400, Michael Rappazzo wrote:
> Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
> or `--shared-index-path` from the root of the main worktree results in
> a relative path to the git dir.
> 
> When executed from a subdirectory of the main tree, it can incorrectly
> return a path which starts 'sub/path/.git'.  Change this to return the
> proper relative path to the git directory.
> 
> Related tests marked to expect failure are updated to expect success

As mentioned previously (but late in the thread), I don't get why this
one case of --git-common-dir should not return the same thing as
--git-dir, which is an absolute directory. Especially when there is
other flag telling you whether you are in the main or another worktree,
so comparing the output for --git-dir and --git-common-dir is the
easiest way to do so, but then you have to normalize them on their own
because git returns different values pointing to the same directory.

Mike
