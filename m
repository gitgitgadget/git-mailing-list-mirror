From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for doing 
	custom path transformations
Date: Thu, 19 Mar 2009 14:02:41 +0100
Message-ID: <9e0f31700903190602h569a3d18y30477c7a136d875e@mail.gmail.com>
References: <49B7DFA1.4030409@viscovery.net>
	 <1236852820-12980-1-git-send-email-johan@johansorensen.com>
	 <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
	 <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>
	 <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
	 <9e0f31700903140739g26be7981lb0fa411cdd8029e6@mail.gmail.com>
	 <7vprgkarq5.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903190107001.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 14:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkHv0-0003jC-KR
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 14:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbZCSNCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755859AbZCSNCq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 09:02:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:59984 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661AbZCSNCo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 09:02:44 -0400
Received: by nf-out-0910.google.com with SMTP id d21so89727nfb.21
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 06:02:41 -0700 (PDT)
Received: by 10.210.20.17 with SMTP id 17mr1709128ebt.14.1237467761196; Thu, 
	19 Mar 2009 06:02:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903190107001.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2009/3/19 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> I actually was hoping (especially we have Dscho on Cc: list) that so=
mebody
>> like you would start suggesting a "plug in" approach to load .so fil=
es,
>> which would lead to a easy-to-port dso support with the help from ms=
ysgit
>> folks we can use later in other parts of the system (e.g. customizab=
le
>> filters used for diff textconv, clean/smudge, etc.)
>
> I do not like that at all. =A0Dynamic libraries -- especially on Wind=
ows --
> are a major hassle.
>
> However, I cannot think of anything Johan might want to do that would=
 not
> be possible using a bunch of regular expressions together with
> substitions.

Let me reiterate my use-case then: I need to dynamically substitute
one path with another. Perhaps "map" paints a better picture than
"substitute" here. Please refer to my second mail in this thread for
more details.

The only way I can see regexps work, is that if they're read, on a
per-request basis (reloading git-daemon every time they change is just
silly), from somewhere outside the git-daemon. Then, you might as well
take the full-on approach this patch provides.

Cheers,
JS


>
> FWIW I have experimental code in my personal tree that sports
> strbuf_regsub(), a function to replace matches of a regular expressio=
n
> (possibly with groups) by a given string (which may contain \0 .. \9,
> being replaced with the respective group's contents).
>
> Ciao,
> Dscho
>
