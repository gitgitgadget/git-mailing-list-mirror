From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: notes TODOs (was: Re: [PATCH 1/4] gitweb: notes feature)
Date: Fri, 5 Feb 2010 16:27:02 +0100
Message-ID: <201002051627.05182.jnareb@gmail.com>
References: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com> <201002051546.19406.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 16:35:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdQDB-0000x9-BS
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 16:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab0BEPfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 10:35:07 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34341 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab0BEPfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 10:35:05 -0500
Received: by bwz19 with SMTP id 19so1543521bwz.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fUAcvS8Gt86rQrVKDltYa/rmudgaOrUd4JYgX+ZoXCo=;
        b=oJ30T1vfFrg9VQU5wRKuAI0p+OeRiDHPcNFh9naRR7czsFPaLBkRZIBgkg05BQSqbI
         Hqn0V9QtICgk+OzfuJaHQZebgG8na1s4H0jB9MRi4iM0P4AjafS07+OxB+SVjK3J7lVk
         tkY4EZNC+0ixJFDdMjjnMg7+rdCRTlXWHgsoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dM2pUwEHWpemiaKkITh/NHHebQjM7l2gqK6xB7ycyWak4G7DqVN/BjpnK8z7g3kPs+
         oAvocvf66udBtWyfZ+z4PFStA6pdRhRQTHtpKFuaAg75c0EgnsKUsSw6qg+/A+pD8/S/
         RN674OlhAFFJamluUImuAVzCDNDozIKqc436E=
Received: by 10.102.236.3 with SMTP id j3mr1945254muh.93.1265383629714;
        Fri, 05 Feb 2010 07:27:09 -0800 (PST)
Received: from ?192.168.1.13? (abvb35.neoplus.adsl.tpnet.pl [83.8.199.35])
        by mx.google.com with ESMTPS id j6sm7816320mue.17.2010.02.05.07.27.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 07:27:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002051546.19406.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139051>

On Fri, 5 Feb 2010, Johan Herland wrote:
> On Friday 05 February 2010, Giuseppe Bilotta wrote:

> > If I may be allowed to add a suggestion to put in the list, I would
> > like to see notes attachable to named refs (branch heads in
> > particular). From a cursory reading of your patches currently in pu
> > it would seem that you explicitly prohibit this case currently.
> > However, this has many possible uses, ranging from longer branch
> > descriptions to tracking information to improve survival in case of
> > remote rebases.
> 
> Nope. There is no explicit prohibition on anything. On a fundamental 
> level, Git-notes simply maps a given SHA1 (the annotated object) to 
> another SHA1 (the object holding the annotation itself). In principle 
> you can annotate _any_ SHA1, it doesn't even have to exist as a git 
> object!

I guess that it isn't currently possible to map _path_ (here: fully 
qualified name of ref, i.e. "refs/heads/master" in example) to SHA1
rather than SHA1 to SHA1, as fan-outs assumes mapping of SHA1 (to 
object).

> 
> In fact, something like the following abomination should solve 
> your "problem" quite easily:
> 
>   git notes add $(echo "refs/heads/master" | git hash-object --stdin)
> 
> (...washing my hands...)

This actually annotates (existing or not) _blob_ object with 
"refs/heads/master" as contents (git-hash-object defaults to -t blob).

> 
> > And one last comment: how do notes behave wrt to cloning and remote
> > handling? Am I correct in my understanding that notes are
> > (presently) local only? Would it make sense to have them cloned to
> > something like the refs/notes/remotes/* namespace?
> 
> They are no more local than any other ref, except that they are
> outside the refspecs that are "usually" pushed/fetched (refs/heads/
> and refs/tags/).
> 
> 	git push <remote> refs/notes/<foo>
> 	git fetch <remote> refs/notes/<foo>[:refs/notes/<foo>]
> 	etc.
> 
> should all work as expected.

It would be nice, but I guess not possible, to have notes autofollowed 
on fetch, like tags are autofollowed...

-- 
Jakub Narebski
Poland
