From: "Kevin Williams" <kevwil@gmail.com>
Subject: Re: git-p4 and changing p4 depot path
Date: Fri, 5 Sep 2008 12:54:34 -0600
Message-ID: <683a886f0809051154r4b8a8121j7e0b7694ad728661@mail.gmail.com>
References: <683a886f0809050947k3b461495u459607dccf891698@mail.gmail.com>
	 <1a6be5fa0809051104g59e08b2dya37add721483d390@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tor Arvid Lund" <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 20:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbgT8-0000MG-5q
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 20:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbYIESyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 14:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYIESyg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 14:54:36 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:55450 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbYIESyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 14:54:36 -0400
Received: by ey-out-2122.google.com with SMTP id 6so238023eyi.37
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G4Flwo1NTvxD9QGaPHnmxmC9YprW4uwPyFCSx4um4CA=;
        b=ezRPL/omCGmBIGQqJvQ3L4YNstHhiEAkthxLdLZFc7ph9jcsnSU3YXibfXf3rS+Q0r
         p508CdRNZjLsUsg04A5Qmq9aQ2tm3Ijh+k7wyMsqKEODY5+82JlniMhZqrJvYmDIBUvw
         VZUwlQMzr0Q5/G8uyM5263VNGZ7ee1mDPA2O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qpzMqsxn9ulOB79L+/1s6rD0jjCesaD6EWsfE6mJgjrThajmcaUDncNqRGgJAViTgM
         iRiAYLQOtelJxfe5CXEulmAaeIhCfk4raK3tn7pgzmmjJybMqSokavnSHd4gCh7+s7gq
         66azp84Y0rDJdPDS60Djm96zxW6BjjJhQqVls=
Received: by 10.210.68.17 with SMTP id q17mr8097528eba.134.1220640874441;
        Fri, 05 Sep 2008 11:54:34 -0700 (PDT)
Received: by 10.210.73.11 with HTTP; Fri, 5 Sep 2008 11:54:34 -0700 (PDT)
In-Reply-To: <1a6be5fa0809051104g59e08b2dya37add721483d390@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95031>

Thanks for the detailed explanation. That will definitely come in
handy next time.

I was working against one path, then was told to commit to a p4 branch location.

I ended up copying my files in the git-p4 working dir over to the p4
working dir and committing from there, so not a problem anymore, but
I'm impressed that there's a way to do it right from git-p4.

Now if I could just convince IT to switch to git .... :)

On Fri, Sep 5, 2008 at 12:04 PM, Tor Arvid Lund <torarvid@gmail.com> wrote:
> Hi,
>
> On Fri, Sep 5, 2008 at 6:47 PM, Kevin Williams <kevwil@gmail.com> wrote:
>> I've got some code I've been working on in a local git repository that
>> I cloned from Perforce using git-p4. Now, I need to commit my changes
>> to a *different depot path* within Perforce. Since the p4 depot path
>> is stored in the logs rather than config, and logs are immutable
>> because commits are immutable, it seems I cannot do this. Is there any
>> way to do this? Why isn't the depot path stored in config? Please
>> help!
>
> I'm not sure I understand why you want to commit to a different
> path... Is is just another branch in p4?
>
> In that case, git-p4 already has some support for working with all
> branches of a project, given that they all reside under a common path,
> like:
>
> //depot/path/to/project/MAIN
> //depot/path/to/project/REL_1_4
>
> ... where MAIN and REL_1_4 are branches of 'project'. This can be
> cloned by invoking
>
> git p4 clone --detect-branches //depot/path/to/project@all
>
> When you are ready to push your git commits to p4, git-p4 will use the
> log message of the nearest parent commit from p4 to determine which
> depot path (branch) to use. In this way, you can commit your work to
> different p4 branches.
>
> -Tor Arvid Lund-
>



-- 
Cheers,

Kevin Williams
http://kevwil.com/
