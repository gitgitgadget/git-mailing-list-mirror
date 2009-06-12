From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 23:49:55 +0200
Message-ID: <4A32CD83.1090801@dawes.za.net>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>	<ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>	<20090612084209.6117@nanako3.lavabit.com>	<alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>	<85647ef50906120838s37c186a9mec301e880b1a8a4e@mail.gmail.com> <m3vdn12y6y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEel-0000YV-PA
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 23:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934372AbZFLVvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 17:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934324AbZFLVvN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 17:51:13 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:60882 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762652AbZFLVvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 17:51:12 -0400
Received: from homiemail-a4.g.dreamhost.com (caiajhbdcaid.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 6692A12EEAC
	for <git@vger.kernel.org>; Fri, 12 Jun 2009 14:51:14 -0700 (PDT)
Received: from vc-41-27-254-80.umts.vodacom.co.za (vc-41-27-254-80.umts.vodacom.co.za [41.27.254.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.g.dreamhost.com (Postfix) with ESMTP id A88014179E;
	Fri, 12 Jun 2009 14:50:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <m3vdn12y6y.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121453>

Jakub Narebski wrote:
>> For SSH using unencrypted private key is very common for scripting and
>> cron jobs. For HTTPS situation looks like being worse since there is
>> no analog of ssh-agent that covers at least some of scripting
>> scenarios. Do we want to disable scripting for HTTPS?
> 
> Actually you can use _encrypted_ private keys together with ssh-agent
> and for example keychain helper for scripting.  You have to provide
> password to all listed private keys only once at login.  I wonder if
> something like this would be possible for HTTP certificates...

I wonder if it might be possible using a PKCS#11 interface?

e.g. there are various "software" PKCS#11 implementations
(<http://trac.opendnssec.org/wiki/SoftHSM> springs to mind).

If you store your keys in the PKCS#11 store, and unlock them prior to
calling git, then the OpenSSL library might be able to access them
without a passphrase. Locking the PKCS#11 store would then secure the keys.

A little cumbersome, but possibly workable.

Rogan
