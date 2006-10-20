From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:43:15 +0200
Message-ID: <vpq4ptz2uh8.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 11:44:30 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaqvU-0004nd-84
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 11:44:28 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaqvH-0003pE-9F; Fri, 20 Oct 2006 10:44:15 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1GaqvF-0003om-0S
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 10:44:13 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9K9hGag024795
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Oct 2006 11:43:16 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1GaquK-0004r3-Gr; Fri, 20 Oct 2006 11:43:16 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GaquJ-0003rA-SN; Fri, 20 Oct 2006 11:43:15 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> (Sean's message
	of "Tue\, 17 Oct 2006 18\:00\:51 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Fri, 20 Oct 2006 11:43:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29432>

Sean <seanlkml@sympatico.ca> writes:

> On Tue, 17 Oct 2006 17:27:44 -0400
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
>
>> Bzr has plugin autoloading, Protocol plugins, Repository format plugins,
>> and more.  Because Python supports monkey-patching, a plugin can change
>> absolutely anything.
>
> But really why does any of that matter?  This is the open source world.
> We don't need plugins to extend features, we just add the feature to
> the source.  The example I asked about earlier is a case in point. 
> Apparently in bzr "bisect" was implemented as a plugin, yet in Git it
> was implemented as a command without any issue at all,

The plugin Vs core feature is not a technical problem. The code for a
plugin and for a core functionality will roughly be the same, but in a
different file.

There can be many reasons why you want to implement something as a
plugin:

* This is project-specific, upstream is not interested (for example,
  bzr has a plugin to submit a merge request to a robot, it will
  probably never come in the core).

* The feature is not matured enough, so you don't want to merge it in
  upstream, but you want to make it available to people without
  patching (for example, "bzr uncommit" was once in the bzrtools
  plugin, and finally landed in upstream).

* The feature you're adding are only of use to a small subset of
  users. You don't want to pollute, in particular "bzr help commands"
  with it, especially not to disturb beginners. I've been arguing in
  favor of a configuration option to hide commands from "bzr help
  commands" instead, but nobody seemed interested.

* Explicit divergent points of view between the implementor of the
  plugin and upstream. That avoids a fork. I don't remember any such
  case with bzr.

I'd compare bzr's plugins to Firefox extensions. Geeks used to like
the big Mozilla-with-tons-of-config-options, but
Firefox-with-only-the-most-relevant-features is the one which allowed
a wide adoption by non-geeks. Still, geeks can customize their
browser, and add features without having to wait for Mozilla Fundation
to incorporate it in upstream.

Now, I don't know git enough to know whether the way it is extensible
allow all of the above, but bzr's plugin system it quite good at that.
At the time git was almost exclusively used by the kernel, you didn't
have all those problems since you targeted only one community, but I
guess you already had some needs for flexibility.
