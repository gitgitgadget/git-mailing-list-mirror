From: Eugene Sajine <euguess@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 15:10:40 -0500
Message-ID: <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
	<7v8w07rje3.fsf@alter.siamese.dyndns.org>
	<AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
	<AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
	<20101203175212.GA8267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObxv-0005xn-9U
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab0LCUKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:10:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44341 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0LCUKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:10:41 -0500
Received: by bwz15 with SMTP id 15so8698573bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=OxWMB2iTyHpmM1XRIkk1BzRWowgGEtqRgvVYM4nlwk4=;
        b=tyvTASW40dI1TfGiAx+x4Us2yi2FN6hX+d27MZnPs48MKvnBG3p4kF0iNKaQFuP6CC
         3+HReKt3LeAXvR91853MPqdKS38ONltr8vmsstw8gWPtzwTpQ6BCH2KjFsDuOUI+MWpT
         QtIfCrvmDcjxZb3eUQfJs1C2W1LmPMnQq0Ytw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=e+jhZ9Dx21nnLgmQgEEolBsVKiKSfgSm43d9XKhp52jV222qMdIIIwS/muHp8N0d5b
         MzI5oyWJ9Qd7oBf6cQZE4dH49EX8f+TN/hWtFZ1XQZ9B3Ac3dx3SO0KvgQxv9TkxjXF2
         g0288rxWb/6NlOSAxcYxWZ57PWEm8rKnJ83+I=
Received: by 10.204.71.65 with SMTP id g1mr3126473bkj.23.1291407040126; Fri,
 03 Dec 2010 12:10:40 -0800 (PST)
Received: by 10.204.80.131 with HTTP; Fri, 3 Dec 2010 12:10:40 -0800 (PST)
In-Reply-To: <20101203175212.GA8267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162842>

On Fri, Dec 3, 2010 at 12:52 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 03, 2010 at 12:41:52PM -0500, Eugene Sajine wrote:
>
>> > yes. I do see it with your command.
>> >
>> > git ls-tree -r HEAD | grep <resulting SHA1 from git hash-object>
>> >
>> > Thanks,
>> > Eugene
>> >
>>
>> While I'm able to see that object using the command Junio has provided
>> the question remains the same:
>> How could the file get into the state where its hash (git has-object
>> file-name) cannot be found in any commit (git log --raw --no-abbrev |
>> grep SHA1), if there was no local changes made to the file???
>
> If the blob was created as the resolution of a merge conflict, I don't
> think that will appear in the output of "git log --raw".
>
> -Peff
>

Yes this does make sense to me. Although it is not necessary to have
conflicts during the merge - recursive merge as i understand also can
create new blobs.
Now as this is pretty much clear: don't you think that the information
about one blob content changed during the merge should be present in
the merge commit info?
It seems strange that git log <filename> contains merge commit, but
git whatchanged <filename> doesn't show the merge commit, while this
merge commit actually had a change of content in the file,  and
finally "git log --raw <filename>" does list the merge commit but is
not showing that particular blob had a change and now has a new SHA1?

IMHO everytime there is a change in the content this change should be
logged properly.

Thanks,
Eugene
