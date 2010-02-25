From: =?ISO-8859-1?Q?Fabian_K=F6ssel?= <mok4sin@googlemail.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Thu, 25 Feb 2010 11:58:52 +0100
Message-ID: <4B8657EC.8060302@googlemail.com>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain> <alpine.LFD.2.00.1002220830550.4141@localhost.localdomain> <7v7hq46gwe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 11:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkbQd-00067S-DL
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 11:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab0BYK6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 05:58:42 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:50258 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0BYK6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 05:58:41 -0500
Received: by bwz1 with SMTP id 1so2694210bwz.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3yccpzCTE4s/MxIUS7ne9GAOkfaU9ZKSXgpIi6/0gEI=;
        b=KYUaK2NxRQiOPJDrUF21LT+g+ah03Fv4QwQHH7E9B6Wg6jsS3FffkOL8J+bLczS+AH
         gW5UUnqtOenlZW2V6kj9a2to12F8LSVJLQIXaqNxOs86O/K96p4xZcSs++P8urBivtxG
         eD7ukUez7WcrPFHRvkX07D141aJR57fqAEYQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=rpjIBQDB43wVLM6X8FewsLb2I+7tcK6KLMemKZO+PEFqUCK/JmS/Qa2oGmsE6QNQMx
         I1nuj0wIsvV+YfI3B1QwMt9b6N9I/4mXd25uMflgRwiez7EYll0GdzTT4U/d3RDpqtaB
         E+P62WZqefQn9XOrge1h02ehDH/xMMKA8ARz0=
Received: by 10.204.34.195 with SMTP id m3mr593783bkd.190.1267095520141;
        Thu, 25 Feb 2010 02:58:40 -0800 (PST)
Received: from ?192.168.2.105? (dslb-088-065-142-140.pools.arcor-ip.net [88.65.142.140])
        by mx.google.com with ESMTPS id 13sm3390522bwz.7.2010.02.25.02.58.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 02:58:39 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20091001 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <7v7hq46gwe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141044>

On 22.02.2010 23:32, Junio C Hamano wrote:
> I'll queue with a trivial addition of "rm builtin/*.o" to the "make
clean"
> target.  I am not looking forward to merging the result of this with
other
> topics, though... X-<.

Just out of curiosity, how do you actually merge such a relatively big
rename with other branches?

I haven't found a pleasant way yet to merge rename+modification in one
branch and modification on an old path in another branch.


There is git file-merge theirs base ours . But it only seems to take
filenames and no git object specifications. It would be very handy if
something like

git file-merge bfile HEAD^:afile afile

would be possible.


For clearification, here an example


echo "First line" > afile

git add .
git commit -m "First commit in master"

git checkout -b mybranch

echo "Second line in mybranch" >> afile
git mv afile bfile

git commit -a -m "Change and rename in mybranch"

git checkout master

echo "Changed first line in master" > afile

git commit -a -m "changed afile"

git merge mybranch


Regards

Fabian
