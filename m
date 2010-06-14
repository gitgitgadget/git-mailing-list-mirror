From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH 3/6] Add library for string-specific memory pool
Date: Tue, 15 Jun 2010 00:45:42 +1000
Message-ID: <7C3A5AC5-78A7-42EB-A5DF-EFFA761FF1A6@cordelta.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>  <1276175389-6185-4-git-send-email-artagnon@gmail.com> <7vk4q5ictl.fsf@alter.siamese.dyndns.org>  <AANLkTilr9Qa9RJ3TIaCTgGwgp75TDBZbqRENC41xRFlq@mail.gmail.com>  <7v631lbutb.fsf@alter.siamese.dyndns.org> <AANLkTimFRpckXjvzaefyOdokf-1f7YkrNAQ8dVr3jQgj@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 16:46:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOAvH-0003yB-RX
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 16:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab0FNOpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 10:45:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53398 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab0FNOpx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 10:45:53 -0400
Received: by pwi1 with SMTP id 1so2839228pwi.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=WHfwRmKCLkuwt9dFWzuLXT50agOYeCXEQQQkP0dM/co=;
        b=JR2/qnL749T7HciDo9DX1/vO+HtOvu50wcyjh26xlVmSSvJroh1iZCwIzJomCJXKCZ
         rQ/gUPKKchOmLDlUs9yMtgkUJaYQIXKEBWDnK2TlieGbmY2c4kMX3Q6TBeAt/jr2qX6c
         /cIAr7kvSbYvpb1MwSoVVge4u2WrTMxknA+EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=bWpK8sx6nQTeL4EDObpnVDZMLWIaN1XpMKJcNEHw2azszZrpz3xJsjaC8E2tSEWVdA
         sHq/g/yt1nCJmVnKfwUcnRlwYyGjFEiNXao5AY89QQSbwAvsNwUIFbsQ0AiS2vGpyZRF
         mSXvprjK2XWuND1xheMGuYwkMlI8fe+Ek6kMI=
Received: by 10.141.187.20 with SMTP id o20mr4591536rvp.13.1276526752576;
        Mon, 14 Jun 2010 07:45:52 -0700 (PDT)
Received: from [192.168.1.2] ([122.109.106.179])
        by mx.google.com with ESMTPS id b12sm4755207rvn.22.2010.06.14.07.45.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 07:45:51 -0700 (PDT)
In-Reply-To: <AANLkTimFRpckXjvzaefyOdokf-1f7YkrNAQ8dVr3jQgj@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149097>

Hi Ram,

>> Note that there isn't that much difference between being in 'pu' and being
>> in the mailing list archive.  Depending on how further discussions go, the
>> series can be replaced with an improvement or even can be dropped as a
>> whole.
> 
> It's an indicator of progress, if not anything else. The project is
> already pretty mature imho- after squashing in a few bugfixes, it
> should be ready for `next`.

I have a feeling that these patches will need a bit more love before they are
ready for 'next'. The persistence component is the least mature of the lot.
I'd really like some feedback on making the persistence robust and simple.
Now that persistence is append-only, the file based representation no longer
need be identical to the in-memory representation.

I've tried several times to simplify the buffer_read_line() method in line_buffer.h
Every time I've ended up with slightly different behaviour.
Someone well versed in I/O might be able to greatly simplify it.
It may well be reduced to a simple wrapper around strbuf methods.

I'm still toying in my head about how to simplify the data structure used to
represent the trees. Conceptually, it is a multiway tree with the constraint that
the labels of siblings share a common prefix at the parent. It is implemented as
a ternary tree with left and right links to siblings in the multiway tree and a
middle link to the 'root' child in the multiway tree, from which all children are
reachable via left/right links.
As the code stands, the middle link is indirected via a 'directory' node.
I'd like to remove this redundancy and make the design of the structure clearer.

There is scope for a massive rename of methods, arguments and variables so
that the code is easier to read.

--
David Barr.
