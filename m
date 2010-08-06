From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [RFC] struct *_struct
Date: Fri, 6 Aug 2010 08:29:20 -0400
Message-ID: <20100806122920.GA2346@localhost.localdomain>
References: <20100804150843.GA2762@localhost.localdomain>
 <7vaap2fafm.fsf@alter.siamese.dyndns.org>
 <AANLkTin_6gaYF++N2GBgDsedfo7mY7yG5H99=-DxCa5E@mail.gmail.com>
 <20100805224321.GA22430@localhost.localdomain>
 <4c5b8819.4f3fdc0a.14ad.22b1@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 14:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhM3I-0005o1-3j
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 14:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385Ab0HFM31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 08:29:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40595 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab0HFM3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 08:29:25 -0400
Received: by vws3 with SMTP id 3so6065319vws.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wW8AjbX2pbwvZdfxtscUBEuIsOfDY9ntYv5ddH15cak=;
        b=dxNCP+EnCaKZvAGlANHmTkQwwKF756WMK1X9WS7k03xUE/GZekEkr88enUx0zcQK1s
         hDhGfz8RucL1S7/6jp8J5XIKgq+Pc33JA4AwipR3mPGIsjMp0+VDcpggBANfSBRp5PXR
         EIVxLrZjA2+INJeMljmEl7byr9gCnTgYs9sC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yC3YPDzaZj2LrdZ81j54+z5jMnDvaowMZSbINmSvsee1n7IMs1xUrHI/41t6pTfdWN
         9P58l5pdhiSPZ6eTFMZECA6LhkkTyMwWvdULTccSc4MKTW9cdF+rR2zy8vpWiBZylJ4w
         d25nAb/NXS/fJ1aeXmWWoCHtIz/CZKLYorUOE=
Received: by 10.220.88.167 with SMTP id a39mr8291093vcm.213.1281097764161;
        Fri, 06 Aug 2010 05:29:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id m9sm482800vcz.41.2010.08.06.05.29.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 05:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4c5b8819.4f3fdc0a.14ad.22b1@mx.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152776>

On Thu, Aug 05, 2010 at 08:57:13PM -0700, Michael Witten wrote:
> On Wed, Aug 4, 2010 at 14:24, Junio C Hamano <gitster@pobox.com> wrote:
> >>> I hate... "typedef foo struct foo"
> 
> On Thu, Aug 05, 2010 at 11:20:14AM -0500, Michael Witten wrote:
> >> How come?
> 
> On Thu, Aug 5, 2010 at 17:43, Jared Hance <jaredhance@gmail.com> wrote:
> Those are valid points, but I'm not sure they have a practical basis;
> your problems are largely solved by capitalization conventions
> (which essentially provide shorter replacements for `struct '):
> 
>     typedef struct { /* ... */ } Foo;
>     Foo foo;

I agree, thats much better. The original hate was on "struct foo foo".
For some reason, I still prefer the version without the typedef,
though.

> Unfortunately, such conventions don't enjoy the benefit of semantic
> protection. However, language-aware source navigation tools (like ctags)
> should be able to solve that problem and are probably more efficient
> in navigation time than grepping.
> 
> Moreover, the form:
> 
>     foo foo;
> 
> is probably not that problematic in practice; it's presence is likely
> to be short lived for 2 reasons:
> 
>     * Subjectively : everyone thinks it looks awful.
>     * Objectively  : It's technically constrained.
> 
> The typedef declaration:
> 
>     typedef /*type*/ foo;
> 
> introduces the typedef name `foo' into the `ordinary identifier'
> name space; consequently, the declaration:
> 
>     foo foo;
> 
> cannot even occur in the same scope as the typdef, and when
> it does occur in an inner scope, it hides the original typdef
> name `foo' for all subsequent inner scopes:
> 
>     typedef struct {char x;} foo;
> 
>     foo foo;         // error: attempt to redeclare `foo'.
>     foo a;
> 
>     int main()
>     {
> 
>       foo foo;       // OK; hide typedef name with variable `foo'
>       foo b;         // error: `foo' is not a type.
> 
>       {
> 
>         foo c;       // error: `foo' is not a type.
> 
>         typedef struct {char x;} foo;   // OK; hide variable `foo'
> 
>         foo foo;     // error: attempt to redeclare `foo'
>         foo d;
> 
>         d = a;       // error: anonymous structs are always different types.
> 
>         {
>           foo foo;   // OK; hide typedef name with variable `foo'
>           d = foo;   // OK; same type
>           foo e;     // error: `foo' is not a type.
>         }
> 
>         {
>           foo foo;   // OK; hide typedef name with variable `foo'
>           d = foo;   // OK; same type
>           foo f;     // error: `foo' is not a type.
>         }
> 
>       }
> 
>     }
> 
> Sincerely,
> Michael Witten

I agree here too. By the way, my comments were mostly against
specifically "typedef foo struct foo", since that what was
specifically mentioned.
