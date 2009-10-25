From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Sun, 25 Oct 2009 10:48:56 -0700
Message-ID: <4AE48F88.1030108@gmail.com>
References: <0016e68fd0123a175304754694b4@google.com> <200910122340.13366.trast@student.ethz.ch> <7vr5t89qiw.fsf@alter.siamese.dyndns.org> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910131358000.32515@iabervon.org> <7vljjfuibr.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910131654270.32515@iabervon.org> <20091013215751.GA12603@coredump.intra.peff.net> <7vhbu2syi6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 18:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27DG-0008WK-3f
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 18:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbZJYRs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbZJYRsz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 13:48:55 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53371 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZJYRsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 13:48:55 -0400
Received: by yxe17 with SMTP id 17so9208735yxe.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=t+RUlYxJx8fGKpGRKB2p+KwBy64egs79AmxwCYhScfg=;
        b=OMXQI9iRuS27jrySt8/NeAkOx/EnKX37K5xfvGWUjYzmQ21HDPVhJ6LbQVnH1PRWps
         id0ViBc0St4j4Zy+eznYCCAGWkxwZXLH0Ex905/qwX4r+W4uER59SxmuczWR+hc46aYj
         sf2ZiWm4MXbD3Ayu9sFml85QKfJllx/Wk7DmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QYubSmQruGrz2O1hmIBRH5t6smKiuhv3mUlL62e2hy/Ai/UpbuXNFg8yEzTSXiQdA7
         /aI+5VabvJdSFMxSME2TXfBYzUXItpC7r2WKgPhgBi8eu81l/gIngugVSiK+NiGLBbIB
         3pNtgmvciuxQO06uaRwUrZPQO2NG33mOnJZIs=
Received: by 10.101.86.7 with SMTP id o7mr383606anl.39.1256492939750;
        Sun, 25 Oct 2009 10:48:59 -0700 (PDT)
Received: from ?192.168.0.4? (cpe-76-90-12-237.socal.res.rr.com [76.90.12.237])
        by mx.google.com with ESMTPS id 7sm922650yxg.50.2009.10.25.10.48.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 10:48:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vhbu2syi6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131227>

Junio C Hamano wrote:
> In this sequence:
> 
>     1$ git checkout $commit_name_that_is_not_a_local_branch
>     2$ git commit; hack; hack; hack;...
>     3$ git checkout $branch_name
> [...]
> Step #3 is where the state built in the detached HEAD "branch" vanishes
> into lost-found.
> 
> The experts argued that #3 is where it is dangerous...

If step 3 is where the danger lies, wouldn't it then be most appropriate to put
the warning message there? I.e., warn or refuse to switch branches when
currently on a detached head containing new commits, kind of like branch -d's
cowardliness.
-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
