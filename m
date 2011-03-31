From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Fix potential local deadlock during fetch-pack
Date: Thu, 31 Mar 2011 09:24:36 -0700
Message-ID: <AANLkTiki2__qAqgDnB6yu8kzxNW-bMj2qJcx50yawCWM@mail.gmail.com>
References: <7vtyelsvp0.fsf@alter.siamese.dyndns.org> <AANLkTikCRRftjExdhMgFGFMy-Dc1UCMdW1nTYV2bK1-T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>, Johannes Sixt <j6t@kdbg.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 31 18:25:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5KgC-00029u-SO
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 18:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649Ab1CaQY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 12:24:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36405 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab1CaQY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 12:24:58 -0400
Received: by vws1 with SMTP id 1so1994276vws.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 09:24:57 -0700 (PDT)
Received: by 10.52.169.37 with SMTP id ab5mr3753840vdc.283.1301588697196; Thu,
 31 Mar 2011 09:24:57 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Thu, 31 Mar 2011 09:24:36 -0700 (PDT)
In-Reply-To: <AANLkTikCRRftjExdhMgFGFMy-Dc1UCMdW1nTYV2bK1-T@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170504>

On Wed, Mar 30, 2011 at 02:42, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Tue, Mar 29, 2011 at 7:06 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> The fetch-pack/upload-pack protocol relies on the underlying transpo=
rt
>> (local pipe or TCP socket) to have enough slack to allow one window =
worth
>> of data in flight without blocking the writer. =A0Traditionally we a=
lways
>> relied on being able to have a batch of 32 "have"s in flight (roughl=
y 1.5k
>> bytes) to stream.
>
> Hmm, this explanation makes me wonder: Could this be related to the
> deadlock we're experiencing with git-push over the git-protocol on
> Windows when side-band-64k is enabled?

I think its unrelated. It might also be a deadlock, but the push
protocol is quite a bit different. As far as I remember, there is no
risk of deadlock in the push protocol.

--=20
Shawn.
