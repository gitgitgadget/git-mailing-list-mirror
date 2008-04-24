From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Cleaning the .git directory with gc
Date: Thu, 24 Apr 2008 01:32:20 +0100
Message-ID: <e1dab3980804231732x29d6d73cudd0568a910642639@mail.gmail.com>
References: <20080423231359.GA30913@fox>
	 <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Haakon Riiser" <haakon.riiser@fys.uio.no>, git@vger.kernel.org
To: "Russ Dill" <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 02:33:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JopOk-00038A-Bu
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 02:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbYDXAcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 20:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYDXAcZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 20:32:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:56657 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbYDXAcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 20:32:24 -0400
Received: by wa-out-1112.google.com with SMTP id m16so5002411waf.23
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 17:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QJZj+cgbQFrsNIVzh1pR6O+Zy4MQVQWq0UqpL2AwwWI=;
        b=rZJ91xQm5aJP7pL9ioU94e4geAQVFAW5KztgYq7/dQ/uwj1+fqMp+WQIihJNjDl5gaol8UgJU43H13zxqpDgoKOy4YycO6Sj1pJxbXrGb3ZxfysDh/twxV+tzyteym/uIabSTf832Jwh0vYmlsUrt4mUPodRUZgrz4ZcvIvhTfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j2tHKDiBtCQxImSHPOTSZ4m7rMTIIY9dPXpLZhunjxeLG1j1rKli+fBqLkQYulbv5sY6Hgpmbl5JnQ7Kvr0A1d8hfPql3UStsQkmiUpruHqEGg+9Fm3Q3YUVi6WiDzKPLSee0rIqIZ00sI60fHYGZQDOn4RGgFrnHwUPlxYshW4=
Received: by 10.115.75.1 with SMTP id c1mr1145531wal.84.1208997140245;
        Wed, 23 Apr 2008 17:32:20 -0700 (PDT)
Received: by 10.114.202.17 with HTTP; Wed, 23 Apr 2008 17:32:20 -0700 (PDT)
In-Reply-To: <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80275>

On Thu, Apr 24, 2008 at 1:09 AM, Russ Dill <russ.dill@gmail.com> wrote:
> On Wed, Apr 23, 2008 at 4:13 PM, Haakon Riiser <haakon.riiser@fys.uio.no> wrote:
>  > I've recently started using git, and while experimenting with
>  >  git commit --amend, I noticed that git gc does not do what I
>  >  expected.  Example:
>
>  Thats a lot of work without first reading the man page:
>
>        --prune
[snip]

There's a relatively recent change in this area. Git keeps stuff
that's apparently unattached for a period of, by default, 2 weeks
(determined by gc.pruneexpire variable) after which a git gc will
remove it. The reasoning is that even with the careful design of the
git updating strategy there are rare times when with a concurrent
other git process there are files in the repo that look unattached but
will become attached as the other process completes. Files kept this
way aren't propagated by clones or pulls so they're essentially
invisible to everything else. If you're sure you can force removal
with

git prune --expire now

AFAICS there's no way to call "git gc --prune" with an --expire option
so you've got to use the "git prune" command.

HTH

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
