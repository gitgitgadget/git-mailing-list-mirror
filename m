From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH v2] tg-graph: print dependency graph like git log 
	--graph
Date: Thu, 21 May 2009 11:29:35 +0200
Message-ID: <36ca99e90905210229s3e621a43h1a336d908d44e685@mail.gmail.com>
References: <1242801900-30895-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090520103703.GS8212@noris.de>
	 <36ca99e90905200348i45e3ad0kf8efc655789702c0@mail.gmail.com>
	 <20090520115814.GT8212@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Thu May 21 11:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74bQ-00082W-74
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZEUJ3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 05:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZEUJ3g
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:29:36 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:35056 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbZEUJ3f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 05:29:35 -0400
Received: by bwz22 with SMTP id 22so891460bwz.37
        for <git@vger.kernel.org>; Thu, 21 May 2009 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WnFQsu2hlcn23SRu+dWgAMpiwiMHCLt9/AgnBfbbDTw=;
        b=LVP8uzSL6gpzyZUxpLvU+jtmJTMrYKPJbtKSkRNInpww6jEvdUyS4cBCKWcFk71HWf
         FMsZEOHnGLoM19oInF8PxNCGliVTLDIT01ov+BXFHYf2qtWSij7T6qwYZl8wP6zRkZ7m
         JtRcImj92T2kBXU7HZ1sRKTAmcvQgGD0MkbVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LnxDItEM3JqPpNf9D1Kzpe3xsMvMxRMpYRGZOgbcYoQVwgVqSaunELZ3Tb2rRgYzYm
         T6uQwRVGzBGk7C2jpP20kaYU2PPJSi27NS2s4pUlYcl4kxDM9Qc09lrlprejfOh6snqS
         VY3OnKT09m9Aa/TJRpg3Sgo+UsE1tOb7K4VZ4=
Received: by 10.223.108.15 with SMTP id d15mr1443589fap.105.1242898175278; 
	Thu, 21 May 2009 02:29:35 -0700 (PDT)
In-Reply-To: <20090520115814.GT8212@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119664>

On Wed, May 20, 2009 at 13:58, Michael Radziej <mir@noris.de> wrote:
> On Wed, May 20, Bert Wesarg wrote:
>
>> > a) graphviz 2.16-3ubuntu2
>> >
>> > mir@mir:topgit (bw/tg-graph-v2)> tg graph
>> > gvpr: "/usr/local/share/topgit/graph.gvpr", line 952: gg_nl_ret +=3D
>> > graph_output_commit_line();<<<
>> > =C2=A0-- cannot convert node_t to string
>> Just a note: I have never seen this error on my side.
>
> graphviz is too old on that system. I've updated to 2.20 and it works=
 fine.
Thanks, I will put a note into the message and try a version check in t=
g-patch.

>
>> Yeah, sorry I hand edited the patch to use printf instead of echo -e=
=2E
>>
>> can you edit this line in tg-summary.sh:
>>
>> printf "\t\"%s\" -> \"%s\";\n" "$$name" "$dep"
>>
>> and change it to this (i.e. remove one '$' from '$$name'):
>>
>> printf "\t\"%s\" -> \"%s\";\n" "$name" "$dep"
>
> Did this, and it works now! (Cheeeers!)
>
> I've attach the output from the big repository (well, the ASCII outpu=
t is
> not very useful, but the graphics obtained by tg graph --graphviz is)=
=2E I
> don't have an immediate idea how this could be improved, other than b=
y
> options to strip away a part of the dependencies.
>
> Is
> =C2=A0tg graph <branch-name>
> expected to work? It results in:
Never tried ;-)


>
> mir@mir:otrs-git (master)> tg graph t/noris-followups
> 3e65695427cf1a15e8a8903e4b11f849045d6800
> ccomps: node "t/noris-followups" not found in graph G - ignored
ccomps decomposes a graph into its connected components. I.e. if you
have topics that depends on master and some one next, you get two
graphs. That itslef improves dramaticaly the graph output, because the
two graphs will be printed separatly. The idea behind the [NAME]
argument is to select only this graph which contains this topic.

Bert
>
> (and no further output)
>
>
> Big thanks so far!
>
> Michael
>
> --
> noris network AG - Deutschherrnstra=C3=9Fe 15-19 - D-90429 N=C3=BCrnb=
erg -
> Tel +49-911-9352-0 - Fax +49-911-9352-100
> http://www.noris.de - The IT-Outsourcing Company
>
> Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk=
 -
> Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=C3=BCrnberg HR=
B 17689
>
