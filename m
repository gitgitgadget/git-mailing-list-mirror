From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC] speed up git submodule
Date: Mon, 17 Jun 2013 10:29:44 +0200
Message-ID: <87a9mpgmx3.fsf@linux-k42r.v.cablecom.net>
References: <1371427503-9678-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 10:29:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoUoy-0003nZ-OF
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 10:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398Ab3FQI3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 04:29:48 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35321 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392Ab3FQI3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 04:29:46 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 10:29:43 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 17 Jun 2013 10:29:43 +0200
In-Reply-To: <1371427503-9678-1-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Mon, 17 Jun 2013 02:05:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228051>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> The interesting feature would be to run C-functions direct inside lua. I
> suppose that would increase speed even more, at the same time as we have
> the convinence of a interpreted language. Lua is smaller and faster
> (well as always, it depends on what you're doing) than python and ruby.
> Perl is a really pain for the windows folks (I've heard).
>
> A correct implementation for lua support would be to start a
> lua-interpreter from inside git.c (or somewhere) and load the lua code
> for a specific command. That would make us independent of any target
> installation of lua (althought the git binary would increase with the
> lua library around 300 kb).
>
> However I did a quick test using lua as a replacement for sh (without
> direct calls to c-functions) and the result is impressive. (However this
> is the wrong way of using lua, shell scripting is not something lua is
> good at).

Ok, so as you say, to really buy us anything you'd have to interface lua
with the C code directly.  Otherwise you might as well write it in Perl
instead which is already a requirement for a lot of the "niceties".

However, instead of writing against git's C code, you could also
interface with libgit2, either from Lua or Perl...


BTW Peff once posted an interface to Lua for the --pretty formatters:

  http://thread.gmane.org/gmane.comp.version-control.git/206335

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
