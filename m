From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 10/21] Free mktag's buffer before dying
Date: Sun, 10 Jun 2007 00:00:27 +0200
Message-ID: <81b0412b0706091500o2c0a8f88xd3808d6ee790d777@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <200706090216.41856.johan@herland.net>
	 <81b0412b0706091437j50070e9aw7c258f136f4d5cde@mail.gmail.com>
	 <200706092346.12359.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 00:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8z1-0003av-2c
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 00:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbXFIWAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759347AbXFIWAa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 18:00:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23261 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbXFIWA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 18:00:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1205576ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 15:00:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bhdyo30gT6yqkb2C2SY3tZ8Ul82+SD5dCXBkGd01j9ov64DMS3NG+wNVBqdubnk4xWvtnuBDT2CoONPRUFjq9wSMWshiUTjZHuYiWyzepOxkZDXZeN2ZdZF9jJ7hhmmMyLjlV8rDndeL3aYH9nQMVnILSgMt6CbDFt1ZqI40lf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zo+Bspeh/USbMjcQg6Q9fdQHXhDCWaaamP+KCyiha7EQ35rE5H2RBb52EoZhfHvjS74Au5AwULCuA7rZ8DzqqjFSHJlR6VzEWLczMK3xV8SOKiS0oqYEfqUNC8rrzw6Q1pe2kHMO8UcoBCJCATKg/YZAp8bDKzAkntaqX2xovgo=
Received: by 10.78.204.7 with SMTP id b7mr1673340hug.1181426427836;
        Sat, 09 Jun 2007 15:00:27 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 15:00:27 -0700 (PDT)
In-Reply-To: <200706092346.12359.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49631>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> On Saturday 09 June 2007, Alex Riesen wrote:
> > On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > > +       if (parse_and_verify_tag_buffer(0, buffer, size, 1)) {
> > > +               free(buffer);
> > > +               die("invalid tag data file");
> >
> > This, and the similar one below are useless. You're destroying the
> > process, what do you free that buffer for? Either handle the error
> > case or do not needlessly complicate your change, which really
> > also absolutely unneeded.
>
> Well, I was taught to treat my memory with care.
>

How do you treat your performance?
Besides, was that systems with common address space
where you were taught? Like DOS or MacOS, perhaps?

> Right now it doesn't make any difference in practice (except that
> Valgrind might be a bit happier with it), but in the future -- with
> the libifaction effort and whatnot -- you never know what might happen
> to this piece of code, and I'd like to stay on the safe side.

So that people have to check your free as well (they will have to,
they come looking for die-calls). You just made more work for them.
