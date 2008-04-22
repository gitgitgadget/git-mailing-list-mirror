From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 11:04:03 -0700
Message-ID: <7vlk35ydf0.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:06:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMrY-0000Ct-TJ
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbYDVSES convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbYDVSES
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:04:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbYDVSER convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 14:04:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE6DC2285;
	Tue, 22 Apr 2008 14:04:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E38DE2280; Tue, 22 Apr 2008 14:04:06 -0400 (EDT)
In-Reply-To: <20080422095549.GB3752@alea.gnuu.de> (=?utf-8?Q?J=C3=B6rg?=
 Sommer's message of "Tue, 22 Apr 2008 11:55:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80152>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> What do you think about this version:
>
> cleanup_before_quit () {
> 	rm -rf "$DOTEST" &&
> 	for ref in $(git for-each-ref --format=3D'%(refname)' ${mark_prefix%=
/})
> 	do
> 		git update-ref -d "$ref" "$ref" || return 1
> 	done
> }

Yeah, except you would want to dqquote "${mark_prefix%/}" part.

Also this being a "clean-up" phase, I wonder if we want to stop at the
first error (e.g. should unremovable "$DOTEST" leave marks behind?  sho=
uld
unremovable one mark leave other marks that happen to sort after it
behind?).
