From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Wed, 05 Mar 2008 13:29:24 -0800
Message-ID: <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX1Bk-00048B-Da
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbYCEV3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbYCEV3f
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:29:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYCEV3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 16:29:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E2C81D0A;
	Wed,  5 Mar 2008 16:29:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 78F6A1D07; Wed,  5 Mar 2008 16:29:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76272>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> +user.default::
> +	If false the defaults values for user.email and user.name are not
> +	used. Useful when you want a different email/name for each
> +	repository, normally set in the global config file.
> +

Aren't there other configuration variables that you might want
to tweak per repository?

Perhaps you can make git-init run a post-init hook script by
default, and have ~/.gitconfig specify the location of it, and
have it do whatever custom settings to the per-repository
configuration file?

Wouldn't that be a more generally useful thing to do, instead of
adding special-purpose configuration variables like this?

If we go that alternate route, I would imagine that we would
need to add "--no-post-init" flag to git-init (and probably an
environment GIT_NO_POST_INIT) so that git-clone and others that
run git-init internally can disable the hook if they want to.
