From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] Threaded grep
Date: Mon, 18 Jan 2010 14:45:44 +0100
Message-ID: <4B546608.4010503@viscovery.net>
References: <20100118103334.GA17361@fredrik-laptop>	 <4B5441D7.40503@viscovery.net> <4c8ef71001180528h6182ef4l8a617fd038bd7318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 14:45:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWrvX-0008KD-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 14:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab0ARNpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 08:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812Ab0ARNpv
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 08:45:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37053 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751413Ab0ARNpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 08:45:50 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NWrvN-0002jv-0j; Mon, 18 Jan 2010 14:45:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B30001660F;
	Mon, 18 Jan 2010 14:45:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4c8ef71001180528h6182ef4l8a617fd038bd7318@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137386>

Fredrik Kuivinen schrieb:
> On Mon, Jan 18, 2010 at 12:11, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Fredrik Kuivinen schrieb:
>>> +     pthread_mutex_unlock(&grep_lock);
>>> +     pthread_cond_signal(&cond_add);
>> Please swap these two lines, so that pthread_cond_signal() is called while
>> the lock is held.
> 
> May I ask why? (just curious)

Because our pthreads_cond_* functions on Windows are not POSIXly correct
and work reliably only when pthread_cond_signal() is called while the
mutex is held.

-- Hannes
