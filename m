From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: "git merge" merges too much!
Date: Tue, 1 Dec 2009 00:17:44 +0300
Message-ID: <20091130211744.GA27278@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 22:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFDdU-0003V2-8L
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 22:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZK3VSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 16:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbZK3VSB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 16:18:01 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48023 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbZK3VSA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 16:18:00 -0500
Received: by bwz27 with SMTP id 27so2950763bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aqbqKEIbpUZ4I5xsnm+xOt7Ua9V/ygmhwRsSdPdVTSc=;
        b=BJlWmx3TO8qI4rgEzr9ndVTQXLnJCcMDIjY/iWPSTb8/Dsp9JS5JEicsYXAWuMjv/N
         r4ur+zg8ZD9FRJxU9sgHs4QlmvJiQgNl8rujYSBJp2CnI7a5C9UwAOCKit9D5ctF/qNw
         VgtVMhtGPQxHdZItUh1dQdbwoav+mmPg5r+Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HTlMMixHxDnj0o7plnG/iXcEUERswSUSbuQ0/YQtDO203Ib9U7kejLI53AHk70pARX
         i72PwBof8k6zAo81/9kkzVgqJFZ6BeDG9bgHCAJ8wf4AlTUcxmWeWPUM/+ZfPdrE1Efj
         jjmahADYOMPgGenmLYd47YReqldzfn4kTWi58=
Received: by 10.204.160.154 with SMTP id n26mr5171293bkx.90.1259615885376;
        Mon, 30 Nov 2009 13:18:05 -0800 (PST)
Received: from localhost (ppp85-140-126-192.pppoe.mtu-net.ru [85.140.126.192])
        by mx.google.com with ESMTPS id 16sm1272045bwz.15.2009.11.30.13.18.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 13:18:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFBAx-000kmgC@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134142>

On Mon, Nov 30, 2009 at 01:40:38PM -0500, Greg A. Woods wrote:
> 
> While it may be quite convenient in small projects to quickly move a
> single working directory from one branch to another and do various
> builds and tests from the result, large projects (say where a compile
> takes the better part of a working day or more and where testing
> requires multi-day processes) demand that working directories remain
> "stable", and multiple lines of development therefore demand multiple
> working directories.

It depends on the project and what tools are used, but using ccache and
proper dependencies help a lot to reduce the cost of switching. In fact,
it may be faster to switch to another branch and have to recompile a few
files than to go into another working directory, because when you go to
another working directory, you hit cold cache and things get very slow.

And then if a project is huge and takes a lot of time to compile and
test everything, I do not think, it is a good idea to build that in your
work tree. Instead, you make a shanshot using git-archive and then run
full build and test on it. In this way, you know that you test exactly
what you have committed (you can amend any commit later until you
publish it).


Dmitry
