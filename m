From: James Cloos <cloos@jhcloos.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 14:59:27 -0400
Message-ID: <m3mya3b5qw.fsf@lugabout.jhcloos.org>
References: <200904260703.31243.chriscool@tuxfamily.org>
	<m363grq13i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 11:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly9er-0003cq-Jw
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 21:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbZDZTCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 15:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbZDZTCw
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 15:02:52 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:4767 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZDZTCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 15:02:51 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 93B70402E5; Sun, 26 Apr 2009 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240772570;
	bh=mqCDVWcxUUg8nKAxflQaOMErLhi/g7L/dFLmYVCgzBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=VzBszwqg+1sft/bkGbWKLLqG5eDN0GNzg2NIdeUUpQbJACgrSSkWlMHeKzrbuYs5F
	 oTUlleQhH1vclANkEr0uOUJ2bZXVNwmZ4C22OEza9kmwhfZixScfNqMC1o3Ibqr9TW
	 VMNVfl7AAmE8h/6n233HuVal1RbLaBVdxYrRJtH4=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 9469549944; Sun, 26 Apr 2009 18:59:51 +0000 (UTC)
In-Reply-To: <m363grq13i.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 26 Apr 2009 01:16:16 -0700 (PDT)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090426:git@vger.kernel.org::NbLfDkB3mzf/m/HW:000000000000000000000000000000000000000008BTvV
X-Hashcash: 1:29:090426:chriscool@tuxfamily.org::J7xIpkljhSliYO+D:0000000000000000000000000000000000000vlCmL
X-Hashcash: 1:29:090426:jnareb@gmail.com::Zb3VyhLSvKMvwGFh:2M8Ak
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117624>

>>>>> "Jakub" =3D=3D Jakub Narebski <jnareb@gmail.com> writes:

Jakub> Perhaps it is time to restart work on _"smart" HTTP protocol_?

I had put together some ideas for how that could work, but didn=E2=80=99=
t post
them because it looked like smarter http transport was fait accompli.

The general idea was to use an http server as a proxy for git-daemon.
Sites running git-daemon could put up such a proxy which will only
accept proxy attempts to their own daemon, and sites or users behind
restrictive firewalls (or http proxies) could set up such a proxy which
requires http-level authentication but then will proxy for any git-daem=
on.

IIRC, I intended to suggest the name post_proxy for the config files.
One could add a post_proxy to a repo (for the former style) or in their
global config (for the latter style).  Either way, an http_proxy could
still be used, if necessary, to access the post_proxy.

Any stream the client would send to a remote git-daemon would be
encapsulted and sent via an HTTP POST to the post_proxy, which would
use the git protocol to send it to the specified git-daemon.  Any
reply back from the git-daemon would be sent to the client as the reply
to the POST.

The proxy can be readilly written as a CGI, as a mod_lang extension (fo=
r
one=E2=80=99s favourite lang), as a standalone server, or as an extensi=
on to
projects such as gitweb or cgit.

I never got past the rough design phase because, when I was preparing t=
o
post the idea, it looked like alternate code was already written....

Is there any interest in this?

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
