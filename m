From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/9] Add memory pool library
Date: Thu, 24 Jun 2010 13:55:21 -0500
Message-ID: <20100624185521.GB1848@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624105339.GC12376@burratino>
 <AANLkTilItX_xbbpX9mfKg0Dfx6ThzYuVsBu25C_-fJ6W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 20:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORraL-0003y3-BR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 20:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab0FXSzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 14:55:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61736 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0FXSzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 14:55:31 -0400
Received: by iwn41 with SMTP id 41so1120622iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=irVisZj2QUmNks1VARg5OiBZAyu/Bvf5VDnJl+Ffcx4=;
        b=u1qRMKVfwz2qLnjb2TvEpaUZMsSxHF0fWN+58N7MXpSTEn5SOoAODKC+NcsY5oZlkI
         8uHxLI0kxMZiwsPwvJ5j3T5jLwV/OP2MnzTLJ+XF3TJqm97+NZ1P3n9SpwlYoSAtmW8T
         ed/7YNqw4jKbfukD7VInyqGY1EVewFj19R6zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F5+ufMrEaTRhSLSwvJ7SplMEcBna7vYTQ9oa+tVCJKV6HWX282/PRT0AayLlap/+IQ
         t17SMMFafl7tI7nRlGMPpbtJEJOJG4GIFpoypVGdklkdLRC4G+2qT7o21huwevZ6lSjT
         3E9oVfcBSJnYW3nPrGZ3I6SdaqPgX0FNJNwmk=
Received: by 10.231.141.26 with SMTP id k26mr10476236ibu.163.1277405730578;
        Thu, 24 Jun 2010 11:55:30 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm19521074ibf.13.2010.06.24.11.55.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 11:55:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilItX_xbbpX9mfKg0Dfx6ThzYuVsBu25C_-fJ6W@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149620>

Hi Ram,

Ramkumar Ramachandra wrote:

> By marking all the generated functions MAYBE_UNUSED, we're
> actually suppressing more warnings than intended. Maybe we can avoid
> it and somehow find a way to mark only those functions that are reall=
y
> unused?

If we used templates instead of macros, a smart compiler would notice
which functions are _never_ used.  But sticking to C, I think it is
fine to rely on humans checking by hand for now.  (FWIW no obj_pool
functions are unused at the moment.)

I tried leaving out the MAYBE_UNUSED for foo_init() before I realized
that calling it is optional.

> Perhaps an extra parameter in obj_pool_gen?

=46illing out such a list for each caller sounds to me like more troubl=
e
than it=E2=80=99s worth.

Jonathan
