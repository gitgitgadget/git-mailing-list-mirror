From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: git on HP NonStop
Date: Mon, 20 Aug 2012 13:27:14 +0200
Message-ID: <001101cd7ec6$c038ba60$40aa2f20$@schmitz-digital.de>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr> <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de> <503217F2.5070105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Jan Engelhardt'" <jengelh@inai.de>,
	"'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 13:27:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Q8q-0006tx-CX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 13:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab2HTL10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 07:27:26 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:60476 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2HTL1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 07:27:25 -0400
Received: from DualCore (dsdf-4db55923.pool.mediaWays.net [77.181.89.35])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LtDrP-1TnZYE0eol-0125O6; Mon, 20 Aug 2012 13:27:17 +0200
In-Reply-To: <503217F2.5070105@viscovery.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHB61oVp3im4Dlw7d/lKpMa4E4AEgJhlvNkAetPHqoCQtTARwHvED+rAsdKdxSXH385QA==
Content-Language: de
X-Provags-ID: V02:K0:OXrq4TP5niV0XXoaELxHhRgZx1XUGxBjWQMnRpuBPAT
 agZ2UQuO1F8P1Usq7Yph2pbqFXGAsOqxn+7RZ8dmJ0h6OlglGb
 drAoI65BHOGdKWAxJVHNyvd08Fm3UVbtkMpvjqPSne2AgSnZod
 nj/tlEoOeHxX+GfREA6epGIHIMVy7vsrR7BtEQc1eaduOkbA7f
 5KiCVOPMeBnkr1N9qGOSWCdAs8AAvkPFp/6l2I7KGRzNQmqA1B
 SmtpYyHlstJjxHR4r9qTuhIoACyTgCP0bRPapQbu1/XuQnM+bR
 NXXfS6NGXf5r3g7hY7wIfGg6MH+Hb4XsQez+v9ilKfAAlQA/IG
 mS6R4UDbjxhzKG5ewFEXvFZSpx7ecxvxBf/OTmnFKgfKuDX31l
 Chu8wCMN4iSXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203769>

> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: Monday, August 20, 2012 12:57 PM
> To: Joachim Schmitz
> Cc: 'Jan Engelhardt'; 'Junio C Hamano'; git@vger.kernel.org
> Subject: Re: git on HP NonStop
> 
> Am 8/20/2012 12:36, schrieb Joachim Schmitz:
> > int var = var;
> > char *othervar = othervar;
> >
> > ...
> >
> > What is the reason for using that self-init stuff? I don't think it is
> > really portable, is it?
> 
> It is used to avoid "var may be used uninitialized" warnings for some
compilers.

Well, it results in a similar warning on NonStop. "var is used before it is
set" and I think this is equally bad.
In either case we don't know what the content of that var is.

E.g. in wt_status.c the variable 'status' is set at only one place, but
later it is switched on. If lucky we get to the default case and die.
So why not just 
int status = 0;

> Officially (according to the C standard), it is undefined behavior. 

Yes, I had that suspicion. Not good to rely in this...

> But I've observed considerable resistance by Junio to fix this properly. 

What's the  reason behind that?

> Therefore, unless
> you can show that your compiler generates unusable code you better live
with
> the "self-initialization" warnings.

So far I can't, so I guess I'll have to live with the warnings, but don't
quite like it.
 
> -- Hannes

Bye, Jojo
