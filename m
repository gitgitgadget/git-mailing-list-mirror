From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 16:12:58 -0500
Message-ID: <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
	 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
	 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <loom.20090216T101457-231@post.gmane.org>
	 <20090216135812.GA20377@coredump.intra.peff.net>
	 <49999ED6.7010608@gmail.com>
	 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
	 <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>
	 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZAnn-0005Rh-10
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZBPVNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZBPVNA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:13:00 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:57081 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbZBPVM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:12:59 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1709042rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nkPN5Zi4VwViigT0Sr2QG3iXsG+Vul4qqqdWtZIcoQI=;
        b=a1+35HQeLRMnM2NANRw499e53kn8G96igyAK7q9veoOKtO6Wc3uR0Ok40ZiNk/+2RN
         gf0Og+YbsKWCxhLU9LWvTrGIzgsEbb1ePM4NodlQLrefO1ns7Z408YoROR7ROwjzCNCN
         eOi7VLSJpzez6g6Y38llJWhK9PLq3jLeuQReQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gq/iWU0T/tx0oIZI4lIA/SlHVOxAUZGuUsvQaTFJz6PSxpeuwpVB94nVvISnrgUfzK
         KB2PN409FNWrS9RhIB8slVUQnJz/GEyiRy098AgEMbt14neg6jdeGq7gelJPk54j/QMm
         MHNOMJ9WYjfaFWTD5Ehg2Mn9qRmciHyjlHdAI=
Received: by 10.141.36.10 with SMTP id o10mr818944rvj.59.1234818778681; Mon, 
	16 Feb 2009 13:12:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110243>

On Mon, Feb 16, 2009 at 3:02 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 16 Feb 2009, Jay Soffian wrote:
>
>> I think the right thing is *not to detach*, but rather when pushing
>> into a non-bare repo for it to go into refs/remotes.
>
> I do not think that is consistent.

Not consistent with what?

So let's say I have a workstation and a laptop. The "sane" thing to do
is probably something like this:

workstation$ mkdir project && cd project && git init
workstation$ (add, commit, ...)
workstation$ git clone --bare . ../project.git
workstation$ git remote add origin ../project.git
laptop$ git clone ssh://workstation/~/project.git project

And now I have two non-bare working repos with the intermediate bare
repo. So at both ends I can push/pull in the way that the designers of
git had in mind. :-)

But I don't think this recipe is well documented for beginners. So
they end up w/o the intermediate bare repository, and all the ensues.

IOW, I think pushing into refs/remotes makes sense in the situation
where the user has two non-bare repos that they want to exchange
commits between.

j.
