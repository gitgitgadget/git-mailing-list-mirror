From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv4 6/6] is_submodule_modified(): clear environment properly
Date: Wed, 24 Feb 2010 10:18:42 +0100
Message-ID: <4B84EEF2.2030502@viscovery.net>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com> 	<1266996196-25978-7-git-send-email-giuseppe.bilotta@gmail.com> 	<4B84DDE9.8000301@viscovery.net> <cb7bb73a1002240055v58953dcfh3be7c4589523b14b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 10:18:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkDOS-0001sW-W9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 10:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab0BXJSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 04:18:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57331 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab0BXJSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 04:18:49 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkDOF-0005iK-GI; Wed, 24 Feb 2010 10:18:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 376281660F;
	Wed, 24 Feb 2010 10:18:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <cb7bb73a1002240055v58953dcfh3be7c4589523b14b@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140921>

Giuseppe Bilotta schrieb:
> On Wed, Feb 24, 2010 at 9:06 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Giuseppe Bilotta schrieb:
>>> +     const char *env[local_repo_env_size+2];
>> Variable sized arrays are prohibited.
> 
> Ah, sorry. Is alloca() allowed? I don't see it being used anywhere
> else in the code, and malloc would be a little too much for this case.

in cache.h:

#define LOCAL_REPO_ENV_CAPACITY 20
const char *const l_r_e[];

in environtment.c:

const char *const l_r_e[LOCAL_REPO_ENV_CAPACITY] = { ..., NULL };

and the compiler will croak if the constant becomes too small. (Oh, I
know, you must use the 'inconsistent mode' that I nit-picked if you use
this approach.)

-- Hannes
