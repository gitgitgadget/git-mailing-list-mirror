From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 12:06:23 -0700
Message-ID: <7vy5jzxmts.fsf@alter.siamese.dyndns.org>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
 <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de>
 <7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
 <7v39271j3n.fsf@alter.siamese.dyndns.org> <5060A32D.1060902@web.de>
 <7vlifzz2vo.fsf@alter.siamese.dyndns.org>
 <CAGHpTB+F3=mW9m3ESQe1wAkLzSBcp+5Kgw1Kb-D-rk2T1q_-iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 21:06:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDzH-0002DC-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802Ab2IXTG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:06:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757748Ab2IXTGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:06:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 871208373;
	Mon, 24 Sep 2012 15:06:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5l0I0weepAvedmCFDNI/Z/os/n0=; b=R3JEaq
	N5YDvhApsxV17R8nz/PptWPjQZgPat3X58loKwJE4XALSjYYTIT0jWnb0jaQKndC
	pnvShp5Mgnax8zD6ATs63+WJDUdmrx8hbWIBArnQ5op6XPZd02alyGSgVnDqzggz
	plhvut/y+emOCxscTgTmetAm88juFY4NU2fRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D5u6AvyTTS9lmPKfu8J0JdWytpjEJyPd
	LYjLS8VWpWKwAIKNqbnlevsNgOunwU6AHUnbOU3/6guF6qZpjKVrDbPpn7K8Bsj0
	8qFKPCEKBG+ZUeK31wv4a87GIl15gp0Sg6JTTCtcEFU9SNfVQbpvxKS7bB58CYZU
	bTRK2nbelIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 722E98371;
	Mon, 24 Sep 2012 15:06:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC7458370; Mon, 24 Sep 2012
 15:06:24 -0400 (EDT)
In-Reply-To: <CAGHpTB+F3=mW9m3ESQe1wAkLzSBcp+5Kgw1Kb-D-rk2T1q_-iw@mail.gmail.com> (Orgad
 Shaneh's message of "Mon, 24 Sep 2012 20:49:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF800E0E-067A-11E2-B4E3-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206313>

Orgad Shaneh <orgads@gmail.com> writes:

> That is not correct. git-config is ignored as well for commit.

What do you mean?  As far as I can tell, if you have

    [submodule "var"]
        path = var
	ignore = dirty

in $GIT_DIR/config, a work-tree-dirty submodule "var" is not
reported by "git status" and "git commit" without your patch, and
your patch does not seem to break that.  The only difference your
patch makes is that if you had the above three-line block in
the .gitmodules file and not in $GIT_DIR/config, "git status"
ignored the dirtyness in the working tree, but "git commit" did
notice and report it.

What am I missing?
