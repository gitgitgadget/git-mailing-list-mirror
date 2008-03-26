From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
 merges
Date: Wed, 26 Mar 2008 01:02:18 -0700
Message-ID: <7vej9xgbg5.fsf@gitster.siamese.dyndns.org>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de>
 <alpine.LSU.1.00.0803232334130.4353@racer.site>
 <20080324111413.GA18488@alea.gnuu.de>
 <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <20080325101345.GA990@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, B.Steinbrink@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Mar 26 09:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeQbQ-0006Vi-Ql
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 09:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbYCZICh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2008 04:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbYCZICh
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 04:02:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbYCZICf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 04:02:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A7E5247F;
	Wed, 26 Mar 2008 04:02:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D6180247E; Wed, 26 Mar 2008 04:02:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78271>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> I would like to extend this example:
>
>       o---o---o---o---o---Z
>      /
>     X---Y---A-------B
>          \           \
>           C---D---N---M---E
>                  /
>                 V
> ...
> merge V
>
> V is not a mark.

That's essentially the same as what I drew in a follow-up to the messag=
e
you are responding to, using --first-parents to mark D as "not subject =
to
rewrite but still interesting".

As I explained there, a bigger issue is how you would express the set o=
f
commits that you would want to rewrite and use intact.  In your
illustration, you would want to rewrite N but you want to reuse V.
"rebase Z E" or "rebase --onto Z X E" would include V (and all of its
ancestors that cannot be reached from Z or X that you did not draw) in =
the
set to be rewritten.  Extending the input to the rebase command to use
revision range syntax and saying it as Z..E (or X..E) would not help
either.
