From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] tagger id
Date: Thu, 14 Jul 2005 18:46:16 -0600
Message-ID: <m1zmsoyjzb.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
	<m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
	<m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
	<7veka48lcw.fsf@assigned-by-dhcp.cox.net>
	<m14qb012x4.fsf@ebiederm.dsl.xmission.com>
	<loom.20050712T230013-978@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 02:46:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtELb-0001fK-PA
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVGOAq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVGOAq2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:46:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5565 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262944AbVGOAq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:46:27 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F0kHac020365;
	Thu, 14 Jul 2005 18:46:17 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F0kHA8020364;
	Thu, 14 Jul 2005 18:46:17 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@twinsun.com>
In-Reply-To: <loom.20050712T230013-978@post.gmane.org> (Junio C. Hamano's
 message of "Tue, 12 Jul 2005 21:16:52 +0000 (UTC)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@twinsun.com> writes:

> Eric W. Biederman <ebiederm <at> xmission.com> writes:
>
>
>> Part of the request was to put all of this information together
>> in a common place.  And note that it is actually:
>> tagger="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE"
>> Where the date is a human unreadable string of the number of seconds
>> since the epoch (aka 1 Jan 1970 UTC).
>
> This may sound whacy, but how about having git-env command that
>
>  (1) parrots GIT_* environment variables if the user has one; or
>  (2) shows the values of environment variables the user _could_ have had
>      to cause the program to behave the same way, when it the user does
>      not have them?

I like the general idea.  But I hate the code implications for
echoing environmental variables that git cares about.  Especially
since we really don't care about the environmental variables.  Instead
we are doing this because we are doing things that the are best
not done in shell.

So I have made the program git-var [ -l | <variable name ]

Without the implicit tying we can just export those values
that we find interesting. -l will list all of the variables
and their values like env, while specifying an single variable
will just read that variables value.

Eric
