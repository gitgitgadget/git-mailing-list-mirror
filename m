From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Sun, 25 Oct 2009 10:44:27 -0700
Message-ID: <4AE48E7B.3030204@gmail.com>
References: <0016e68fd0123a175304754694b4@google.com> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org> <200910131051.47117.trast@student.ethz.ch> <7vy6nfwssk.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de> <20091013220640.GB12603@coredump.intra.peff.net> <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de> <76718490910131805o42e8321ama85b90b7e901dc7d@mail.gmail.com> <7vfx9modqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 18:44:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N278u-0006qZ-Ry
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 18:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbZJYRo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 13:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZJYRo0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 13:44:26 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46873 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZJYRoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 13:44:25 -0400
Received: by yxe17 with SMTP id 17so9207032yxe.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=s25zuXbf9Cj+ZLmNdUroTsf57IIhU8s4HS12z2+VkNI=;
        b=neQnf+TTf5Gu6cQ46NJmEn5uNA2URPfXGIGl+uckD4iFe141QYs5bTX/fTkk0QpepF
         mtP0zrplhONT8hi04xwPk/i40unC0jGLBeAiKAdeAVr6B0qHuHQqAHL7GaAfkUrNcC91
         ct9JtW+QURm/6hQDbYHtjyFsdelM7xPjSChOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ORTdg5vJgFbA+tjzD2at73gHCDT3qEvFOraOdxsVzZOrRIxxaGkO09pQQGGmxmuc4X
         bTh2h5UFNbDl+1UVTcE+BsppwgDM/+bE5zjKVue/fK2wa++zwG4EZRA7oUnq/LARWmV8
         CDxDDLg3yL8suoW/pA6xRuV6b0U2ZSlLaatYk=
Received: by 10.101.176.38 with SMTP id d38mr8509355anp.12.1256492670631;
        Sun, 25 Oct 2009 10:44:30 -0700 (PDT)
Received: from ?192.168.0.4? (cpe-76-90-12-237.socal.res.rr.com [76.90.12.237])
        by mx.google.com with ESMTPS id 15sm931356yxh.40.2009.10.25.10.44.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 10:44:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vfx9modqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131226>

Junio C Hamano wrote:
  > When you do not have local "frotz" branch, and do have cloned/fetched from
> the origin that has "frotz" branch, I am actually Ok with this
> 
>     $ git checkout frotz [--]
> 
> to do an equivalent of:
> 
>     $ git checkout -t -b frotz origin/frotz
> 
> I do not have problem with this _particular_ DWIMmery.  It will not break
> people's expectations, other than "asking to check out non-existing ref
> should fail".  That expectation might be logical, but I do not think it is
> useful.

FWIW most of the people we train (and we do spend time explaining the
distinction between origin/foo and foo) still find it annoying to have
to create local branches that track branches from the cloned repo.  I
think this probably has something to do with the fact that master is
automatically checked out when you clone--people expect other upstream
branches to just 'exist' locally in a similar fashion.

I think the above suggestion is simple enough and would provide the most
bang-for-your-buck in terms of usability.
-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
