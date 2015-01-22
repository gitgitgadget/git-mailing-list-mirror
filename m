From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 19:51:28 +0000
Message-ID: <54C154C0.9020708@ramsay1.demon.co.uk>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>	<1421893929-7447-6-git-send-email-sbeller@google.com>	<54C0F41F.2080705@ramsay1.demon.co.uk> <CAGZ79kZnECcGOWKr4JLpF5zh68+L8XX7yYntyZDJTbZ5cLD50w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENsV-0006cO-13
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 20:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbbAVT5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:57:15 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:48552 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753185AbbAVT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:57:13 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2015 14:57:13 EST
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id AA62A6F9CEB;
	Thu, 22 Jan 2015 19:51:32 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 4FE746F9CE9;
	Thu, 22 Jan 2015 19:51:32 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 22 Jan 2015 19:51:31 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAGZ79kZnECcGOWKr4JLpF5zh68+L8XX7yYntyZDJTbZ5cLD50w@mail.gmail.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262861>

On 22/01/15 19:16, Stefan Beller wrote:
> How do you run sparse on git?

  $ make sparse >sp-out 2>&1

> 
> I noticed there is 'make sparse' though I cannot get it working
> here in the corporate world as I have problems with openssl
> headers not being found.

If you can build git with gcc, you should be able to run 'make sparse'
(modulo bugs, of course!). Having said that, I build sparse from source
and (on Linux) I'm running:

  $ sparse --version
  v0.5.0-30-gca3309e
  $

The most up-to-date (from git://git.kernel.org/pub/scm/devel/sparse/sparse.git)
is actually:

  $ sparse --version
  v0.5.0-41-g6c2d743
  $ 

which should work just fine. (I also run sparse on cygwin and MinGW).

> 
> Also the line numbers seem to bit off compared to what I have
> here, did you need to modify/preprocess files to get sparse running?

No, I am simply building the 'pu' branch (currently @ 028c360).

> 
> As for the fix, would it be sufficient to check != NULL instead of < 0?

Hmm, I didn't give it any thought, but don't you want that to be '== NULL'?
(you don't want to use a NULL lock->lk->fp in the following fprintf()).
Or simply '!fdopen_lock_file(lock->lk, "w")' I suppose.

ATB,
Ramsay Jones
