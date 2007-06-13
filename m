From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH 1/2] gitview: Fix the blame interface.
Date: Wed, 13 Jun 2007 14:03:21 +0530
Message-ID: <cc723f590706130133v3952e38yc4ceecc6cdc44365@mail.gmail.com>
References: <11816697213806-git-send-email-aneesh.kumar@gmail.com>
	 <7vmyz4h2nb.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 10:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyOI8-0005Ce-Ew
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 10:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbXFMIdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 04:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756216AbXFMIdX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 04:33:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:37690 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbXFMIdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 04:33:22 -0400
Received: by nz-out-0506.google.com with SMTP id n1so134348nzf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 01:33:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UNIaZ4zKeJQYEe/x7TljnNOkBHBaDt/QMZPlSm/HRVPg3fGmSk5KglRaJ9yvr/7p2lQuQO2GyDesytQXEfymXOY7EkoAZQcAXYBWSIwBraKQyNtrp9+H4HFT7H8CWTvwhYfRNQFYjbQuxt641aPUXbQXuoqMNF3uQyI/Ki8bu+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qUFxTYiskwS+eRJFukomMFsCSKR+af2fiuKtKJT2f1uRDLUBLIZHuX+pE5ppYJicXGcXanH5tP/2MgdBt3eQ+JkEqEogTXpy+KXTbUP2Dyi83zlnWSVOn7duj4bXx7DM81nO8QHXb8wbVtFMJjUNOeDDuaHuqkfEeqWC6EvFzKA=
Received: by 10.114.36.1 with SMTP id j1mr438010waj.1181723601452;
        Wed, 13 Jun 2007 01:33:21 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Wed, 13 Jun 2007 01:33:21 -0700 (PDT)
In-Reply-To: <7vmyz4h2nb.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50031>

On 6/13/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
>
> > @@ -401,7 +402,11 @@ class AnnotateWindow(object):
> >       def data_ready(self, source, condition):
> >               while (1):
> >                       try :
> > -                             buffer = source.read(8192)
> > +                             # A simple readline doesn't work
> > +                             # a readline bug ??
> > +                             buffer=""
> > +                             buffer = source.read(100)
> > +
>
> Are you sure about the first assignment?
>

That was a debug left over i guess. I will send an update patch which
removed the same.
The problem was an interrupted source.read/readline was returning old values.



> > @@ -419,7 +432,8 @@ class AnnotateWindow(object):
> >                                       m = annotate_line.match(buff)
> >                                       if not m:
> >                                               continue
> > -                                     filename = m.group(2)
> > +                                     else:
> > +                                             filename = m.group(2)
> >                               else:
> >                                       self.commit_sha1 = m.group(1)
> >                                       self.source_line = int(m.group(2))
>
> The script is in contrib/ so I probably shouldn't be nitpicking,
> but for this particular hunk, I think (1) this is a no-op
> change, and (2) the original is easier to read.
>
>


I will update if you feel that way

-aneesh
