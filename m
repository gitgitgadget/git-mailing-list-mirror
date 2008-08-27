From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve portability: Avoid SS constant as it is
 already defined
Date: Wed, 27 Aug 2008 11:56:51 -0700
Message-ID: <7vwsi2p9qk.fsf@gitster.siamese.dyndns.org>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net>
 <1219858743-4476-2-git-send-email-sn_@gmx.net>
 <1219858743-4476-3-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQDY-0002SW-Ph
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbYH0S5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYH0S47
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:56:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYH0S47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:56:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E20F26327D;
	Wed, 27 Aug 2008 14:56:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2EF3A6327C; Wed, 27 Aug 2008 14:56:54 -0400 (EDT)
In-Reply-To: <1219858743-4476-3-git-send-email-sn_@gmx.net> (David Soria
 Parra's message of "Wed, 27 Aug 2008 19:39:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC7EEE2A-7469-11DD-91BD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93923>

David Soria Parra <sn_@gmx.net> writes:

> From: David Soria Parra <dsp@php.net>
>
> Constants that have the names of CPU registers are already defined
> in OpenSolaris's sys/regset.h. This causes a warning as we try to
> (re)define SS in ctype.c. So we just use another name.

I do not mind this _particular_ workaround per-se, but I have to wonder
what happens the next time some random other platform has "SP" defined in
a random header file.

First of all, why are you including <sys/regset.h>?  We certainly don't
include from any of our header or source files.  And second of all, why is
the indirect inclusion of that header file by some standard header file we
do include cause the namespace to get poluted with "SS" symbol?
