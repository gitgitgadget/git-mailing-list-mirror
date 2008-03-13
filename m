From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Thu, 13 Mar 2008 11:17:31 +0100
Message-ID: <47D8FF3B.9050304@viscovery.net>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain> <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site> <7vwso74p33.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122348210.1656@racer.site> <7vzlt335a5.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803130021520.1656@racer.site> <7vod9j342h.fsf@gitster.siamese.dyndns.org> <7FB80115-C1E4-4F83-9374-41AB1BDA0579@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 11:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZkVs-0004LK-MA
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 11:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbYCMKRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYCMKRg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 06:17:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32946 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYCMKRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2008 06:17:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZkUQ-0001vN-OL; Thu, 13 Mar 2008 11:16:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 23AF16B7; Thu, 13 Mar 2008 11:17:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7FB80115-C1E4-4F83-9374-41AB1BDA0579@wincent.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77057>

Wincent Colaiuta schrieb:
> El 13/3/2008, a las 0:39, Junio C Hamano escribi=F3:
>>          if (strcmp(value, "now")) {
>>                    unsigned long now =3D approxidate("now");
>>                    if (approxidate(value) >=3D now)
>>                 return error("Invalid %s: '%s'", var, value);
>>             ...
>>         }
>=20
>=20
> Are you sure that that alternative provides any guarantees about
> evaluation order either? (I'm not a compiler expert, nor am I consult=
ing
> a copy of the standard; but I don't think it does.)

There is a sequence point at the semicolon. This means that all observa=
ble
side effects of approxidate("now") are visible when approxidate(value) =
is
evaluated (and no observable side effect of the latter is visible when =
the
former is evaluated), which doesn't leave much choice for the compiler.
So, yes, this does guarantee the intended evaluation order.

-- Hannes
