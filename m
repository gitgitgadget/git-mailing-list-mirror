From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Sat, 16 Aug 2008 03:31:51 -0700
Message-ID: <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
References: <20080815142439.GA10609@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 12:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUJ5j-0005EH-RT
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 12:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYHPKcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Aug 2008 06:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYHPKcA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 06:32:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYHPKb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Aug 2008 06:31:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 811E55B5EA;
	Sat, 16 Aug 2008 06:31:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4DFB65B5E9; Sat, 16 Aug 2008 06:31:54 -0400 (EDT)
In-Reply-To: <20080815142439.GA10609@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message of "Fri, 15 Aug 2008 21:24:39
 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D80BEEC-6B7E-11DD-A833-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92541>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The implementation with insights from Junio turns out smaller and bet=
ter
> (and I was thinking about applying it for huge maildir).

I think I can agree with the general direction this is taking, except t=
hat
we would need to think about the transition plans.  Note that I haven't
really read through the full series yet.

> Another difference from the last round is "narrow rules" will not be =
preserved
> when switching branches. When you switch branch with no option, you w=
ill get
> full checkout. You may want to use --path|--add-path|--remove-path wh=
en
> switching branches to have narrow checkout again.

You could save the "narrow rules" in the extension section of the index=
=2E
If the final form of this series needs to use a separate CE_NO_CHECKOUT
bit (which would make the resulting index incompatible with the current
git), the narrow rules section can be marked as "your git must understa=
nd
this" class of extension to make sure that people do not mistakenly acc=
ess
an index written by this new version of git with the current or older g=
it.

> Now back to technical POV. I did not reuse CE_VALID (assume unchanged=
) bit
> because it has been used for core.ignorestat.

I am not sure what's the relation between these two.
