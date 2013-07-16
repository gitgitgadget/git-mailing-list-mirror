From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Tue, 16 Jul 2013 21:53:35 +0100
Organization: OPDS
Message-ID: <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Junio C Hamano" <gitster@pobox.com>,
	"GIT Mailing-list" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 16 22:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzCFY-00069h-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 22:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934011Ab3GPUx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jul 2013 16:53:29 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27193 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933954Ab3GPUx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jul 2013 16:53:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYNAB2x5VFZ8YYB/2dsb2JhbABaFoJwNINVhT65MwEDAYERF3SCHgUBAQMCCAEBGQ8BBR4BASELAgMFAgEDDgcBAgICBSECAhQBBBoGBxcGARIIAgECAwEJh3oIpBWRRIEmjSItaoJgM20DjnyKCZAkgxM7
X-IPAS-Result: AvYNAB2x5VFZ8YYB/2dsb2JhbABaFoJwNINVhT65MwEDAYERF3SCHgUBAQMCCAEBGQ8BBR4BASELAgMFAgEDDgcBAgICBSECAhQBBBoGBxcGARIIAgECAwEJh3oIpBWRRIEmjSItaoJgM20DjnyKCZAkgxM7
X-IronPort-AV: E=Sophos;i="4.89,679,1367967600"; 
   d="scan'208";a="430608537"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip03ir2.opaltelecom.net with SMTP; 16 Jul 2013 21:53:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230583>

=46rom: "Jeff King" <peff@peff.net>
Sent: Tuesday, July 16, 2013 7:21 AM
> On Tue, Jul 16, 2013 at 07:57:20AM +0200, Johannes Sixt wrote:
>
>> Am 7/15/2013 19:31, schrieb Ramsay Jones:
>> > Sparse issues three "Using plain integer as NULL pointer" warnings=
=2E
>> > Each warning relates to the use of an '{0}' initialiser expression
>> > in the declaration of an 'struct object_info'.
>>
>> I question the value of this warning. Initialization with '=3D {0}' =
is
>> a
>> well-established idiom, and sparse should know about it. Also, plain
>> 0
>> *is* a null pointer constant.
>
> I agree with you. It's not a bug, and I think sparse is being overly
> picky here; it is missing the forest for the trees in interpreting th=
e
> idiom.
>
> Still, it may be worth tweaking in the name of eliminating compiler
> noise, since it does not cost us very much to do so (and I believe we
> have done so in the past, too).
>
> We could also ask people with sparse to turn off the "use NULL instea=
d
> of 0" warning, but I think it _is_ a useful warning elsewhere (even
> though it is never a bug, it violates our style guidelines and may be
> an
> indication of a bug). It would be nice if sparse learned to ignore th=
e
> warning in this particular idiom, but I am not going to hold my breat=
h
> for that.
>
> -Peff
> --

On the subject of warnings and null pointers, yesterday's Code Project
news linked to a blog on the problems of unexpected optimization bugs,
such as dereferencing a null pointer. "Finding Undefined Behavior Bugs
by Finding Dead Code" http://blog.regehr.org/archives/970 which links t=
o=20
the draft of an interesting paper=20
[http://pdos.csail.mit.edu/~xi/papers/stack-sosp13.pdf]

Does anyone run the "new static checker called 'Stack' that precisely
identifies unstable code"? [though the paper's conclusion says 'All
Stack source code will be publicly available.' which suggests it's not
yet available]

Or use the =E2=80=98-fno-delete-null-pointer-checks=E2=80=99 referred t=
o in the blog
comments (see also index : kernel/git/torvalds/linux.git "Add
'-fno-delete-null-pointer-checks' to gcc CFLAGS"
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Da3ca86aea507904148870946d599e07a340b39bf

You're probably already aware of these aspects but I thought it worth
mentioning for the wider readership.

regards

Philip
