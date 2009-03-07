From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Sat, 7 Mar 2009 08:48:37 -0500
Message-ID: <76718490903070548u4545ec12me4698fef0df6c7b0@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
	 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
	 <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
	 <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
	 <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
	 <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 14:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfwuw-0004XV-0q
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 14:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZCGNsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 08:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752795AbZCGNsk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 08:48:40 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:30642 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbZCGNsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 08:48:39 -0500
Received: by rv-out-0506.google.com with SMTP id g37so924053rvb.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EM3dMjmmcdCaQQP60D4+Jw37QOeKLq+sY8zeYCIF1wg=;
        b=XZBMDpuTUhLUDYSC8o+V+SXaHpaCdw2ITMecH1EZ1+F6jl8adbm/Crjfw3kyQ8rLdE
         2rUpGQopheD4qLyjZX1g1kaUF59+Mx9yo1Lph8+IZ3gVW6I4LfUXJ4gn0IB5cu342yL0
         bG9p15fAwPZWq/ag5+Wqf2ulFrfO4+gqlLZug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RJKoOhBUBcnQsju/rW36TPfjC/mz9oiBBjajxxs5LbraxII2oKze7ECOHfq8sPvC+e
         h9vAiBllvXo9SUFG/1jS8N91b0dKXxQs1yEF1tQt2HPzU4lDqbDfiBjjrfH1+LhJYvGv
         q54E7GvZb7iWuivKYZaRzBZHnooKj1BW89S8M=
Received: by 10.140.140.3 with SMTP id n3mr1898159rvd.111.1236433717479; Sat, 
	07 Mar 2009 05:48:37 -0800 (PST)
In-Reply-To: <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112539>

On Sat, Mar 7, 2009 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Note that you do not have to cover branch.*.remote and other things i=
n the
> same patch. =C2=A0The first one could just handle branch.*.mergeoptio=
ns and you
> can let later patches to implement the fallbacks for other variables.

Oh, indeed, but I think I do need to provide all the patches at once.
Otherwise it will just be very confusing and I anticipate a user
asking "how come I can use branch.*.mergeoptions, but none of the
other branch.*.foo settings work?"

And to be honest, that concern extends beyond branch.*. "How come git
foo allows defaults, but git bar does not?" seems like a valid
question, and while "because no one implemented defaults for foo and
bar" is a valid answer, it isn't a very satisfying one (to me).

This thread is what inspired me to start the "what's so evil about
overriding builtins with aliases" thread (please don't address that
here, I got it from the other thread). But I still wonder if we should
provide defaults consistently instead of piecemeal. For example:

[defaults]
   merge =3D --no-ff

But I suppose that will be objected to as confusing/complicated/likely
to have side-effects.

j.
