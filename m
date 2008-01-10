From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] - Added recurse command to git submodule
Date: Thu, 10 Jan 2008 09:27:20 +0600
Message-ID: <7bfdc29a0801091927v4eb65a60qf5b185924b9d1e44@mail.gmail.com>
References: <1199857906-26321-1-git-send-email-imyousuf@gmail.com>
	 <7vmyrfjsw1.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580801090242g3f755814pa56e896d0a8723bb@mail.gmail.com>
	 <7vhchmhhjv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>, git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 04:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCo5H-00080d-9N
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 04:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbYAJD1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 22:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbYAJD1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 22:27:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:8069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbYAJD1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 22:27:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so510910fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jmfQ7iZXc6aWClFdJIDdBa2XilCwFQi/izY06l04fOo=;
        b=aV1WBiDt5gC+XP2KCT0I81s2TmS8ezf/8cPG8vHusYo4yjyTNAprB6GnUaMvI7uBP3ZYCwG2vDaCDG0EZmT/UMhYERSwKZkQkjzU29DXmYKPvCrAZz7LCYgijFoJzuYSoZf6LZG3XLcxaRLypr5+OsolhpMAkvwcqKMT+tyB2MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lX+945CIpLVGYKvxDRglUNI310e+OPjQjPxVuj/XjsIMQYEpswd4d93th6IZjdByAdt7d8JXgPfnK6F3K/PUVKtIqmTwQxqpZEo/PM4C+ERrVom1kPC+i601g7VMCnR7/3nV/DcYWYKlpl0KeZ+mrMdayyDZCNugIh0bE2Rnx3g=
Received: by 10.78.167.12 with SMTP id p12mr1678791hue.20.1199935640494;
        Wed, 09 Jan 2008 19:27:20 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 19:27:20 -0800 (PST)
In-Reply-To: <7vhchmhhjv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70036>

On Jan 10, 2008 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > A possible extension is to specifiy "inter-submodule" paths to the
> > init subcommand, i.e. for a possible KDE layout:
> >   git submodule -r init kdelibs kdelibs/admin
> >
> > This should then recursively initialize the kdelibs submodule and the
> > admin-submodule (in the kdelibs submodule).
>
> Beautiful.

Firstly, thank you for the feedback Junio and Lars. Secondly, I was
not planning to add recurse to the init/update command, but your
(Lars) suggestion seems really handy; I will implement it in my patch.
About auto-initialization, I, as writing, am implementing it to be
optional and an extra -i has to be specified if the user wants to do
it.

>
> > Btw: from my reading of the code, the git-command specified for
> > 'recurse' will be done top-to-bottom: I guess that's what you want for
> > something like 'git submodule recurse diff', but not for something
> > like 'git submodule recurse commit' (but IMHO the latter one should
> > never be executed ;-)
>
> Thanks for raising a very good point.  Yes, some commands
> inherently wants depth first.
>

I could not agree more and in fact, I wanted to leave to the user how
they use the recurse command. I basically will be using for status and
diff primarily; and may be for creating and checking out branches; but
as I said it mostly depends on how the user wants to use it.

> While I agree that making a recursive is a grave usage error
> (submodule commit and toplevel commit are logically different
> events and even their commit log message should be different, as
> they talk about changes in logically different levels) from
> project management point of view, I do not think it is something
> a tool has to explicitly forbid the users to do.  I view it as a
> kind of a long rope, a misuse the users can be allowed to
> inflict on themselves if they really wanted to.
>

In fact if I am also thinking whether to add intelligence in such
scenarios. What do you think if we choose DF of BF based on the
command and options?

> Also, some commands cannot be made recursive by driving them
> from a higher level recursive wrapper.  "git submodule recursive
> log" would not make much sense, not only because the order of
> the log entries are output from different invocations would not
> be useful, but because the revision range specifier would need
> to be different in different submodules (e.g. library submodules
> and application submodule will not share version name namespace,
> i.e. "log v1.0..v2.0" is undefined, and worse yet, running "log
> v1.0:path/to/sub..v2.0:path/to/sub" in a submodule when running
> "log v1.0..v2.0" in the toplevel is not a correct solution
> either in general).
>

What is you suggestion in such cases Junio?

>

-- 
Imran M Yousuf
