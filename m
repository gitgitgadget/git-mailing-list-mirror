From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding list of p4 jobs to git commit message
Date: Fri, 15 Apr 2016 13:27:16 -0700
Message-ID: <xmqq4mb2bot7.fsf@gitster.mtv.corp.google.com>
References: <010201541b7a24b8-83b0f526-2f01-40e3-afc8-d81549af70d4-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:27:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arAKx-00042r-34
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbcDOU1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:27:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbcDOU1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:27:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 50FB113250;
	Fri, 15 Apr 2016 16:27:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j3TqzCNwVAiizcnGypLTxhPRcqo=; b=gwQQUT
	aSIXS/PiG6XArhZHJ+qHFLf8CrfywdPoCcrJYijjnPCoeWI5vXzjAm40zdEcNmFS
	fM8OpMl4U7ktVEZts/bOZ9P2C3JAurRYv/q06tYIw8vt4rv78dhZ7hS5HC2oyGg4
	rVRmAUaxYXUzlySdQq5XwRx3ng0U/UetJWt2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hjXXOSDwLErK7oww1Bs3eJh/dP/tB85m
	TJhq02PwTMQVuh5IPh3ppP28lIdpDjmIOUXgku0AxLC3VUeiTitYdPU5csfNvYL9
	Stgg8xX3VVjMz8EMszoWUdrERFoPYZ/8Vx+du7FpnHBnRiL72n38tNla4Ks/eXk9
	4e3tJMQRt3E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48FD41324F;
	Fri, 15 Apr 2016 16:27:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B103C1324E;
	Fri, 15 Apr 2016 16:27:17 -0400 (EDT)
In-Reply-To: <010201541b7a24b8-83b0f526-2f01-40e3-afc8-d81549af70d4-000000@eu-west-1.amazonses.com>
	(Jan Durovec's message of "Fri, 15 Apr 2016 19:51:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72A64D0C-0348-11E6-BF5C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291656>

Jan Durovec <jan.durovec@gmail.com> writes:

> ---

A few issues.  Please:

 (1) Sign-off your work.

 (2) Try to find those who are familiar with the area and Cc them.

     "git shortlog -s -n --since=18.months --no-merges git-p4.py"
     may help.

 (3) Follow the style of existing commits when giving a title to
     your patch.

     "git shortlog --since=18.months --no-merges git-p4.py" may
     help you notice "git-p4: do this thing" is the common way to
     title "git p4" patches.

 (4) Justify why your change is a good thing in your log message.
     What you did, i.e. "list p4 jobs when making a commit", can be
     seen by the patch, but readers cannot guess why you thought it
     is a good idea to extract "job%d" out of the P4 commit and to
     record them in the resulting Git commit, unless you explain
     things like:

     - what goes wrong if you don't?
     - when would "job%d" appear in P4 commit?
     - is it sane to assume "job0", "job1",... appear consecutively?

 (5) Describe what your change does clearly.  "Adding list" is not
     quite clear.  Where in the "git commit message" are you adding
     the list, and why is that location in the message the most
     appropriate place to add it?

Thanks.

>  git-p4.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 527d44b..a81795f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2320,6 +2320,15 @@ def extractFilesFromCommit(self, commit):
>              fnum = fnum + 1
>          return files
>  
> +    def extractJobsFromCommit(self, commit):
> +        jobs = []
> +        jnum = 0
> +        while commit.has_key("job%s" % jnum):
> +            job = commit["job%s" % jnum]
> +            jobs.append(job)
> +            jnum = jnum + 1
> +        return jobs
> +
>      def stripRepoPath(self, path, prefixes):
>          """When streaming files, this is called to map a p4 depot path
>             to where it should go in git.  The prefixes are either
> @@ -2665,6 +2674,7 @@ def hasBranchPrefix(self, path):
>      def commit(self, details, files, branch, parent = ""):
>          epoch = details["time"]
>          author = details["user"]
> +        jobs = self.extractJobsFromCommit(details)
>  
>          if self.verbose:
>              print('commit into {0}'.format(branch))
> @@ -2696,6 +2706,8 @@ def commit(self, details, files, branch, parent = ""):
>                               (','.join(self.branchPrefixes), details["change"]))
>          if len(details['options']) > 0:
>              self.gitStream.write(": options = %s" % details['options'])
> +        if len(jobs) > 0:
> +            self.gitStream.write(": jobs = %s" % (','.join(jobs)))
>          self.gitStream.write("]\nEOT\n\n")
>  
>          if len(parent) > 0:
>
> --
> https://github.com/git/git/pull/225
