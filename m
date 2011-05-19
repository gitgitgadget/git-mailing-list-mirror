From: Paul Ebermann <Paul-Ebermann@gmx.de>
Subject: Re: [PATCH/WIP] completion: complete git diff with only changed files.
Date: Thu, 19 May 2011 14:31:37 +0200
Message-ID: <4DD50DA9.8010305@gmx.de>
References: <4DD30F87.2000807@gmx.de> <7v8vu4efvj.fsf@alter.siamese.dyndns.org> <4DD3C814.8000100@gmx.de> <7voc2zbwz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 14:31:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN2OI-0001sb-Li
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 14:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab1ESMbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 08:31:41 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:52305 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752696Ab1ESMbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 08:31:40 -0400
Received: (qmail invoked by alias); 19 May 2011 12:31:38 -0000
Received: from stilgar.mathematik.hu-berlin.de (EHLO [141.20.50.149]) [141.20.50.149]
  by mail.gmx.net (mp071) with SMTP; 19 May 2011 14:31:38 +0200
X-Authenticated: #2289940
X-Provags-ID: V01U2FsdGVkX1+xKMAVEamx0LYbIaWdP1cdtwjRU+0p6S2Aj/YJkU
	Aw6ZL6TTVZuRwb
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.19) Gecko/20110420 SUSE/2.0.14-0.2.1 SeaMonkey/2.0.14
In-Reply-To: <7voc2zbwz8.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173957>

Junio C Hamano schrieb:
> Paul Ebermann <Paul-Ebermann@gmx.de> writes:
> 
>> I'm normally using (for differences to head) git status first, and then
>> have a look at the files I really want to see. Then completion of only
>> the changed files seems useful.
> 
> By the time completion offers you the choices, you already have spent
> enough extra cycles to compute the paths, which is half the cost of
> generating the diff itself.
> 
> I have this nagging feeling that you are trying to solve a problem that
> does not exist.

Maybe.

For me, it is not so much about saving CPU cycles (I have enough of
these) but about not seeing things I don't want to see, and helping me
decide what to type. This might be against the Git philosophy, I'm
starting to realize.

>  Perhaps you have too many things going on in your working
> tree at once, and if git helped in such a way that your workflow does not
> have to touch so many (possibly unrelated) things at once, you do not have
> to worry about unconstrained "git diff" output overwhelming you?

If I only want to do "git diff" (without any paths), I obviously don't
need path completion at all.


Here is an example:

Yesterday, I addes a new Java class (193 lines)
  src/de/hub/sam/es/managementclient/ssh/TunnelSocketImpl.java
and at the same time made some changes to
  src/de/hub/sam/es/managementclient/ssh/ConnectionManager.java
to use this new class (adding 29 lines).

I wanted to look only at the changes made to ConnectionManager.java.

(The changes to TunnelSocketImpl.java were obvious: creating the whole
new class, thus I could look at this in my editor if I wanted).

With the usual filename-completion, this goes like

    git diff -- s<tab><tab><tab><tab><tab><tab>s<tab>C<tab>

If I had a broader package tree (like in some other projects),
it takes even more work, as I must remember which package name
starting letters to type between the tabs.

(In some projects I started to choose the package names so that
there never would be two sibling directories starting with the
same letter, to help autocompletion.)

With the new completion scheme, this would be

   git diff -- <tab>C<tab>

It might need doubled time to complete-and-execute, but
my computer is quite faster than I can type (and think),
even if the .git directory is on a NFS.

(You could ask why my shell working directory is not the
 managementclient directory. The reason is that sometimes
 there are files in ./ which get changed, too.)


Paul
