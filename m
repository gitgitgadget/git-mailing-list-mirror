From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to start well for a special git construction
Date: Fri, 19 Mar 2010 16:48:18 -0400
Message-ID: <32541b131003191348q71a922d9nf9e295cbec6716a9@mail.gmail.com>
References: <e8be804e1003181226y20328151s75641f4341ca12d8@mail.gmail.com> 
	<32541b131003181348j1e7d5dfamec09bed2c81916d8@mail.gmail.com> 
	<e8be804e1003191231h68983d75od0ef7ec5b715e19f@mail.gmail.com> 
	<32541b131003191259j1208118ayca6c79c21cae2291@mail.gmail.com> 
	<e8be804e1003191330w70d9827cr1cfc1f46a5f45a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: bruno le hyaric <bruno.lehyaric@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 21:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsj8S-0002RA-16
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 21:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0CSUta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 16:49:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37354 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0CSUt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 16:49:29 -0400
Received: by gwaa18 with SMTP id a18so147gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=vEEhDcrnTuf6jalYX/y37AEHTSmFDZ8DaG/ilU5yu3s=;
        b=mHoawzaeJydOJw4SfffdxOvrmVQ79VICPMvwVN66mkFj9X3FbtjlNOmUYVAoidCqDM
         rGUpZDIVT0/bvc6xuA/ch1Ab0kJl7jwYqz3JgO3+h+b54cYR7fRU1gJw5yeG7ktKv1qy
         /zotlE4xkMpK9JzagSGIE0KQjH88EPHtWSeT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gF3xlL1zxRh69Xy+fjTKMmm7j7sdBSf3zWtHt4CltfauBZ/QVd0hYMKIfxubm4fKg+
         0xV86qrIiggyfW3EPRx2sXqx2hXNmWeZeJjG5lWopixrgpYNHJOIek7g6ECgY8Iq4+c+
         7AAG407iMuO/iwb/G1kRw07u08UEl7jmHaH2A=
Received: by 10.151.21.18 with SMTP id y18mr2679108ybi.23.1269031718110; Fri, 
	19 Mar 2010 13:48:38 -0700 (PDT)
In-Reply-To: <e8be804e1003191330w70d9827cr1cfc1f46a5f45a2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142644>

On Fri, Mar 19, 2010 at 4:30 PM, bruno le hyaric
<bruno.lehyaric@gmail.com> wrote:
> Thanks for your help.
> I've just created my empty new branch for delivery stuff... and
> effectively the branch is empty :-D
> Any idea on how I can add executable files in this empty branch from
> the master branch? Is that possible?
> (perhaps I'm using Git in a bad way)

There are fancy things you can do to create a branch containing only a
single file without checking it out.  It's a bit advanced, but it
looks something like this:

    FILENAME=path/to/file
    BASENAME=$(basename $FILENAME)
    BLOBID=$(cat $FILENAME | git hash-object --stdin -w)
    TREEID=$(printf '100644 blob %s\t%s' $BLOBID $BASENAME | git mktree)
    COMMITID=$(echo Commit Message | git commit-tree $TREEID -p
refs/heads/release-branch)
    git update-ref refs/heads/release-branch $COMMITID

A more straightforward way to do it would be to clone your repository,
and check out the release branch in your clone, then copy the file to
it and commit as you normally would.

Have fun,

Avery
