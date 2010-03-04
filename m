From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What should "git submodule summary" give before an initial 
	commit?
Date: Thu, 4 Mar 2010 07:01:52 +0100
Message-ID: <fabb9a1e1003032201l38b052ebk4c0061e9d40f68b6@mail.gmail.com>
References: <4B8E5450.3040702@gmail.com> <7vhboxqje8.fsf@alter.siamese.dyndns.org> 
	<20100303200239.GA28904@coredump.intra.peff.net> <7vhboxno38.fsf@alter.siamese.dyndns.org> 
	<20100303204257.GA5501@coredump.intra.peff.net> <7v3a0hktga.fsf@alter.siamese.dyndns.org> 
	<7vzl2phz8e.fsf@alter.siamese.dyndns.org> <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org> 
	<4B8F00AA.5050007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Ping Yin <pkufranky@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 04 07:02:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn48Z-0001Bg-Li
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 07:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab0CDGCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 01:02:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36420 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab0CDGCN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 01:02:13 -0500
Received: by pwj8 with SMTP id 8so1438193pwj.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 22:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=gHEtKPQ+IN/1FgunXVmQjy7oVT1t5q1vwGoa/EoHPh8=;
        b=Oeyxb4/S4wH77wm40kPkdjak7Dovn2Y1IGda5MGo+fjAcULcQb3d9zIOecOPVDKS5I
         NcKVwak/GfJzFLiyu3QfmWzVvMLxqUUUohGpD6AcWY24u+KhFjliB4q5WrV9zUCjmIv1
         8BW1NiHhsTldxfAnNz3/+UYOpgtghWg29r9bM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Jyf/WGZBzOdCN/TRNW1Xyjq3sUFUNycXBaqcMYF4dWvJbpTBj5J1npqFMgLm/jgFLy
         ai+J01J2ci1D8IF7Y3Js3LoLq0ylbceTWJ9M5k71FKaWoq0SIOxIFDKzBkFOBm21YFpO
         cBCYkiT4P/YgddUyWUcGYUbZ89xac7qvuK2PM=
Received: by 10.143.26.23 with SMTP id d23mr222069wfj.84.1267682532125; Wed, 
	03 Mar 2010 22:02:12 -0800 (PST)
In-Reply-To: <4B8F00AA.5050007@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141509>

Heya,

On Thu, Mar 4, 2010 at 01:36, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> But to make "git status" with status.submodulesummary work as expected,
> i need something like the following patch on top of current pu (because
> "git submodule summary --cached HEAD" returns no changes in a freshly
> created repo):

I think the problem is deeper than that: git doesn't work that great
if there's no HEAD yet. Some of our features don't work (as expected)
if there's no HEAD. For example, 'git reset' doesn't work, of course,
I can use 'git rm --cached .' to achieve the same effect (since all
staged changes are guaranteed to be adds), but its' not quite the
same. Perhaps it's an idea to look at how we handle not having a head
across the board and deal with it at a higher level? Something like
pretending we do have a HEAD that's pointing at the empty tree when on
an unborn branch might fix 'git reset' (although I'm sure there's all
kinds of objections to actually doing that, I'm not suggesting that's
what we should do, but that's the kind of solution I think we should
look at).

-- 
Cheers,

Sverre Rabbelier
